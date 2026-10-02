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
begin
end;

procedure TScriptEngine.CmdPRNT(AActionContext: TActionContext);
begin
//  HasError := True;
  // get argument and operation
  WriteLn(AActionContext.SArg1);
  //Form12.WriteMessage(VarToText(AActionContext.SArg1));
//  HasError := False;
end;

procedure TScriptEngine.CmdWAIT(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdEND(AActionContext: TActionContext);
begin
end;

procedure TScriptEngine.CmdEXIT(AActionContext: TActionContext);
begin
end;
