{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmproperties.pas                                                        | }
{ | Modul properties form                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmproperties;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ValEdit, core_cpu, core_memory, core_ioport, uconfig, uproperties, Grids, Types;
type
  { TForm15 }
  TForm15 = class(TForm)
    Bevel1:           TBevel;
    Button1:          TButton;
    Button2:          TButton;
    ValueListEditor1: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure ValueListEditor1ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
  private
    FMemInstance:      TMemory;
    FProcInstance:     TCPU;
    FPortInstance:     TIOPort;
    FSelectModuleType: Byte;                                              // 0-3
    procedure SetMemInstance(AMemInstance: TMemory);                        // 1
    procedure SetProcInstance(AProcInstance: TCPU);                         // 2
    procedure SetPortInstance(APortInstance: TIOPort);                      // 3
  public
    property MemInstance: TMemory write SetMemInstance;
    property ProcInstance: TCPU write SetProcInstance;
    property PortInstance: TIOPort write SetPortInstance;
  end;
var
  Form15: TForm15;

implementation

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Cannot open memory modulka.';
  MSG03 = 'Property';
  MSG04 = 'Value';
  MSG05 = 'The memory size can be 16 B-16 MB';
  MSG06 = 'Data conversion error at save.';
  MSG07 = 'The address value be 0-2^24';

{$R *.lfm}

{ TForm15 }

// ----  PRIVATE METHODS ----

// SETTERS
procedure TForm15.SetMemInstance(AMemInstance: TMemory);
begin
  if Assigned(AMemInstance) then
  begin
    FMemInstance := AMemInstance;
    FSelectModuleType := 1;
  end else
  begin
    FSelectModuleType := 0;
    ShowMessage(MSG01 + MSG02);
  end;
end;

procedure TForm15.SetProcInstance(AProcInstance: TCPU);
begin
  if Assigned(AProcInstance) then
  begin
    FProcInstance := AProcInstance;
    FSelectModuleType := 2;
  end else
  begin
    FSelectModuleType := 0;
    ShowMessage(MSG01 + MSG02);
  end;
end;

procedure TForm15.SetPortInstance(APortInstance: TIOPort);
begin
  if Assigned(APortInstance) then
  begin
    FPortInstance := APortInstance;
    FSelectModuleType := 3;
  end else
  begin
    FSelectModuleType := 0;
    ShowMessage(MSG01 + MSG02);
  end;
end;

// ---- EVENT HANDLER METHODS ----

// APPLY AND CLOSE FORM
procedure TForm15.Button1Click(Sender: TObject);

  // SAVE TO I/O PORT MODULE
  procedure SaveIOProperties(APortInstance: TIOPort);
  var
    lm: TLineMode;
  begin
    try
      // save properties
      with ValueListEditor1 do
      begin
        APortInstance.BaseAddress := StrToInt('$' + Values['BaseAddress']);
        APortInstance.IntVector := StrToInt('$' + Values['IntVector']);
        APortInstance.Enabled := StrToBool(Values['Enabled']);
        APortInstance.DataInMode := lm.fromString(Values['DataInMode']);
        APortInstance.DataInNegation := StrToBool(Values['DataInNegation']);
        APortInstance.DataOutMode := lm.fromString(Values['DataOutMode']);
        APortInstance.DataOutNegation := StrToBool(Values['DataOutNegation']);
        APortInstance.SelMode := lm.fromString(Values['SelMode']);
        APortInstance.SelNegation := StrToBool(Values['SelNegation']);
      end;
    except
      ShowMessage(MSG01 + MSG06);
    end;
  end;

  // SAVE TO MEMORY MODULE
  procedure SaveMProperties(AMemInstance: TMemory);
  var
     mm: TMemoryMode;
  begin
    try
      // save properties
      with ValueListEditor1 do
      begin
        AMemInstance.Enabled := StrToBool(Values['Enabled']);
        AMemInstance.AddressRangeSize := StrToInt(Values['AddressRangeSize']);
        AMemInstance.BaseAddress := StrToInt('$' + Values['BaseAddress']);
        AMemInstance.MemoryMode := mm.fromString(Values['MemoryMode']);
      end;
    except
      ShowMessage(MSG01 + MSG06);
    end;
  end;

  // SAVE TO PROCESSOR MODULE
  procedure SavePProperties(AProcInstance: TCPU);
  begin
    try
      // save properties
      with ValueListEditor1 do
        AProcInstance.Enabled := StrToBool(Values['Enabled']);
    except
      ShowMessage(MSG01 + MSG06);
    end;
  end;

begin
  // save properties
  case FSelectModuleType of
    1: SaveMProperties(FMemInstance);
    2: SavePProperties(FProcInstance);
    3: SaveIOProperties(FPortInstance);
  end;
  ModalResult := mrOk;
end;

// CANCEL AND CLOSE FORM
procedure TForm15.Button2Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

// CREATE FORM
procedure TForm15.FormCreate(Sender: TObject);
begin
  ValueListEditor1.TitleCaptions.Add(MSG03);
  ValueListEditor1.TitleCaptions.Add(MSG04);
end;

// SHOW FORM
procedure TForm15.FormShow(Sender: TObject);

  // LOAD FROM I/O PORT MODULE
  procedure LoadIOProperties(APortInstance: TIOPort);
  var
    lm: TLineMode;
  begin
    try
      // load properies
      with ValueListEditor1 do
      begin
        Clear;
        DefaultRowHeight := 30;
        InsertRow(uproperties.IOPropertyInfoArray[0].Name, StrPas(APortInstance.ModName), True);
        ItemProps[uproperties.IOPropertyInfoArray[0].Name].ReadOnly := not uproperties.IOPropertyInfoArray[0].Writable;
        InsertRow(uproperties.IOPropertyInfoArray[1].Name, StrPas(APortInstance.Description), True);
        ItemProps[uproperties.IOPropertyInfoArray[1].Name].ReadOnly := not uproperties.IOPropertyInfoArray[1].Writable;
        InsertRow(uproperties.IOPropertyInfoArray[2].Name, APortInstance.Version.ToString, True);
        ItemProps[uproperties.IOPropertyInfoArray[2].Name].ReadOnly := not uproperties.IOPropertyInfoArray[2].Writable;
        InsertRow(uproperties.IOPropertyInfoArray[3].Name, BoolToStr(APortInstance.Enabled, 'true', 'false'), True);
        ItemProps[uproperties.IOPropertyInfoArray[3].Name].ReadOnly := not uproperties.IOPropertyInfoArray[3].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[3].Name] do
        begin
          EditStyle := esPickList;
          PickList.CommaText := 'true,false';
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[4].Name, BoolToStr(APortInstance.HasPanel, 'true', 'false'), True);
        ItemProps[uproperties.IOPropertyInfoArray[4].Name].ReadOnly := not uproperties.IOPropertyInfoArray[4].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[4].Name] do
        begin
          EditStyle := esPickList;
          PickList.CommaText := 'true,false';
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[6].Name, IntToStr(APortInstance.AddressRangeSize), True);
        ItemProps[uproperties.IOPropertyInfoArray[6].Name].ReadOnly := not uproperties.IOPropertyInfoArray[6].Writable;
        InsertRow(uproperties.IOPropertyInfoArray[5].Name, IntToHex(APortInstance.BaseAddress, 4), True);
        ItemProps[uproperties.IOPropertyInfoArray[5].Name].ReadOnly := not uproperties.IOPropertyInfoArray[5].Writable;
        InsertRow(uproperties.IOPropertyInfoArray[7].Name, IntToHex(APortInstance.IntVector, 2), True);
        ItemProps[uproperties.IOPropertyInfoArray[7].Name].ReadOnly := not uproperties.IOPropertyInfoArray[7].Writable;
        InsertRow(uproperties.IOPropertyInfoArray[8].Name, APortInstance.DataInMode.ToString, True);
        ItemProps[uproperties.IOPropertyInfoArray[8].Name].ReadOnly := not uproperties.IOPropertyInfoArray[8].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[8].Name] do
        begin
          EditStyle := esPickList;
          for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[9].Name, BoolToStr(APortInstance.DataInNegation, True), True);
        ItemProps[uproperties.IOPropertyInfoArray[9].Name].ReadOnly := not uproperties.IOPropertyInfoArray[9].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[9].Name] do
        begin
          EditStyle := esPickList;
          PickList.CommaText := 'true,false';
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[10].Name, APortInstance.DataOutMode.ToString, True);
        ItemProps[uproperties.IOPropertyInfoArray[10].Name].ReadOnly := not uproperties.IOPropertyInfoArray[10].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[10].Name] do
        begin
          EditStyle := esPickList;
          for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[11].Name, BoolToStr(APortInstance.DataOutNegation, True), True);
        ItemProps[uproperties.IOPropertyInfoArray[11].Name].ReadOnly := not uproperties.IOPropertyInfoArray[11].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[11].Name] do
        begin
          EditStyle := esPickList;
          PickList.CommaText := 'true,false';
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[12].Name, APortInstance.SelMode.ToString, True);
        ItemProps[uproperties.IOPropertyInfoArray[12].Name].ReadOnly := not uproperties.IOPropertyInfoArray[12].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[12].Name] do
        begin
          EditStyle := esPickList;
          for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[13].Name, BoolToStr(APortInstance.SelNegation, True), True);
        ItemProps[uproperties.IOPropertyInfoArray[13].Name].ReadOnly := not uproperties.IOPropertyInfoArray[13].Writable;
        with ItemProps[uproperties.IOPropertyInfoArray[13].Name] do
        begin
          EditStyle := esPickList;
          PickList.CommaText := 'true,false';
          ReadOnly := True;
        end;
        InsertRow(uproperties.IOPropertyInfoArray[14].Name, BoolToStr(APortInstance.LatchedOutput, True), True);
        ItemProps[uproperties.IOPropertyInfoArray[14].Name].ReadOnly := not uproperties.IOPropertyInfoArray[14].Writable;
        InsertRow(uproperties.IOPropertyInfoArray[15].Name, BoolToStr(APortInstance.ReadBackOutput, True), True);
        ItemProps[uproperties.IOPropertyInfoArray[15].Name].ReadOnly := not uproperties.IOPropertyInfoArray[15].Writable;
        ValueListEditor1.TopRow := 1;
      end;
    except
    end;
  end;

  // LOAD FROM MEMORY MODULE
  procedure LoadMProperties(AMemInstance: TMemory);
  var
    mm: TMemoryMode;
  begin
    try
      // load properies
      with ValueListEditor1 do
      begin
        Clear;
        DefaultRowHeight := 30;
        InsertRow(uproperties.MPropertyInfoArray[0].Name, StrPas(AMemInstance.ModName), True);
        ItemProps[uproperties.MPropertyInfoArray[0].Name].ReadOnly := not uproperties.MPropertyInfoArray[0].Writable;
        InsertRow(uproperties.MPropertyInfoArray[1].Name, StrPas(AMemInstance.Description), True);
        ItemProps[uproperties.MPropertyInfoArray[1].Name].ReadOnly := not uproperties.MPropertyInfoArray[1].Writable;
        InsertRow(uproperties.MPropertyInfoArray[2].Name, AMemInstance.Version.ToString, True);
        ItemProps[uproperties.MPropertyInfoArray[2].Name].ReadOnly := not uproperties.MPropertyInfoArray[2].Writable;
        InsertRow(uproperties.MPropertyInfoArray[3].Name, BoolToStr(AMemInstance.Enabled, 'true', 'false'), True);
        ItemProps[uproperties.MPropertyInfoArray[3].Name].ReadOnly := not uproperties.MPropertyInfoArray[3].Writable;
        with ItemProps[uproperties.MPropertyInfoArray[3].Name] do
        begin
          EditStyle := esPickList;
          PickList.CommaText := 'true,false';
          ReadOnly := True;
        end;
        InsertRow(uproperties.MPropertyInfoArray[5].Name, IntToStr(AMemInstance.AddressRangeSize), True);
        ItemProps[uproperties.MPropertyInfoArray[5].Name].ReadOnly := not uproperties.MPropertyInfoArray[5].Writable;
        InsertRow(uproperties.MPropertyInfoArray[4].Name, IntToHex(AMemInstance.BaseAddress, 4), True);
        ItemProps[uproperties.MPropertyInfoArray[4].Name].ReadOnly := not uproperties.MPropertyInfoArray[4].Writable;
        InsertRow(uproperties.MPropertyInfoArray[6].Name, AMemInstance.MemoryMode.ToString, True);
        ItemProps[uproperties.MPropertyInfoArray[6].Name].ReadOnly := not uproperties.MPropertyInfoArray[6].Writable;
        with ItemProps[uproperties.MPropertyInfoArray[6].Name] do
        begin
          EditStyle := esPickList;
          for mm := Low(TMemoryMode) to High(TMemoryMode) do PickList.Add(mm.ToString);
          ReadOnly := True;
        end;
        ValueListEditor1.TopRow := 1;
      end;
    except
    end;
  end;

  // LOAD FROM PROCESSOR MODULE
  procedure LoadPProperties(AProcInstance: TCPU);
  begin
    try
      // load properies
      with ValueListEditor1 do
      begin
        Clear;
        DefaultRowHeight := 30;
        InsertRow(uproperties.PPropertyInfoArray[0].Name, StrPas(AProcInstance.ModName), True);
        ItemProps[uproperties.PPropertyInfoArray[0].Name].ReadOnly := not uproperties.PPropertyInfoArray[0].Writable;
        InsertRow(uproperties.PPropertyInfoArray[1].Name, StrPas(AProcInstance.Description), True);
        ItemProps[uproperties.PPropertyInfoArray[1].Name].ReadOnly := not uproperties.PPropertyInfoArray[1].Writable;
        InsertRow(uproperties.PPropertyInfoArray[2].Name, AProcInstance.Version.ToString, True);
        ItemProps[uproperties.PPropertyInfoArray[2].Name].ReadOnly := not uproperties.PPropertyInfoArray[2].Writable;
        InsertRow(uproperties.PPropertyInfoArray[3].Name, BoolToStr(AProcInstance.Enabled, 'true', 'false'), True);
        ItemProps[uproperties.PPropertyInfoArray[3].Name].ReadOnly := not uproperties.PPropertyInfoArray[3].Writable;
        with ItemProps[uproperties.PPropertyInfoArray[3].Name] do
        begin
          EditStyle := esPickList;
          PickList.CommaText := 'true,false';
          ReadOnly := True;
        end;
        InsertRow(uproperties.PPropertyInfoArray[5].Name, IntToStr(AProcInstance.AddressWidth), True);
        ItemProps[uproperties.PPropertyInfoArray[5].Name].ReadOnly := not uproperties.PPropertyInfoArray[5].Writable;
        InsertRow(uproperties.PPropertyInfoArray[6].Name, AProcInstance.Architecture.ToString, True);
        ItemProps[uproperties.PPropertyInfoArray[6].Name].ReadOnly := not uproperties.PPropertyInfoArray[6].Writable;
        InsertRow(uproperties.PPropertyInfoArray[7].Name, AProcInstance.Endianness.ToString, True);
        ItemProps[uproperties.PPropertyInfoArray[7].Name].ReadOnly := not uproperties.PPropertyInfoArray[7].Writable;
        InsertRow(uproperties.PPropertyInfoArray[8].Name, BoolToStr(AProcInstance.HasSeparateIOBus, 'true', 'false'), True);
        ItemProps[uproperties.PPropertyInfoArray[8].Name].ReadOnly := not uproperties.PPropertyInfoArray[8].Writable;
        InsertRow(uproperties.PPropertyInfoArray[9].Name, IntToHex(AProcInstance.MaxIOPortAddress, 4), True);
        ItemProps[uproperties.PPropertyInfoArray[9].Name].ReadOnly := not uproperties.PPropertyInfoArray[9].Writable;
        InsertRow(uproperties.PPropertyInfoArray[10].Name, IntToHex(AProcInstance.MaxMemAddress, 6), True);
        ItemProps[uproperties.PPropertyInfoArray[10].Name].ReadOnly := not uproperties.PPropertyInfoArray[10].Writable;
        InsertRow(uproperties.PPropertyInfoArray[11].Name, IntToHex(AProcInstance.MaxCodeAddress, 6), True);
        ItemProps[uproperties.PPropertyInfoArray[11].Name].ReadOnly := not uproperties.PPropertyInfoArray[11].Writable;
        ValueListEditor1.TopRow := 1;
      end;
    except
    end;
  end;

