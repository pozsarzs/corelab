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
var
  Text: Variant;
begin
  with AActionContext do
  begin
    HasError := True;
    Text := '';
    // get and check arguments
    if ChkRegName(SArg1, True) then
    begin
      // address in register
      if not FScriptRuntime.GetRegister(SArg1[3], Text) then Exit;
      // write to console
      Form12.WriteMessage(VarToStr(Text));
    end else
    begin
      // address in value
      // write to console
      Form12.WriteMessage(SArg1);
    end;
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
      if not ChkVarInt(Delay) then Exit;
      // sleeping
      Sleep(DWord(Delay));
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
end;

procedure TScriptEngine.CmdEXIT(AActionContext: TActionContext);
begin
end;
