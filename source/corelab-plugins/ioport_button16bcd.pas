{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_button16bcd.pas                                                   | }
{ | 4x4 button input implementation module                                   | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_button16bcd;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport,
  core_gioport;
const
  MAXX = 3;                               // Index of the last button in the row
  MAXY = 3;                            // Index of the last button in the column
type
  { TButton16BCD }
  TButton16BCD = class(TGIOPort)
  protected
    FSB: array[0..MAXX, 0..MAXY] of TSpeedButton;                     // Buttons
    procedure AllRelease(Amx, Amy: Byte);
    procedure FSBOnClick(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Reset; override;
    function ReadPort(APort: Word): Byte; override;
    procedure WritePort(APort: Word; AValue: Byte); override;
    procedure CreatePanel; override;
  end;

{ TButton16BCD }

// ---- PROTECTED METHODS ----

// RELEASE ALL BUTTONS
procedure TButton16BCD.AllRelease(Amx, Amy: Byte);
var
  x, y: Byte;
begin
  for x := 0 to Amx do
    for y := 0 to Amy do
      FSB[x, y].Down := false;
end;

// COMMON ONCLICK EVENT
procedure TButton16BCD.FSBOnClick(Sender: TObject);
begin
  RequestInterrupt;
end;

// ---- PUBLIC METHODS ----
  
// CREATE TBUTTON16BCD INSTANCE
constructor TButton16BCD.Create;
begin
  inherited Create;
  FModname := '4x4 button matrix input with BCD output';
  FDescription := 'One button can be pressed at a time, the value of which can be read in BCD format.';
  FHasPanel := true;
end;

// DESTROY TBUTTON16BCD INSTANCE
destructor TButton16BCD.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TButton16BCD.Reset;
begin
  AllRelease(MAXX, MAXY);
end;

// READ VIRTUAL PORT
function TButton16BCD.ReadPort(APort: Word): Byte;
var
  x, y: Byte;
begin
  if FEnabled and (APort = 0) then
  begin
    for x := 0 to MAXX do
      for y := 0 to MAXY do
        if FSB[x, y].Down then Result := y * 4 + x;
    AllRelease(MAXX, MAXY);
  end else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TButton16BCD.WritePort(APort: Word; AValue: Byte);
begin
end;

// CREATE PANEL
procedure TButton16BCD.CreatePanel;
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
  Result := TButton16BCD.Create;
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
  if Assigned(APort) and (APort is TButton16BCD)
    then TButton16BCD(APort).CreatePanel;
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