begin
  // retrieve settings
  with uconfig.AppConfig.ModulePropertiesConfig do
  begin
    Form15.Top := top;
    Form15.Left := left;
    Form15.Height := height;
    Form15.Width := width;
    ValueListEditor1.ColWidths[0] := column0_width;
  end;
  // load properties
  case FSelectModuleType of
    1: LoadMProperties(FMemInstance);
    2: LoadPProperties(FProcInstance);
    3: LoadIOProperties(FPortInstance);
  end;
end;

// COLORING READ-ONLY PROPERTIES
procedure TForm15.ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  Grid: TValueListEditor;
begin
  Grid := TValueListEditor(Sender);
  if Length(Grid.Cells[0, aRow]) > 0 then
    if (aRow > 0) and
       (aRow <= Grid.RowCount - 1) and
       (Grid.ItemProps[Grid.Keys[aRow]].ReadOnly) and
       (not (Grid.ItemProps[Grid.Keys[aRow]].EditStyle = esPickList)) and
       (aCol = 0) then
      with Grid.Canvas do
      begin
        Brush.Color := clBtnFace;
        Font.Color := clGrayText;
        Font.Style := [fsItalic];
        FillRect(aRect);
        TextRect(aRect, aRect.Left + 4, aRect.Top + 6, Grid.Cells[ACol, ARow]);
     end;
