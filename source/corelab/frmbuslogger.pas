{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmbuslogger.pas                                                         | }
{ | BusLogger form                                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmbuslogger;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  EditBtn, Grids, Types, core_bus, uconfig;
const
  MAX_LOG = 1024;
type
  { TForm14 }
  TForm14 = class(TForm)
    Bevel1:      TBevel;
    Button1:     TButton;
    Button2:     TButton;
    Button3:     TButton;
    DrawGrid1:   TDrawGrid;
    EditButton1: TEditButton;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    // colors
    FOperationColor:    TColor;                              // Operation column
    FDeviceColor:       TColor;                                 // Device column
    FAddressColor:      TColor;                                // Address column
    FRelAddressColor:   TColor;                       // Relative address column
    FDataColor:         TColor;                                   // Data column
    FStatusColor:       TColor;                                 // Status column
    FLineSelectorColor: TColor;                                 // Selector line
    FBGColorOddLines:   TColor;                                     // Odd lines
    FBGColorEvenLines:  TColor;                                    // Even lines
    // others
    FRecordCount:       Integer;          // Number of valid items in the buffer
    FRingBuffer:        array[0..MAX_LOG - 1] of TBusLogRec;  // Log rec. buffer
    FWriteMarker:       Integer;         // Next empty place for write to buffer
    procedure Reset;
    function ReadBuffer(ALine: Integer): TBusLogRec;
    procedure WriteBuffer(ABusLogRec: TBusLogRec);
  public
    procedure AppendRecord(ABusLogRec: TBusLogRec);
    procedure ClearContent;
    procedure RefreshContent;
    procedure RefreshColors;
  end;
var
  Form14: TForm14;

implementation

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Save log to file';
  MSG03 = 'Cannot save ''%s'' log file.';
  MSG04 = 'Log file|*.log|All file|*.*';
  MSG05 = 'Operation';
  MSG06 = 'Device';
  MSG07 = 'Address';
  MSG08 = 'Rel. address';
  MSG09 = 'Data';
  MSG10 = 'Status';

{$R *.lfm}

{ TForm14 }

// ---- PRIVATE METHODS ----

// RESET RINGBUFFER
procedure TForm14.Reset;
var
  i: Integer;
begin
  for i := 0 to MAX_LOG - 1 do
    with FRingBuffer[i] do
    begin
      Operation := '';
      Device := '';
      Address := '';
      RelAddress := '';
      Data := '';
      Status := '';
    end;
  FRecordCount := 0;
  FWriteMarker := 0;
end;

// READ A RECORD FROM RINGBUFFER
function TForm14.ReadBuffer(ALine: Integer): TBusLogRec;
var
  PhysicalIndex: Integer;
begin
  if (ALine < 0) or (ALine >= FRecordCount) then
  with Result do
  begin
    Operation := '';
    Device := '';
    Address := '';
    RelAddress := '';
    Data := '';
    Status := '';
  end else
  begin
    if FRecordCount < MAX_LOG
      then PhysicalIndex := ALine
      else PhysicalIndex := (FWriteMarker + ALine) mod MAX_LOG;
    Result := FRingBuffer[PhysicalIndex];
  end;
end;

// WRITE RECORD TO RINGBUFFER
procedure TForm14.WriteBuffer(ABusLogRec: TBusLogRec);
begin
  FRingBuffer[FWriteMarker] := ABusLogRec;
  FWriteMarker := (FWriteMarker + 1) mod MAX_LOG;         // next empty position
  if FRecordCount < MAX_LOG then Inc(FRecordCount);   // number of the all items
end;

// ---- PUBLIC METHODS ----

// APPEND A RECORD TO LOG
procedure TForm14.AppendRecord(ABusLogRec: TBusLogRec);
begin
  WriteBuffer(ABusLogRec);
end;

// CLEAR LOGS
procedure TForm14.ClearContent;
begin
  Button2Click(Nil);
end;

// REFRESH CONTENT
procedure TForm14.RefreshContent;
begin
  DrawGrid1.RowCount := FRecordCount + 1;
  if DrawGrid1.RowCount > 1 then DrawGrid1.Row := DrawGrid1.RowCount - 1;
end;

// REFRESH COLORS
procedure TForm14.RefreshColors;
begin
  with uconfig.AppConfig.BusLoggerConfig do
  begin
    Form14.FOperationColor := operation_color;
    Form14.FDeviceColor := device_color;
    Form14.FAddressColor := address_color;
    Form14.FRelAddressColor := reladdress_color;
    Form14.FDataColor := data_color;
    Form14.FStatusColor := status_color;
    Form14.FLineSelectorColor := lineselector_color;
    Form14.FBGColorOddLines := bgodd_color;
    Form14.FBGColorEvenLines := bgeven_color;
    DrawGrid1.Color := FBGColorOddLines;
    DrawGrid1.Invalidate;
  end;
end;

// EVENT HANDLER METHODS

// HIDE LOG WINDOW
procedure TForm14.Button1Click(Sender: TObject);
begin
  // store settings
  with uconfig.AppConfig.BusLoggerConfig do
  begin
    top := Form14.Top;
    left := Form14.Left;
    height := Form14.Height;
    width := Form14.Width;
    with DrawGrid1.Columns do
    begin
      column0_width := Items[0].Width;
      column1_width := Items[1].Width;
      column2_width := Items[2].Width;
      column3_width := Items[3].Width;
      column4_width := Items[4].Width;
      column5_width := Items[5].Width;
    end;
  end;
  Form14.Hide;
end;

// CLEAR LOG
procedure TForm14.Button2Click(Sender: TObject);
begin
  Reset;
  DrawGrid1.RowCount := 1;
  DrawGrid1.Invalidate;
end;

// SAVE LOG TO FILE
procedure TForm14.Button3Click(Sender: TObject);
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
            Operation + #9 +
            Device + #9 +
            Address + #9 +
            RelAddress + #9 +
            Data + #9 +
            Status);
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
procedure TForm14.DrawGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  BusLogRec: TBusLogRec;
  Style:  TTextStyle;
