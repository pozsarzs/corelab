{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uactcontext.pas                                                          | }
{ | ActionContext class                                                      | }
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
  TActionSource = (asMainMenu, asToolBar, asModuleExplorer, asSysConsole,
                   asScript, asProject);
  // ActionContext class
  TActionContext = class
  public
    ActionSource:  TActionSource;
    SArg1:  string;
    SArg2:  string;
    IArg1:  Integer;
    IArg2:  Integer;
    BArg1:  Boolean;
    BArg2:  Boolean;
    // ezek megszűnnek
    InstanceName:  string;
    ModuleType:    string;
    Enabled:       Boolean;
    AttachedToBus: Boolean;
    PanelCaption: string;
    PanelLeft:    Integer;
    PanelTop:     Integer;
    PanelWidth:   Integer;
    PanelHeight:  Integer;
    PanelShow:    Boolean;
    constructor Create;
  end;

implementation

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
  // ezek megszűnnek
  InstanceName := '';
  ModuleType := '';
  Enabled := False;
  AttachedToBus := False;
  PanelCaption := 'MyIO';
  PanelHeight := 100;
  PanelLeft := 8;
  PanelShow := True;
  PanelTop := 8;
  PanelWidth := 100;
end;

end.

