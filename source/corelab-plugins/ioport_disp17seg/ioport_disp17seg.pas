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
{$MODE OBJFPC}{$H+}
uses
  Interfaces, Forms, Controls, StdCtrls, ExtCtrls, SysUtils, Buttons,
  core_ioport, core_gioport, display_til302;
type
  // 7 segments display output class
  TDisp17seg = class(TGIOPort)
  protected
    FPanel:     TPanel;
    FPaintBox:  TPaintBox;
    FDP:        TDisplayTIL302;
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

{$I BCD7seg_7447.pas}

// PAINTBOX ONPAINT EVENT
procedure TDisp17seg.PaintBoxPaint(Sender: TObject);
begin
    FDP.RenderTo(FPaintBox.Canvas, 1, 1);
end;

// CREATE TDISP17SEG INSTANCE
constructor TDisp17seg.Create;
begin
  inherited Create;
  FModname := '7 segments display';
  FDescription := 'TIL302 style display with direct inversable and BCD input.';
  FHasPanel := true;
  FLatchedOutput := true;
  FDP := TDisplayTIL302.Create;
  FDP.Reset;
end;

// DESTROY TDISP17SEG INSTANCE
destructor TDisp17seg.Destroy;
begin
  FDP.Free;
  FreePanel;
  inherited Destroy;
end;

// READ VIRTUAL PORT
function TDisp17seg.ReadPort(Port: byte): byte;
begin
  if FEnabled and (Port = 0) then Result := 0 else Result := $FF;
end;

// RESET VIRTUAL PORT
procedure TDisp17seg.Reset;
begin
  FDP.Reset;
  FPaintBox.Invalidate;
end;

// WRITE VIRTUAL PORT
procedure TDisp17seg.WritePort(Port: byte; Value: byte);
begin
  if FEnabled and (Port = 0) then 
    with FDP do
    begin
      case FDataOutMode of
        lmDirect: begin
                    if FDataOutNegation then Value := not Value;
                    SetRightDot((Value and $80) > 0);
                    SetSegments(Value and $7F);
                    FPaintBox.Invalidate;
                  end;
        lmBCD:    begin
                    SetRightDot((Value and $80) > 0);
                    SetSegments(BCD7seg_7447[Value and $7F]);
                    FPaintBox.Invalidate;
                  end;
       end;           
    end;
end;

// CREATE PANEL
procedure TDisp17seg.CreatePanel;
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
  Result := TDisp17seg.Create;
end;

procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Free;
end;

procedure CreatePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TDisp17seg) then
    TDisp17seg(Port).CreatePanel;
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
