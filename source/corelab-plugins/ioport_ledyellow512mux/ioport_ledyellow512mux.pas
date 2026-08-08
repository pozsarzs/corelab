{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_ledyellow512mux.pas                                               | }
{ | 8-LED output implementation module                                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_ledyellow512mux;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, Controls, Graphics, StdCtrls, ExtCtrls, SysUtils,
  Buttons, core_ioport, core_gioport, core_led, led_square;
const
  MAXX = 63;
  MAXY = 7;
type
  // 8x8-LED output class
  TLEDYellow512MUX = class(TGIOPort)
  private
    FValue:    array[0..MAXX] of Byte;
  protected
    FPanel:    TPanel;
    FPaintBox: TPaintBox;
    FLED:      array[0..MAXX, 0..MAXY] of TLEDSquare;
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

// ---- PROTECTED METHODS ----

// PAINTBOX ONPAINT EVENT
procedure TLEDYellow512MUX.PaintBoxPaint(Sender: TObject);
var
  x, y: Byte;
begin
  for x := 0 to MAXX do
    for y := 0 to MAXY do
      FLED[x, y].RenderTo(FPaintBox.Canvas, 1 + (16 * x), 1 + (16 * y));
end;

// ---- PUBLIC METHODS ----

// CREATE TLEDYELLOW512MUX INSTANCE
constructor TLEDYellow512MUX.Create;
var
  x, y: Byte;
begin
  inherited Create;
  FModname := '64x8-LED output';
  FDescription := 'Select the column and write the row status.';
  FAddressRangeSize:= 2;
  FSelLine := 0;
  FHasPanel := true;
  FLatchedOutput := true;
  for x := 0 to MAXX do
   for y := 0 to MAXY do
  begin
    FLED[x, y] := TLEDSquare.Create;
    with FLED[x, y] do
    begin
      Color := RETRO_COLORS[clRetroYellow];
      BGColor := clBackground;
      Reset;
    end;
  end;
end;

// DESTROY TLEDYELLOW512MUX INSTANCE
destructor TLEDYellow512MUX.Destroy;
var
  x, y: Byte;
begin
  for x := 0 to MAXX do
    for y := 0 to MAXy do
      FLED[x, y].Free;
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TLEDYellow512MUX.Reset;
var
  x, y: Byte;
begin
  for x := 0 to MAXX do
    for y := 0 to MAXy do
      FLED[x, y].Reset;
  if Assigned (FPaintBox) then FPaintBox.Invalidate;
end;

// READ VIRTUAL PORT
function TLEDYellow512MUX.ReadPort(APort: Word): Byte;
begin
  if FEnabled then Result := 0 else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TLEDYellow512MUX.WritePort(APort: Word; AValue: Byte);
var
  y:     Byte;
  Value: Byte;
begin
  if FEnabled then 
  case APort of
    0: begin
         FValue[FSelLine] := AValue;
         Value := FValue[FSelLine];
         if FDataInNegation then Value := not Value;
         for y := 0 to MAXY do
           FLED[FSelLine, y].IsOn := (Value and (1 shl y)) <> 0;
         if Assigned (FPaintBox) then FPaintBox.Invalidate;
       end;
    1: if AValue <= MAXX then FSelLine := AValue;
    end;
end;

// LOAD SAVED STATE
function TLEDYellow512MUX.LoadState(AStream: TStream): Boolean;
var
  x: Byte;
begin
  Result := inherited LoadState(AStream);
  if Result then
    try
      // display status
      for x := 0 to MAXX do
      begin
        AStream.ReadBuffer(FValue[x], SizeOf(FValue[x]));
        WritePort(1, x);
        WritePort(0, FValue[x]);
      end;
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function TLEDYellow512MUX.SaveState(AStream: TStream): Boolean;
var
  x: Byte;
begin
  Result := inherited SaveState(AStream);
  // display status
  if Result then
    for x := 0 to MAXX do
      AStream.WriteBuffer(FValue[x], SizeOf(FValue[x]));
end;

// CREATE PANEL
procedure TLEDYellow512MUX.CreatePanel;
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
    ClientWidth := (MAXX + 1) * 16 + FrameX + 3;
    ClientHeight := (MAXY + 1) * 16 + FrameY + 3;
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
  Result := TLEDYellow512MUX.Create;
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
  if Assigned(APort) and (APort is TLEDYellow512MUX)
    then TLEDYellow512MUX(APort).CreatePanel;
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
