{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uactcontext.pas                                                          | }
{ | TActionContext class                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uactcontext;
{$MODE OBJFPC} {$H+} {$MACRO ON}
interface
type
  // source of action type
  TActionSource = (asMainMenu, asToolBar, asModuleExplorer, asSysConsole,
                   asScript, asProject, asOther);
  { TActionContext }
  TActionContext = class
  public
    constructor Create;
    ActionSource:  TActionSource;                            // source of action
    SArg1:  string;                 // arguments from to ...Operation procedures
    SArg2:  string;
    IArg1:  Integer;
    IArg2:  Integer;
    BArg1:  Boolean;
    BArg2:  Boolean;
    DArg1:  DWord;
    DArg2:  DWord;
  end;

implementation

{ TActionContext }

// CREATE TACTIONCONTEXT INSTANCE
constructor TActionContext.Create;
begin
  inherited Create;
  ActionSource := asMainMenu;
  SArg1 := '';
  SArg2 := '';
  IArg1 := -1;
  IArg2 := -1;
  BArg1 := false;
  BArg2 := false;
  DArg1 := 0;
  DArg2 := 0;
end;

end.
