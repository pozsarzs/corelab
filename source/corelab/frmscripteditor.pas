{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmscripteditor;
{$MODE OBJFPC}{$H+}
{$I defcolors.pas}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterAny, MODSynHighlighterAny;
type
  { TForm6 }
  TForm6 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    SynAnySyn1: TSynAnySyn;
    SynEdit1: TSynEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure SynEdit1Exit(Sender: TObject);
  private
    // colors
    FBGColor:         TColor;
    FFontColor:       TColor;
    FGutterFontColor: TColor;
    // Others
    FExtBuffer: TStringList;
    FLineNumber: Boolean;
    FSyntax:     Boolean;
  protected
    procedure SetBGColor(AColor: TColor);
    procedure SetFontColor(AColor: TColor);
    procedure SetGutterFontColor(AColor: TColor);
    procedure SetLineNumber(AEnable: Boolean);
    procedure SetExtBuffer(AExtBuffer: TStringList);
    procedure SetSyntax(AEnable: Boolean);
  public
    procedure CopyBufferToEditor;
    procedure CopyEditorToBuffer;
    property BGColor: TColor read FBGColor write SetBGColor;
    property FontColor: TColor read FFontColor write SetFontColor;
    property GutterFontColor: TColor read FGutterFontColor write SetGutterFontColor;
    property LineNumber: Boolean read FLineNumber write SetLineNumber;
    property ExtBuffer: TStringList write SetExtBuffer;
    property Syntax: Boolean read FSyntax write SetSyntax;
  end;
var
  Form6: TForm6;

implementation

{$R *.lfm}
// ---- PROTECTED METHODS ----

// SET BACKGROUND COLOR
procedure TForm6.SetBGColor(AColor: TColor);
begin
  FBGColor := AColor;
  with SynEdit1 do
  begin
    Color := FBGColor;
    Gutter.Color := FBGColor;
    Gutter.LineNumberPart.MarkupInfo.Background := FBGColor;
    Invalidate;
  end;
end;

// SET FONT COLOR
procedure TForm6.SetFontColor(AColor: TColor);
begin
  FFontColor := AColor;
  SynEdit1.Font.Color := FFontColor;
  SynEdit1.Invalidate;
end;

// SET COLOR OF THE GUTTER FONT
procedure TForm6.SetGutterFontColor(AColor: TColor);
begin
  FBGColor := AColor;
  SynEdit1.Gutter.LineNumberPart.MarkupInfo.Foreground := GutterFontColor;
  SynEdit1.Invalidate;
end;

procedure TForm6.SetLineNumber(AEnable: Boolean);
begin
  FLineNumber := AEnable;
  SynEdit1.Gutter.Visible := FLineNumber;
end;

procedure TForm6.SetSyntax(AEnable: Boolean);
begin
  FSyntax := AEnable;
  if FSyntax
    then SynEdit1.HighLighter := SynAnySyn1
    else SynEdit1.HighLighter := nil;
end;

// SET EXTERNAL BUFFER
procedure TForm6.SetExtBuffer(AExtBuffer: TStringList);
begin
  if Assigned(AExtBuffer) then FExtBuffer := AExtBuffer else FExtBuffer := nil;
end;

// ---- PUBLIC METHODS ----

// COPY LINES FROM BUFFER
procedure TForm6.CopyBufferToEditor;
begin
  if FExtBuffer <> nil then SynEdit1.Lines.Assign(FExtBuffer);
end;

// // COPY LINES TO BUFFER
procedure TForm6.CopyEditorToBuffer;
begin
  if FExtBuffer <> nil then FExtBuffer.Assign(SynEdit1.Lines);
end;

// ---- EVENT HANDLER METHODS

// CLOSE
procedure TForm6.Button1Click(Sender: TObject);
begin
  CopyEditorToBuffer;
  Close;
end;

// COPY LINES TO BUFFER
procedure TForm6.SynEdit1Exit(Sender: TObject);
begin
    CopyEditorToBuffer;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  // default colors
  FBGColor := StringToColor(SCRIPTEDITOR_BG_COLOR_DEFAULT);
  FFontColor := StringToColor(SCRIPTEDITOR_FONT_COLOR_DEFAULT);
  FGutterFontColor := StringToColor(SCRIPTEDITOR_GUTTERFONT_COLOR_DEFAULT);
  // other default settings
  FLineNumber := True;
  FSyntax := True;
  FExtBuffer := nil;
  // set syntax highlightning for the script editor
  with SynAnySyn1 do
  begin
    ActiveDot := False;
    Comments := [csBashStyle];
    CommentAttri.Foreground := clLime;
{    for b := 0 to 1 do Constants.Add(DEV_TYPE[b]);
    for b := 0 to 2 do Constants.Add(FILE_TYPE[b]);
    for b := 1 to 3 do Constants.Add(PROT_TYPE[b]);
    for b := 0 to 3 do Constants.Add(REG_TYPE[b]);
    for b := 0 to 4 do Constants.Add(PREFIX[b]);
    for b := 0 to 5 do Constants.Add(METHOD[b]);
    for b := 0 to 3 do Constants.Add(NUM_SYS[b]);}
    ConstantAttri.Foreground := clRed;
    DetectPreprocessor := false;
    DollarVariables := false;
    KeyAttri.Foreground := clWhite;
//    for b := 0 to COMMARRSIZE - 1 do KeyWords.Add(COMMANDS[b]);
    Markup := False;
    StringAttri.Foreground := clYellow;
    StringAttri.Style := [fsItalic];
    StringDelim := sdDoubleQuote;
    VariableAttri.Foreground := clNone;
  end;
end;

procedure TForm6.FormHide(Sender: TObject);
begin
  CopyEditorToBuffer;
end;

procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CopyEditorToBuffer;
end;

end.