end;

// VALIDATE ENTRY
procedure TForm15.ValueListEditor1ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
begin
  begin
    if (aCol = 1) and (FSelectModuleType = 1)then
    begin
      // memory address range
      if ValueListEditor1.Keys[aRow] = 'AddressRangeSize' then
      begin
        NewValue := Trim(NewValue);
        if NewValue = '' then NewValue := '0';
        if (StrToInt(NewValue) < 16) or (StrToInt(NewValue) > (1 shl 24)) then
        begin
          ShowMessage(MSG01 + MSG05);
          NewValue := OldValue;
        end;
      end;
      if ValueListEditor1.Keys[aRow] = 'BaseAddress' then
      begin
        NewValue := Trim(NewValue);
        if NewValue = '' then NewValue := '0';
        if StrToInt('$' + NewValue) > (1 shl 24) then
        begin
          ShowMessage(MSG01 + MSG07);
          NewValue := OldValue;
        end;
      end;
    end;
  end;
end;

// CLOSE FORM
procedure TForm15.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // store changeable setting
  with uconfig.AppConfig.ModulePropertiesConfig do
  begin
    top := Form15.Top;
    left := Form15.Left;
    height := Form15.Height;
    width := Form15.Width;
    column0_width := ValueListEditor1.ColWidths[0];
  end;
end;

end.

