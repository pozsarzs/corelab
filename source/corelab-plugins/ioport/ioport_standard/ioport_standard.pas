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
  Interfaces, Forms, StdCtrls, SysUtils, core_ioport;
type
  // Standard port implementation
  TStandardPort = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  var
    CurrentPort: TStandardPort = nil;    
    EditRx: TEdit = nil;
    EditTx: TEdit = nil;
    PanelForm: TForm = nil;
  
// Create TIOPort instance
constructor TStandardPort.Create;
begin
  inherited Create;
  FModname := 'Standard I/O port';
  FDescription := 'It reads the entered value and displays the output value.';
  FHasGUI := true;
  FPortMode := pmReadWrite;
  FLatchedOutput := true;
  Reset;
end;

// Destroy TIOPort instance
destructor TStandardPort.Destroy;
begin
  inherited Destroy;
end;

// Read virtual port
function TStandardPort.ReadPort(Port: byte): byte;
var
  Value: integer;
begin
  Result := 0;
  if Assigned(EditRx) then
  begin
    if TryStrToInt('$' + EditRx.Text, Value) then 
    begin
      Result := Value;
      EditRx.Clear;
    end;
  end;
end;

// Write virtual port
procedure TStandardPort.WritePort(Port: byte; Value: byte);
begin
  if Assigned(EditTx) then EditTx.Text := IntToHex(Value, 2);
end;

// Reset virtual port
procedure TStandardPort.Reset;
begin
  if Assigned(EditRx) then EditRx.Clear;
  if Assigned(EditTx) then EditTx.Clear;
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  Result := TStandardPort.Create;
end;

// Exportable function for destroy TIOPort instance
procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Destroy;
end;

// Exportable function for create UI panel
procedure CreatePanel(Port: TIOPort); cdecl;
var
  L1, L2: TLabel;
begin
  if Assigned(PanelForm) then exit;

  PanelForm := TForm.Create(nil);
  PanelForm.Caption := Port.Title;
  PanelForm.Position := poDefaultPosOnly;
  PanelForm.BorderIcons := [biSystemMenu, biMinimize];
  PanelForm.ClientWidth := 258;
  PanelForm.ClientHeight := 80;

  L1 := TLabel.Create(PanelForm);
  L1.Parent := PanelForm;
  L1.Caption := 'Received (hex):';
  L1.Left := 10;
  L1.Top := 12;

  EditTx := TEdit.Create(PanelForm);
  EditTx.Parent := PanelForm;
  EditTx.Left := 150;
  EditTx.Top := 8;
  EditTx.Width := 100;
  EditTx.ReadOnly := True;

  L2 := TLabel.Create(PanelForm);
  L2.Parent := PanelForm;
  L2.Caption := 'To be sent (hex):';
  L2.Left := 10;
  L2.Top := 44;

  EditRx := TEdit.Create(PanelForm);
  EditRx.Parent := PanelForm;
  EditRx.MaxLength := 2;
  EditRx.Left := 150;
  EditRx.Top := 40;
  EditRx.Width := 100;

  PanelForm.Constraints.MinWidth := PanelForm.Width;
  PanelForm.Constraints.MaxWidth := PanelForm.Width;
  PanelForm.Constraints.MinHeight := PanelForm.Height;
  PanelForm.Constraints.MaxHeight := PanelForm.Height;

  CurrentPort := TStandardPort(Port);
end;

// Exportable function for show UI panel
procedure ShowPanel; cdecl;
begin
  if Assigned(PanelForm) then PanelForm.Show;
end;

// Exportable function for hide UI panel
procedure HidePanel; cdecl;
begin
  if Assigned(PanelForm) then PanelForm.Hide;
end;

// Exportable function for destroy UI panel
procedure FreePanel; cdecl;
begin
if Assigned(PanelForm) then
  begin
    PanelForm.Close;
    PanelForm.Free;
    PanelForm := nil;
    EditRx := nil;
    EditTx := nil;
  end;
end;

// Exportable function for move and resize UI panel
procedure SetSizePosPanel(Left, Top, Width, Height: integer); cdecl;
begin
  if Assigned(PanelForm) then
  begin
    PanelForm.Left := Left;
    PanelForm.Top := Top;
    PanelForm.Width := Width;
    PanelForm.Height := Height;
  end;
end;

// Exported functions and procedures
exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';
exports CreatePanel name 'ioport_createpanel';
exports ShowPanel name 'ioport_showpanel';
exports HidePanel name 'ioport_hidepanel';
exports FreePanel name 'ioport_freepanel';
exports SetSizePosPanel name  'ioport_setsizepospanel';

begin
end.
