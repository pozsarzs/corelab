{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_console.pas                                                       | }
{ | Console implementation module                                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{$IFDEF NOT_A_LIBRARY_BUT_A_UNIT}
unit ioport_console;
interface
{$ELSE}
library ioport_console;
{$ENDIF}

{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, Controls, Graphics, Interfaces, ComCtrls, ExtCtrls, Forms,
  StdCtrls, SysUtils, core_ioport, core_gioport;
type
  // Console port class
  TConsole = class(TGIOPort)
  protected
    FConFace:   TMemo;
    FRxBuffer:  string;
    FStatusBar: TStatusBar;
    FTimer:     TTimer;
    procedure FConFaceKeyPress(Sender: TObject; var Key: char);
    procedure FTimerOnTime(Sender: TObject);
    procedure UpdateGauge;
    procedure RequestInterrupt; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Reset; override;
    function ReadPort(APort: Word): Byte; override;
    procedure WritePort(APort: Word; AValue: Byte); override;
    procedure CreatePanel; override;
  end;
const
  BUFSIZE: Byte = 64;

{$IFDEF NOT_A_LIBRARY_BUT_A_UNIT}
implementation
{$ELSE}
{$ENDIF}

// ---- PROTECTED METHODS ----

// HANDLE KEY PRESS (BUFFERING)
procedure TConsole.FConFaceKeyPress(Sender: TObject; var Key: char);
begin
  if Length(FRxBuffer) < BUFSIZE then
  begin
    FRxBuffer := FRxBuffer + Key;
    UpdateGauge;
    RequestInterrupt;
  end;
  // uncomment next line to switch off local echo
  // Key := #0; 
end;

// TIMED STATUS MESSAGE CLEARING
procedure TConsole.FTimerOnTime(Sender: TObject);
begin
  FTimer.Enabled := False;
  FStatusBar.Panels[1].Text := '';                                       // read
  FStatusBar.Panels[2].Text := '';                                      // write
end;

// REQUEST INTERRUPT
procedure TConsole.RequestInterrupt;
begin
  if FEnabled and Assigned(FOnInterrupt) then
  begin
    FOnInterrupt(Self, FIntVector);
    if Assigned(FStatusBar) then FStatusBar.Panels[3].Text := 'INT';                             // interrupt
  end;
end;

// UPDATE BUFFER GAUGE
procedure TConsole.UpdateGauge;
var
  Pct: Integer;
begin
  if Assigned(FStatusBar) then
  begin
    Pct := Round((Length(FRxBuffer) / BUFSIZE) * 100);
    FStatusBar.Panels[0].Text := ' Buffer: ' + IntToStr(Pct) + '%';
  end;
end;

// ---- PUBLIC METHODS ----

// CREATE TCONSOLE INSTANCE
constructor TConsole.Create;
begin
  inherited Create;
  FModname := 'Minimalist console';
  FDescription := 'Minimalist character I/O console with buffered input.';
  FHasPanel := true;
  FLatchedOutput := true;
  FRxBuffer := '';
  Reset;
end;

// DESTROY TCONSOLE INSTANCE
destructor TConsole.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TConsole.Reset;
begin
  FRxBuffer := '';
  if Assigned(FConFace) then FConFace.Clear;
  UpdateGauge;
end;

// READ VIRTUAL PORT
function TConsole.ReadPort(APort: Word): Byte;
begin
  Result := 0;
  if FEnabled and (APort = 0) then
  begin
    if Assigned(FStatusBar) then 
    begin
      FStatusBar.Panels[1].Text := 'RD';
      FStatusBar.Panels[3].Text := '';
    end;
    if Assigned(FTimer) then FTimer.Enabled := True;
    if Length(FRxBuffer) > 0 then
    begin
      Result := Ord(FRxBuffer[1]);
      Delete(FRxBuffer, 1, 1);
      UpdateGauge;
    end;
  end else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TConsole.WritePort(APort: Word; AValue: Byte);
begin
  if FEnabled and (APort = 0) then
  begin
    if Assigned(FConFace) then FConFace.SelText := Chr(AValue);
    if Assigned(FStatusBar) then FStatusBar.Panels[2].Text := 'WR';
    if Assigned(FTimer) then FTimer.Enabled := True;
  end;
end;

// CREATE PANEL
procedure TConsole.CreatePanel;
var
  BevelPanel: TPanel;
begin
  if Assigned(FPanelForm) then exit;

  FPanelForm := TForm.Create(nil);
  with FPanelForm do
  begin
    Caption := StrPas(FPanelCaption);
    Position := poDefault;
    BorderIcons := [biSystemMenu, biMinimize, biMaximize]; 
    FPanelLeft := Left;
    FPanelTop := Top;
    FPanelHeight := Height;
    FPanelWidth := Width;
    ClientWidth := 400;
    ClientHeight := 300;
    Constraints.MinWidth := 258;
    Constraints.MinHeight := 150;
  end;

  FStatusBar := TStatusBar.Create(FPanelForm);
  with FStatusBar do
  begin
    ShowHint := true;
    Parent := FPanelForm;
    Align := alBottom;
    SimplePanel := false;
    Panels.Add;
    Panels[0].Width := 100;
    Panels.Add;
    Panels[1].Alignment := taCenter;
    Panels[1].Width := 36;
    Panels.Add;
    Panels[2].Alignment := taCenter;
    Panels[2].Width := 36;
    Panels.Add;
    Panels[3].Alignment := taCenter;
    Panels[3].Width := 72;
  end;

  BevelPanel := TPanel.Create(FPanelForm);
  with BevelPanel do
  begin
    Parent := FPanelForm;
    Align := alClient;
    BorderSpacing.Around := 4; 
    BevelOuter := bvLowered;    
    Caption := '';
  end;

  FConFace := TMemo.Create(FPanelForm);
  with FConFace do
  begin
    Parent := BevelPanel;
    Align := alClient;
    BorderStyle := bsNone;      
    Color := clBlack;           
    Font.Color := $0029CAFF;    
    Font.Pitch := fpFixed;      
    Font.Style := [fsBold];
    Font.Size := 14;
    Font.Name := 'Courier New'; 
    OnKeyPress := @FConFaceKeyPress;
  end;

  FTimer := TTimer.Create(FPanelForm);
  with FTimer do
  begin
   Enabled := false;
   Interval := 500;
   OnTimer := @FTimerOnTime;
  end;
end;

{$IFDEF NOT_A_LIBRARY_BUT_A_UNIT}
{$ELSE}

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TConsole.Create;
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
  if Assigned(APort) and (APort is TConsole)
    then TConsole(APort).CreatePanel;
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
