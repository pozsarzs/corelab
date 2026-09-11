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
  ComCtrls, SynEdit, MODSynHighlighterAny, uconfig;
type
  { TForm6 }
  TForm6 = class(TForm)
    StatusBar1: TStatusBar;
    SynAnySyn1: TSynAnySyn;
    SynEdit1: TSynEdit;
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
    procedure RefreshColors;
    property ExtBuffer: TStringList write SetExtBuffer;
  end;
  const
    SEConstants: array[0..12] of string = ('ARG', 'ARGCNT', 'DATE', 'FC', 'FZ',
                                           'HOME', 'INSCNT', 'PRJDIR', 'RNDB', 'RNDI',
                                           'RNDW', 'TIME', 'VER');
    SEKeyWords: array[0..67] of string = ('ABS', 'ADD', 'AND', 'APPX', 'ASCI',
                                          'ATTH', 'BIT', 'CALL', 'CALM', 'CHAR',
                                          'COMP', 'CONV', 'CRTE', 'DEC', 'DEPO',
                                          'DEST', 'DETH', 'END', 'EXAM', 'EXIT',
                                          'FILL', 'GETP', 'HELP', 'IDV', 'IMD',
                                          'INC', 'INDX', 'INPW', 'INRG', 'JPEQ',
                                          'JPGE', 'JPGT', 'JPLE', 'JPLT', 'JPNE',
                                          'JPNZ', 'JPZR', 'MSGW', 'MUL', 'NOT',
                                          'OR', 'PAUS', 'POPA', 'PRNT', 'PSHA',
                                          'RDV', 'RSET', 'RTRN', 'SAPP', 'SDEL',
                                          'SETP', 'SETV', 'SFND', 'SHL', 'SHR',
                                          'SINS', 'SLEN', 'SLOW', 'SREP', 'SSUB',
                                          'STEP', 'STOP', 'STRT', 'SUB', 'SUPP',
                                          'SWAP', 'WAIT', 'XOR');
var
  Form6: TForm6;

implementation

{$R *.lfm}
{ TForm6 }

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

// COPY LINES TO BUFFER
procedure TForm6.CopyEditorToBuffer;
begin
  if FExtBuffer <> nil then FExtBuffer.Assign(SynEdit1.Lines);
end;

// REFRESH COLORS
procedure TForm6.RefreshColors;
begin
  with uconfig.AppConfig.ScriptEditorConfig do
  begin
    Form6.FBGColor := bg_color;
    Form6.FFontColor := font_color;
    Form6.FGutterFontColor := gutterfont_color;
    Form6.FLineNumber := linenumber;
    Form6.FSyntax := syntax;
    with SynEdit1 do
    begin
      Color := FBGColor;
      Font.Color := FFontColor;
      Gutter.Color := FBGColor;
      Gutter.LineNumberPart.MarkupInfo.Background := FBGColor;
      Gutter.LineNumberPart.MarkupInfo.Foreground := FGutterFontColor;
      Gutter.Visible := FLineNumber;
      if FSyntax
        then HighLighter := SynAnySyn1
        else HighLighter := nil;
      Invalidate;
    end;
  end;
end;

// ---- EVENT HANDLER METHODS

// COPY LINES TO BUFFER
procedure TForm6.SynEdit1Exit(Sender: TObject);
begin
    CopyEditorToBuffer;
end;

// CREATE FORM
procedure TForm6.FormCreate(Sender: TObject);
var
  b: Byte;
begin
  // other default settings
  FLineNumber := True;
  FSyntax := True;
  FExtBuffer := nil;
  // set syntax highlightning for the script editor
  with SynAnySyn1 do
  begin
    ActiveDot := False;
    Comments := [csAsmStyle];
    CommentAttri.Foreground := clLime;
    for b := 0 to Length(SEConstants) - 1 do Constants.Add(SEConstants[b]);
    ConstantAttri.Foreground := clRed;
    VariableAttri.Foreground := clRed;
    DetectPreprocessor := false;
    DollarVariables := true;
    KeyAttri.Foreground := clWhite;
    for b := 0 to Length(SEKeyWords) - 1 do Constants.Add(SEKeyWords[b]);
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
  end;
  RefreshColors;
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

