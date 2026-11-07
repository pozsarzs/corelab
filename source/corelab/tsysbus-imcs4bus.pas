{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | tsysbus-imcs4bus.pas                                                     | }
{ | TSysBus IMCS4Bus related methods                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

// WRITE ALL CHIP'S CONTROL REGISTER
procedure TSysBus.SendSRC(AAddress: Byte);
begin
end;

// READ 4002 CHIP'S RAM
function TSysBus.ReadRAM: Byte;
begin
  Result := 0;
end;

// WRITE 4002 CHIP'S RAM
procedure TSysBus.WriteRAM(AData: Byte);
begin
end;

// READ 4002 CHIP'S RAM STATUS
function TSysBus.ReadRAMStatus(AIndex: Byte): Byte;
begin
  Result := 0;
end;

// WRITE 4002 CHIP'S RAM STATUS
procedure TSysBus.WriteRAMStatus(AIndex: Byte; AData: Byte);
begin
end;

// WRITE 4002 CHIP'S I/O PORT
procedure TSysBus.WriteRAMIOPort(AData: Byte);
begin
end;

// READ 4001 CHIP'S ROM
function TSysBus.ReadROM(AAddress: Word): Byte;
begin
  Result := 0;
end;

// READ 4001 CHIP'S I/O PORT
function TSysBus.ReadROMIOPort: Byte;
begin
  Result := 0;
end;

// WRITE 4001 CHIP'S I/O PORT
procedure TSysBus.WriteROMIOPort(AData: Byte);
begin
end;
