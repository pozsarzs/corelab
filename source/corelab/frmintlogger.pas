{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmintlogger.pas                                                         | }
{ | IntLogger form                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmintlogger;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  EditBtn, Grids, Types, core_cpu, uconfig;
const
  MAX_LOG = 1024;
type
  { TForm8 }
  TForm8 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DrawGrid1: TDrawGrid;
    EditButton1: TEditButton;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSenderColor:       TColor;                                 // Sender column
    FVectorColor:       TColor;                                 // Vector column
    FStatusColor:       TColor;                                 // Status column
    FFlagColor:         TColor;                                   // Flag column
    FLineSelectorColor: TColor;                                 // Selector line
    FBGColorOddLines:   TColor;                                     // Odd lines
    FBGColorEvenLines:  TColor;                                    // Even lines
    // others
    FRecordCount:       Integer;          // Number of valid items in the buffer
    FRingBuffer:        array[0..MAX_LOG - 1] of TIntLogRec;  // Log rec. buffer
    FWriteMarker:       Integer;         // Next empty place for write to buffer
    procedure Reset;
    function ReadBuffer(ALine: Integer): TIntLogRec;
    procedure WriteBuffer(AIntLogRec: TIntLogRec);
  public
    procedure ClearContent;
    procedure RefreshColors;
    procedure AppendRecord(AIntLogRec: TIntLogRec);
  end;

var
  Form8: TForm8;

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Save log to file';
  MSG03 = 'Cannot save ''%s'' log file.';
  MSG04 = 'Log file|*.log|All file|*.*';
  MSG05 = 'Sender';
  MSG06 = 'Vector';
  MSG07 = 'Status';
  MSG08 = 'Flag';

implementation

{$R *.lfm}
{ TForm8 }

// ---- PRIVATE METHODS ----

// RESET RINGBUFFER
procedure TForm8.Reset;
var
  i: Integer;
begin
  for i := 0 to MAX_LOG - 1 do
    with FRingBuffer[i] do
    begin
//      InstCount := -1;
      Sender := '';
      Vector := '';
      Status := '';
      Flag := '';
    end;
  FRecordCount := 0;
  FWriteMarker := 0;
end;

// READ A RECORD FROM RINGBUFFER
function TForm8.ReadBuffer(ALine: Integer): TIntLogRec;
var
  PhysicalIndex: Integer;
begin
  if (ALine < 0) or (ALine >= FRecordCount) then
  with Result do
  begin
//    InstCount := -1;
    Sender := '';
    Vector := '';
    Status := '';
    Flag := '';
  end else
  begin
    if FRecordCount < MAX_LOG
      then PhysicalIndex := ALine
      else PhysicalIndex := (FWriteMarker + ALine) mod MAX_LOG;
    Result := FRingBuffer[PhysicalIndex];
  end;
end;

// WRITE RECORD TO RINGBUFFER
procedure TForm8.WriteBuffer(AIntLogRec: TIntLogRec);
begin
  FRingBuffer[FWriteMarker] := AIntLogRec;
  FWriteMarker := (FWriteMarker + 1) mod MAX_LOG;         // next empty position
  if FRecordCount < MAX_LOG then Inc(FRecordCount);   // number of the all items
end;

// ---- PUBLIC METHODS ----

// APPEND A RECORD TO LOG
procedure TForm8.AppendRecord(AIntLogRec: TIntLogRec);
begin
  WriteBuffer(AIntLogRec);
  if Form8.Visible then DrawGrid1.RowCount := FRecordCount + 1;
end;

// CLEAR LOGS
procedure TForm8.ClearContent;
begin
  Button2Click(Nil);
end;

// REFRESH COLORS
procedure TForm8.RefreshColors;
begin
  with uconfig.AppConfig.IntLoggerConfig do
  begin
    Form8.FSenderColor := sender_color;
    Form8.FVectorColor := vector_color;
    Form8.FStatusColor := status_color;
    Form8.FFlagColor := flag_color;
    Form8.FLineSelectorColor := lineselector_color;
    Form8.FBGColorOddLines := bgodd_color;
    Form8.FBGColorEvenLines := bgeven_color;
    DrawGrid1.Color := FBGColorOddLines;
    DrawGrid1.Invalidate;
  end;
end;

// EVENT HANDLER METHODS

// HIDE LOG WINDOW
procedure TForm8.Button1Click(Sender: TObject);
begin
  // store settings
  with uconfig.AppConfig.IntLoggerConfig do
  begin
    top := Form8.Top;
    left := Form8.Left;
    height := Form8.Height;
    width := Form8.Width;
    with DrawGrid1.Columns do
    begin
      column0_width := Items[0].Width;
      column1_width := Items[1].Width;
      column2_width := Items[2].Width;
      column3_width := Items[3].Width;
    end;
  end;
  Form8.Hide;
end;

// CLEAR LOG
procedure TForm8.Button2Click(Sender: TObject);
begin
  Reset;
  DrawGrid1.RowCount := 1;
  DrawGrid1.Invalidate;
end;

// SAVE LOG TO FILE
procedure TForm8.Button3Click(Sender: TObject);
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
            Sender + #9 +
            Vector + #9 +
            Status + #9 +
            Flag);
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
procedure TForm8.DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  IntLogRec: TIntLogRec;
  Style:  TTextStyle;
