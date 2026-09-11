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
  TActionSource = (asDefault, asModuleExplorer, asSysConsole, asScript, asProject);
  TActionContext = class
  public
    Source: TActionSource;
    // Target module
    InstanceName:    string;
    ModuleType:      string;
    // Common module properties
    Enabled:         Boolean;
    AttachedToBus:   Boolean;
    BaseAddress:     DWord;
    InterruptVector: Byte;
    // Visual properties
    PanelCaption:    string;
    PanelLeft:       Integer;
    PanelTop:        Integer;
    PanelWidth:      Integer;
    PanelHeight:     Integer;
    PanelShow:       Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TActionContext.Create;
begin
  inherited Create;
  Source := asDefault;
  AttachedToBus := False;
  BaseAddress := 0;
  Enabled := False;
  InstanceName := '';
  InterruptVector := 0;
  ModuleType := '';
  PanelCaption := 'MyIO';
  PanelHeight := 100;
  PanelLeft := 8;
  PanelShow := True;
  PanelTop := 8;
  PanelWidth := 100;
end;

destructor TActionContext.Destroy;
begin
  inherited Destroy;
end;

end.
