{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_switch16bcd.pas                                                   | }
{ | 4x4 switch input implementation module                                   | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_switch16bcd;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport,
  core_gioport;
const
  MAXX = 3;                               // Index of the last switch in the row
  MAXY = 3;                            // Index of the last switch in the column
type
  { TSwitch16BCD }
  TSwitch16BCD = class(TGIOPort)
  protected
    FSB: array[0..MAXX, 0..MAXY] of TSpeedButton;                    // switches
    procedure AllRelease(Amx, Amy: Byte);
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

{ TSwitch16BCD }

// ---- PROTECTED METHODS ----

// RELEASE ALL SWITCHES
procedure TSwitch16BCD.AllRelease(Amx, Amy: Byte);
var
  x, y: Byte;
begin
  for x := 0 to Amx do
    for y := 0 to Amy do
      FSB[x, y].Down := false;
end;

// COMMON ONCLICK EVENT
procedure TSwitch16BCD.FSBOnClick(Sender: TObject);
begin
  RequestInterrupt;
end;

// ---- PUBLIC METHODS ----
  
// CREATE TSWITCH16BCD INSTANCE
constructor TSwitch16BCD.Create;
begin
  inherited Create;
  FModname := '4x4 switch matrix input with BCD output';
  FDescription := 'One switch can be pressed at a time, the value of which can be read in BCD format.';
  FHasPanel := true;
end;

// DESTROY TSWITCH16BCD INSTANCE
destructor TSwitch16BCD.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TSwitch16BCD.Reset;
begin
  AllRelease(MAXX, MAXY);
end;

// READ VIRTUAL PORT
function TSwitch16BCD.ReadPort(APort: Word): Byte;
var
  x, y: Byte;
begin
  if FEnabled and (APort = 0) then
  begin
    for x := 0 to MAXX do
      for y := 0 to MAXY do
        if FSB[x, y].Down then Result := y * 4 + x;
  end else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TSwitch16BCD.WritePort(APort: Word; AValue: Byte);
begin
end;

// LOAD SAVED STATE
function TSwitch16BCD.LoadState(AStream: TStream): Boolean;
var
  x, y: Byte;
  o:    Boolean;
begin
  Result := inherited LoadState(AStream);
  if Result then
    try
      // button status
      for x := 0 to MAXX do
        for y := 0 to MAXY do
        begin
          AStream.ReadBuffer(o, SizeOf(o));
          FSB[x, y].Down := o;
        end;
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function TSwitch16BCD.SaveState(AStream: TStream): Boolean;
var
  x, y: Byte;
  o:    Boolean;
begin
  Result := inherited SaveState(AStream);
  if Result then
    // button status
    for x := 0 to MAXX do
      for y := 0 to MAXY do
      begin
        o := FSB[x, y].Down;
        AStream.WriteBuffer(o, SizeOf(o));
      end;
end;

// CREATE PANEL
procedure TSwitch16BCD.CreatePanel;
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
    y := MAXY + 1;
    ClientWidth := (4 * (x + 1) + x * 34) + 8;
    ClientHeight := (4 * (y + 1) + y * 34) + 8;
  end;
  
  for x := 0 to MAXX do
    for y := 0 to MAXY do
    begin
      FSB[x, y] := TSpeedButton.Create(FPanelForm);
      with FSB[x, y] do
      begin
        Parent := FPanelForm;
        Caption := IntToHex(y * 4 + x, 1);
        AllowAllUp := True;
        GroupIndex := 1;
        if y = 0 then Top := 8 else Top := (4 * (y + 1) + y * 34) + 4;
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
  Result := TSwitch16BCD.Create;
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
  if Assigned(APort) and (APort is TSwitch16BCD)
    then TSwitch16BCD(APort).CreatePanel;
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