begin
  if aRow = 0 then Exit else IntLogRec := ReadBuffer(aRow - 1);
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
      0: Font.Color := FSenderColor;
      1: Font.Color := FVectorColor;
      2: Font.Color := FStatusColor;
      3: Font.Color := FFlagColor;
    end;
    // text alignment
    Style := TextStyle;
    Style.Layout := tlCenter;
    case ACol of
      0: Style.Alignment := taLeftJustify;
      1: Style.Alignment := taCenter;
      2: Style.Alignment := taLeftJustify;
      3: Style.Alignment := taLeftJustify;
    end;
    TextStyle := Style;
    // write content
    case ACol of
      0: TextRect(aRect, aRect.Left, aRect.Top, IntLogRec.Sender);
      1: TextRect(aRect, aRect.Left, aRect.Top, IntLogRec.Vector);
      2: TextRect(aRect, aRect.Left + 4, aRect.Top, IntLogRec.Status);
      3: TextRect(aRect, aRect.Left + 4, aRect.Top, IntLogRec.Flag);
    end;
  end;
end;

// SEARCH IN LOG
procedure TForm8.EditButton1ButtonClick(Sender: TObject);
var
  i: Integer;
  s: string;
begin
  if (Length(EditButton1.Text) > 0) and (FRecordCount > 0) then
  for i := DrawGrid1.Row to FRecordCount -1 do
  begin
    with ReadBuffer(i) do
      s := LowerCase(
             Sender + #9 +
             Vector + #9 +
             Status + #9 +
             Flag);
    if Pos(LowerCase(EditButton1.Text), s) > 0 then
    begin
      DrawGrid1.Row := i + 1;
      DrawGrid1.TopRow:= i + 1;
      Exit;
    end;
  end;
end;

// ONACTIVATE
procedure TForm8.FormActivate(Sender: TObject);
begin
  Form8.Invalidate;
end;

// CREATE FORM
procedure TForm8.FormCreate(Sender: TObject);
begin
  Reset;
  with DrawGrid1 do
  begin
    with Columns do
    begin
      Items[0].Title.Caption := MSG05;
      Items[1].Title.Caption := MSG06;
      Items[2].Title.Caption := MSG07;
      Items[3].Title.Caption := MSG08;
    end;
    Color := FBGColorOddLines;
    RowCount := 1;
    Invalidate;
  end;
end;

// SHOW FORM
procedure TForm8.FormShow(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig.IntLoggerConfig do
  begin
    Form8.Top := top;
    Form8.Left := left;
    Form8.Height := height;
    Form8.Width := width;
    with DrawGrid1.Columns do
    begin
      Items[0].Width := column0_width;
      Items[1].Width := column1_width;
      Items[2].Width := column2_width;
      Items[3].Width := column3_width;
    end;
  end;
  RefreshColors;
  DrawGrid1.RowCount := FRecordCount + 1;
end;

// CLOSE FORM
procedure TForm8.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // store settings
  with uconfig.AppConfig.IntLoggerConfig do
  begin
    top := Form8.Top;
    left := Form8.Left;
    height := Form8.Height;
    width := Form8.Width;
    with DrawGrid1.Columns do
    begin
      column0_width := Items[0].Width;
      column1_width := Items[1].Width;
      column2_width := Items[2].Width;
      column3_width := Items[3].Width;
    end;
  end;
end;

end.

