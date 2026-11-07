{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | tsysbus-common.pas                                                       | }
{ | TSysBus common methods                                                   | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

// ATTACH CPU TO SYSTEM BUS
function TSysBus.AttachCPU(const AModuleName: string; ACPU: TCPU): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if (AModuleName = '') or not Assigned(ACPU) then Exit;
  // already is attached?
  Result := 2;
  for i := 0 to High(FCPUs) do
    if FCPUs[i].ModuleName = AModuleName then Exit;
  // one CPU is allowed
  Result := 3;
  if Length(FCPUs) >= 1 then Exit;
  // create entry
  SetLength(FCPUs, Length(FCPUs) + 1);
  with FCPUs[High(FCPUs)] do
  begin
    ModuleName := AModuleName;
    CPU := ACPU;
  end;
  Result := 0;
end;

// ATTACH MEMORY TO SYSTEM BUS
function TSysBus.AttachMemory(const AModuleName: string; AMemory: TMemory): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if (AModuleName = '') or not Assigned(AMemory) then Exit;
  // already is attached?
  Result := 2;
  for i := 0 to High(FMemories) do
    if FMemories[i].ModuleName = AModuleName then Exit;
  // create entry
  SetLength(FMemories, Length(FMemories) + 1);
  with FMemories[High(FMemories)] do
  begin
    ModuleName := AModuleName;
    Memory := AMemory;
  end;
  Result := 0;
end;

// ATTACH I/O PORT TO SYSTEM BUS
function TSysBus.AttachIOPort(const AModuleName: string; AIOPort: TIOPort): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if (AModuleName = '') or not Assigned(AIOPort) then Exit;
  // already is attached?
  Result := 2;
  for i := 0 to High(FIOPorts) do
    if FIOPorts[i].ModuleName = AModuleName then Exit;
  // create entry
  SetLength(FIOPorts, Length(FIOPorts) + 1);
  with FIOPorts[High(FIOPorts)] do
  begin
    ModuleName := AModuleName;
    IOPort := AIOPort;
  end;
  Result := 0;
end;

// DETACH CPU FROM SYSTEM BUS
function TSysBus.DetachCPU(const AModuleName: string): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if AModuleName = '' then Exit;
  // already is detached?
  Result := 2;
  for i := 0 to High(FCPUs) do
    if FCPUs[i].ModuleName = AModuleName then
    begin
      // remove entry
      if i < High(FCPUs) then FCPUs[i] := FCPUs[High(FCPUs)];
      SetLength(FCPUs, Length(FCPUs) - 1);
      Result := 0;
      Exit;
    end;
end;

// DETACH MEMORY FROM SYSTEM BUS
function TSysBus.DetachMemory(const AModuleName: string): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if AModuleName = '' then Exit;
  // already is detached?
  Result := 2;
  for i := 0 to High(FMemories) do
    if FMemories[i].ModuleName = AModuleName then
    begin
      // remove entry
      if i < High(FMemories) then FMemories[i] := FMemories[High(FMemories)];
      SetLength(FMemories, Length(FMemories) - 1);
      Result := 0;
      Exit;
    end;
end;

// DETACH I/O PORT FROM SYSTEM BUS
function TSysBus.DetachIOPort(const AModuleName: string): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if AModuleName = '' then Exit;
  // already detached?
  Result := 2;
  for i := 0 to High(FIOPorts) do
    if FIOPorts[i].ModuleName = AModuleName then
    begin
      // remove entry
      if i < High(FIOPorts) then FIOPorts[i] := FIOPorts[High(FIOPorts)];
      SetLength(FIOPorts, Length(FIOPorts) - 1);
      Result := 0;
      Exit;
    end;
end;
