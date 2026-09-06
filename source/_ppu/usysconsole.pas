{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | usysconsole.pas                                                          | }
{ | TSysConsole visual component                                             | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit usysconsole;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, StdCtrls, Controls, Graphics, Messages, LMessages;
type
  TSysConsole = class(TMemo)
  private
    FOnCommand: TNotifyEvent;
    FBGColor: TColor;
    FFontColor: TColor;
    procedure Clear;
    procedure SetBGColor(AColor: TColor);
    procedure SetFontColor(AColor: TColor);
    procedure WMKeyDown(var Message: TLMKeyDown); message WM_KEYDOWN;
  public
    constructor Create(AOwner: TComponent); override;
    procedure WriteMessage(const AText: string);
  published
    property BGColor: TColor read FBGColor write SetBGColor;
    property TextColor: TColor read FFontColor write SetFontColor;
    property OnCommand: TNotifyEvent read FOnCommand write FOnCommand;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('CoreLab', [TSysConsole]);
end;

// ---- PRIVATE METHODS ----

// CLEAR CONSOLE
procedure TSysConsole.Clear;
begin
  Clear;
end;

// SET BACKGROUND COLOR
procedure TSysConsole.SetBGColor(AColor: TColor);
begin
  FBGColor := AColor;
  Color := FBGColor;
  Invalidate;
end;

// SET FONT COLOR
procedure TSysConsole.SetFontColor(AColor: TColor);
begin
  FFontColor := AColor;
  Font.Color := FFontColor;
  Invalidate;
end;

// READ COMMAND FROM CONSOLE
procedure TSysConsole.WMKeyDown(var Message: TLMKeyDown);
begin
  if Message.CharCode = $0D then                                      // [ENTER]
  begin
    if Assigned(FOnCommand) then
      FOnCommand(Self);
    Message.Result := 0;
    Exit;
  end;
  inherited;
end;

// ---- PUBLIC METHODS ----

// CREATE COMPONENT
constructor TSysConsole.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  ScrollBars := ssAutoBoth;
  ReadOnly := True;
  FBGColor := $001E1E1E;
  FFontColor := $00D4D4D4;
  Color := FBGColor;
  Font.Color := FFontColor;
  Font.Name := 'Courier New';
end;

// WRITE MESSAGE TO CONSOLE
procedure TSysConsole.WriteMessage(const AText: string);
begin
  Lines.Add(AText);
  SelStart := Length(Text);
end;

initialization
  RegisterClass(TSysConsole);

end.
