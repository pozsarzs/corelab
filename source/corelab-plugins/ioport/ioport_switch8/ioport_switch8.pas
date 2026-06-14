{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_switch8.pas                                                       | }
{ | 8-switch input implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_switch8;
{$mode objfpc}{$H+}
uses
  Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport;
type
  // 8-switch input implementation
  TSwitch8Port = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  var
    CurrentPort: TSwitch8Port = nil;    
    PanelForm: TForm = nil;
    SB: array[0..7] of TSpeedButton;
  
// Create TIOPort instance
constructor TSwitch8Port.Create;
begin
  inherited Create;
  FModname := '8-switch input';
  FDescription := 'This is an 8-switch input, each button controls a specific bit within a byte.';
  FHasGUI := true;
  FPortMode := pmReadOnly;
  Reset;
end;

// Destroy TIOPort instance
destructor TSwitch8Port.Destroy;
begin
  inherited Destroy;
end;

// Read virtual port
function TSwitch8Port.ReadPort(Port: byte): byte;
var
  b: byte;
  Value: integer;
begin
  Value := 0;
  for b := 0 to 7 do
    if SB[b].Down then Value := Value + (1 shl b);
  Result := Value;
end;

// Write virtual port
procedure TSwitch8Port.WritePort(Port: byte; Value: byte);
begin
end;

// Reset virtual port
procedure TSwitch8Port.Reset;
begin
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  result := TSwitch8Port.Create;
end;

// Exportable function for destroy TIOPort instance
procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Destroy;
end;

// Exportable function for create UI panel
procedure CreatePanel(Port: TIOPort); cdecl;
var
  b: byte;
begin
  if Assigned(PanelForm) then exit;

  PanelForm := TForm.Create(nil);
  PanelForm.Caption := Port.ModName;
  PanelForm.Position := poDefaultPosOnly;
  PanelForm.BorderIcons := [biSystemMenu, biMinimize];
  PanelForm.ClientWidth := 294;
  PanelForm.ClientHeight := 50;
  
  for b := 0 to 7 do
  begin
    SB[b] := TSpeedButton.Create(nil);
    with SB[b] do
    begin
      Parent := PanelForm;
      Caption := IntToStr(b);
      AllowAllUp := True;
      GroupIndex := b + 1;
      Top := 8;
      Left := 8 + b * 34;
      Height := 34;
      Width := Height;
    end;
  end;

  PanelForm.Constraints.MinWidth := PanelForm.Width;
  PanelForm.Constraints.MaxWidth := PanelForm.Width;
  PanelForm.Constraints.MinHeight := PanelForm.Height;
  PanelForm.Constraints.MaxHeight := PanelForm.Height;

  CurrentPort := TSwitch8Port(Port);
end;

// Exportable function for show UI panel
procedure ShowPanel; cdecl;
begin
  if Assigned(PanelForm) then PanelForm.Show;
end;

// Exportable function for hide UI panel
procedure HidePanel; cdecl;
begin
  if Assigned(PanelForm) then PanelForm.Hide;
end;

// Exportable function for destroy UI panel
procedure FreePanel; cdecl;
var
  b: byte;
begin
if Assigned(PanelForm) then
  begin
    PanelForm.Close;
    PanelForm.Free;
    PanelForm := nil;
    for b := 0 to 7 do SB[b] := nil;
  end;
end;

// Exportable function for move and resize UI panel
procedure SetSizePosPanel(Left, Top, Width, Height: integer); cdecl;
begin
  if Assigned(PanelForm) then
  begin
    PanelForm.Left := Left;
    PanelForm.Top := Top;
    PanelForm.Width := Width;
    PanelForm.Height := Height;
  end;
end;

// Exported functions and procedures
exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';
exports CreatePanel name 'ioport_createpanel';
exports ShowPanel name 'ioport_showpanel';
exports HidePanel name 'ioport_hidepanel';
exports FreePanel name 'ioport_freepanel';
exports SetSizePosPanel name  'ioport_setsizepospanel';

begin
end.
