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
  TActionSource = (asMainMenu, asToolBar, asModuleExplorer,
                   asSysConsole, asScript, asProject);
  { TActionContext }
  TActionContext = class
  public
    ActionSource:  TActionSource;
      // Target module
    InstanceName:  string;
    ModuleType:    string;
    // Common module properties
    Enabled:       Boolean;
    AttachedToBus: Boolean;
    constructor Create;
  end;
  { TIOActionContext }
  TIOActionContext = class(TActionContext)
    public
      // Visual properties
      PanelCaption: string;
      PanelLeft:    Integer;
      PanelTop:     Integer;
      PanelWidth:   Integer;
      PanelHeight:  Integer;
      PanelShow:    Boolean;
    constructor Create;
  end;
  { TMActionContext }
  TMActionContext = class(TActionContext)
    public
    constructor Create;
  end;
  { TPActionContext }
  TPActionContext = class(TActionContext)
    public
    constructor Create;
  end;

implementation

{ TActionContext }
constructor TActionContext.Create;
begin
  inherited Create;
  ActionSource := asMainMenu;
  InstanceName := '';
  ModuleType := '';
  Enabled := False;
  AttachedToBus := False;
end;

{ TIOActionContext }
constructor TIOActionContext.Create;
begin
  inherited Create;
  PanelCaption := 'MyIO';
  PanelHeight := 100;
  PanelLeft := 8;
  PanelShow := True;
  PanelTop := 8;
  PanelWidth := 100;
end;

{ TPActionContext }
constructor TMActionContext.Create;
begin
  inherited Create;
end;

{ TMActionContext }
constructor TPActionContext.Create;
begin
  inherited Create;
end;

end.

