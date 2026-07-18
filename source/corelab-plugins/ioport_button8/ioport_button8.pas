{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_button8.pas                                                       | }
{ | 8-button input implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_button8;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport,
  core_gioport;
const
  MAXX = 7;                             // Index of the last button in the row
type
  // 8-button input class
  TButton8 = class(TGIOPort)
  protected
    FSB: array[0..MAXX] of TSpeedButton;
    procedure AllRelease(mx: byte);
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

// RELEASE ALL BUTTONS
procedure TButton8.AllRelease(mx: byte);
var
  x: byte;
begin
  for x := 0 to mx do
    FSB[x].Down := false;
end;
  
// CREATE TBUTTON8 INSTANCE
constructor TButton8.Create;
begin
  inherited Create;
  FModname := '8-button input';
  FDescription := 'This is an 8-button input, each button controls a specific bit within a byte.';
  FHasPanel := true;
end;

// DESTROY TBUTTON8 INSTANCE
destructor TButton8.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// READ VIRTUAL PORT
function TButton8.ReadPort(Port: byte): byte;
var
  x: byte;
  Value: integer;
begin
  if FEnabled and (Port = 0) then
  begin
    Value := 0;
    for x := 0 to MAXX do
      if FSB[x].Down then Value := Value + (1 shl x);
    if FDataOutNegation then Value := not Value;
    Result := Value;
    AllRelease(MAXX);
  end else Result := $FF;
end;

// RESET VIRTUAL PORT
procedure TButton8.Reset;
begin
  AllRelease(MAXX);
end;

// WRITE VIRTUAL PORT
procedure TButton8.WritePort(Port: byte; Value: byte);
begin
end;

// CREATE PANEL
procedure TButton8.CreatePanel;
var
  x, y: byte;
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

// EXPORTABLE FUNCTIONS AND PROCEDURES
function CreatePort: TIOPort; CALLTYPE; export;
begin
  result := TButton8.Create;
end;

procedure DestroyPort(Port: TIOPort); CALLTYPE; export;
begin
  if Assigned(Port) then Port.Free;
end;

procedure CreatePanel(Port: TIOPort); CALLTYPE; export;
begin
  if Assigned(Port) and (Port is TButton8) then
    TButton8(Port).CreatePanel;
end;
procedure FreePanel(Port: TIOPort); CALLTYPE; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).FreePanel;
end;

procedure HidePanel(Port: TIOPort); CALLTYPE; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).HidePanel;
end;

function MovePanel(Port: TIOPort; Left, Top: Integer): Boolean; CALLTYPE; export;
begin
  Result := False;
  if Assigned(Port) and (Port is TGIOPort) then
    Result := TGIOPort(Port).MovePanel(Left, Top);
end;

procedure RenamePanel(Port: TIOPort; Caption: PChar); CALLTYPE; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).RenamePanel(Caption);
end;

function ResizePanel(Port: TIOPort; Width, Height: Integer): Boolean; CALLTYPE; export;
begin
  Result := False;
  if Assigned(Port) and (Port is TGIOPort) then
    Result := TGIOPort(Port).ResizePanel(Width, Height);
end;

procedure ShowPanel(Port: TIOPort); CALLTYPE; export;
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
