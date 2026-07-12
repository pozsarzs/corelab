{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_disp1hexbcd.pas                                                   | }
{ | Hexadecimal display output implementation module                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_disp1hexbcd;
{$MODE OBJFPC}{$H+}
uses
  Interfaces, Forms, Controls, StdCtrls, ExtCtrls, SysUtils, Buttons,
  core_ioport, core_gioport, display_til311;
type
  // Hexadecimal display output class
  TDisp1HexBCD = class(TGIOPort)
  protected
    FPanel:    TPanel;
    FPaintBox: TPaintBox;
    FDP:       TDisplayTIL311;
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
procedure TDisp1HexBCD.PaintBoxPaint(Sender: TObject);
begin
    FDP.RenderTo(FPaintBox.Canvas, 1, 1);
end;

// CREATE TDISP1HEXBCD INSTANCE
constructor TDisp1HexBCD.Create;
begin
  inherited Create;
  FModname := 'Hexadecimal display with BCD input';
  FDescription := 'TIL311 style display; low nibble: BCD input, high nibble: 0-blank-ldp-rdp.';
  FHasPanel := true;
  FLatchedOutput := true;
  FDP := TDisplayTIL311.Create;
  FDP.Reset;
end;

// DESTROY TDISP1HEXBCD INSTANCE
destructor TDisp1HexBCD.Destroy;
begin
  FDP.Free;
  FreePanel;
  inherited Destroy;
end;

// READ VIRTUAL PORT
function TDisp1HexBCD.ReadPort(Port: byte): byte;
begin
  if FEnabled and (Port = 0) then Result := 0 else Result := $FF;
end;

// RESET VIRTUAL PORT
procedure TDisp1HexBCD.Reset;
begin
  FDP.Reset;
  FPaintBox.Invalidate;
end;

// WRITE VIRTUAL PORT
procedure TDisp1HexBCD.WritePort(Port: byte; Value: byte);
begin
  if FEnabled and (Port = 0) then 
    with FDP do
    begin
      SetBlank((Value and $40) > 0);
      SetLeftDot((Value and $20) > 0);
      SetRightDot((Value and $10) > 0);
      SetValue(Value and $0F);
      FPaintBox.Invalidate;
    end;
end;

// CREATE PANEL
procedure TDisp1HexBCD.CreatePanel;
begin
  if Assigned(FPanelForm) then exit;

  FPanelForm := TForm.Create(nil);
  with FPanelForm do
  begin
    Caption := StrPas(FPanelCaption);
    Position := poDefaultPosOnly;
    BorderIcons := [biSystemMenu, biMinimize];
  end;

  FPanel := TPanel.Create(FPanelForm);
  with FPanel do
  begin
    Parent := FPanelForm;
    BevelInner := bvLowered;
    BevelOuter := bvLowered;
    ClientWidth := 104 + FrameX;
    ClientHeight := 94 + FrameY;
    Left := 8;
    Top := 8;
  end;

  FPaintBox := TPaintBox.Create(FPanelForm);
  FPaintBox.Parent := FPanel;
  FPaintBox.Align := alClient;
  FPaintBox.OnPaint := @PaintBoxPaint;
  
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
  Result := TDisp1HexBCD.Create;
end;

procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Free;
end;

procedure CreatePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TDisp1HexBCD) then
    TDisp1HexBCD(Port).CreatePanel;
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
