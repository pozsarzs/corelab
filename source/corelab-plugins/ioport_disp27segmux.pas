{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_disp27segmux.pas                                                  | }
{ | 7 segments display output implementation module                          | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_disp27segmux;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, Controls, StdCtrls, ExtCtrls, SysUtils,
  Buttons, core_ioport, core_gioport, display_til302;
const
  MAXX = 1;
type
  { TDisp27segMUX }
  TDisp27segMUX = class(TGIOPort)
  private
    FValue:    array[0..MAXX] of Byte;
  protected
    FPanel:    TPanel;
    FPaintBox: TPaintBox;
    FDP:       array[0..MAXX] of TDisplayTIL302;
    FSelLine:  Byte;
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

{ TDisp27segMUX }

// ---- PROTECTED METHODS ----

// PAINTBOX ONPAINT EVENT
procedure TDisp27segMUX.PaintBoxPaint(Sender: TObject);
var
  b: Byte;
begin
  for b := 0 to MAXX do FDP[b].RenderTo(FPaintBox.Canvas, 1 + (112 * b), 1);
end;

// ---- PUBLIC METHODS ----

// CREATE TDISP27SEGMUX INSTANCE
constructor TDisp27segMUX.Create;
var
  b: Byte;
begin
  inherited Create;
  FModname := '2-digit 7 segments multiplexed display';
  FDescription := 'TIL302 style display; A0: direct inversable input, A1: select.';
  FAddressRangeSize:= 2;
  FHasPanel := true;
  FLatchedOutput := true;
  FSelLine := 0;
  for b := 0 to MAXX do
  begin
    FDP[b] := TDisplayTIL302.Create;
    FDP[b].Reset;
  end;
end;

// DESTROY TDISP27SEGMUX INSTANCE
destructor TDisp27segMUX.Destroy;
var
  b: Byte;
begin
  for b := 0 to MAXX do FDP[b].Free;
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TDisp27segMUX.Reset;
var
  b: Byte;
begin
  for b := 0 to MAXX do FDP[b].Reset;
  if Assigned (FPaintBox) then FPaintBox.Invalidate;
end;

// READ VIRTUAL PORT
function TDisp27segMUX.ReadPort(APort: Word): Byte;
begin
  if FEnabled then Result := 0 else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TDisp27segMUX.WritePort(APort: Word; AValue: Byte);
begin
  if FEnabled then 
  case APort of
    0: begin
         FValue[FSelLine] := AValue;
         with FDP[FSelLine] do
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
    1: if AValue <= MAXX then FSelLine := AValue;
    end;
end;

// LOAD SAVED STATE
function TDisp27segMUX.LoadState(AStream: TStream): Boolean;
var
  b: Byte;
begin
  Result := inherited LoadState(AStream);
  if Result then
    try
      // display status
      for b := 0 to MAXX do
      begin
        AStream.ReadBuffer(FValue[b], SizeOf(FValue[b]));
        WritePort(1, b);
        WritePort(0, FValue[b]);
      end;
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function TDisp27segMUX.SaveState(AStream: TStream): Boolean;
var
  b: Byte;
begin
  Result := inherited SaveState(AStream);
  // display status
  if Result then
    for b := 0 to MAXX do
      AStream.WriteBuffer(FValue[b], SizeOf(FValue[b]));
end;

// CREATE PANEL
procedure TDisp27segMUX.CreatePanel;
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

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TDisp27segMUX.Create;
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
  if Assigned(APort) and (APort is TDisp27segMUX)
    then TDisp27segMUX(APort).CreatePanel;
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
