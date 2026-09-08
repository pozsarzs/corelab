{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uintelhex.pas                                                            | }
{ | Intel hex file handler functions                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uintelhex;
{$MODE OBJFPC} {$H+} {$MACRO ON}
interface
uses
  Classes, SysUtils;
const
  EMPTY_RAM_BYTE = $00;
type
  EIntelHexError = class(Exception);                       // own exception type
  THexRecord = record                                   // Intel hex record type 
    ByteCount:  Byte;
    Address:    Word;
    RecordType: Byte;
    Data:       array[0..255] of Byte;
    Checksum:   Byte;
  end;  

function LoadFromIntelHex(AFilename: string; var ATargetArray: array of Byte): Byte;
function SaveToIntelHex(AFilename: string; const ASourceArray: array of Byte): Byte;
function LoadFromIntelHexToStream(AFilename: string; ATargetStream: TStream): Byte;
function SaveToIntelHexFromStream(AFilename: string; ASourceStream: TStream): Byte;

implementation

// LOAD DATA FROM INTEL HEX FORMAT FILE  
function LoadFromIntelHex(AFilename: string; var ATargetArray: array of Byte): Byte;
var
  StringList:      TStringList;
  i, j:            Integer;
  Line:            string;
  HexRecord:       THexRecord;
  BaseAddress:     Integer;
  AbsoluteAddress: Integer;
  Sum:             Integer;
begin
  Result := 0;
  BaseAddress := 0;
  StringList := TStringList.Create;
  try
    try
      // load file to StringList
      StringList.LoadFromFile(AFilename);
      // processing records
      for i := 0 to StringList.Count - 1 do
      begin
        // line clean and check
        Line := Trim(StringList.Strings[i]);
        if Line = '' then Continue;
        if Line[1] <> ':' then Continue;
        if Line = ':00000001FF' then Break;
        // line checksum check (ok, if the sum of the all bytes mod 256 = 0)
        Sum := 0;
        for j := 1 to (Length(Line) - 1) div 2 do
          Sum := Sum + StrToInt('$' + Copy(Line, j * 2, 2));
        if (Sum and $FF) <> 0 then raise EIntelHexError.Create('');

        // Record format:
        //
        // :LLAAAATTDDDD...DDCC
        //
        // LL:   1 byte datalength
        // AAAA: 2 bytes address
        // TT:   1 byte record type
        // DD:   n byte(s) data
        // CC:   2 bytes two-complements checksum

        // fill record fields
        with HexRecord do
        begin
          ByteCount  := StrToInt('$' + Copy(Line, 2, 2));
          Address    := StrToInt('$' + Copy(Line, 4, 4));
          RecordType := StrToInt('$' + Copy(Line, 8, 2));
        end;
        // get databytes from line
        for j := 0 to HexRecord.ByteCount - 1 do
        begin
          HexRecord.Data[j] := StrToInt('$' + Copy(Line, 10 + (j * 2), 2));
        end;
        // data processing
        case HexRecord.RecordType of
          $00: begin                                                     // data
                 AbsoluteAddress := BaseAddress + HexRecord.Address;
                 // check target array size
                 if (AbsoluteAddress + HexRecord.ByteCount) > Length(ATargetArray)
                   then raise Exception.Create('');
                 // copy byte(s) to target array
                 for j := 0 to HexRecord.ByteCount - 1 do
                   ATargetArray[AbsoluteAddress + j] := HexRecord.Data[j];
               end;
          $01: Break;                                                     // EOF
          $02: begin                  // extended segment address (x86, > 64 kB)
                 if HexRecord.ByteCount = 2
                   then BaseAddress := ((HexRecord.Data[0] shl 8) or
                                         HexRecord.Data[1]) shl 4;
               end;
          $04: begin                                  // extended linear address
                 if HexRecord.ByteCount = 2
                   then BaseAddress := ((HexRecord.Data[0] shl 8) or
                                         HexRecord.Data[1]) shl 16;
               end;
        end;
      end;
    except
      on E: EFOpenError do Result := 1;                       // file open error
      on E: EConvertError do Result := 2;                    // converting error
      on E: EIntelHexError do Result := 3;                // line checksum error 
      on E: Exception do Result := 255;                // other unexpected error
    end;
  finally
    StringList.Free;
  end;
end;

// SAVE DATA TO INTEL HEX FORMAT FILE  
function SaveToIntelHex(AFilename: string; const ASourceArray: array of Byte): Byte;
var
  StringList:        TStringList;
  i, j:              Integer;
  BlockSize:         Integer;
  IsEmpty:           Boolean;
  HighAddr, LowAddr: Word;
  LastHighAddr:      Integer;
  Line, DataStr:     string;
  Sum, Checksum:     Integer;
begin
  Result := 0;
  StringList := TStringList.Create;
  try
    try
      // optimal memory allocation for big files
      StringList.Capacity := (Length(ASourceArray) div 16) + 4000;
      LastHighAddr := -1;
      i := 0;
      // data processing
      while i < Length(ASourceArray) do
      begin
        // block size to be handled at the same time (16 bytes or < 16 bytes)
        BlockSize := 16;
        if i + BlockSize > Length(ASourceArray)
          then BlockSize := Length(ASourceArray) - i;
        // empty block?
        IsEmpty := True;
        for j := 0 to BlockSize - 1 do
        begin
          if ASourceArray[i + j] <> EMPTY_RAM_BYTE then
          begin
            IsEmpty := False;
            Break;
          end;
        end;
        // is not then add to StringList
        if not IsEmpty then
        begin
          // split address
          HighAddr := i shr 16;                                    // upper word
          LowAddr  := i and $FFFF;                                 // lower word
          // insert extended linear address (record type: 04)
          if HighAddr <> LastHighAddr then
          begin
            // ':02 0000 04 HHHH CC'
            Sum := 2 + 0 + 0 + 4 + (HighAddr shr 8) + (HighAddr and $FF);
            Checksum := ((not Sum) + 1) and $FF;
            Line := Format(':02000004%0.4X%0.2X', [HighAddr, Checksum]);
            StringList.Add(Line);
            LastHighAddr := HighAddr;
          end;
          // insert data (record type: 00)
          DataStr := '';
          Sum := BlockSize + (LowAddr shr 8) + (LowAddr and $FF) + 0;
          for j := 0 to BlockSize - 1 do
          begin
            DataStr := DataStr + IntToHex(ASourceArray[i + j], 2);
            Sum := Sum + ASourceArray[i + j];
          end;
          Checksum := ((not Sum) + 1) and $FF;
          Line := Format(':%0.2X%0.4X00%s%0.2X', [BlockSize, LowAddr, DataStr, Checksum]);
          StringList.Add(Line);
        end;
        Inc(i, BlockSize);
      end;
      // add EOF record
      StringList.Add(':00000001FF');
      // save to file
      StringList.SaveToFile(AFilename);
    except
      on E: EFCreateError do Result := 1;                   // file create error
      on E: Exception do Result := 255;                // other unexpected error
    end;
  finally
    StringList.Free;
  end;
end;

// LOAD DATA FROM INTEL HEX FORMAT FILE TO STREAM
function LoadFromIntelHexToStream(AFilename: string; ATargetStream: TStream): Byte;
var
  StringList:      TStringList;
  i, j:            Integer;
  Line:            string;
  HexRecord:       THexRecord;
  BaseAddress:     Integer;
  AbsoluteAddress: Integer;
  Sum:             Integer;
begin
  Result := 0;
  BaseAddress := 0;
  StringList := TStringList.Create;
  try
    try
      StringList.LoadFromFile(AFilename);
      for i := 0 to StringList.Count - 1 do
      begin
        Line := Trim(StringList.Strings[i]);
        if Line = '' then Continue;
        if Line[1] <> ':' then Continue;
        if Line = ':00000001FF' then Break;
        
        Sum := 0;
        for j := 1 to (Length(Line) - 1) div 2 do
          Sum := Sum + StrToInt('$' + Copy(Line, j * 2, 2));
        if (Sum and $FF) <> 0 then raise EIntelHexError.Create('');

        with HexRecord do
        begin
          ByteCount  := StrToInt('$' + Copy(Line, 2, 2));
          Address    := StrToInt('$' + Copy(Line, 4, 4));
          RecordType := StrToInt('$' + Copy(Line, 8, 2));
        end;
        
        for j := 0 to HexRecord.ByteCount - 1 do
        begin
          HexRecord.Data[j] := StrToInt('$' + Copy(Line, 10 + (j * 2), 2));
        end;
        
        case HexRecord.RecordType of
          $00: begin
                 AbsoluteAddress := BaseAddress + HexRecord.Address;
                 ATargetStream.Position := AbsoluteAddress;
                 ATargetStream.WriteBuffer(HexRecord.Data[0], HexRecord.ByteCount);
               end;
          $01: Break;
          $02: begin
                 if HexRecord.ByteCount = 2 then
                   BaseAddress := ((HexRecord.Data[0] shl 8) or HexRecord.Data[1]) shl 4;
               end;
          $04: begin
                 if HexRecord.ByteCount = 2 then
                   BaseAddress := ((HexRecord.Data[0] shl 8) or HexRecord.Data[1]) shl 16;
               end;
        end;
      end;
    except
      on E: EFOpenError do Result := 1;
      on E: EConvertError do Result := 2;
      on E: EIntelHexError do Result := 3;
      on E: Exception do Result := 255;
    end;
  finally
    StringList.Free;
  end;
end;

// SAVE DATA TO INTEL HEX FORMAT FILE FROM STREAM
function SaveToIntelHexFromStream(AFilename: string; ASourceStream: TStream): Byte;
var
  StringList:        TStringList;
  i, j:              Integer;
  BlockSize:         Integer;
  IsEmpty:           Boolean;
  HighAddr, LowAddr: Word;
  LastHighAddr:      Integer;
  Line, DataStr:     string;
  Sum, Checksum:     Integer;
  Buffer:            array[0..15] of Byte;
begin
  Result := 0;
  StringList := TStringList.Create;
  try
    try
      StringList.Capacity := (ASourceStream.Size div 16) + 4000;
      LastHighAddr := -1;
      i := 0;
      
      while i < ASourceStream.Size do
      begin
        BlockSize := 16;
        if i + BlockSize > ASourceStream.Size then 
          BlockSize := ASourceStream.Size - i;
          
        ASourceStream.Position := i;
        ASourceStream.ReadBuffer(Buffer[0], BlockSize);
        
        IsEmpty := True;
        for j := 0 to BlockSize - 1 do
        begin
          if Buffer[j] <> EMPTY_RAM_BYTE then
          begin
            IsEmpty := False;
            Break;
          end;
        end;
        
        if not IsEmpty then
        begin
          HighAddr := i shr 16;
          LowAddr  := i and $FFFF;
          
          if HighAddr <> LastHighAddr then
          begin
            Sum := 2 + 0 + 0 + 4 + (HighAddr shr 8) + (HighAddr and $FF);
            Checksum := ((not Sum) + 1) and $FF;
            Line := Format(':02000004%0.4X%0.2X', [HighAddr, Checksum]);
            StringList.Add(Line);
            LastHighAddr := HighAddr;
          end;
          
          DataStr := '';
          Sum := BlockSize + (LowAddr shr 8) + (LowAddr and $FF) + 0;
          for j := 0 to BlockSize - 1 do
          begin
            DataStr := DataStr + IntToHex(Buffer[j], 2);
            Sum := Sum + Buffer[j];
          end;
          Checksum := ((not Sum) + 1) and $FF;
          Line := Format(':%0.2X%0.4X00%s%0.2X', [BlockSize, LowAddr, DataStr, Checksum]);
          StringList.Add(Line);
        end;
        Inc(i, BlockSize);
      end;
      
      StringList.Add(':00000001FF');
      StringList.SaveToFile(AFilename);
    except
      on E: EFCreateError do Result := 1;
      on E: Exception do Result := 255;
    end;
  finally
    StringList.Free;
  end;
end;

end.
