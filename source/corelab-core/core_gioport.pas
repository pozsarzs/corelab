{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_gioport.pas                                                         | }
{ | Graphical I/O port (device) abstraction module                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_gioport;
{$MODE OBJFPC}{$H+}
{$MODESWITCH TYPEHELPERS}
interface
uses
  Forms, SysUtils, TypInfo, core_ioport;
type
  // Graphical I/O port (device) class
  TGIOPort = class(TIOPort)
  protected
    FPanelForm:    TForm;                                               // Panel
    FPanelCaption: PChar;                                       // Panel caption
    FPanelHeight:  Integer;                                      // Panel height
    FPanelLeft:    Integer;                               // Panel left position
    FPanelTop:     Integer;                                // Panel top position
    FPanelWidth:   Integer;                                       // Panel width
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function MovePanel(Left, Top: Integer): Boolean; virtual;
    function ResizePanel(Width, Height: Integer): Boolean; virtual;
    procedure CreatePanel; virtual; abstract;
    procedure FreePanel; virtual;
    procedure HidePanel; virtual;
    procedure RenamePanel(Caption: PChar); virtual;
    procedure ShowPanel; virtual;
    property PanelCaption: PChar read FPanelCaption;
    property PanelHeight: integer read FPanelHeight;
    property PanelLeft: integer read FPanelLeft;
    property PanelTop: integer read FPanelTop;
    property PanelWidth: integer read FPanelWidth;
  end;

implementation

// CREATE TGIOPORT INSTANCE
constructor TGIOPort.Create;
begin
  inherited Create;
  // Initial state
  FPanelLeft := 0;
  FPanelTop := 0;
  FPanelHeight := 0;
  FPanelWidth := 0;
  FPanelCaption := 'MyIO';
end;

// DESTROY TGIOPORT INSTANCE
destructor TGIOPort.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// MOVE PANEL
function TGIOPort.MovePanel(Left, Top: Integer): Boolean;
begin
  Result := False;
  if (Left >= 0) and (Top >= 0) then
  begin
    FPanelLeft := Left;
    FPanelTop := Top;
    if Assigned(FPanelForm) then
    begin
      FPanelForm.Hide;
      FPanelForm.SetBounds(FPanelLeft, FPanelTop, FPanelWidth, FPanelHeight);
      FPanelForm.Show;
      Result := True;
    end;
  end;
end;

// RESIZE PANEL
function TGIOPort.ResizePanel(Width, Height: Integer): Boolean;
begin
  Result := False;
  if (Width >= 0) and (Height >= 0) then
  begin
    FPanelHeight := Height;
    FPanelWidth := Width;
    if Assigned(FPanelForm) then
    begin
      FPanelForm.SetBounds(FPanelLeft, FPanelTop, FPanelWidth, FPanelHeight);
      Result := True;
    end;
  end;
end;

// DESTROY PANEL
procedure TGIOPort.FreePanel;
begin
  if Assigned(FPanelForm) then
  begin
    FPanelForm.Free;
    FPanelForm := Nil;
  end;
end;

// HIDE PANEL
procedure TGIOPort.HidePanel;
begin
  if Assigned(FPanelForm) then FPanelForm.Hide;
end;

// RENAME PANEL
procedure TGIOPort.RenamePanel(Caption: PChar);
begin
  FPanelCaption := Caption;
  if Assigned(FPanelForm) then
  begin
    FPanelForm.Caption := StrPas(FPanelCaption);
    FPanelForm.Invalidate;
    FPanelForm.Update;
  end;
end;

// SHOW PANEL
procedure TGIOPort.ShowPanel;
begin
  if Assigned(FPanelForm) then FPanelForm.Show;
end;

end.
