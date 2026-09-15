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
  Classes, Forms, SysUtils, TypInfo, core_ioport;
type
  // Graphical I/O port (device) class
  TGIOPort = class(TIOPort)
  private
    SPanelCaption: String;                // Internal variable for panel caption
  protected
    FPanelForm:    TForm;                                               // Panel
    FPanelCaption: PChar;                                       // Panel caption
    FPanelHeight:  Integer;                                      // Panel height
    FPanelLeft:    Integer;                               // Panel left position
    FPanelTop:     Integer;                                // Panel top position
    FPanelWidth:   Integer;                                       // Panel width
  public
    constructor Create; override;
    destructor Destroy; override;
    // Used via the ISvcAPI by TSupervisor class
    procedure CreatePanel; virtual; abstract;
    procedure FreePanel; virtual;
    procedure ShowPanel; virtual;
    procedure HidePanel; virtual;
    procedure RenamePanel(ACaption: PChar); virtual;
    function MovePanel(ALeft, ATop: Integer): Boolean; virtual;
    function ResizePanel(AWidth, AHeight: Integer): Boolean; virtual;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    // properties
    property PanelCaption: PChar read FPanelCaption;
    property PanelHeight: integer read FPanelHeight;
    property PanelLeft: integer read FPanelLeft;
    property PanelTop: integer read FPanelTop;
    property PanelWidth: integer read FPanelWidth;
  end;

implementation

// ---- PUBLIC METHODS ----

// CREATE TGIOPORT INSTANCE
constructor TGIOPort.Create;
begin
  inherited Create;
  // Initial state
  SPanelCaption := 'MyIO';
  FPanelLeft := 0;
  FPanelTop := 0;
  FPanelHeight := 0;
  FPanelWidth := 0;
  FPanelCaption := PChar(SPanelCaption);
end;

// DESTROY TGIOPORT INSTANCE
destructor TGIOPort.Destroy;
begin
  FreePanel;
  inherited Destroy;
end;

// -- ISvcAPI --

// LOAD SAVED STATE
function TGIOPort.LoadState(AStream: TStream): Boolean;
var
  l: Byte;
begin
  Result := inherited LoadState(AStream);
  if Result then
    with AStream do
      try
        ReadBuffer(l, 1);
        SetLength(SPanelCaption, l);
        if l > 0 then 
          ReadBuffer(SPanelCaption[1], l);
        FPanelCaption := PChar(SPanelCaption);

        ReadBuffer(FPanelHeight, SizeOf(FPanelHeight));
        ReadBuffer(FPanelLeft, SizeOf(FPanelLeft));
        ReadBuffer(FPanelTop, SizeOf(FPanelTop));
        ReadBuffer(FPanelWidth, SizeOf(FPanelWidth));

        RenamePanel(FPanelCaption);
        ResizePanel(FPanelWidth, FPanelHeight);
        MovePanel(FPanelLeft, FPanelTop);
      except
        Result := false;
      end;
end;

// SAVE ACTUAL STATE
function TGIOPort.SaveState(AStream: TStream): Boolean;
var
  l: Byte;
begin
  Result := inherited SaveState(AStream);
  if Result then
    with AStream do
    begin
      // common fields
      l := Length(SPanelCaption);
      if l = 0 then
      begin
        SPanelCaption := 'MyIO';
        l := Length(SPanelCaption);
      end;
      WriteBuffer(l, 1);
      WriteBuffer(SPanelCaption[1], l);

      WriteBuffer(FPanelHeight, SizeOf(FPanelHeight));
      WriteBuffer(FPanelLeft, SizeOf(FPanelLeft));
      WriteBuffer(FPanelTop, SizeOf(FPanelTop));
      WriteBuffer(FPanelWidth, SizeOf(FPanelWidth));
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

// SHOW PANEL
procedure TGIOPort.ShowPanel;
begin
  if Assigned(FPanelForm) then FPanelForm.Show;
end;

// HIDE PANEL
procedure TGIOPort.HidePanel;
begin
  if Assigned(FPanelForm) then FPanelForm.Hide;
end;

// RENAME PANEL
procedure TGIOPort.RenamePanel(ACaption: PChar);
begin
  SPanelCaption := StrPas(ACaption);
  FPanelCaption := PChar(SPanelCaption);
  if Assigned(FPanelForm) then
  begin
    FPanelForm.Caption := SPanelCaption;
    FPanelForm.Invalidate;
    FPanelForm.Update;
  end;
end;

// RESIZE PANEL
function TGIOPort.ResizePanel(AWidth, AHeight: Integer): Boolean;
begin
  Result := False;
  if (AWidth >= 0) and (AHeight >= 0) then
  begin
    FPanelHeight := AHeight;
    FPanelWidth := AWidth;
    if Assigned(FPanelForm) then
    begin
      FPanelForm.SetBounds(FPanelLeft, FPanelTop, FPanelWidth, FPanelHeight);
      Result := True;
    end;
  end;
end;

// MOVE PANEL
function TGIOPort.MovePanel(ALeft, ATop: Integer): Boolean;
begin
  Result := False;
  if (ALeft >= 0) and (ATop >= 0) then
  begin
    FPanelLeft := ALeft;
    FPanelTop := ATop;
    if Assigned(FPanelForm) then
    begin
      FPanelForm.Hide;
      FPanelForm.SetBounds(FPanelLeft, FPanelTop, FPanelWidth, FPanelHeight);
      FPanelForm.Show;
      Result := True;
    end;
  end;
end;

end.
