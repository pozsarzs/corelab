{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ucommon.pas                                                              | }
{ | common procedures and functions                                          | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

unit ucommon;
{$MODE OBJFPC} {$H+} {$MACRO ON}
interface
uses
  {$IFDEF WINDOWS} Windows, {$ENDIF} SysUtils, crt, dos;
const
  CRC16TABLE: array[0..255] of Word = (
    $0000, $C0C1, $C181, $0140, $C301, $03C0, $0280, $C241,
    $C601, $06C0, $0780, $C741, $0500, $C5C1, $C481, $0440,
    $CC01, $0CC0, $0D80, $CD41, $0F00, $CFC1, $CE81, $0E40,
    $0A00, $CAC1, $CB81, $0B40, $C901, $09C0, $0880, $C841,
    $D801, $18C0, $1980, $D941, $1B00, $DBC1, $DA81, $1A40,
    $1E00, $DEC1, $DF81, $1F40, $DD01, $1DC0, $1C80, $DC41,
    $1400, $D4C1, $D581, $1540, $D701, $17C0, $1680, $D641,
    $D201, $12C0, $1380, $D341, $1100, $D1C1, $D081, $1040,
    $F001, $30C0, $3180, $F141, $3300, $F3C1, $F281, $3240,
    $3600, $F6C1, $F781, $3740, $F501, $35C0, $3480, $F441,
    $3C00, $FCC1, $FD81, $3D40, $FF01, $3FC0, $3E80, $FE41,
    $FA01, $3AC0, $3B80, $FB41, $3900, $F9C1, $F881, $3840,
    $2800, $E8C1, $E981, $2940, $EB01, $2BC0, $2A80, $EA41,
    $EE01, $2EC0, $2F80, $EF41, $2D00, $EDC1, $EC81, $2C40,
    $E401, $24C0, $2580, $E541, $2700, $E7C1, $E681, $2640,
    $2200, $E2C1, $E381, $2340, $E101, $21C0, $2080, $E041,
    $A001, $60C0, $6180, $A141, $6300, $A3C1, $A281, $6240,
    $6600, $A6C1, $A781, $6740, $A501, $65C0, $6480, $A441,
    $6C00, $ACC1, $AD81, $6D40, $AF01, $6FC0, $6E80, $AE41,
    $AA01, $6AC0, $6B80, $AB41, $6900, $A9C1, $A881, $6840,
    $7800, $B8C1, $B981, $7940, $BB01, $7BC0, $7A80, $BA41,
    $BE01, $7EC0, $7F80, $BF41, $7D00, $BDC1, $BC81, $7C40,
    $B401, $74C0, $7580, $B541, $7700, $B7C1, $B681, $7640,
    $7200, $B2C1, $B381, $7340, $B101, $71C0, $7080, $B041,
    $5000, $90C1, $9181, $5140, $9301, $53C0, $5280, $9241,
    $9601, $56C0, $5780, $9741, $5500, $95C1, $9481, $5440,
    $9C01, $5CC0, $5D80, $9D41, $5F00, $9FC1, $9E81, $5E40,
    $5A00, $9AC1, $9B81, $5B40, $9901, $59C0, $5880, $9841,
    $8801, $48C0, $4980, $8941, $4B00, $8BC1, $8A81, $4A40,
    $4E00, $8EC1, $8F81, $4F40, $8D01, $4DC0, $4C80, $8C41,
    $4400, $84C1, $8581, $4540, $8701, $47C0, $4680, $8641,
    $8201, $42C0, $4380, $8341, $4100, $81C1, $8081, $4040);
  {$IFDEF WINDOWS}
    CSIDL_PROFILE = 40;
    SHGFP_TYPE_CURRENT = 0;
  {$ENDIF}
  {$IFDEF WINDOWS}
var
    Buffer: array[0..MAX_PATH] of Char;
  {$ENDIF}

{$DEFINE SLASH := DirectorySeparator}

Function AddZero(v: Word): string;
Function AddSomeZero(n: Byte; s: string): string;
Function CheckCRC16(s: string; l: Word): Boolean;
Function CheckIPAddress(address: string): Boolean;
Function CheckLRC(s: string; l: Word): Boolean;
Function CRC16(s: string): Word;
Function Hex1(n: byte; w: Word): string;
Function Hex2(s: string): string;
Function GetExeDir: string;
Function GetLang: string;
Function GetUserDir: string;
Function LRC(s: string): Word;

implementation

{$IFDEF WINDOWS}
  function SHGetFolderPath(hwndOwner: HWND; nFolder: Integer; hToken: THandle;
           dwFlags: DWORD; pszPath: LPTSTR): HRESULT; stdcall;
           external 'Shell32.dll' name 'SHGetFolderPathA';

  function GetUserProfile: string;
  begin
    FillChar(Buffer, SizeOf(Buffer), 0);
    ShGetFolderPath(0, CSIDL_PROFILE, 0, SHGFP_TYPE_CURRENT, buffer);
    Result := string(PChar(@buffer));
  end;
{$ENDIF}

// INSERT ZERO BEFORE [0-9]
function AddZero(v: Word): string;
var
  u: string;
begin
  Str(v:0, u);
  if Length(u) = 1 then u := '0' + u;
   AddZero := u;
end;

// INSERT SOME ZERO BEFORE STRING
function AddSomeZero(n: Byte; s: string): string;
begin
  while Length(s) <> n do
    s := '0' + s;
  Result := s;
end;

// CONVERT A BYTE/WORD NUMBER TO 2/4 DIGIT HEX NUMBER AS STRING
function Hex1(n: Byte; w: Word): string;
var
  b:         Byte;
  Remainder: Word;
  Res:       string;
begin
  Res := '';
  for b := 1 to n do
  begin
    Remainder := w mod 16;
    w := w div 16;
    if Remainder <= 9 then
      Res := Chr(Remainder + 48) + Res
    else
      Res := Chr(Remainder + 87) + Res;
  end;
  Result := Res;
end;

// CONVERT A STRING OF ASCII CODED HEXA BYTES TO STRING OF HEXA BYTES }
function Hex2(s: string): string;
var
  b:   Byte;
  d:   Integer;
  Res: string;
begin
  b := 1;
  Res := '';
  repeat
    d := StrToInt('$' + s[b] + s[b + 1]);
    Res := Res + Char(d);
    b:= b + 2;
  until b >= Length(s);
  Result := Res;
end;

// CREATE CYCLIC REDUNDANCY CHECK (CRC16/MODBUS) VALUE
function CRC16(s: string): Word;
var
  i:   Integer;
  idx: Byte = 0;
  crc: Word = $FFFF;
begin
  for i := 1 to Length(s) do
  begin
    idx := Ord(s[i]) xor crc;
    crc := crc shr 8;
    crc := crc xor CRC16TABLE[idx];
  end;
  Result := crc;
end;

// CHECK CRC OF A STRING
function CheckCRC16(s: string; l: Word): Boolean;
begin
  if l = CRC16(s)
    then Result := True
    else Result := False;
end;

// CREATE LONGITUDINAL REDUNDANCY CHECK (LRC) VALUE
function LRC(s: string): Word;
var
   b:   Byte;
   Res: Word;
begin
  s := Hex2(s);
  Res := 0;
  for b := 1 to Length(s) do
    Res := Res + Ord(s[b]) and $FF;
  Res := (((Res xor $FF) + 1) and $FF);
  Result := Res;
end;

// CHECK LRC OF A STRING
function CheckLRC(s: string; l: Word): Boolean;
begin
  if l = LRC(s)
    then Result := True
    else Result := False;
end;

// CHECK IP ADDRESS
function CheckIPAddress(Address: string): Boolean;
var
  b, c: Byte;
  s:    array[0..3] of string;

begin
  for b := 0 to 3 do s[b] := '';
  c := 0;
  for b := 1 to Length(Address) do
    if Address[b] <> '.'
    then
      s[c] := s[c] + Address[b]
    else
      if c < 3 then Inc(c);
  c := 0;
  for b := 0 to 3 do
    if (StrToIntDef(s[b], -1) < 0) or (StrToIntDef(s[b], -1) > 255) then Inc(c);
  if (c > 0) then Result := False else Result := True;
end;

// GET SYSTEM LANGUAGE
function GetLang: string;
var
  {$IFDEF WINDOWS}
    Buffer: PChar;
    Size:   Integer;
  {$ENDIF}
  s: string;
begin
  {$IFDEF GO32V2}
    s := GetEnvironmentVariable('LANG');
  {$ELSE}
    {$IFDEF WINDOWS}
      Size := GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Nil, 0);
      GetMem(Buffer, Size);
      try
        GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Buffer, Size);
        s := string(Buffer);
      finally
        FreeMem(Buffer);
      end;
    {$ELSE}
      {$IFDEF UNIX}
        s := GetEnvironmentVariable('LANG');
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF} 
  if Length(s) = 0 then
    s := 'en';
  s := LowerCase(s[1..2]);
  GetLang := s;
end;

// GET PATH OF THE EXECUTABLE FILE;
function GetExeDir: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

// GET USER'S DIRECTORY
function GetUserDir: string;
begin
  {$IFDEF GO32V2}
    Result := GetExeDir;
  {$ELSE}
    {$IFDEF WINDOWS}
      Result := GetUserProfile + SLASH;
    {$ELSE}
      {$IFDEF UNIX}
        Result := GetEnvironmentVariable('HOME') + SLASH;
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;
// Run browser application
procedure runbrowser(url: string);
begin
  Form1.Process1.CommandLine:=browserapp+' '+url;
  try
    Form1.Process1.Execute;
  except
    ShowMessage(MESSAGE03);
  end;
end;

// Run mailer application
procedure runmailer(adr: string);
begin
  Form1.Process2.CommandLine:=mailerapp+' '+adr;
  try
    Form1.Process2.Execute;
  except
    ShowMessage(MESSAGE04);
  end;
end;





end.
