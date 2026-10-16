{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-other.pas                                                            | }
{ | Other commands                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ CONV PRNT WAIT END EXIT }

procedure TScriptEngine.CmdCONV(AActionContext: TActionContext);
var
  Operandus1: DWord;
  Operandus3: DWord;
  s:          string;
  Temp:       Variant;
begin
  with AActionContext do
  begin
    HasError := True;
    // get accu value
    Temp := 0;
    if not FScriptRuntime.GetRegister('A', Temp) then Exit;
    // check value type
    if not TryStrToDWord(VarToStr(Temp), Operandus1) then Exit;
    // get target register
    if not ChkRegName(SArg1, False) then Exit;
    // get base (2, 8, 16)
    if ChkRegName(SArg2, True) then
    begin
      // value in register
      if not FScriptRuntime.GetRegister(SArg2[3], Temp) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(Temp), Operandus3) then Exit;
    end else
    begin
      // direct value
      if not TryStrToDWord(SArg2, Operandus3) then Exit;
    end;
    // convert value $RA
    case Operandus3 of
      2: s := DezToBin(IntToStr(Operandus1));
      8: s := DezToOkt(IntToStr(Operandus1));
      16: s := DezToHex(IntToStr(Operandus1));
    else
      Exit;
    end;
    // store in target register
    if not FScriptRuntime.SetRegister(SArg1[2], s, False) then Exit;
    // set flags
    if not FScriptRuntime.SetFlag('C', False) then Exit;
    if not FScriptRuntime.SetFlag('Z', False) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdPRNT(AActionContext: TActionContext);
var
  Text1, Text2: Variant;
begin
  with AActionContext do
  begin
    HasError := True;
    Text1 := '';
    Text2 := '';
    // get and check arguments
    if ChkRegName(SArg1, True) then
    begin
      if not FScriptRuntime.GetRegister(SArg1[3], Text1) then Exit;
      Text1 := VarToStr(Text1);
    end else Text1 := SArg1;
    if ChkRegName(SArg2, True) then
    begin
      if not FScriptRuntime.GetRegister(SArg2[3], Text2) then Exit;
      Text2 := VarToStr(Text2);
    end else Text2 := SArg2;
    Form12.WriteMessage(Format('%s%s', [Text1, Text2]));
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdWAIT(AActionContext: TActionContext);
var
  Delay:  Variant;
  WDelay: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    Delay := 0;
    WDelay := 0;
    // get and check arguments
    if ChkRegName(SArg1, True) then
    begin
      // address in register
      if not FScriptRuntime.GetRegister(SArg1[3], Delay) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(Delay), WDelay) then Exit;
      // sleeping
      Sleep(WDelay);
    end else
    begin
      // address in value
      // check type
      if not TryStrToDWord(SArg1, WDelay) then Exit;
      // sleeping
      Sleep(WDelay);
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdEND(AActionContext: TActionContext);
begin
  AActionContext.HasError := False;
  FScriptRuntime.MainEnded := True;
end;

procedure TScriptEngine.CmdEXIT(AActionContext: TActionContext);
begin
  AActionContext.HasError := False;
  FScriptRuntime.ScriptExited := True;
end;
