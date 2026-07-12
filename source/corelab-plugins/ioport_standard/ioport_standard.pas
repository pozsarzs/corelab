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

library ioport_standard;
{$mode objfpc}{$H+}
uses
  Interfaces, Forms, StdCtrls, SysUtils, core_ioport,
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
    // - port
    function ReadPort(Port: byte): byte; override;
    procedure Reset;  override;
    procedure WritePort(Port: byte; Value: byte); override;
    // - panel
    procedure CreatePanel; override;

  end;
  
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

// READ VIRTUAL PORT
function TStandardPort.ReadPort(Port: byte): byte;
var
  Value: integer;
begin
  Result := 0;
  if FEnabled and (Port = 0) then
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

// RESET VIRTUAL PORT
procedure TStandardPort.Reset;
begin
  if Assigned(FEditRx) then FEditRx.Clear;
  if Assigned(FEditTx) then FEditTx.Clear;
end;

// WRITE VIRTUAL PORT
procedure TStandardPort.WritePort(Port: byte; Value: byte);
begin
  if FEnabled and (Port = 0) then
  begin
    if Assigned(FEditTx) then FEditTx.Text := IntToHex(Value, 2);
  end;
end;

// CREATE PANEL
procedure TStandardPort.CreatePanel;
var
  L1, L2: TLabel;
begin
  if Assigned(FPanelForm) then exit;

  FPanelForm := TForm.Create(nil);
  FPanelForm.Caption := FPanelCaption;
  FPanelForm.Position := poDefaultPosOnly;
  FPanelForm.BorderIcons := [biSystemMenu, biMinimize];
  FPanelForm.ClientWidth := 258;
  FPanelForm.ClientHeight := 80;

  L1 := TLabel.Create(FPanelForm);
  L1.Parent := FPanelForm;
  L1.Caption := 'Received (hex):';
  L1.Left := 10;
  L1.Top := 12;

  FEditTx := TEdit.Create(FPanelForm);
  FEditTx.Parent := FPanelForm;
  FEditTx.Left := 150;
  FEditTx.Top := 8;
  FEditTx.Width := 100;
  FEditTx.ReadOnly := True;

  L2 := TLabel.Create(FPanelForm);
  L2.Parent := FPanelForm;
  L2.Caption := 'To be sent (hex):';
  L2.Left := 10;
  L2.Top := 44;

  FEditRx := TEdit.Create(FPanelForm);
  FEditRx.Parent := FPanelForm;
  FEditRx.MaxLength := 2;
  FEditRx.Left := 150;
  FEditRx.Top := 40;
  FEditRx.Width := 100;

  FPanelForm.Constraints.MinWidth := FPanelForm.Width;
  FPanelForm.Constraints.MaxWidth := FPanelForm.Width;
  FPanelForm.Constraints.MinHeight := FPanelForm.Height;
  FPanelForm.Constraints.MaxHeight := FPanelForm.Height;
end;

// EXPORTABLE FUNCTIONS AND PROCEDURES
function CreatePort: TIOPort; cdecl; export;
begin
  Result := TStandardPort.Create;
end;

procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Free;
end;

procedure CreatePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TStandardPort) then
    TStandardPort(Port).CreatePanel;
end;
procedure FreePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).FreePanel;
end;

procedure HidePanel(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).HidePanel;
end;

function MovePanel(Port: TIOPort; Left, Top: Integer): Boolean; cdecl; export;
begin
  Result := False;
  if Assigned(Port) and (Port is TGIOPort) then
    Result := TGIOPort(Port).MovePanel(Left, Top);
end;

procedure RenamePanel(Port: TIOPort; Caption: PChar); cdecl; export;
begin
  if Assigned(Port) and (Port is TGIOPort) then
    TGIOPort(Port).RenamePanel(Caption);
end;

function ResizePanel(Port: TIOPort; Width, Height: Integer): Boolean; cdecl; export;
begin
  Result := False;
  if Assigned(Port) and (Port is TGIOPort) then
    Result := TGIOPort(Port).ResizePanel(Width, Height);
end;

procedure ShowPanel(Port: TIOPort); cdecl; export;
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
