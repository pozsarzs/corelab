{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_switch8.pas                                                       | }
{ | 8-switch input implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_switch8;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport,
  core_gioport;
const
  MAXX = 7;                               // Index of the last switch in the row
type
  // 8-switch input class
  TSwitch8 = class(TGIOPort)
  protected
    FSB: array[0..MAXX] of TSpeedButton;
    procedure AllRelease(Amx: Byte);
    procedure FSBOnClick(Sender: TObject);
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

// RELEASE ALL SWITCHES
procedure TSwitch8.AllRelease(Amx: Byte);
var
  x: Byte;
begin
  for x := 0 to Amx do
    FSB[x].Down := false;
end;

// COMMON ONCLICK EVENT
procedure TSwitch8.FSBOnClick(Sender: TObject);
begin
  RequestInterrupt;
end;

// ---- PUBLIC METHODS ----
  
// CREATE TSWITCH8 INSTANCE
constructor TSwitch8.Create;
begin
  inherited Create;
  FModname := '8-switch input';
  FDescription := 'This is an 8-switch input, each switch controls a specific bit within a Byte.';
  FHasPanel := true;
end;

// DESTROY TSWITCH8 INSTANCE
destructor TSwitch8.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TSwitch8.Reset;
begin
  AllRelease(MAXX);
end;

// READ VIRTUAL PORT
function TSwitch8.ReadPort(APort: Word): Byte;
var
  x:     Byte;
  Value: Integer;
begin
  if FEnabled and (APort = 0) then
  begin
    Value := 0;
    for x := 0 to MAXX do
      if FSB[x].Down then Value := Value + (1 shl x);
    if FDataOutNegation then Value := not Value;
    Result := Value;
  end else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TSwitch8.WritePort(APort: Word; AValue: Byte);
begin
end;

// LOAD SAVED STATE
function TSwitch8.LoadState(AStream: TStream): Boolean;
var
  x: Byte;
  o: Boolean;
begin
  Result := inherited LoadState(AStream);
  if Result then
    try
      // button status
      for x := 0 to MAXX do
      begin
        AStream.ReadBuffer(o, SizeOf(o));
        FSB[x].Down := o;
      end;
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function TSwitch8.SaveState(AStream: TStream): Boolean;
var
  x: Byte;
  o: Boolean;
begin
  Result := inherited SaveState(AStream);
  if Result then
    // button status
    for x := 0 to MAXX do
    begin
      o := FSB[x].Down;
      AStream.WriteBuffer(o, SizeOf(o));
    end;
end;

// CREATE PANEL
procedure TSwitch8.CreatePanel;
var
  x, y: Byte;
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
    x := MAXX + 1;
    y := 1;
    ClientWidth := (4 * (x + 1) + x * 34) + 8;
    ClientHeight := (4 * (y + 1) + y * 34) + 8;
  end;
  
  for x := 0 to MAXX do
  begin
    FSB[x] := TSpeedButton.Create(FPanelForm);
    with FSB[x] do
    begin
      Parent := FPanelForm;
      Caption := IntToStr(x);
      AllowAllUp := True;
      GroupIndex := x + 1;
      Top := 8;
      if x = 0 then Left := 8 else Left := (4 * (x + 1) + x * 34) + 4;
      Height := 34;
      Width := Height;
      OnClick := @FSBOnClick;
    end;
  end;

  with FPanelForm do
  begin
    Constraints.MinWidth := Width;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MaxHeight := Height;
  end;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TSwitch8.Create;
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
  if Assigned(APort) and (APort is TSwitch8)
    then TSwitch8(APort).CreatePanel;
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
