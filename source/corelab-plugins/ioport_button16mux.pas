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
  CMem, Classes, Interfaces, Forms, StdCtrls, SysUtils, Buttons, core_ioport,
  core_gioport;
const
  MAXX = 3;
  MAXY = 3;
type
  // 4x4 button matrix input class
  TButton16MUX = class(TGIOPort)
  protected
    FSB: array[0..MAXX, 0..MAXY] of TSpeedButton;                     // Buttons
    SelLine: Integer;
    procedure AllRelease(Amx, Amy: Byte);
    procedure FSBOnClick(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Reset;  override;
    function ReadPort(APort: Word): Byte; override;
    procedure WritePort(APort: Word; AValue: Byte); override;
    procedure CreatePanel; override;
  end;

// ---- PROTECTED METHODS ----

// RELEASE ALL BUTTONS
procedure TButton16MUX.AllRelease(Amx, Amy: Byte);
var
  x, y: Byte;
begin
  for x := 0 to Amx do
    for y := 0 to Amy do
      FSB[x, y].Down := false;
end;

// COMMON ONCLICK EVENT
procedure TButton16MUX.FSBOnClick(Sender: TObject);
begin
  RequestInterrupt;
end;

// ---- PUBLIC METHODS ----
  
// CREATE TBUTTON16MUX INSTANCE
constructor TButton16MUX.Create;
begin
  inherited Create;
  FModname := '4x4 button matrix input';
  FDescription := 'Select the column and read the row status.';
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

// RESET VIRTUAL PORT
procedure TButton16MUX.Reset;
begin
  SelLine := 0;
  AllRelease(MAXX, MAXY);
end;

// READ VIRTUAL PORT
function TButton16MUX.ReadPort(APort: Word): Byte;
var
  Value: Byte;
  x, y: Byte;
begin
  Result := $FF;
  if FEnabled and (APort = 0) then
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

// WRITE VIRTUAL PORT
procedure TButton16MUX.WritePort(APort: Word; AValue: Byte);
var
  i: Integer;
begin
  if FEnabled and (APort = 1) then
  begin
    i := -1;
    case FSelMode of
      lmDirect: begin
                  if FSelNegation then AValue := not AValue;
                  if AValue = 0 then i := -1 else
                  begin
                    i := 0;
                    while AValue > 1 do
                    begin
                      AValue := AValue shr 1;
                      Inc(i);
                    end;
                  end;
                end;
      lmBCD:    if AValue <= MAXY then i := AValue;
    end;
    SelLine := i;
  end;
end;

// CREATE PANEL
procedure TButton16MUX.CreatePanel;
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
        Caption := IntToHex(x, 1) + IntToHex(y, 1);
        AllowAllUp := True;
        GroupIndex := y * 4 + x + 1;
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
  Result := TButton16MUX.Create;
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
  if Assigned(APort) and (APort is TButton16MUX)
    then TButton16MUX(APort).CreatePanel;
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
