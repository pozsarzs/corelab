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
  core_ioport, core_gioport, display_til311;
const
  MAXX = 1;
type
  // Hexadecimal display output class
  TDisp2HexMUXBCD = class(TGIOPort)
  protected
    FPanel : TPanel;
    FPaintBox: TPaintBox;
    FDP: array[0..MAXX] of TDisplayTIL311;
    FSelLine: byte;
    procedure PaintBoxPaint(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    // - port
    function ReadPort(Port: byte): byte; override;
    procedure Reset;  override;
    procedure WritePort(Port: byte; Value: byte); override;
    // - panel
    procedure CreatePanel; override;
  end;

// PAINTBOX ONPAINT EVENT
procedure TDisp2HexMUXBCD.PaintBoxPaint(Sender: TObject);
var
  b: byte;
begin
  for b := 0 to MAXX do FDP[b].RenderTo(FPaintBox.Canvas, 1 + (112 * b), 1);
end;

// CREATE TDISP2HEXMUXBCD INSTANCE
constructor TDisp2HexMUXBCD.Create;
var
  b: byte;
begin
  inherited Create;
  FModname := '2-digit hexadecimal multiplexed display with BCD input';
  FDescription := 'TIL311 style display; A0: low nibble: BCD input, high nibble: 0-blank-ldp-rdp., A1: select.';
  FAddressRangeSize:= 2;
  FHasPanel := true;
  FLatchedOutput := true;
  FSelLine := 0;
  for b := 0 to MAXX do
  begin
    FDP[b] := TDisplayTIL311.Create;
    FDP[b].Reset;
  end;
end;

// DESTROY TDISP2HEXMUXBCD INSTANCE
destructor TDisp2HexMUXBCD.Destroy;
var
  b: byte;
begin
  for b := 0 to MAXX do FDP[b].Free;
  FreePanel;
  inherited Destroy;
end;

// READ VIRTUAL PORT
function TDisp2HexMUXBCD.ReadPort(Port: byte): byte;
begin
  if FEnabled then Result := 0 else Result := $FF;
end;

// RESET VIRTUAL PORT
procedure TDisp2HexMUXBCD.Reset;
var
  b: byte;
begin
  for b := 0 to MAXX do FDP[b].Reset;
  FPaintBox.Invalidate;
end;

// WRITE VIRTUAL PORT
procedure TDisp2HexMUXBCD.WritePort(Port: byte; Value: byte);
begin
  case Port of
    0: with FDP[FSelLine] do
       begin
         SetBlank((Value and $40) > 0);
         SetLeftDot((Value and $20) > 0);
         SetRightDot((Value and $10) > 0);
         SetValue(Value and $0F);
         FPaintBox.Invalidate;
       end;
    1: if Value <= MAXX then FSelLine := Value;
    end;
end;

// CREATE PANEL
procedure TDisp2HexMUXBCD.CreatePanel;
begin
  if Assigned(FPanelForm) then exit;

  FPanelForm := TForm.Create(nil);
  with FPanelForm do
  begin
    Caption := StrPas(FPanelCaption);
    Position := poDesigned;
    BorderIcons := [biSystemMenu, biMinimize];
    FPanelLeft := Left;
    FPanelTop := Top;
    FPanelHeight := Height;
    FPanelWidth := Width;
  end;

  FPanel := TPanel.Create(FPanelForm);
  with FPanel do
  begin
    Parent := FPanelForm;
    BevelInner := bvLowered;
    BevelOuter := bvLowered;
    ClientWidth := (MAXX + 1) * 112 + FrameX;
    ClientHeight := 94 + FrameY;
    Left := 8;
    Top := 8;
  end;

  FPaintBox := TPaintBox.Create(FPanelForm);
  with FPaintBox do
  begin
    Parent := FPanel;
    Align := alClient;
    OnPaint := @PaintBoxPaint;
  end;
  
  with FPanelForm do
  begin
    ClientWidth := FPanel.Width + 16;
    ClientHeight := FPanel.Height + 16;
    Constraints.MinWidth := Width;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MaxHeight := Height;
  end;
end;

// EXPORTABLE FUNCTIONS AND PROCEDURES
function CreatePort: TIOPort; cdecl; export;
begin
  Result := TDisp2HexMUXBCD.Create;
end;

procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Free;
end;

procedure CreatePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TDisp2HexMUXBCD) then
    TDisp2HexMUXBCD(Port).CreatePanel;
end;

procedure FreePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).FreePanel;
end;

procedure HidePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).HidePanel;
end;

function MovePanel(Port: TIOPort; Left, Top: Integer): Boolean; cdecl; export;
begin
  Result := False;
  if Assigned(Port) and (Port is TGIOPort) then
    Result := TGIOPort(Port).MovePanel(Left, Top);
end;

procedure RenamePanel(Port: TIOPort; Caption: PChar); cdecl; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).RenamePanel(Caption);
end;

function ResizePanel(Port: TIOPort; Width, Height: Integer): Boolean; cdecl; export;
begin
  Result := False;
  if Assigned(Port) and (Port is TGIOPort) then
    Result := TGIOPort(Port).ResizePanel(Width, Height);
end;

procedure ShowPanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).ShowPanel;
end;

// EXPORTED FUNCTIONS AND PROCEDURES
// - port
exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';
// - panel
exports CreatePanel name 'ioport_createpanel';
exports FreePanel name 'ioport_freepanel';
exports HidePanel name 'ioport_hidepanel';
exports MovePanel name 'ioport_movepanel';
exports RenamePanel name 'ioport_renamepanel';
exports ResizePanel name 'ioport_resizepanel';
exports ShowPanel name 'ioport_showpanel';

begin
end.
