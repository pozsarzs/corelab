{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_bus.pas                                                             | }
{ | System bus interface                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_bus;
{$MODE OBJFPC}{$H+}
{$MODESWITCH TYPEHELPERS}
interface
uses
  CMem, TypInfo;
type
  // Last bus operation record for BusLogger
  TBusLogRec = record
    Operation:  string[31];
    Device:     string[31];
    Address:    string[31];
    RelAddress: string[31];
    Data:       string[31];
    Status:     string[31];
  end;
  // Type of system bus
  TBusType = (btStandard, btMCS4);
  TBusTypeHelper = type helper for TBusType
    function ToString: string;
    function FromString(const Value: string): TBusType;
  end;
  { IStandardBus }
  IStandardBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    // memory functions
    function ReadMemory(AAddress: DWord): Byte;
    procedure WriteMemory(AAddress: DWord; AValue: Byte);
    // I/O functions
    function ReadPort(APort: DWord): Byte;
    procedure WritePort(APort: DWord; AValue: Byte);
  end;
  { IMCS4Bus }
  IMCS4Bus = interface
    ['{923A5391-77FD-41FB-B935-046D62F45C18}']
    // common addressing
    procedure SendSRC(AAddress: Byte);
    // RAM functions (r/w memory and w I/O)
    function ReadRAM: Byte;
    procedure WriteRAM(AData: Byte);
    function ReadRAMStatus(AIndex: Byte): Byte;
    procedure WriteRAMStatus(AIndex: Byte; AData: Byte);
    procedure WriteRAMIOPort(AData: Byte);
    // ROM functions (r memory and r/w I/O)
    function ReadROM(AAddress: Word): Byte;
    function ReadROMIOPort: Byte;
    procedure WriteROMIOPort(AData: Byte);
  end;

implementation

// ---- HELPER FOR OWN TYPES ----

function TBusTypeHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TBusTypeHelper.FromString(const Value: string): TBusType;
begin
  Result := TBusType(GetEnumValue(TypeInfo(TBusType), Value));
end;

end.
