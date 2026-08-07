{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_ledyellow8.pas                                                    | }
{ | 8-LED output implementation module                                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_ledyellow8;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, Controls, Graphics, StdCtrls, ExtCtrls, SysUtils,
  Buttons, core_ioport, core_gioport, core_led, led_round;
const
  MAXX = 7;
type
  // 8-LED output class
  TLEDYellow8 = class(TGIOPort)
  private
    FValue:    Byte;
  protected
    FPanel:    TPanel;
    FPaintBox: TPaintBox;
    FLED:      array[0..MAXX] of TLEDRound;
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

// ---- PROTECTED METHODS ----

// PAINTBOX ONPAINT EVENT
procedure TLEDYellow8.PaintBoxPaint(Sender: TObject);
var
  b: Byte;
begin
  for b := 0 to MAXX do FLED[b].RenderTo(FPaintBox.Canvas, 1 + (26 * b), 1);
end;

// ---- PUBLIC METHODS ----

// CREATE TLEDYELLOW8 INSTANCE
constructor TLEDYellow8.Create;
var
  b: Byte;
begin
  inherited Create;
  FModname := '8-LED output';
  FDescription := 'This is an output with yellow LEDs, each bit controls a specific LED within a Byte.';
  FAddressRangeSize:= 1;
  FHasPanel := true;
  FLatchedOutput := true;
  for b := 0 to MAXX do
  begin
    FLED[b] := TLEDRound.Create;
    with FLED[b] do
    begin
      Color := RETRO_COLORS[clRetroYellow];
      BGColor := clBackground;
      Reset;
    end;
  end;
end;

// DESTROY TLEDYELLOW8 INSTANCE
destructor TLEDYellow8.Destroy;
var
  b: Byte;
begin
  for b := 0 to MAXX do FLED[b].Free;
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TLEDYellow8.Reset;
var
  b: Byte;
begin
  for b := 0 to MAXX do FLED[b].Reset;
  if Assigned (FPaintBox) then FPaintBox.Invalidate;
end;

// READ VIRTUAL PORT
function TLEDYellow8.ReadPort(APort: Word): Byte;
begin
  if FEnabled then Result := 0 else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TLEDYellow8.WritePort(APort: Word; AValue: Byte);
var
  b:     Byte;
  Value: Byte;
begin
  if FEnabled and (APort = 0) then
  begin   
    FValue := AValue;
    Value := FValue;
    if FDataInNegation then Value := not Value;
    for b := 0 to MAXX do
      FLED[b].IsOn := (Value and (1 shl b)) <> 0;
    if Assigned (FPaintBox) then FPaintBox.Invalidate;
  end;
end;

// LOAD SAVED STATE
function TLEDYellow8.LoadState(AStream: TStream): Boolean;
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
function TLEDYellow8.SaveState(AStream: TStream): Boolean;
begin
  Result := inherited SaveState(AStream);
  // display status
  if Result then
    AStream.WriteBuffer(FValue, SizeOf(FValue));
end;

// CREATE PANEL
procedure TLEDYellow8.CreatePanel;
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
    ClientWidth := (MAXX + 1) * 26 + FrameX;
    ClientHeight := 26 + FrameY;
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
  Result := TLEDYellow8.Create;
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
  if Assigned(APort) and (APort is TLEDYellow8)
    then TLEDYellow8(APort).CreatePanel;
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
