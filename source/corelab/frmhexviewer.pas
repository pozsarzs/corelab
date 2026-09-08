{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmhexviewer.pas                                                         | }
{ | HexViewer form                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmhexviewer;
{$MODE OBJFPC}{$H+}
{$I defcolors.pas}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, EditBtn, Grids, Types, core_memory, core_cpu, ucommon;
type
  { TForm3 }
  TForm3 = class(TForm)
    Bevel1:      TBevel;
    Button1:     TButton;
    DrawGrid1:   TDrawGrid;
    EditButton1: TEditButton;
    FindDialog1: TFindDialog;
    procedure Button1Click(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FMemInstance:       TMemory;                               // TMemory object
    FMemSize:           DWord;
    // colors
    FAddressColor:      TColor;                                // Address column
    FDataColor:         TColor;                                 // Opcode column
    FLineSelectorColor: TColor;                                 // Selector line
    FBGColorOddLines:   TColor;                                     // Odd lines
    FBGColorEvenLines:  TColor;                                    // Even lines
  protected
    procedure SetAddressColor(AColor: TColor);
    procedure SetDataColor(AColor: TColor);
    procedure SetLineSelectorColor(AColor: TColor);
    procedure SetBGColorEvenLines(AColor: TColor);
    procedure SetBGColorOddLines(AColor: TColor);
    procedure SetMemInstance(AMemInstance: TMemory);
  public
    property MemInstance: TMemory write SetMemInstance;
    property AddressColor: TColor read FAddressColor write SetAddressColor;
    property DataColor: TColor read FDataColor write SetDataColor;
    property LineSelectorColor: TColor read FLineSelectorColor write SetLineSelectorColor;
    property BGColorOddLines: TColor read FBGColorOddLines write SetBGColorOddLines;
    property BGColorEvenLines: TColor read FBGColorEvenLines write SetBGColorEvenLines;
  end;
var
  Form3: TForm3;

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Address';
  MSG03 = 'Cannot open memory modul.';

implementation
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

// SET INSTANCE AND MEMORY SIZE (16 BYTES PER ROW)
procedure TForm3.SetMemInstance(AMemInstance: TMemory);
begin
  if Assigned(AMemInstance) then
  begin
    FMemInstance := AMemInstance;
    FMemSize := FMemInstance.AddressRangeSize;
    if FMemSize = 0 then Exit;
    DrawGrid1.RowCount := ((FMemSize + 15) div 16) + 1;
  end else
  begin
    ShowMessage(MSG01 + MSG03);
  end;
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
  BaseAddress:   DWord;
  CellAddress:   DWord;
  CurrentStatus: Boolean;
  BData:         Byte;
  SText:         string;
  Style:         TTextStyle;
begin
  if aRow = 0 then Exit;

  BaseAddress := (aRow - 1) * 16;
  SText := '';

  if aCol = 0 then
  begin
    FormatHexValue(IntToHex(BaseAddress), 6, SText);
  end
  else if (aCol >= 1) and (aCol <= 16) then
  begin
    CellAddress := BaseAddress + aCol - 1;
    if CellAddress < FMemSize then
    begin
      // store original status and enable module
      CurrentStatus := FMemInstance.Enabled;
      FMemInstance.Enabled := True;
      BData := FMemInstance.ReadMemory(CellAddress);
      // restore original status
      FMemInstance.Enabled := CurrentStatus;
      FormatHexValue(IntToHex(BData), 2, SText);
    end;
  end;

  with DrawGrid1.Canvas do
  begin
    // background
    if Odd(aRow)
      then Brush.Color := FBGColorOddLines
      else Brush.Color := FBGColorEvenLines;
    if gdSelected in aState then Brush.Color := FLineSelectorColor;
    FillRect(aRect);

    // text color
    if aCol = 0 then Font.Color := FAddressColor
    else Font.Color := FDataColor;

    // text alignment
    Style := TextStyle;
    Style.Layout := tlCenter;
    Style.Alignment := taCenter;
    TextStyle := Style;

    // write content
    TextRect(aRect, aRect.Left, aRect.Top, SText);
  end;
end;

// SEARCH IN DUMP
procedure TForm3.EditButton1ButtonClick(Sender: TObject);
var
  CurrentStatus:            Boolean;
  BaseAddress, CellAddress: DWord;
  BData:                    Byte;
  r, c:                     Integer;
  s, SAddress, SData:       string;
begin
  if Length(EditButton1.Text) > 0 then
  for r := DrawGrid1.Row to DrawGrid1.RowCount - 1 do
  begin
    BaseAddress := (r - 1) * 16;
    SAddress := '';
    FormatHexValue(IntToHex(BaseAddress), 6, SAddress);
    s := SAddress;

    // store original status and enable module
    CurrentStatus := FMemInstance.Enabled;
    FMemInstance.Enabled := True;
    for c := 0 to 15 do
    begin
      CellAddress := BaseAddress + c;
      if CellAddress < FMemSize then
      begin
        BData := FMemInstance.ReadMemory(CellAddress);
        SData := '';
        FormatHexValue(IntToHex(BData), 2, SData);
        s := s + #9 + SData;
      end;
    end;
    // restore original status
    FMemInstance.Enabled := CurrentStatus;

    s := lowercase(s);
    if Pos(LowerCase(EditButton1.Text), s) > 0 then
    begin
      DrawGrid1.Row := r;
      DrawGrid1.TopRow := r;
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
var
  i: Integer;
begin
  // default colors
  FAddressColor := StringToColor(HEXVIEWER_ADDRESS_DEFAULT);
  FDataColor := StringToColor(HEXVIEWER_DATA_DEFAULT);
  FLineSelectorColor := StringToColor(HEXVIEWER_LINESELECTOR_DEFAULT);
  FBGColorOddLines := StringToColor(HEXVIEWER_BGCOLOR_ODD_DEFAULT);
  FBGColorEvenLines := StringToColor(HEXVIEWER_BGCOLOR_EVEN_DEFAULT);

  with DrawGrid1 do
  begin
    Columns.Clear;
    // Address column
    with Columns.Add do
    begin
      Width := 64;
      Title.Caption := MSG02;
    end;
    // Data columns (0-F)
    for i := 0 to 15 do
    begin
      with Columns.Add do
      begin
        Width := 24;
        Title.Caption := IntToHex(i, 1);
      end;
    end;
    Color := FBGColorOddLines;
  end;

  FMemSize := 1024;
end;

end.
