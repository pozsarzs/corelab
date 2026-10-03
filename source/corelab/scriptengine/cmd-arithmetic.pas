{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-arithmetic.pas                                                       | }
{ | Arithmetic commands                                                      | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ ADD SUB MUL INC DEC }

procedure TScriptEngine.CmdADD(AActionContext: TActionContext);
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
    if not ChkVarInt(Temp) then Exit;
    Operandus1 := DWord(Temp);
    if ChkRegName(SArg1, True) then
    begin
      // value in register
      if not FScriptRuntime.GetRegister(SArg1[3], Temp) then Exit;
      // check type
      if not ChkVarInt(Temp) then Exit;
      Operandus2 := DWord(Temp);
    end else
    begin
      // direct value
      if not TryStrToDWord(SArg1, Operandus2) then Exit;
    end;
    // control and operation
    if Operandus2 <= High(DWord) - Operandus1
      then Operandus1 := Operandus1 + Operandus2
      else Overflow := True;
    // set accu and flags
    if not FScriptRuntime.SetFlag('C', Overflow) then Exit;
    if not OverFlow then
    begin
      if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
      if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdSUB(AActionContext: TActionContext);
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
    if not ChkVarInt(Temp) then Exit;
    Operandus1 := DWord(Temp);
    if ChkRegName(SArg1, True) then
    begin
      // value in register
      if not FScriptRuntime.GetRegister(SArg1[3], Temp) then Exit;
      // check type
      if not ChkVarInt(Temp) then Exit;
      Operandus2 := DWord(Temp);
    end else
    begin
      // direct value
      if not TryStrToDWord(SArg1, Operandus2) then Exit;
    end;
    // control and operation
    if Operandus2 <= Operandus1
      then Operandus1 := Operandus1 - Operandus2
      else Overflow := True;
    // set accu and flags
    if not FScriptRuntime.SetFlag('C', Overflow) then Exit;
    if not OverFlow then
    begin
      if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
      if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdMUL(AActionContext: TActionContext);
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
    if not ChkVarInt(Temp) then Exit;
    Operandus1 := DWord(Temp);
    if ChkRegName(SArg1, True) then
    begin
      // value in register
      if not FScriptRuntime.GetRegister(SArg1[3], Temp) then Exit;
      // check type
      if not ChkVarInt(Temp) then Exit;
      Operandus2 := DWord(Temp);
    end else
    begin
      // direct value
      if not TryStrToDWord(SArg1, Operandus2) then Exit;
    end;
    // control and operation
    if (Operandus1 <> 0) and (Operandus2 > High(DWord) div Operandus1)
      then Overflow := True
      else Operandus1 := Operandus1 * Operandus2;
    // set accu and flags
    if not FScriptRuntime.SetFlag('C', Overflow) then Exit;
    if not OverFlow then
    begin
      if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
      if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdINC(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Overflow:   Boolean;
begin
  with AActionContext do
  begin
    HasError := True;
    OverFlow := False;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // control and operation
    if Operandus1 >= High(DWord)
      then Overflow := True
      else Operandus1 := Operandus1 + 1;
    // set accu and flags
    if not FScriptRuntime.SetFlag('C', Overflow) then Exit;
    if not OverFlow then
    begin
      if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
      if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    end;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdDEC(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Overflow:   Boolean;
begin
  with AActionContext do
  begin
    HasError := True;
    OverFlow := False;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // control and operation
    if Operandus1 <= 0
      then Overflow := True
      else Operandus1 := Operandus1 - 1;
    // set accu and flags
    if not FScriptRuntime.SetFlag('C', Overflow) then Exit;
    if not OverFlow then
    begin
      if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
      if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    end;
    HasError := False;
  end;
end;

