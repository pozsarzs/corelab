{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_disp17segbcd.pas                                                  | }
{ | 7 segments display output implementation module                          | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_disp17seg;
{$mode objfpc}{$H+}
uses
  Interfaces, Forms, Controls, StdCtrls, ExtCtrls, SysUtils, Buttons,
  core_ioport, display_til302;
type
  // 7 segments display output implementation
  TDisp17Seg = class(TIOPort)
  protected
    procedure PaintBoxPaint(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  var
    PanelForm: TForm = nil;
    Panel : TPanel = nil;
    PaintBox: TPaintBox = nil;
    DP: TDisplayTIL302;

// PaintBox onPaint event
procedure TDisp17Seg.PaintBoxPaint(Sender: TObject);
begin
    DP.RenderTo(PaintBox.Canvas, 1, 1);
end;

// Create TIOPort instance
constructor TDisp17Seg.Create;
var
  s: string;
begin
  inherited Create;
  s := '7 segments display';
  FModname := PChar(s);
  s := 'TIL302 style display with direct inversable input.';
  FDescription := PChar(s);
  FHasGUI := true;
  FLatchedOutput := true;
  FPortMode := pmWriteOnly;
  DP := TDisplayTIL302.Create;
  DP.Reset;
end;

// Destroy TIOPort instance
destructor TDisp17Seg.Destroy;
begin
  DP.Free;
  inherited Destroy;
end;

// Read virtual port
function TDisp17Seg.ReadPort(Port: byte): byte;
begin
  Result := 0;
end;

// Write virtual port
procedure TDisp17Seg.WritePort(Port: byte; Value: byte);
begin
  with DP do
  begin
    if FInNegation then Value := not Value;
    SetRightDot((Value and $80) > 0);
    SetSegments(Value and $7F);
    PaintBox.Invalidate;
  end;
end;

// Reset virtual port
procedure TDisp17Seg.Reset;
begin
  DP.Reset;
  PaintBox.Invalidate;
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  Result := TDisp17Seg.Create;
end;

// Exportable function for destroy TIOPort instance
procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Destroy;
end;

// Exportable function for create UI panel
procedure CreatePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(PanelForm) then exit;

  PanelForm := TForm.Create(nil);
  with PanelForm do
  begin
    Caption := Port.Title;
    Position := poDefaultPosOnly;
    BorderIcons := [biSystemMenu, biMinimize];
  end;

  Panel := TPanel.Create(PanelForm);
  with Panel do
  begin
    Parent := PanelForm;
    BevelInner := bvLowered;
    BevelOuter := bvLowered;
    ClientWidth := 104 + FrameX;
    ClientHeight := 94 + FrameY;
    Left := 8;
    Top := 8;
  end;

  PaintBox := TPaintBox.Create(PanelForm);
  PaintBox.Parent := Panel;
  PaintBox.Align := alClient;
  PaintBox.OnPaint := @TDisp17Seg(Port).PaintBoxPaint;
  
  with PanelForm do
  begin
    ClientWidth := Panel.Width + 16;
    ClientHeight := Panel.Height + 16;
    Constraints.MinWidth := Width;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MaxHeight := Height;
  end;
end;

// Exportable function for show UI panel
procedure ShowPanel; cdecl; export;
begin
  if Assigned(PanelForm) then PanelForm.Show;
end;

// Exportable function for hide UI panel
procedure HidePanel; cdecl; export;
begin
  if Assigned(PanelForm) then PanelForm.Hide;
end;

// Exportable function for destroy UI panel
procedure FreePanel; cdecl; export;
begin
if Assigned(PanelForm) then
  begin
    DP.Free;
    DP := nil;
    PanelForm.Close;
    PanelForm.Free;
    PanelForm := nil;
  end;
end;

// Exportable function for move and resize UI panel
procedure SetSizePosPanel(Left, Top, Width, Height: integer); cdecl; export;
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
