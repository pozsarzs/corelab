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
interface
uses
  CMem;
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
  { ISysBus }
  ISysBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    function ReadMemory(AAddress: DWord): Byte;
    procedure WriteMemory(AAddress: DWord; AValue: Byte);
    function ReadPort(APort: DWord): Byte;
    procedure WritePort(APort: DWord; AValue: Byte);
  end;

implementation

end.
