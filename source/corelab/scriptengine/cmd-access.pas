{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-access.pas                                                           | }
{ | Data access commands                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ LDRG RDIO RDME WRIO WRME SWAP }

procedure TScriptEngine.CmdRDIO(AActionContext: TActionContext);
var
  Data:     Byte;
  VAddress: Variant;
  WAddress: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    Data := 0;
    VAddress := 0;
    WAddress := 0;
    // get and check arguments
    if ChkRegName(SArg1, True) then
    begin
      // address in register
      if not FScriptRuntime.GetRegister(SArg1[3], VAddress) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(VAddress), WAddress) then Exit;
      // read data from port via SysBus
      Data := FReadPortFunc(DWord(WAddress));
      // store in accumulator
      if not FScriptRuntime.SetRegister('A', Data, False) then Exit;
    end else
    begin
      // address in value
      // check type
      if not TryStrToDWord(SArg1, WAddress) then Exit;
      // read data from port via SysBus
      Data := FReadPortFunc(WAddress);
      // store in accumulator
      if not FScriptRuntime.SetRegister('A', Data, False) then Exit;
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdWRIO(AActionContext: TActionContext);
var
  Data:     Variant;
  IData:    Integer;
  VAddress: Variant;
  WAddress: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    Data := 0;
    IData := 0;
    VAddress := 0;
    WAddress := 0;
    // get and check arguments
    if ChkRegName(SArg1, True) then
    begin
      // address in register
      if not FScriptRuntime.GetRegister(SArg1[3], VAddress) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(VAddress), WAddress) then Exit;
      // data in accumulator
      if not FScriptRuntime.GetRegister('A', Data) then Exit;
      // check data type
      if not TryStrToInt(VarToStr(Data), IData) then Exit;
      // write data to port via SysBus
      FWritePortProc(WAddress, Byte(IData));
    end else
    begin
      // address in value
      // check type
      if not TryStrToDWord(SArg1, WAddress) then Exit;
      // data in accumulator
      if not FScriptRuntime.GetRegister('A', Data) then Exit;
      // check data type
      if not TryStrToInt(VarToStr(Data), IData) then Exit;
      // write data to port via SysBus
      FWritePortProc(WAddress, Byte(IData));
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdRDME(AActionContext: TActionContext);
var
  Data:     Byte;
  VAddress: Variant;
  WAddress: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    Data := 0;
    VAddress := 0;
    WAddress := 0;
    // get and check arguments
    if ChkRegName(SArg1, True) then
    begin
      // address in register
      if not FScriptRuntime.GetRegister(SArg1[3], VAddress) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(VAddress), WAddress) then Exit;
      // read data from memory via SysBus
      Data := FReadMemoryFunc(WAddress);
      // store in accumulator
      if not FScriptRuntime.SetRegister('A', Data, False) then Exit;
    end else
    begin
      // address in value
      // check type
      if not TryStrToDWord(SArg1, WAddress) then Exit;
      // read data from memory via SysBus
      Data := FReadMemoryFunc(WAddress);
      // store in accumulator
      if not FScriptRuntime.SetRegister('A', Data, False) then Exit;
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdWRME(AActionContext: TActionContext);
var
  Data:     Variant;
  IData:    Integer;
  VAddress: Variant;
  WAddress: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    Data := 0;
    IData := 0;
    VAddress := 0;
    WAddress := 0;
    // get and check arguments
    if ChkRegName(SArg1, True) then
    begin
      // address in register
      if not FScriptRuntime.GetRegister(SArg1[3], VAddress) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(VAddress), WAddress) then Exit;
      // data in accumulator
      if not FScriptRuntime.GetRegister('A', Data) then Exit;
      // check value type
      if not TryStrToInt(VarToStr(Data), IData) then Exit;
      // write data to memory via SysBus
      FWriteMemoryProc(WAddress, Byte(IData));
    end else
    begin
      // address in value
      // check type
      if not TryStrToDWord(SArg1, WAddress) then Exit;
      // data in accumulator
      if not FScriptRuntime.GetRegister('A', Data) then Exit;
      // check value type
      if not TryStrToInt(VarToStr(Data), IData) then Exit;
      // write data to memory via SysBus
      FWriteMemoryProc(WAddress, Byte(IData));
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdLDRG(AActionContext: TActionContext);
var
  Data: Variant;
begin
  with AActionContext do
  begin
    HasError := True;
    Data := 0;
    // get and check arguments
    if not ChkRegName(SArg1, False) then Exit;
    if ChkRegName(SArg2, True) then
    begin
      // register 2 -> register 1
      if not FScriptRuntime.GetRegister(SArg2[3], Data) then Exit;
      if not FScriptRuntime.SetRegister(SArg1[2], Data, False) then Exit;
    end else
    begin
      // value -> register 1
      if not FScriptRuntime.SetRegister(SArg1[2], SArg2, False) then Exit;
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdSWAP(AActionContext: TActionContext);
var
  Temp1, Temp2: Variant;
begin
  with AActionContext do
  begin
    HasError := True;
    Temp1 := 0;
    Temp2 := 0;
    // get and check arguments
    if not (ChkRegName(SArg1, True) and ChkRegName(SArg2, True)) then Exit;
    // swap register content
    if not FScriptRuntime.GetRegister(SArg1[3], Temp1) then Exit;
    if not FScriptRuntime.GetRegister(SArg2[3], Temp2) then Exit;
    if not FScriptRuntime.SetRegister(SArg1[3], Temp2, False) then Exit;
    if not FScriptRuntime.SetRegister(SArg2[3], Temp1, False) then Exit;
    HasError := False;
  end;
end;

