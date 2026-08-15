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
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, Controls, StdCtrls, ExtCtrls, SysUtils,
  Buttons, core_ioport, core_gioport, display_til302;
type
  // 7 segments display output class
  TDisp17seg = class(TGIOPort)
  private
    FValue:     Byte;
  protected
    FPanel:     TPanel;
    FPaintBox:  TPaintBox;
    FDP:        TDisplayTIL302;
    procedure PaintBoxPaint(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Reset; override;
    function ReadPort(APort: Word): Byte; override;
    procedure WritePort(APort: Word; AValue: Byte); override;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    procedure CreatePanel; override;
  end;

{$I BCD7seg_7447.pas}

// ---- PROTECTED METHODS ----

// PAINTBOX ONPAINT EVENT
procedure TDisp17seg.PaintBoxPaint(Sender: TObject);
begin
    FDP.RenderTo(FPaintBox.Canvas, 1, 1);
end;

// ---- PUBLIC METHODS ----

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

// RESET VIRTUAL PORT
procedure TDisp17seg.Reset;
begin
  FDP.Reset;
  if Assigned (FPaintBox) then FPaintBox.Invalidate;
end;

// READ VIRTUAL PORT
function TDisp17seg.ReadPort(APort: Word): Byte;
begin
  if FEnabled and (APort = 0) then Result := 0 else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TDisp17seg.WritePort(APort: Word; AValue: Byte);
begin
  if FEnabled and (APort = 0) then
  begin 
    FValue := AValue;
    with FDP do
    begin
      case FDataOutMode of
        lmDirect: begin
                    if FDataOutNegation then AValue := not AValue;
                    SetRightDot((AValue and $80) > 0);
                    SetSegments(AValue and $7F);
                    if Assigned (FPaintBox) then FPaintBox.Invalidate;
                  end;
        lmBCD:    begin
                    SetRightDot((AValue and $80) > 0);
                    SetSegments(BCD7seg_7447[AValue and $7F]);
                    if Assigned (FPaintBox) then FPaintBox.Invalidate;
                  end;
       end;           
    end;
  end;
end;

// LOAD SAVED STATE
function TDisp17seg.LoadState(AStream: TStream): Boolean;
begin
  Result := inherited LoadState(AStream);
  if Result then
    try
      // display status
      AStream.ReadBuffer(FValue, SizeOf(FValue));
      WritePort(0, FValue);
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function TDisp17seg.SaveState(AStream: TStream): Boolean;
begin
  Result := inherited SaveState(AStream);
  // display status
  if Result then AStream.WriteBuffer(FValue, SizeOf(FValue));
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
function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TDisp17seg.Create;
end;

procedure DestroyPort(APort: TIOPort); CALLTYPE; export;
begin
  if Assigned(APort) then APort.Free;
end;

procedure SetIntHandler(APort: TIOPort; AIntProc: TInterruptCallback; AIntVect: Byte); CALLTYPE; export;
begin
  if Assigned(APort) then
  begin
    APort.OnInterrupt := AIntProc;
    APort.IntVector := AIntVect;
  end;
end;

function LoadState(APort: TIOPort; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.LoadState(AStream)
    else Result := false;
end;

function SaveState(APort: TIOPort; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.SaveState(AStream)
    else Result := false;
end;

procedure CreatePanel(APort: TIOPort); CALLTYPE; export;
begin
  if Assigned(APort) and (APort is TDisp17seg)
    then TDisp17seg(APort).CreatePanel;
end;

procedure FreePanel(APort: TIOPort); CALLTYPE; export;
begin
  if Assigned(APort) and (APort is TGIOPort)
    then TGIOPort(APort).FreePanel;
end;

procedure ShowPanel(APort: TIOPort); CALLTYPE; export;
begin
  if Assigned(APort) and (APort is TGIOPort)
    then TGIOPort(APort).ShowPanel;
end;

procedure HidePanel(APort: TIOPort); CALLTYPE; export;
begin
  if Assigned(APort) and (APort is TGIOPort)
    then TGIOPort(APort).HidePanel;
end;

procedure RenamePanel(APort: TIOPort; ACaption: PChar); CALLTYPE; export;
begin
  if Assigned(APort) and (APort is TGIOPort)
    then TGIOPort(APort).RenamePanel(ACaption);
end;

function ResizePanel(APort: TIOPort; AWidth, AHeight: Integer): Boolean; CALLTYPE; export;
begin
  Result := False;
  if Assigned(APort) and (APort is TGIOPort)
    then Result := TGIOPort(APort).ResizePanel(AWidth, AHeight);
end;

function MovePanel(APort: TIOPort; ALeft, ATop: Integer): Boolean; CALLTYPE; export;
begin
  Result := False;
  if Assigned(APort) and (APort is TGIOPort)
    then Result := TGIOPort(APort).MovePanel(ALeft, ATop);
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';
exports SetIntHandler name 'ioport_setinthandler';
exports LoadState name 'ioport_loadstate';
exports SaveState name 'ioport_savestate';
exports CreatePanel name 'ioport_createpanel';
exports FreePanel name 'ioport_freepanel';
exports HidePanel name 'ioport_hidepanel';
exports ShowPanel name 'ioport_showpanel';
exports RenamePanel name 'ioport_renamepanel';
exports ResizePanel name 'ioport_resizepanel';
exports MovePanel name 'ioport_movepanel';

begin
end.
