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
  Operandus:  Integer;
begin
  AActionContext.HasError := False;
  with FScriptRuntime do
  begin
    AActionContext.HasError := GetRegister('A', Operandus);
    if not AActionContext.HasError
      then SetRegister('A', Operandus and AActionContext.DArg1, True);
  end;
end;

procedure TScriptEngine.CmdOR(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdXOR(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdNOT(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdSHL(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdSHR(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdBIT(AActionContext: TActionContext);
begin
end;
