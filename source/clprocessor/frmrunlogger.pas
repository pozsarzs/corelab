{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmrunlogger.pas                                                         | }
{ | RunLogger form                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmrunlogger;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, EditBtn, Grids, Types;
const
  MAX_LOG = 1024;
type
  TLogRec = record
    InstCount: Integer;
    Address:   string[31];
    OpCode:    string[31];
    Mnemonic:  string[127];
  end;
  { TForm4 }
  TForm4 = class(TForm)
    Bevel1:      TBevel;
    Button1:     TButton;
    Button2:     TButton;
    Button3:     TButton;
    DrawGrid1:   TDrawGrid;
    EditButton1: TEditButton;
    FindDialog1: TFindDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    // colors
    FInstCountColor:    TColor;                    // Instruction counter column
    FAddressColor:      TColor;                                // Address column
    FOpCodeColor:       TColor;                                 // Opcode column
    FMnemonicColor:     TColor;                               // Mnemonic column
    FLineSelectorColor: TColor;                                 // Selector line
    FBGColorOddLines:   TColor;                                     // Odd lines
    FBGColorEvenLines:  TColor;                                    // Even lines
    // others
    FRecordCount:       Integer;          // Number of valid items in the buffer
    FRingBuffer:        array[0..MAX_LOG - 1] of TLogRec;   // Log record buffer
    FWriteMarker:       Integer;         // Next empty place for write to buffer
    procedure ResetBuffer;
    function ReadBuffer(ALine: Integer): TLogRec;
    procedure WriteBuffer(ALogRec: TLogRec);
  protected
    procedure SetInstCountColor(AColor: TColor);
    procedure SetAddressColor(AColor: TColor);
    procedure SetOpCodeColor(AColor: TColor);
    procedure SetMnemonicColor(AColor: TColor);
    procedure SetLineSelectorColor(AColor: TColor);
    procedure SetBGColorEvenLines(AColor: TColor);
    procedure SetBGColorOddLines(AColor: TColor);
  public
    procedure AppendRecord(ALogRec: TLogRec);
    property InstCountColor: TColor read FInstCountColor write SetInstCountColor;
    property AddressColor: TColor read FAddressColor write SetAddressColor;
    property OpCodeColor: TColor read FOpCodeColor write SetOpCodeColor;
    property MnemonicColor: TColor read FMnemonicColor write SetMnemonicColor;
    property LineSelectorColor: TColor read FLineSelectorColor write SetLineSelectorColor;
    property BGColorOddLines: TColor read FBGColorOddLines write SetBGColorOddLines;
    property BGColorEvenLines: TColor read FBGColorEvenLines write SetBGColorEvenLines;
  end;
var
  Form4: TForm4;

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Save log to file';
  MSG03 = 'Cannot save ''%s'' log file.';
  MSG04 = 'Log file|*.log|All file|*.*';
  MSG05 = 'Counter';
  MSG06 = 'Address';
  MSG07 = 'Opcode';
  MSG08 = 'Mnemonic';

implementation

{$R *.lfm}

// ---- PRIVATE METHODS ----

// RESET RINGBUFFER
procedure TForm4.ResetBuffer;
var
  i: Integer;
begin
  for i := 0 to MAX_LOG - 1 do
    with FRingBuffer[i] do
    begin
      InstCount := -1;
      Address := '';
      OpCode := '';
      Mnemonic := '';
    end;
  FRecordCount := 0;
  FWriteMarker := 0;
end;

// READ A RECORD FROM RINGBUFFER
function TForm4.ReadBuffer(ALine: Integer): TLogRec;
var
  PhysicalIndex: Integer;
begin
  if (ALine < 0) or (ALine >= FRecordCount) then
  with Result do
  begin
    Address := '';
    InstCount := -1;
    Mnemonic := '';
    OpCode := '';
  end else
  begin
    if FRecordCount < MAX_LOG
      then PhysicalIndex := ALine
      else PhysicalIndex := (FWriteMarker + ALine) mod MAX_LOG;
    Result := FRingBuffer[PhysicalIndex];
  end;
end;

// WRITE RECORD TO RINGBUFFER
procedure TForm4.WriteBuffer(ALogRec: TLogRec);
begin
  FRingBuffer[FWriteMarker] := ALogRec;
  FWriteMarker := (FWriteMarker + 1) mod MAX_LOG;         // next empty position
  if FRecordCount < MAX_LOG then Inc(FRecordCount);   // number of the all items
end;

// ---- PROTECTED METHODS ----

// SET COLOR OF THE INSTRUCTION COUNTER COLUMN
procedure TForm4.SetInstCountColor(AColor: TColor);
begin
  FInstCountColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET COLOR OF THE ADDRESS COLUMN
procedure TForm4.SetAddressColor(AColor: TColor);
begin
  FAddressColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET COLOR OF THE OPCODE COLUMN
procedure TForm4.SetOpCodeColor(AColor: TColor);
begin
  FOpCodeColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET COLOR OF THE MNEMONIC COLUMN
procedure TForm4.SetMnemonicColor(AColor: TColor);
begin
  FMnemonicColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET LINE SELECTOR COLOR
procedure TForm4.SetLineSelectorColor(AColor: TColor);
begin
  FLineSelectorColor := AColor;
  DrawGrid1.Invalidate;
end;

// SET BACKGROUND COLOR OF THE ODD LINES
procedure TForm4.SetBGColorOddLines(AColor: TColor);
begin
  FBGColorOddLines := AColor;
  DrawGrid1.Invalidate;
end;

// SET BACKGROUND COLOR OF THE EVEN LINES
procedure TForm4.SetBGColorEvenLines(AColor: TColor);
begin
  FBGColorEvenLines := AColor;
  DrawGrid1.Invalidate;
end;

// ---- PUBLIC METHODS ----

// APPEND A RECORD TO LOG
procedure TForm4.AppendRecord(ALogRec: TLogRec);
begin
  WriteBuffer(ALogRec);
  if Form4.Visible then DrawGrid1.RowCount := FRecordCount + 1;
end;

// ---- EVENT HANDLER METHODS ----

// HIDE LOG WINDOW
procedure TForm4.Button1Click(Sender: TObject);
begin
  Form4.Hide;
end;

// CLEAR LOG
procedure TForm4.Button2Click(Sender: TObject);
begin
  ResetBuffer;
  DrawGrid1.RowCount := 1;
  DrawGrid1.Invalidate;
end;

// SAVE LOG TO FILE
procedure TForm4.Button3Click(Sender: TObject);
var
  Filename:    string;
  i:           Integer;
  StringList1: TStringList;
begin
  with SaveDialog1 do
  begin
    InitialDir := GetUserDir;
    Title := MSG02;
    Filter := MSG04;
  end;
  if SaveDialog1.Execute then
  begin
    Filename := SaveDialog1.FileName;
    try
      StringList1 := TStringList.Create();
      try
        for i := 0 to FRecordCount -1 do
        with ReadBuffer(i) do
          StringList1.Add(
            Format('%*.*d',[5, 5, InstCount]) + #9 +
            Address + #9 +
            OpCode + #9 +
            Mnemonic);
        StringList1.SaveToFile(Filename);
      except
        ShowMessage(MSG01 + Format(MSG03, [FileName]));
      end;
    finally
      StringList1.Free;
    end;
  end;
end;

// DRAW RECORDS INTO THE GRID
procedure TForm4.DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  LogRec: TLogRec;
  Style:  TTextStyle;
begin
  if aRow = 0 then Exit else LogRec := ReadBuffer(aRow - 1);
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
      0: Font.Color := FInstCountColor;
      1: Font.Color := FAddressColor;
      2: Font.Color := FOpCodeColor;
      3: Font.Color := FMnemonicColor;
    end;
    // text alignment
    Style := TextStyle;
    Style.Layout := tlCenter;
    case ACol of
      0: Style.Alignment := taCenter;
      1: Style.Alignment := taCenter;
      2: Style.Alignment := taLeftJustify;
      3: Style.Alignment := taLeftJustify;
    end;
    TextStyle := Style;
    // write content
    case ACol of
      0: TextRect(aRect, aRect.Left, aRect.Top, Format('%*.*d',[5, 5, LogRec.InstCount]));
      1: TextRect(aRect, aRect.Left, aRect.Top, LogRec.Address);
      2: TextRect(aRect, aRect.Left + 4, aRect.Top, LogRec.OpCode);
      3: TextRect(aRect, aRect.Left + 4, aRect.Top, LogRec.Mnemonic);
    end;
  end;
end;

// SEARCH IN LOG
procedure TForm4.EditButton1ButtonClick(Sender: TObject);
var
  i: Integer;
  s: string;
begin
  if (Length(EditButton1.Text) > 0) and (FRecordCount > 0) then
  for i := DrawGrid1.Row to FRecordCount -1 do
  begin
    with ReadBuffer(i) do
      s := LowerCase(
             Format('%*.*d',[5, 5, InstCount]) + #9 +
             Address + #9 +
             OpCode + #9 +
             Mnemonic);
    if Pos(LowerCase(EditButton1.Text), s) > 0 then
    begin
      DrawGrid1.Row := i + 1;
      DrawGrid1.TopRow:= i + 1;
      Exit;
    end;
  end;
end;

// CREATE FORM
procedure TForm4.FormCreate(Sender: TObject);
begin
  // default colors
  FInstCountColor := $004E8B60;
  FAddressColor := $00AADCDC;
  FOpCodeColor := $00D69C56;
  FMnemonicColor := $00D4D4D4;
  FLineSelectorColor := $00473523;
  FBGColorOddLines := $001E1E1E;
  FBGColorEvenLines := $00262525;
  ResetBuffer;
  with DrawGrid1 do
  begin
    with Columns do
    begin
      Items[0].Title.Caption := MSG05;
      Items[1].Title.Caption := MSG06;
      Items[2].Title.Caption := MSG07;
      Items[3].Title.Caption := MSG08;
    end;
    Color:= FBGColorOddLines;
    RowCount := 1;
    Invalidate;
  end;
end;

// SHOW FORM
procedure TForm4.FormShow(Sender: TObject);
begin
  DrawGrid1.RowCount := FRecordCount + 1;
end;

end.

