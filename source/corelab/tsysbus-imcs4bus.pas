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
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'SRCWR';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    RelAddress := 'N/A';
    FormatHexValue(IntToHex(AAddress, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then MCS4Dev.SendSRC(AAddress);
  BusLogRec.Status := MSG111;                                      { 'Success' }
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// READ 4002 CHIP'S RAM
function TSysBus.ReadRAM: Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  Result := 0;
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'RAMRD';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    RelAddress := 'N/A';
    Data := 'N/A';
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then Result := Result or MCS4Dev.ReadRAM;
  with BusLogRec do
  begin
    FormatHexValue(IntToHex(Result, 2), 2, s);
    Data := s;
    Status := MSG111;                                              { 'Success' }
  end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE 4002 CHIP'S RAM
procedure TSysBus.WriteRAM(AData: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'RAMWR';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    RelAddress := 'N/A';
    FormatHexValue(IntToHex(AData, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then MCS4Dev.WriteRAM(AData);
  BusLogRec.Status := MSG111;                                      { 'Success' }
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// READ 4002 CHIP'S RAM STATUS
function TSysBus.ReadRAMStatus(AIndex: Byte): Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  Result := 0;
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'STATRD';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    FormatHexValue(IntToHex(AIndex, 2), 2, s);
    RelAddress := s;
    Data := 'N/A';
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then Result := Result or MCS4Dev.ReadRAMStatus(AIndex);
  with BusLogRec do
  begin
    FormatHexValue(IntToHex(Result, 2), 2, s);
    Data := s;
    Status := MSG111;                                              { 'Success' }
  end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE 4002 CHIP'S RAM STATUS
procedure TSysBus.WriteRAMStatus(AIndex: Byte; AData: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'STATWR';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    FormatHexValue(IntToHex(AIndex, 2), 2, s);
    RelAddress := s;
    FormatHexValue(IntToHex(AData, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then MCS4Dev.WriteRAMStatus(AIndex, AData);
  BusLogRec.Status := MSG111;                                      { 'Success' }
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE 4002 CHIP'S I/O PORT
procedure TSysBus.WriteRAMIOPort(AData: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'IOWR';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    RelAddress := 'N/A';
    FormatHexValue(IntToHex(AData, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then MCS4Dev.WriteRAMIOPort(AData);
  BusLogRec.Status := MSG111;                                      { 'Success' }
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// READ 4001 CHIP'S ROM
function TSysBus.ReadROM(AAddress: Word): Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  Result := 0;
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'ROMRD';
    Device := 'MCS-4 Bus';
    FormatHexValue(IntToHex(AAddress, 4), 2, s);
    Address := s;
    RelAddress := 'N/A';
    Data := 'N/A';
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then Result := Result or MCS4Dev.ReadROM(AAddress);
  with BusLogRec do
  begin
    FormatHexValue(IntToHex(Result, 2), 2, s);
    Data := s;
    Status := MSG111;                                              { 'Success' }
  end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// READ 4001 CHIP'S I/O PORT
function TSysBus.ReadROMIOPort: Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  Result := 0;
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'IORD';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    RelAddress := 'N/A';
    Data := 'N/A';
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then Result := Result or MCS4Dev.ReadROMIOPort;
  with BusLogRec do
  begin
    FormatHexValue(IntToHex(Result, 2), 2, s);
    Data := s;
    Status := MSG111;                                              { 'Success' }
  end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE 4001 CHIP'S I/O PORT
procedure TSysBus.WriteROMIOPort(AData: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  MCS4Dev:   IMCS4Bus;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'IOWR';
    Device := 'MCS-4 Bus';
    Address := 'N/A';
    RelAddress := 'N/A';
    FormatHexValue(IntToHex(AData, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      // check bus type
      if Enabled and (BusType = btMCS4) then
        if Supports(FMemories[i].Memory, IMCS4Bus, MCS4Dev)
          then MCS4Dev.WriteROMIOPort(AData);
  BusLogRec.Status := MSG111;                                      { 'Success' }
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;
