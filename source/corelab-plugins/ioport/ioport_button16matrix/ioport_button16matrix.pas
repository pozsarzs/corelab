{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_button16matrix.pas                                                | }
{ | 4x4 button matrix input implementation module                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_button16matrix;
{$mode objfpc}{$H+}
uses
  Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport;
type
  // 4x4 button matrix input implementation
  TButton16Matrix = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  const
    HORBUTCNT = 3;
    VERBUTCNT = 3;
  var
    CurrentPort: TButton16Matrix = nil;    
    PanelForm: TForm = nil;
    SB: array[0..HORBUTCNT, 0..VERBUTCNT] of TSpeedButton;
    SelLine: byte;
  
// Create TIOPort instance
constructor TButton16Matrix.Create;
begin
  inherited Create;
  FModname := '4x4 button matrix input';
  FDescription := 'Select the row (binary) and read the row status..';
  FHasGUI := true;
  FPortMode := pmReadWrite;
  FLatchedOutput := true;
end;

// Destroy TIOPort instance
destructor TButton16Matrix.Destroy;
begin
  inherited Destroy;
end;

// Read virtual port
function TButton16Matrix.ReadPort(Port: byte): byte;
var
  Value: byte;
  x, y: byte;
begin
  Value := 0;
  y := SelLine;
  for x := 0 to 3 do
    if SB[x, y].Down then Value := Value + (1 shl x);
  Result := Value;
  for x := 0 to 3 do
    for y := 0 to 3 do
      SB[x, y].Down := false;
end;

// Write virtual port
procedure TButton16Matrix.WritePort(Port: byte; Value: byte);
begin
  if Value <= 3SelLine := Value;
end;

// Reset virtual port
procedure TButton16Matrix.Reset;
var
  x, y: byte;
begin
  SelLine := 0;
  for x := 0 to 3 do
    for y := 0 to 3 do
      SB[x, y].Down := false;
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  Result := TButton16Matrix.Create;
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
  x := 4;
  y := 4;
  PanelForm.ClientWidth := (4 * (x + 1) + x * 34) + 8;
  PanelForm.ClientHeight := (4 * (y + 1) + y * 34) + 8;
  
  for x := 0 to 3 do
    for y := 0 to 3 do
    begin
      SB[x, y] := TSpeedButton.Create(nil);
      with SB[x, y] do
      begin
        Parent := PanelForm;
        Caption := IntToHex(y * 4 + x, 1);
        AllowAllUp := True;
        GroupIndex := y * 4 + x + 1;
        if y = 0 then Top := 8 else Top := (4 * (y + 1) + y * 34) + 4;
        if x = 0 then Left := 8 else Left := (4 * (x + 1) + x * 34) + 4;
        Height := 34;
        Width := Height;
      end;
    end;

  PanelForm.Constraints.MinWidth := PanelForm.Width;
  PanelForm.Constraints.MaxWidth := PanelForm.Width;
  PanelForm.Constraints.MinHeight := PanelForm.Height;
  PanelForm.Constraints.MaxHeight := PanelForm.Height;

  CurrentPort := TButton16Matrix(Port);
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
  x, y: byte;
begin
if Assigned(PanelForm) then
  begin
    PanelForm.Close;
    PanelForm.Free;
    PanelForm := nil;
    for x := 0 to 3 do
      for y := 0 to 3 do
        SB[x, y] := nil;
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
