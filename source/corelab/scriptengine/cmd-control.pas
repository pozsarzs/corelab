{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-control.pas                                                          | }
{ | Control commands                                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ COMP INRG JUMP JPZE JPNZ JPCA JPNC CALL RTRN }

procedure TScriptEngine.CmdCOMP(AActionContext: TActionContext);
var
  Operandus1: DWord;
  Operandus2: DWord;
  Overflow:   Boolean;
  Temp:       Variant;
begin
  with AActionContext do
  begin
    HasError := True;
    Overflow := False;
    // get accu value
    Temp := 0;
    if not FScriptRuntime.GetRegister('A', Temp) then Exit;
    // check type
    if not TryStrToDWord(VarToStr(Temp), Operandus1) then Exit;
    if ChkRegName(SArg1, True) then
    begin
      // value in register
      if not FScriptRuntime.GetRegister(SArg1[3], Temp) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(Temp), Operandus2) then Exit;
    end else
    begin
      // direct value
      if not TryStrToDWord(SArg1, Operandus2) then Exit;
    end;
    // control and operation
    Overflow := Operandus2 > Operandus1;
    Operandus1 := Operandus1 - Operandus2;
    // set flags
    if not FScriptRuntime.SetFlag('C', Overflow) then Exit;
    if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdINRG(AActionContext: TActionContext);
var
  Operandus1: DWord;
  Operandus2: DWord;
  Operandus3: DWord;
  Swap:       DWord;
  Temp:       Variant;
  Zero:       Boolean;
begin
  with AActionContext do
  begin
    HasError := True;
    Zero := False;
    // get accu value
    Temp := 0;
    if not FScriptRuntime.GetRegister('A', Temp) then Exit;
    // check type
    if not TryStrToDWord(VarToStr(Temp), Operandus1) then Exit;
    // get operandus 2
    if ChkRegName(SArg1, True) then
    begin
      // value in register
      if not FScriptRuntime.GetRegister(SArg1[3], Temp) then Exit;
      // check type
      if not TryStrToDWord(VarToStr(Temp), Operandus2) then Exit;
    end else
    begin
      // direct value
      if not TryStrToDWord(SArg1, Operandus2) then Exit;
    end;
    // get operandus 3
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
    if Operandus2 > Operandus3 then
    begin
      Swap := Operandus3;
      Operandus3 := Operandus2;
      Operandus2 := Swap;
    end;
    // control and operation
    Zero := (Operandus1 >= Operandus2) and (Operandus1 <= Operandus3);
    // set flags
    if not FScriptRuntime.SetFlag('C', False) then Exit;
    if not FScriptRuntime.SetFlag('Z', Zero) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdJUMP(AActionContext: TActionContext);
var
  NewLine: Integer;
begin
  with AActionContext do
  begin
    HasError := not FScriptRuntime.FindLabel(UpperCase(SArg1), NewLine);
    if not HasError then FScriptRuntime.SetRegister('C', NewLine, True);
  end;
end;

procedure TScriptEngine.CmdJPZE(AActionContext: TActionContext);
var
  NewLine: Integer;
  Zero:    Boolean;
begin
  with AActionContext do
  begin
    Zero := False;
    HasError := not FScriptRuntime.GetFlag('Z', Zero);
    if HasError then Exit;
    if Zero then
    begin
      HasError := not FScriptRuntime.FindLabel(UpperCase(SArg1), NewLine);
      if HasError then Exit;
      HasError := not FScriptRuntime.SetRegister('C', NewLine, True);
    end;
  end;
end;

procedure TScriptEngine.CmdJPNZ(AActionContext: TActionContext);
var
  NewLine: Integer;
  Zero:    Boolean;
begin
  with AActionContext do
  begin
    Zero := False;
    HasError := not FScriptRuntime.GetFlag('Z', Zero);
    if HasError then Exit;
    if not Zero then
    begin
      HasError := not FScriptRuntime.FindLabel(UpperCase(SArg1), NewLine);
      if HasError then Exit;
      HasError := not FScriptRuntime.SetRegister('C', NewLine, True);
    end;
  end;
end;

procedure TScriptEngine.CmdJPCA(AActionContext: TActionContext);
var
  NewLine: Integer;
  Carry:    Boolean;
begin
  with AActionContext do
  begin
    Carry := False;
    HasError := not FScriptRuntime.GetFlag('C', Carry);
    if HasError then Exit;
    if Carry then
    begin
      HasError := not FScriptRuntime.FindLabel(UpperCase(SArg1), NewLine);
      if HasError then Exit;
      HasError := not FScriptRuntime.SetRegister('C', NewLine, True);
    end;
  end;
end;

procedure TScriptEngine.CmdJPNC(AActionContext: TActionContext);
var
  NewLine: Integer;
  Carry:    Boolean;
begin
  with AActionContext do
  begin
    Carry := False;
    HasError := not FScriptRuntime.GetFlag('C', Carry);
    if HasError then Exit;
    if not Carry then
    begin
      HasError := not FScriptRuntime.FindLabel(UpperCase(SArg1), NewLine);
      if HasError then Exit;
      HasError := not FScriptRuntime.SetRegister('C', NewLine, True);
    end;
  end;
end;

procedure TScriptEngine.CmdCALL(AActionContext: TActionContext);
var
  OrigLine: Variant;
  NewLine: Integer;
begin
  OrigLine := 0;
  with AActionContext do
  begin
    HasError := not FScriptRuntime.FindLabel(UpperCase(SArg1), NewLine);
    if not HasError then
    begin
      FScriptRuntime.GetRegister('C', OrigLine);
      HasError := not FScriptRuntime.PushCallStack(Integer(OrigLine) + 1);
      if not HasError then FScriptRuntime.SetRegister('C', NewLine, True);
    end;
  end;
end;

procedure TScriptEngine.CmdRTRN(AActionContext: TActionContext);
var
  RetLine: Integer;
begin
  with AActionContext do
  begin
    HasError := not FScriptRuntime.PopCallStack(RetLine);
    if not HasError then FScriptRuntime.SetRegister('C', RetLine, True);
  end;
end;

