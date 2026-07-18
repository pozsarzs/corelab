{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_button16mux.pas                                                   | }
{ | 4x4 button matrix input implementation module                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_button16mux;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  Cmem, Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport,
  core_gioport;
const
  MAXX = 3;
  MAXY = 3;
type
  // 4x4 button matrix input class
  TButton16MUX = class(TGIOPort)
  protected
    FSB: array[0..MAXX, 0..MAXY] of TSpeedButton;                     // Buttons
    SelLine: integer;
    procedure AllRelease(mx, my: byte);
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
procedure TButton16MUX.AllRelease(mx, my: byte);
var
  x, y: byte;
begin
  for x := 0 to mx do
    for y := 0 to my do
      FSB[x, y].Down := false;
end;

// CREATE TBUTTON16MUX INSTANCE
constructor TButton16MUX.Create;
begin
  inherited Create;
  FModname := '4x4 button matrix input';
  FDescription := 'Select the column and read the row status..';
  FHasPanel := true;
  FAddressRangeSize := 2;
  FLatchedOutput := true;
  SelLine := 0;
end;

// DESTROY TBUTTON16MUX INSTANCE
destructor TButton16MUX.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// READ VIRTUAL PORT
function TButton16MUX.ReadPort(Port: byte): byte;
var
  Value: byte;
  x, y: byte;
begin
  Result := $FF;
  if FEnabled and (Port = 0) then
  begin
    if (SelLine < 0) or (SelLine > MAXX) then exit;
    x := SelLine;
    Value := 0;
    for y := 0 to MAXY do
      if FSB[x, y].Down then
      begin
        Value := Value + (1 shl y);
        FSB[x, y].Down := false;
      end;
    if FDataInNegation then Value := not Value;
    Result := Value;
  end;
end;

// RESET VIRTUAL PORT
procedure TButton16MUX.Reset;
begin
  SelLine := 0;
  AllRelease(MAXX, MAXY);
end;

// WRITE VIRTUAL PORT
procedure TButton16MUX.WritePort(Port: byte; Value: byte);
var
  i: integer;
begin
  if FEnabled and (Port = 1) then
  begin
    i := -1;
    case FSelMode of
      lmDirect: begin
                  if FSelNegation then Value := not Value;
                  if Value = 0 then i := -1 else
                  begin
                    i := 0;
                    while Value > 1 do
                    begin
                      Value := Value shr 1;
                      Inc(i);
                    end;
                  end;
                end;
      lmBCD:    if Value <= MAXY then i := Value;
    end;
    SelLine := i;
  end;
end;

// CREATE PANEL
procedure TButton16MUX.CreatePanel;
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
        Caption := IntToHex(x, 1) + IntToHex(y, 1);
        AllowAllUp := True;
        GroupIndex := y * 4 + x + 1;
        if y = 0 then Top := 8 else Top := (4 * (y + 1) + y * 34) + 4;
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
  Result := TButton16MUX.Create;
end;

procedure DestroyPort(Port: TIOPort); CALLTYPE; export;
begin
  if Assigned(Port) then Port.Free;
end;

procedure CreatePanel(Port: TIOPort); CALLTYPE; export;
begin
  if Assigned(Port) and (Port is TButton16MUX) then
    TButton16MUX(Port).CreatePanel;
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