begin
  if aRow = 0 then Exit else BusLogRec := ReadBuffer(aRow - 1);
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
      0: Font.Color := FOperationColor;
      1: Font.Color := FDeviceColor;
      2: Font.Color := FAddressColor;
      3: Font.Color := FRelAddressColor;
      4: Font.Color := FDataColor;
      5: Font.Color := FStatusColor;
    end;
    // text alignment
    Style := TextStyle;
    Style.Layout := tlCenter;
    case ACol of
      0: Style.Alignment := taLeftJustify;
      1: Style.Alignment := taCenter;
      2: Style.Alignment := taCenter;
      3: Style.Alignment := taCenter;
      4: Style.Alignment := taCenter;
      5: Style.Alignment := taCenter;
    end;
    TextStyle := Style;
    // write content
    case ACol of
      0: TextRect(aRect, aRect.Left + 4, aRect.Top, BusLogRec.Operation);
      1: TextRect(aRect, aRect.Left, aRect.Top, BusLogRec.Device);
      2: TextRect(aRect, aRect.Left, aRect.Top, BusLogRec.Address);
      3: TextRect(aRect, aRect.Left, aRect.Top, BusLogRec.RelAddress);
      4: TextRect(aRect, aRect.Left, aRect.Top, BusLogRec.Data);
      5: TextRect(aRect, aRect.Left, aRect.Top, BusLogRec.Status);
    end;
  end;
end;

// SEARCH IN LOG
procedure TForm14.EditButton1ButtonClick(Sender: TObject);
var
  i: Integer;
  s: string;
begin
  if (Length(EditButton1.Text) > 0) and (FRecordCount > 0) then
  for i := DrawGrid1.Row to FRecordCount -1 do
  begin
    with ReadBuffer(i) do
      s := LowerCase(
            Operation + #9 +
            Device + #9 +
            Address + #9 +
            RelAddress + #9 +
            Data + #9 +
            Status);
    if Pos(LowerCase(EditButton1.Text), s) > 0 then
    begin
      DrawGrid1.Row := i + 1;
      DrawGrid1.TopRow:= i + 1;
      Exit;
    end;
  end;
end;

// ONACTIVATE
procedure TForm14.FormActivate(Sender: TObject);
begin
  Form14.Invalidate;
end;

// CREATE FORM
procedure TForm14.FormCreate(Sender: TObject);
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
      Items[4].Title.Caption := MSG09;
      Items[5].Title.Caption := MSG10;
    end;
    Color := FBGColorOddLines;
    RowCount := 1;
    Invalidate;
  end;
end;

// SHOW FORM
procedure TForm14.FormShow(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig.BusLoggerConfig do
  begin
    Form14.Top := top;
    Form14.Left := left;
    Form14.Height := height;
    Form14.Width := width;
    with DrawGrid1.Columns do
    begin
      Items[0].Width := column0_width;
      Items[1].Width := column1_width;
      Items[2].Width := column2_width;
      Items[3].Width := column3_width;
      Items[4].Width := column4_width;
      Items[5].Width := column5_width;
    end;
  end;
  RefreshColors;
  DrawGrid1.RowCount := FRecordCount + 1;
end;

// CLOSE FORM
procedure TForm14.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // store settings
  with uconfig.AppConfig.BusLoggerConfig do
  begin
    top := Form14.Top;
    left := Form14.Left;
    height := Form14.Height;
    width := Form14.Width;
    with DrawGrid1.Columns do
    begin
      column0_width := Items[0].Width;
      column1_width := Items[1].Width;
      column2_width := Items[2].Width;
      column3_width := Items[3].Width;
      column4_width := Items[4].Width;
      column5_width := Items[5].Width;
    end;
  end;
end;

end.

