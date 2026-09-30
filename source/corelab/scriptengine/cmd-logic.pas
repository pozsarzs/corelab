{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-logic.pas                                                            | }
{ | Logic commands                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ AND OR XOR NOT SHL SHR BIT }

procedure TScriptEngine.CmdAND(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Operandus2: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // get argument(s)
    if not TryStrToUint(SArg1, Operandus2) then Exit;
    // control and operation
    Operandus1 := Operandus1 and Operandus2;
    // set accu and flags
    if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
    if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdOR(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Operandus2: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // get argument(s)
    if not TryStrToUint(SArg1, Operandus2) then Exit;
    // control and operation
    Operandus1 := Operandus1 or Operandus2;
    // set accu and flags
    if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
    if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdXOR(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Operandus2: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // get argument(s)
    if not TryStrToUint(SArg1, Operandus2) then Exit;
    // control and operation
    Operandus1 := Operandus1 xor Operandus2;
    // set accu and flags
    if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
    if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdNOT(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
begin
  with AActionContext do
  begin
    HasError := True;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // control and operation
    Operandus1 := not Operandus1;
    // set accu and flags
    if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
    if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdSHL(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Operandus2: DWord;
  Carry:   Boolean;
begin
  with AActionContext do
  begin
    HasError := True;
    Carry := False;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // get argument(s)
    if not TryStrToUint(SArg1, Operandus2) then Exit;
    if Operandus2 > 31 then Operandus2 := 31;
    // control and operation
    if Operandus2 > 0 then
    begin
      Carry := ((Operandus1 shr (32 - Operandus2)) and 1) <> 0;
      Operandus1 := Operandus1 shl Operandus2;
      // set accu and flags
      if not FScriptRuntime.SetFlag('C', Carry) then Exit;
      if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    end;
    // set flag
    if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdSHR(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Operandus2: DWord;
  Carry:   Boolean;
begin
  with AActionContext do
  begin
    HasError := True;
    Carry := False;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // get argument(s)
    if not TryStrToUint(SArg1, Operandus2) then Exit;
    if Operandus2 > 31 then Operandus2 := 31;
    // control and operation
    if Operandus2 > 0 then
    begin
      Carry := ((Operandus1 shr (Operandus2 - 1)) and 1) <> 0;
      Operandus1 := Operandus1 shr Operandus2;
      // set accu and flags
      if not FScriptRuntime.SetFlag('C', Carry) then Exit;
      if not FScriptRuntime.SetRegister('A', Operandus1, True) then Exit;
    end;
    // set flag
    if not FScriptRuntime.SetFlag('Z', Operandus1 = 0) then Exit;
    HasError := False;
  end;
end;

procedure TScriptEngine.CmdBIT(AActionContext: TActionContext);
var
  Accu:       Variant;
  Operandus1: DWord;
  Operandus2: DWord;
  Zero:       Boolean;
begin
  with AActionContext do
  begin
    HasError := True;
    Zero := False;
    // get accu value
    Accu := 0;
    if not FScriptRuntime.GetRegister('A', Accu) then Exit;
    if not ChkVarInt(Accu) then Exit;
    Operandus1 := DWord(Accu);
    // get argument(s)
    if not TryStrToUint(SArg1, Operandus2) then Exit;
    if Operandus2 > 31 then Operandus2 := 31;
    // control and operation
    Zero := (Operandus1 and (1 shl Operandus2)) = 0;
    // set flag
    if not FScriptRuntime.SetFlag('Z', Zero) then Exit;
    HasError := False;
  end;
end;

