{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_button8.pas                                                       | }
{ | 8-button input implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_button8;
{$mode objfpc}{$H+}
uses
  Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport;
type
  // 8-button input implementation
  TButton8Port = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  var
    CurrentPort: TButton8Port = nil;    
    PanelForm: TForm = nil;
    SB: array[0..7] of TSpeedButton;
  
// Create TIOPort instance
constructor TButton8Port.Create;
begin
  inherited Create;
  FModname := '8-button input';
  FDescription := 'This is an 8-button input, each button controls a specific bit within a byte.';
  FHasGUI := true;
  FPortMode := pmReadOnly;
end;

// Destroy TIOPort instance
destructor TButton8Port.Destroy;
begin
  inherited Destroy;
end;

// Read virtual port
function TButton8Port.ReadPort(Port: byte): byte;
var
  x: byte;
  Value: integer;
begin
  Value := 0;
  for x := 0 to 7 do
    if SB[x].Down then Value := Value + (1 shl x);
  Result := Value;
  Reset;
end;

// Write virtual port
procedure TButton8Port.WritePort(Port: byte; Value: byte);
begin
end;

// Reset virtual port
procedure TButton8Port.Reset;
var
  x: byte;
begin
  for x := 0 to 7 do SB[x].Down := false;
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  result := TButton8Port.Create;
end;

// Exportable function for destroy TIOPort instance
procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Destroy;
end;

// Exportable function for create UI panel
procedure CreatePanel(Port: TIOPort); cdecl;
var
  x, y: byte;
begin
  if Assigned(PanelForm) then exit;

  PanelForm := TForm.Create(nil);
  PanelForm.Caption := Port.Title;
  PanelForm.Position := poDefaultPosOnly;
  PanelForm.BorderIcons := [biSystemMenu, biMinimize];
  x := 8;
  y := 1;
  PanelForm.ClientWidth := (4 * (x + 1) + x * 34) + 8;
  PanelForm.ClientHeight := (4 * (y + 1) + y * 34) + 8;
  
  for x := 0 to 7 do
  begin
    SB[x] := TSpeedButton.Create(nil);
    with SB[x] do
    begin
      Parent := PanelForm;
      Caption := IntToStr(x);
      AllowAllUp := True;
      GroupIndex := x + 1;
      Top := 8;
      if x = 0 then Left := 8 else Left := (4 * (x + 1) + x * 34) + 4;
      Height := 34;
      Width := Height;
    end;
  end;

  PanelForm.Constraints.MinWidth := PanelForm.Width;
  PanelForm.Constraints.MaxWidth := PanelForm.Width;
  PanelForm.Constraints.MinHeight := PanelForm.Height;
  PanelForm.Constraints.MaxHeight := PanelForm.Height;

  CurrentPort := TButton8Port(Port);
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
  x: byte;
begin
if Assigned(PanelForm) then
  begin
    PanelForm.Close;
    PanelForm.Free;
    PanelForm := nil;
    for x := 0 to 7 do SB[x] := nil;
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
