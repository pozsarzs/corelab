{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmscripteditor.pas                                                      | }
{ | ScriptEditor form                                                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmscripteditor;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  SynEdit, SynHighlighterAny, MODSynHighlighterAny, uconfig;
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
    procedure FormShow(Sender: TObject);
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
    procedure SetExtBuffer(AExtBuffer: TStringList);
  public
    procedure CopyBufferToEditor;
    procedure CopyEditorToBuffer;
    property ExtBuffer: TStringList write SetExtBuffer;
  end;
var
  Form6: TForm6;

implementation

{$R *.lfm}
// ---- PRIVATE METHODS ----

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

// CREATE FORM
procedure TForm6.FormCreate(Sender: TObject);
begin
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

// SHOW FORM
procedure TForm6.FormShow(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig.ScriptEditorConfig do
  begin
    Form6.Top := top;
    Form6.Left := left;
    Form6.Height := height;
    Form6.Width := width;
    Form6.FBGColor := bg_color;
    Form6.FFontColor := font_color;
    Form6.FGutterFontColor := gutterfont_color;
    Form6.FLineNumber := linenumber;
    Form6.FSyntax := syntax;
    with SynEdit1 do
    begin
      Color := FBGColor;
      Gutter.Color := FBGColor;
      Gutter.LineNumberPart.MarkupInfo.Background := FBGColor;
      Font.Color := FFontColor;
      Gutter.LineNumberPart.MarkupInfo.Foreground := FGutterFontColor;
      Gutter.Visible := FLineNumber;
      if FSyntax
        then HighLighter := SynAnySyn1
        else HighLighter := nil;
      Invalidate;
    end;
  end;
end;

//HIDE FORM
procedure TForm6.FormHide(Sender: TObject);
begin
  CopyEditorToBuffer;
end;

// CLOSE FORM
procedure TForm6.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CopyEditorToBuffer;
  // store changeable setting
  with uconfig.AppConfig.ScriptEditorConfig do
  begin
    top := Form6.Top;
    left := Form6.Left;
    height := Form6.Height;
    width := Form6.Width;
  end;
end;

end.

