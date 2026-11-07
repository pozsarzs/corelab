{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | tsysbus-isysbus.pas                                                      | }
{ | TSysBus ISysBus related methods                                          | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

// READ MEMORY
function TSysBus.ReadMemory(AAddress: DWord): Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  Result := 0;
  with BusLogRec do
  begin
    Operation := 'MEMRD';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(AAddress, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    Data := MSG110;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      if Enabled and
       (AAddress >= BaseAddress) and
       (AAddress < BaseAddress + AddressRangeSize) then
      begin
        // operation
        Result := ReadMemory(AAddress - BaseAddress);
        with BusLogRec do
        begin
          Device := FMemories[i].ModuleName;
          FormatHexValue(IntToHex(AAddress - FMemories[i].Memory.BaseAddress, 6), 6, s);
          RelAddress := s;
          FormatHexValue(IntToHex(Result, 2), 2, s);
          Data := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE MEMORY
procedure TSysBus.WriteMemory(AAddress: DWord; AValue: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'MEMWR';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(AAddress, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    FormatHexValue(IntToHex(AValue, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      if Enabled and
       (AAddress >= BaseAddress) and
       (AAddress < BaseAddress + AddressRangeSize) then
      begin
        WriteMemory(AAddress - BaseAddress, AValue);
        with BusLogRec do
        begin
          Device := FMemories[i].ModuleName;
          FormatHexValue(IntToHex(AAddress - FMemories[i].Memory.BaseAddress, 6), 6, s);
          RelAddress := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// READ I/O PORT
function TSysBus.ReadPort(APort: DWord): Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  Result := 0;
  with BusLogRec do
  begin
    Operation := 'IORD';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(APort, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    Data := MSG110;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FIOPorts) do
    with FIOPorts[i].IOPort do
      if Enabled and
       (APort >= BaseAddress) and
       (APort < BaseAddress + AddressRangeSize) then
      begin
        Result := ReadPort(APort - BaseAddress);
        with BusLogRec do
        begin
          Device := FIOPorts[i].ModuleName;
          FormatHexValue(IntToHex(APort - FIOPorts[i].IOPort.BaseAddress, 6), 6, s);
          RelAddress := s;
          FormatHexValue(IntToHex(Result, 2), 2, s);
          Data := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE I/O PORT
procedure TSysBus.WritePort(APort: DWord; AValue: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'IOWR';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(APort, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    FormatHexValue(IntToHex(AValue, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FIOPorts) do
    with FIOPorts[i].IOPort do
      if Enabled and
       (APort >= BaseAddress) and
       (APort < BaseAddress + AddressRangeSize) then
      begin
        WritePort(APort - BaseAddress, AValue);
        with BusLogRec do
        begin
          Device := FIOPorts[i].ModuleName;
          FormatHexValue(IntToHex(APort - FIOPorts[i].IOPort.BaseAddress, 6), 6, s);
          RelAddress := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;
