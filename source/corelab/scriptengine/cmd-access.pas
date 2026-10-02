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

{ DEPO EXAM SWAP }


procedure TScriptEngine.CmdRDIO(AActionContext: TActionContext);
begin
  writeln(FReadPortFunc(12));
end;

procedure TScriptEngine.CmdWRIO(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdRDME(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdWRME(AActionContext: TActionContext);
var
  Temp: Variant;
begin
//  Temp := FSysBus.ReadMemory(12);
end;

procedure TScriptEngine.CmdLDRG(AActionContext: TActionContext);
var
  Temp: Variant;
begin
  with AActionContext do
  begin
    HasError := True;
    Temp := 0;
    // get and check arguments
    if not ChkRegName(SArg1) then Exit;
    if ChkRegName(SArg2) then
    begin
      // register 2 -> register 1
      if not FScriptRuntime.GetRegister(SArg2[3], Temp) then Exit;
      if not FScriptRuntime.SetRegister(SArg1[3], Temp, False) then Exit;
    end else
    begin
      // value -> register 1
      if not FScriptRuntime.SetRegister(SArg1[3], SArg2, False) then Exit;
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
    if not (ChkRegName(SArg1) and ChkRegName(SArg2)) then Exit;
    // swap register content
    if not FScriptRuntime.GetRegister(SArg1[3], Temp1) then Exit;
    if not FScriptRuntime.GetRegister(SArg2[3], Temp2) then Exit;
    if not FScriptRuntime.SetRegister(SArg1[3], Temp2, False) then Exit;
    if not FScriptRuntime.SetRegister(SArg2[3], Temp1, False) then Exit;
    HasError := False;
  end;
end;

