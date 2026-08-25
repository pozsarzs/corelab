{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_standard.pas                                                      | }
{ | Standard port implementation module                                      | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{$IFDEF NOT_A_LIBRARY_BUT_A_UNIT}
unit ioport_standard;
interface
{$ELSE}
library ioport_standard;
{$ENDIF}

{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Interfaces, Forms, StdCtrls, SysUtils, core_ioport,
  core_gioport;
type
  // Standard port class
  TStandardPort = class(TGIOPort)
  protected
    FEditRx: TEdit;
    FEditTx: TEdit;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Reset; override;
    function ReadPort(APort: Word): Byte; override;
    procedure WritePort(APort: Word; AValue: Byte); override;
    procedure CreatePanel; override;
  end;

{$IFDEF NOT_A_LIBRARY_BUT_A_UNIT}
implementation
{$ELSE}
{$ENDIF}

// ---- PUBLIC METHODS ----
  
// CREATE TSTANDARDPORT INSTANCE
constructor TStandardPort.Create;
begin
  inherited Create;
  FModname := 'Standard I/O port';
  FDescription := 'It reads the entered value and displays the output value.';
  FHasPanel := true;
  FLatchedOutput := true;
  Reset;
end;

// DESTROY TSTANDARDPORT INSTANCE
destructor TStandardPort.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TStandardPort.Reset;
begin
  if Assigned(FEditRx) then FEditRx.Clear;
  if Assigned(FEditTx) then FEditTx.Clear;
end;

// READ VIRTUAL PORT
function TStandardPort.ReadPort(APort: Word): Byte;
var
  Value: Integer;
begin
  Result := 0;
  if FEnabled and (APort = 0) then
  begin
    if Assigned(FEditRx) then
    begin
      if TryStrToInt('$' + FEditRx.Text, Value) then 
      begin
        Result := Value;
        FEditRx.Clear;
      end;
    end;
  end else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TStandardPort.WritePort(APort: Word; AValue: Byte);
begin
  if FEnabled and (APort = 0) then
  begin
    if Assigned(FEditTx) then FEditTx.Text := IntToHex(AValue, 2);
  end;
end;

// CREATE PANEL
procedure TStandardPort.CreatePanel;
var
  L1, L2: TLabel;
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
    ClientWidth := 258;
    ClientHeight := 80;
  end;

  L1 := TLabel.Create(FPanelForm);
  with L1 do
  begin
    Parent := FPanelForm;
    Caption := 'Received (hex):';
    Left := 10;
    Top := 12;
  end;

  FEditTx := TEdit.Create(FPanelForm);
  with FEditTx do
  begin
    Parent := FPanelForm;
    Left := 150;
    Top := 8;
    Width := 100;
    ReadOnly := True;
  end;

  L2 := TLabel.Create(FPanelForm);
  with L2 do
  begin
    Parent := FPanelForm;
    Caption := 'To be sent (hex):';
    Left := 10;
    Top := 44;
  end;

  FEditRx := TEdit.Create(FPanelForm);
  with FEditRx do
  begin
    Parent := FPanelForm;
    MaxLength := 2;
    Left := 150;
    Top := 40;
    Width := 100;
  end;

  with FPanelForm do
  begin
    Constraints.MinWidth := Width;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MaxHeight := Height;
  end;
end;

{$IFDEF NOT_A_LIBRARY_BUT_A_UNIT}
{$ELSE}

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TStandardPort.Create;
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
  if Assigned(APort) and (APort is TStandardPort)
    then TStandardPort(APort).CreatePanel;
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

{$ENDIF}

begin
end.
