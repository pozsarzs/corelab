{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uproperties.pas                                                          | }
{ | Module properties                                                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uproperties;
{$MODE OBJFPC}{$H+}
interface
type
  TDataType = (dtBoolean, dtDWord, dtInteger, dtString, dtPChar, dtVersion,
               dtMemoryMode, dtLineMode, dtArchitecture, dtEndianness);
  TPropertyInfo = record
    Name:     string;
    DataType: TDataType;
    Writable: Boolean;
  end;
  TPropertyInfoArray = array of TPropertyInfo;
var
  IOPropertyInfoArray: TPropertyInfoArray;
  MPropertyInfoArray:  TPropertyInfoArray;
  PPropertyInfoArray:  TPropertyInfoArray;

implementation

initialization
  // I/O port
  SetLength(IOPropertyInfoArray, 16);
begin
  with IOPropertyInfoArray[0] do
  begin
    Name := 'ModName';
    DataType := dtPChar;
    Writable := False;
  end;
  with IOPropertyInfoArray[1] do
  begin
    Name := 'Description';
    DataType := dtPChar;
    Writable := False;
  end;
  with IOPropertyInfoArray[2] do
  begin
    Name := 'Version';
    DataType := dtVersion;
    Writable := False;
  end;
  with IOPropertyInfoArray[3] do
  begin
    Name := 'Enabled';
    DataType := dtBoolean;
    Writable := True;
  end;
  with IOPropertyInfoArray[4] do
  begin
    Name := 'HasPanel';
    DataType := dtBoolean;
    Writable := False;
  end;
  with IOPropertyInfoArray[5] do
  begin
    Name := 'BaseAddress';
    DataType := dtDWord;
    Writable := True;
  end;
  with IOPropertyInfoArray[6] do
  begin
    Name := 'AddressRangeSize';
    DataType := dtDWord;
    Writable := False;
  end;
  with IOPropertyInfoArray[7] do
  begin
    Name := 'IntVector';
    DataType := dtDWord;
    Writable := True;
  end;
  with IOPropertyInfoArray[8] do
  begin
    Name := 'DataInMode';
    DataType := dtLineMode;
    Writable := True;
  end;
  with IOPropertyInfoArray[9] do
  begin
    Name := 'DataInNegation';
    DataType := dtBoolean;
    Writable := True;
  end;
  with IOPropertyInfoArray[10] do
  begin
    Name := 'DataOutMode';
    DataType := dtLineMode;
    Writable := True;
  end;
  with IOPropertyInfoArray[11] do
  begin
    Name := 'DataOutNegation';
    DataType := dtBoolean;
    Writable := True;
  end;
  with IOPropertyInfoArray[12] do
  begin
    Name := 'SelMode';
    DataType := dtLineMode;
    Writable := True;
  end;
  with IOPropertyInfoArray[13] do
  begin
    Name := 'SelNegation';
    DataType := dtBoolean;
    Writable := True;
  end;
  with IOPropertyInfoArray[14] do
  begin
    Name := 'LatchedOutput';
    DataType := dtBoolean;
    Writable := False;
  end;
  with IOPropertyInfoArray[15] do
  begin
    Name := 'ReadBackOutput';
    DataType := dtBoolean;
    Writable := False;
  end;
  // MEMORY
  SetLength(MPropertyInfoArray, 7);
  with MPropertyInfoArray[0] do
  begin
    Name := 'ModName';
    DataType := dtPChar;
    Writable := False;
  end;
  with MPropertyInfoArray[1] do
  begin
    Name := 'Description';
    DataType := dtPChar;
    Writable := False;
  end;
  with MPropertyInfoArray[2] do
  begin
    Name := 'Version';
    DataType := dtVersion;
    Writable := False;
  end;
  with MPropertyInfoArray[3] do
  begin
   Name := 'Enabled';
    DataType := dtBoolean;
    Writable := True;
  end;
  with MPropertyInfoArray[4] do
  begin
    Name := 'BaseAddress';
    DataType := dtDWord;
    Writable := True;
  end;
  with MPropertyInfoArray[5] do
  begin
    Name := 'AddressRangeSize';
    DataType := dtDWord;
    Writable := True;
  end;
  with MPropertyInfoArray[6] do
  begin
    Name := 'MemoryMode';
    DataType := dtMemoryMode;
    Writable := True;
  end;
  // CPU
  SetLength(PPropertyInfoArray, 12);
  with PPropertyInfoArray[0] do
  begin
    Name := 'Modname';
    DataType := dtPChar;
    Writable := False;
  end;
  with PPropertyInfoArray[1] do
  begin
    Name := 'Description';
    DataType := dtPChar;
    Writable := False;
  end;
  with PPropertyInfoArray[2] do
  begin
    Name := 'Version';
    DataType := dtVersion;
    Writable := False;
  end;
  with PPropertyInfoArray[3] do
  begin
    Name := 'Enabled';
    DataType := dtBoolean;
    Writable := True;
  end;
  with PPropertyInfoArray[4] do
  begin
    Name := '';
    DataType := dtInteger;
    Writable := False;
  end;
  with PPropertyInfoArray[5] do
  begin
    Name := 'AddressWidth';
    DataType := dtDWord;
    Writable := False;
  end;
  with PPropertyInfoArray[6] do
  begin
    Name := 'Architecture';
    DataType := dtArchitecture;
    Writable := False;
  end;
  with PPropertyInfoArray[7] do
  begin
    Name := 'Endianness';
    DataType := dtEndianness;
    Writable := False;
  end;
  with PPropertyInfoArray[8] do
  begin
    Name := 'HasSeparateIOBus';
    DataType := dtBoolean;
    Writable := False;
  end;
  with PPropertyInfoArray[9] do
  begin
    Name := 'MaxIOPortAddress';
    DataType := dtDWord;
    Writable := False;
  end;
  with PPropertyInfoArray[10] do
  begin
    Name := 'MaxMemAddress';
    DataType := dtDWord;
    Writable := False;
  end;
  with PPropertyInfoArray[11] do
  begin
    Name := 'MaxCodeAddress';
    DataType := dtDWord;
    Writable := False;
  end;
end;

end.
