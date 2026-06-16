{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_button16mtx.pas                                                   | }
{ | 4x4 button matrix input implementation module                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_button16mtx;
{$mode objfpc}{$H+}
uses
  Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport;
type
  // 4x4 button matrix input implementation
  TButton16Mtx = class(TIOPort)
  protected
    procedure AllRelease(mx, my: byte);
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  const
    MAXX = 3;
    MAXY = 3;
  var
    CurrentPort: TButton16Mtx = nil;    
    PanelForm: TForm = nil;
    SB: array[0..MAXX, 0..MAXY] of TSpeedButton;
    SelLine: integer;

// Release all buttons
procedure TButton16Mtx.AllRelease(mx, my: byte);
var
  x, y: byte;
begin
  for x := 0 to mx do
    for y := 0 to my do
      SB[x, y].Down := false;
end;
  
// Create TIOPort instance
constructor TButton16Mtx.Create;
var
  s: string;
begin
  inherited Create;
  s := (IntToStr(MAXX + 1)) + 'x' + PChar(IntToStr(MAXY + 1)) + ' button matrix input';
  FModname := PChar(s);
  FDescription := 'Select the column and read the row status..';
  FHasGUI := true;
  FPortMode := pmReadWrite;
  FLatchedOutput := true;
end;

// Destroy TIOPort instance
destructor TButton16Mtx.Destroy;
begin
  inherited Destroy;
end;

// Read virtual port
function TButton16Mtx.ReadPort(Port: byte): byte;
var
  Value: byte;
  x, y: byte;
begin
  Result := 0;
  if SelLine = (-1) then exit;
  Value := 0;
  x := SelLine;
  for y := 0 to MAXY do
    if SB[x, y].Down then Value := Value + (1 shl y);

  if FOutNegation then Value := not Value;
  Result := Value;
  AllRelease(MAXX, MAXY);
end;

// Write virtual port
procedure TButton16Mtx.WritePort(Port: byte; Value: byte);
var
  i: integer;
begin
  if FSelNegation then Value := not Value;
  if Value = 0 then
  begin
    SelLine := -1;
    exit;
  end;
  i := 0;
  while Value > 1 do
  begin
    Value := Value shr 1;
    Inc(i);
  end;
  SelLine := i;
end;

// Reset virtual port
procedure TButton16Mtx.Reset;
begin
  SelLine := 0;
  AllRelease(MAXX, MAXY);
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  Result := TButton16Mtx.Create;
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
  x := MAXX + 1;
  y := MAXY + 1;
  PanelForm.ClientWidth := (4 * (x + 1) + x * 34) + 8;
  PanelForm.ClientHeight := (4 * (y + 1) + y * 34) + 8;
  
  for x := 0 to MAXX do
    for y := 0 to MAXY do
    begin
      SB[x, y] := TSpeedButton.Create(nil);
      with SB[x, y] do
      begin
        Parent := PanelForm;
        Caption := IntToHex(x, 1) + IntToHex(y, 1);
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

  CurrentPort := TButton16Mtx(Port);
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
    for x := 0 to MAXX do
      for y := 0 to MAXY do
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
