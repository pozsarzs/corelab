{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | usysconsole.pas                                                          | }
{ | TSysConsole class (visual component)                                     | }
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
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  LCLType;
const
  PROMPT = '> ';
type
  // Command event type
  TCommandEvent = procedure(Sender: TObject; const ACommand: string) of object;
  // SysConsole class
  TSysConsole = class(TMemo)
  private
    FBGColor:      TColor;
    FFontColor:    TColor;
    FPromptBorder: Integer;
    FOnCommand:    TCommandEvent;
    procedure AddPrompt;
    procedure SetBGColor(AColor: TColor);
    procedure SetFontColor(AColor: TColor);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ClearContent;
    procedure WriteMessage(const AMsg: string);
  published
    property BGColor: TColor read FBGColor write SetBGColor;
    property OnCommand: TCommandEvent read FOnCommand write FOnCommand;
    property TextColor: TColor read FFontColor write SetFontColor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('CoreLab', [TSysConsole]);
end;

// ---- PRIVATE METHODS ----

// ADD PROMPT
procedure TSysConsole.AddPrompt;
begin
  // go to end of text
  SelStart := Length(Text);
  if Text <> '' then SelText := sLineBreak + PROMPT else SelText := PROMPT;
  // end of the prompt
  FPromptBorder := Length(Text);
  // go to the character following the prompt
  SelStart := FPromptBorder;
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

// ---- PROTECTED METHODS ----

// KEY EVENT HANDLER
procedure TSysConsole.KeyDown(var Key: Word; Shift: TShiftState);
var
  Command: string;
begin
  // handling command
  // [Enter]
  if Key = VK_RETURN then
  begin
    // remove linebreak
    Key := 0;
    Command := Copy(Text, FPromptBorder + 1, Length(Text));
    AddPrompt;
    // make command event
    if Assigned(FOnCommand) then FOnCommand(Self, Command);
    Exit;
  end;
  // protections against prompt deletion
  // [Left][Up][Backspace]
  if (Key = VK_LEFT) or (Key = VK_UP) or (Key = VK_BACK) then
    if SelStart <= FPromptBorder then Key := 0;
  // [Del]
  if Key = VK_DELETE then
    if SelStart < FPromptBorder then  Key := 0;
  // delete and overwrite with select
  if (SelLength > 0) and (SelStart < FPromptBorder) then
    if not (Key in [VK_SHIFT, VK_CONTROL, VK_MENU, VK_CAPITAL, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN])
      then Key := 0;
  inherited;
end;

// MOUSE EVENT HANDLER
procedure TSysConsole.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  // back drop cursor to the line of the prompt
  if SelStart < FPromptBorder then
  begin
    SelStart := FPromptBorder;
    SelLength := 0;
  end;
end;

// ---- PUBLIC METHODS ----

// CLEAR CONSOLE
procedure TSysConsole.ClearContent;
begin
  Clear;
end;

// CREATE COMPONENT
constructor TSysConsole.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Clear;
  Color := FBGColor;
  FBGColor := $001E1E1E;
  FFontColor := $00D4D4D4;
  Font.Color := FFontColor;
  Font.Name := 'Courier New';
  ScrollBars := ssAutoBoth;
  WordWrap := False;
  // show prompt
  if Text = '' then Text := PROMPT;
  FPromptBorder := Length(Text);
  SelStart := FPromptBorder;
end;

// WRITE MESSAGE TO CONSOLE
procedure TSysConsole.WriteMessage(const AMsg: string);
var
  CurrentInput: string;
  CurrentPosOffset: Integer;
begin
  // save text after prompt and cursor position
  CurrentInput := Copy(Text, FPromptBorder + 1, Length(Text));
  CurrentPosOffset := SelStart - FPromptBorder;
  // insert message before line of the prompt
  Lines.Insert(Lines.Count - 1, AMsg);
  // recalculate prompt border
  FPromptBorder := Length(Text) - Length(CurrentInput);
  // restore cursor position
  if CurrentPosOffset > 0
  then SelStart := FPromptBorder + CurrentPosOffset
  else SelStart := FPromptBorder;
end;

initialization
  RegisterClass(TSysConsole);

end.
