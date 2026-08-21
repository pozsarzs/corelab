{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmhexviewer.pas                                                         | }
{ | RunLogger form                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmhexviewer;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, EditBtn, Grids, Types, core_cpu, ucommon;
type
  { TForm3 }
  TForm3 = class(TForm)
    Bevel1:      TBevel;
    Button1:     TButton;
    DrawGrid1:   TDrawGrid;
    EditButton1: TEditButton;
    FindDialog1: TFindDialog;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    // colors
    FAddressColor:      TColor;                                // Address column
    FDataColor:         TColor;                                 // Opcode column
    FLineSelectorColor: TColor;                                 // Selector line
    FBGColorOddLines:   TColor;                                     // Odd lines
    FBGColorEvenLines:  TColor;                                    // Even lines
    // others
    FArchitecture: TArchitecture;     // CPU architecture (arHarvard, arNeumann)
    FMemSize: Integer;                                // Size of emulated memory
  protected
    procedure SetAddressColor(AColor: TColor);
    procedure SetDataColor(AColor: TColor);
    procedure SetLineSelectorColor(AColor: TColor);
    procedure SetBGColorEvenLines(AColor: TColor);
    procedure SetBGColorOddLines(AColor: TColor);
    procedure SetFArchitecture(AArchitecture: TArchitecture);
    procedure SetFMemSize(AMemSize: Integer);
  public
    property Architecture: TArchitecture read FArchitecture write SetFArchitecture;
    property AddressColor: TColor read FAddressColor write SetAddressColor;
    property DataColor: TColor read FDataColor write SetDataColor;
    property LineSelectorColor: TColor read FLineSelectorColor write SetLineSelectorColor;
    property BGColorOddLines: TColor read FBGColorOddLines write SetBGColorOddLines;
    property BGColorEvenLines: TColor read FBGColorEvenLines write SetBGColorEvenLines;
    property MemSize: integer read FMemSize write SetFMemSize;
  end;
var
  Form3: TForm3;

resourcestring
  MSG01 = 'Address';
  MSG02 = 'Data';

implementation
uses frmmain;
{$R *.lfm}

// ---- PROTECTED METHODS ----

// SET COLOR OF THE ADDRESS COLUMN
procedure TForm3.SetAddressColor(AColor: TColor);
begin
  FAddressColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET COLOR OF THE OPCODE COLUMN
procedure TForm3.SetDataColor(AColor: TColor);
begin
  FDataColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET LINE SELECTOR COLOR
procedure TForm3.SetLineSelectorColor(AColor: TColor);
begin
  FLineSelectorColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET BACKGROUND COLOR OF THE ODD LINES
procedure TForm3.SetBGColorOddLines(AColor: TColor);
begin
  FBGColorOddLines := AColor;
  DrawGrid1.Invalidate;
end;

// SET BACKGROUND COLOR OF THE EVEN LINES
procedure TForm3.SetBGColorEvenLines(AColor: TColor);
begin
  FBGColorEvenLines := AColor;
  DrawGrid1.Invalidate;
end;

// SET FARCHITECTURE FIELD
procedure TForm3.SetFArchitecture(AArchitecture: TArchitecture);
begin
  FArchitecture := AArchitecture;
  RadioGroup1.Enabled := (FArchitecture = arHarvard);
end;

// SET MEMORY SIZE
procedure TForm3.SetFMemSize(AMemSize: Integer);
begin
  if AMemSize > 0 then FMemSize := AMemSize else Exit;
  DrawGrid1.RowCount := FMemSize + 1;
end;

// ---- EVENT HANDLER METHODS ----

// HIDE LOG WINDOW
procedure TForm3.Button1Click(Sender: TObject);
begin
  Form3.Hide;
end;

// DRAW RECORDS INTO THE GRID
procedure TForm3.DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  DAddress: DWord;
  QData:    QWord;
  SAddress: string;
  SData:    string;
  Style:    TTextStyle;
begin
  SAddress := '';
  SData := '';
  // get data
  if aRow = 0 then Exit else DAddress := aRow - 1;
  if RadioGroup1.Enabled
    then QData := Form1.GetMemoryCell(RadioGroup1.ItemIndex, DAddress)
    else QData := Form1.GetMemoryCell(0, DAddress);
  FormatHexValue(IntToHex(DAddress), 6, SAddress);
  FormatHexValue(IntToHex(QData), 16, SData);
  with DrawGrid1.Canvas do
  begin
    // background
    if Odd(aRow)
      then Brush.Color := FBGColorOddLines
      else Brush.Color := FBGColorEvenLines;
    if gdSelected in aState then Brush.Color := FLineSelectorColor;
    FillRect(aRect);
    // text color
    case ACol of
      0: Font.Color := FAddressColor;
      1: Font.Color := FDataColor;
   end;
    // text alignment
    Style := TextStyle;
    Style.Layout := tlCenter;
    case ACol of
      0: Style.Alignment := taCenter;
      1: Style.Alignment := taCenter;
    end;
    TextStyle := Style;
    // write content
    case ACol of
      0: TextRect(aRect, aRect.Left, aRect.Top, SAddress);
      1: TextRect(aRect, aRect.Left, aRect.Top, SData);
    end;
  end;
end;

// SEARCH IN DUMP
procedure TForm3.EditButton1ButtonClick(Sender: TObject);
var
  s: string;
  DAddress: DWord;
  QData:    QWord;
  SAddress: string;
  SData:    string;
begin
  if Length(EditButton1.Text) > 0 then
  for DAddress := DrawGrid1.Row to FMemSize - 1 do
  begin
    SAddress := '';
    SData := '';
    // get data
    if RadioGroup1.Enabled
      then QData := Form1.GetMemoryCell(RadioGroup1.ItemIndex, DAddress)
      else QData := Form1.GetMemoryCell(0, DAddress);
    FormatHexValue(IntToHex(DAddress), 6, SAddress);
    FormatHexValue(IntToHex(QData), 16, SData);
    s := lowercase(SAddress + #9 + SData);
    if Pos(LowerCase(EditButton1.Text), s) > 0 then
    begin
      DrawGrid1.Row := DAddress + 1;
      DrawGrid1.TopRow:= DAddress + 1;
      Exit;
    end;
  end;
end;

// ONACTIVATE
procedure TForm3.FormActivate(Sender: TObject);
begin
  Form3.Invalidate;
end;

// CREATE FORM
procedure TForm3.FormCreate(Sender: TObject);
begin
  // default colors
  FAddressColor := $00AADCDC;
  FDataColor := $00D69C56;
  FLineSelectorColor := $00473523;
  FBGColorOddLines := $001E1E1E;
  FBGColorEvenLines := $00262525;
  SetFArchitecture(arNeumann);
  SetFMemSize(1024);
  with DrawGrid1 do
  begin
    with Columns do
    begin
      Items[0].Title.Caption := MSG01;
      Items[1].Title.Caption := MSG02;
    end;
    Color:= FBGColorOddLines;
    Invalidate;
  end;
end;

end.

