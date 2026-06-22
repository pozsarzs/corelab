{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_disp2hexmuxbcd.pas                                                   | }
{ | Hexadecimal display output implementation module                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_disp2hexmuxbcd;
{$mode objfpc}{$H+}
uses
  Interfaces, Forms, Controls, StdCtrls, ExtCtrls, SysUtils, Buttons,
  core_ioport, display_til311;
type
  // Hexadecimal display output implementation
  TDisp2HexMuxBCD = class(TIOPort)
  protected
    procedure PaintBoxPaint(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  const
    MAXX = 1;
  var
    PanelForm: TForm = nil;
    Panel : TPanel = nil;
    PaintBox: TPaintBox = nil;
    DP: array[0..MAXX] of TDisplayTIL311;
    SelLine: byte;

// PaintBox onPaint event
procedure TDisp2HexMuxBCD.PaintBoxPaint(Sender: TObject);
var
  b: byte;
begin
  for b := 0 to MAXX do  DP[b].RenderTo(PaintBox.Canvas, 1 + (104 * b), 1);
end;

// Create TIOPort instance
constructor TDisp2HexMuxBCD.Create;
var
  b: byte;
  s: string;
begin
  inherited Create;
  s := '2 pcs. hexadecimal multiplexed display with BCD input';
  FModname := PChar(s);
  s := 'TIL311 style display; A0: low nibble: BCD input, high nibble: 0-blank-ldp-rdp., A1: select';
  FDescription := PChar(s);
  FAddressRangeSize:= 2;
  FHasGUI := true;
  FLatchedOutput := true;
  FPortMode := pmWriteOnly;
  SelLine := 0;
  for b := 0 to MAXX do
  begin
    DP[b] := TDisplayTIL311.Create;
    DP[b].Reset;
  end;
end;

// Destroy TIOPort instance
destructor TDisp2HexMuxBCD.Destroy;
var
  b: byte;
begin
  for b := 0 to MAXX do DP[b].Free;
  inherited Destroy;
end;

// Read virtual port
function TDisp2HexMuxBCD.ReadPort(Port: byte): byte;
begin
  Result := 0;
end;

// Write virtual port
procedure TDisp2HexMuxBCD.WritePort(Port: byte; Value: byte);
begin
  case Port of
    0: with DP[SelLine] do
       begin
         SetBlank((Value and $40) > 0);
         SetLeftDot((Value and $20) > 0);
         SetRightDot((Value and $10) > 0);
         SetValue(Value and $0F);
         PaintBox.Invalidate;
       end;
    1: if Value <= MAXX then SelLine := Value;
    end;
end;

// Reset virtual port
procedure TDisp2HexMuxBCD.Reset;
var
  b: byte;
begin
  for b := 0 to MAXX do DP[b].Reset;
  PaintBox.Invalidate;
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  Result := TDisp2HexMuxBCD.Create;
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
    ClientWidth := (MAXX + 1) * 104 + FrameX;
    ClientHeight := 94 + FrameY;
    Left := 8;
    Top := 8;
  end;

  PaintBox := TPaintBox.Create(PanelForm);
  PaintBox.Parent := Panel;
  PaintBox.Align := alClient;
  PaintBox.OnPaint := @TDisp2HexMuxBCD(Port).PaintBoxPaint;
  
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
var
  b: byte;
begin
if Assigned(PanelForm) then
  begin
    for b := 0 to MAXX do
    begin
      DP[b].Free;
      DP[b] := nil;
    end;
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
