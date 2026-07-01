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

unit frmmain;
{$mode objfpc}{$H+}
interface
uses
  cmem, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ValEdit, ExtCtrls, EditBtn, ShellCtrls, DynLibs, core_ioport, Grids,
  Menus, ComCtrls, Types;
type
  TPluginAttributes = record
    PFilename: string;                                 // Filename of the module
    PAddressRangeSize: byte;                               // Address range size
    PDataInMode: TLineMode;                         // Decoding input data lines
    PDataInNegation: boolean;               // Negation of databit (port -> CPU)
    PDataOutMode: TLineMode;                       // Decoding output data lines
    PDataOutNegation: boolean;              // Negation of databit (CPU -> port)
    PDescription: string;                                   // Short description
    PEnabled: boolean;                    // Enable port without detach from bus
    PHasGUI: boolean;                     // Does the implementation have a GUI?
    PLatchedOutput: boolean;                                   // Latched output
    PModname: string;                                             // Module name
    PPortMode: TPortMode;                                 // Port operation mode
    PReadBackOutput: boolean;           // Output port with read-back capability
    PResponse: TResponse;                    // Response type of the null device
    PSelMode: TLineMode;                       // Decoding matrix selector lines
    PSelNegation: boolean;                   // Negation of matrix selector bits
    PTitle: string;                                                // Form title
  end;
  // Direction pairs for data moving procedures
  TOpDirection = (opPlugin2Var, opVar2List, opList2Var, opVar2Plugin);
  // Port
  TCreatePortFunc = function: TIOPort; cdecl;
  TDestroyPortProc = procedure(Port: TIOPort); cdecl;
  // UI
  TCreatePanelProc = procedure(Port: TIOPort); cdecl;
  TShowPanelProc = procedure; cdecl;
  THidePanelProc = procedure; cdecl;
  TFreePanelProc = procedure; cdecl;
  TSetSizePosPanelProc = procedure(Left, Top, Width, Height: integer); cdecl;
  { TForm1 }
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DirectoryEdit1: TDirectoryEdit;
    Panel1: TPanel;
    ShellListView1: TShellListView;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    ValueListEditor1: TValueListEditor;
    ValueListEditor2: TValueListEditor;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure ValueListEditor1EditingDone(Sender: TObject);
  private
    // Port
    CreatePort: TCreatePortFunc;
    DestroyPort: TDestroyPortProc;
    CurrentPort: TIOPort;                     // Created object of TIOPort class
    // UI
    CreatePanel: TCreatePanelProc;
    ShowPanel: TShowPanelProc;
    HidePanel: THidePanelProc;
    FreePanel: TFreePanelProc;
    SetSizePosPanel: TSetSizePosPanelProc;
    // Module
    LibHandle: TLibHandle;                        // Handle of the loaded module
    LoadedPlugin: TPluginAttributes;          // Properties of the loaded module
    procedure RefreshProperties(Direction: TOpDirection);
    procedure ImpExpProperties(Direction: TOpDirection);
  public
  end;
var
  Form1: TForm1;
  LoadCounter: byte = 0;              // Number of the succesfull load procedure

implementation

{$R *.lfm}
{ TForm1 }

Resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = '';
  MSG03 = '';
  MSG04 = '';
  MSG05 = '';
  MSG06 = '';

// Import/export properties
procedure TForm1.ImpExpProperties(Direction: TOpDirection);
begin
  // Import from plugin to variables
  if Direction = opPlugin2Var then
  begin
    // Check and read Modname and Description
    with LoadedPlugin do
    begin
      if Assigned(CurrentPort.Modname)
        then PModname := string(CurrentPort.Modname)
        else PModname := '';
      if Assigned(CurrentPort.Description)
        then PDescription := string(CurrentPort.Description)
        else PDescription := '';
      // Read other properties
      PAddressRangeSize := CurrentPort.AddressRangeSize;
      PDataInMode := CurrentPort.DataInMode;
      PDataInNegation := CurrentPort.DataInNegation;
      PDataOutMode := CurrentPort.DataOutMode;
      PDataOutNegation := CurrentPort.DataOutNegation;
      PEnabled := CurrentPort.Enabled;
      PHasGUI := CurrentPort.HasGUI;
      PLatchedOutput := CurrentPort.LatchedOutput;
      PPortMode := CurrentPort.PortMode;
      PReadBackOutput := CurrentPort.ReadBackOutput;
      PResponse := CurrentPort.Response;
      PSelMode := CurrentPort.SelMode;
      PSelNegation := CurrentPort.SelNegation;
      PTitle := string(CurrentPort.Title);
    end;
  end;
  // Export from variables to plugin
  if Direction = opVar2Plugin then
  begin
    with LoadedPlugin do
    begin
      CurrentPort.DataInMode := PDataInMode;
      CurrentPort.DataInNegation := PDataInNegation;
      CurrentPort.DataOutMode := PDataOutMode;
      CurrentPort.DataOutNegation := PDataOutNegation;
      CurrentPort.Enabled := PEnabled;
      CurrentPort.Response := PResponse;
      CurrentPort.SelMode := PSelMode;
      CurrentPort.SelNegation := PSelNegation;
      CurrentPort.Title := PChar(PTitle);
    end;
  end;
end;

// Refresh property list
procedure TForm1.RefreshProperties(Direction: TOpDirection);
var
  lm: TLineMode;
  rp: TResponse;
begin
  if Direction = opVar2List then
  begin
    // Variables to ValueListEditor1
    with ValueListEditor1 do
    begin
      Clear;
      DefaultRowHeight := 30;
      InsertRow('Filename', LoadedPlugin.PFilename, true);
      ItemProps['Filename'].ReadOnly := true;

      InsertRow('Modname',  LoadedPlugin.PModname, true);
      ItemProps['Modname'].ReadOnly := true;

      InsertRow('Title',  LoadedPlugin.PTitle, true);
      ItemProps['Title'].ReadOnly := true;

      InsertRow('Description', LoadedPlugin.PDescription, true);
      ItemProps['Description'].ReadOnly := true;

      InsertRow('HasGUI', BoolToStr(LoadedPlugin.PHasGUI,'true','false'), true);
      ItemProps['HasGUI'].ReadOnly := true;

      InsertRow('Enabled', BoolToStr(LoadedPlugin.PEnabled, 'true', 'false'), true);
      with ItemProps['Enabled'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := true;
      end;

      InsertRow('AddressRangeSize', LoadedPlugin.PAddressRangeSize.ToString, true);
      ItemProps['AddressRangeSize'].ReadOnly := true;

      InsertRow('LatchedOutput', BoolToStr(LoadedPlugin.PLatchedOutput, 'true', 'false'), true);
      ItemProps['LatchedOutput'].ReadOnly := true;

      InsertRow('PortMode', LoadedPlugin.PPortMode.ToString, true);
      ItemProps['PortMode'].ReadOnly := true;

      InsertRow('ReadBackOutput', BoolToStr(LoadedPlugin.PReadBackOutput, 'true', 'false'), true);
      ItemProps['ReadBackOutput'].ReadOnly := true;

      InsertRow('DataInMode', LoadedPlugin.PDataInMode.ToString, true);
      with ItemProps['DataInMode'] do
      begin
        EditStyle := esPickList;
        for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
        ReadOnly := true;
      end;

      InsertRow('DataInNegation', BoolToStr(LoadedPlugin.PDataInNegation, 'true', 'false'), true);
      with ItemProps['DataInNegation'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := true;
      end;

      InsertRow('DataOutMode', LoadedPlugin.PDataOutMode.ToString, true);
      with ItemProps['DataOutMode'] do
      begin
        EditStyle := esPickList;
        for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
        ReadOnly := true;
      end;

      InsertRow('DataOutNegation', BoolToStr(LoadedPlugin.PDataOutNegation, 'true', 'false'), true);
      with ItemProps['DataOutNegation'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := true;
      end;

      InsertRow('SelMode', LoadedPlugin.PSelMode.ToString, true);
      with ItemProps['SelMode'] do
      begin
        EditStyle := esPickList;
        for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
        ReadOnly := true;
      end;

      InsertRow('SelNegation', BoolToStr(LoadedPlugin.PSelNegation, 'true', 'false'), true);
      with ItemProps['SelNegation'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := true;
      end;

      InsertRow('Response', LoadedPlugin.PResponse.ToString, true);
      with ItemProps['Response'] do
      begin
        EditStyle := esPickList;
        for rp := Low(TResponse) to High(TResponse) do ItemProps['Response'].PickList.Add(rp.ToString);
        ReadOnly := true;
      end;

      AutoSizeColumn(0);
      Row := 1;
    end;
  end;
  if Direction = opList2Var then
  begin
    // ValueListEditor1 to variables
    with ValueListEditor1 do
    begin
      try
        LoadedPlugin.PEnabled := StrToBool(Values['Enabled']);
        LoadedPlugin.PDataInMode :=  lm.fromString(ItemProps['DataInMode'].toString);
        LoadedPlugin.PDataInNegation := StrToBool(Values['DataInNegation']);
        LoadedPlugin.PDataOutMode :=  lm.fromString(ItemProps['DataOutMode'].toString);
        LoadedPlugin.PDataOutNegation := StrToBool(Values['DataOutNegation']);
        LoadedPlugin.PSelMode :=  lm.fromString(ItemProps['SelMode'].toString);
        LoadedPlugin.PSelNegation := StrToBool(Values['SelNegation']);
        LoadedPlugin.PResponse :=  rp.fromString(ItemProps['Response'].toString);
      except
        ShowMessage('hiba');
      end;
    end;
  end;
end;

// Refresh plugin list
procedure TForm1.Button4Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
    ShellListView1.Mask := 'ioport_*.dll';
  {$ELSE}
    ShellListView1.Mask := 'libioport_*.so';
  {$ENDIF}
  try
    ShellListView1.Root := DirectoryEdit1.Directory;
    Button3.Enabled := true;
  except
    ShowMessage(ER + 'There is not such directory!');
    ShellListView1.Root := '.';
    Button3.Enabled := false;
  end;
end;

// Select plugin
procedure TForm1.Button3Click(Sender: TObject);
var
  b: byte;
  SelectedFile: string;
begin
  if ShellListView1.Selected <> nil then
  begin
    SelectedFile := ShellListView1.GetPathFromItem(ShellListView1.Selected);
    // remove previous loaded module
    // UI
    if Assigned(FreePanel) then
    begin
      HidePanel;
      FreePanel;
      Application.ProcessMessages;
    end;
    // port
    if Assigned(CurrentPort) then
    begin
      DestroyPort(CurrentPort);
      CurrentPort := nil;
    end;
    // module
    if LibHandle <> NilHandle then
    begin
//      UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      CreatePort := nil;
      DestroyPort := nil;
      CreatePanel := nil;
      ShowPanel := nil;
      HidePanel := nil;
      FreePanel := nil;
      SetSizePosPanel := nil;
    end;
    // load module
    LibHandle := LoadLibrary(SelectedFile);
    if LibHandle = NilHandle then
    begin
      ShowMessage(ER + 'Cannot load this module: ' + SelectedFile);
      exit;
    end;
    // search exported function and instantiation
    Pointer(CreatePort) := GetProcedureAddress(LibHandle, 'ioport_create');
    Pointer(DestroyPort) := GetProcedureAddress(LibHandle, 'ioport_destroy');
    Pointer(CreatePanel) := GetProcedureAddress(LibHandle, 'ioport_createpanel');
    Pointer(ShowPanel) := GetProcedureAddress(LibHandle, 'ioport_showpanel');
    Pointer(HidePanel) := GetProcedureAddress(LibHandle, 'ioport_hidepanel');
    Pointer(FreePanel) := GetProcedureAddress(LibHandle, 'ioport_freepanel');
    Pointer(SetSizePosPanel) := GetProcedureAddress(LibHandle, 'ioport_setsizepospanel');
    if (Assigned(CreatePort)) and (Assigned(DestroyPort)) then
    begin
      CurrentPort := CreatePort();
      LoadedPlugin.PFilename := SelectedFile;
      // get properties
      ImpExpProperties(opPlugin2Var);
      // show properties
      RefreshProperties(opVar2List);
      // preset address/data table
      ValueListEditor2.Clear;
      for b := 0 to LoadedPlugin.PAddressRangeSize - 1 do
      begin
        ValueListEditor2.InsertRow('BA+' + b.ToString, '', true);
        ValueListEditor2.Cells[1,b + 1] := '0';
      end;
      if LoadedPlugin.PPortMode = pmWriteOnly then
      begin
        Button1.Enabled := false; // read
        Button2.Enabled := true;  // write
      end;
      if LoadedPlugin.PReadBackOutput
        then Button1.Enabled := true; // read
      if LoadedPlugin.PPortMode = pmReadOnly then
      begin
        Button1.Enabled := true; // read
        Button2.Enabled := false;  // write
      end;
      ValueListEditor2.Enabled := true;
      // show UI
      if LoadedPlugin.PHasGUI and
        Assigned(CreatePanel) and Assigned(ShowPanel) and
        Assigned(HidePanel) and Assigned(FreePanel) and
        Assigned(SetSizePosPanel) then
      begin
        CreatePanel(CurrentPort);
        ShowPanel;
      end;
      ValueListEditor1.Enabled := true;
      // show info
      Form1.Caption := Application.Title + ' - ' + LoadedPlugin.PModName;
      Inc(LoadCounter);
      with StatusBar1.Panels do
      begin
        Items[0].Text := LoadCounter.ToString + ' ';
        Items[1].Text := ' ' + ShellListView1.Selected.Caption;
        Items[2].Text := '';
      end;
    end else
    begin
      ShowMessage(ER + 'It is not a CoreLAB IOPort module!');
      ValueListEditor1.Clear;
      ValueListEditor2.Clear;
      UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      ValueListEditor1.Enabled := false;
      ValueListEditor2.Enabled := false;
      Button1.Enabled := false;
      Button2.Enabled := false;
    end;
  end;
end;

// Read data from port
procedure TForm1.Button1Click(Sender: TObject);
var
  InAddr, InData: byte;
begin
  InData := 0;
  InAddr := ValueListEditor2.Row - 1;
  if Assigned(CurrentPort) then
  begin
    InData := CurrentPort.ReadPort(InAddr);
    StatusBar1.Panels.Items[2].Text := ' ' + IntToHex(InData, 2) + 'h read from port ' + IntToHex(InAddr, 2) + 'h.';
  end;
  ValueListEditor2.Cells[2, ValueListEditor2.Row] := IntToHex(InData, 2);
end;

// Write data to port
procedure TForm1.Button2Click(Sender: TObject);
var
  OutAddr, OutData: integer;
begin
  OutAddr := ValueListEditor2.Row - 1;
  OutData := 0;
  if TryStrToInt('$' + ValueListEditor2.Cells[1, ValueListEditor2.Row], OutData) then
  begin
    if Assigned(CurrentPort) then
    begin
      CurrentPort.WritePort(OutAddr, OutData);
      StatusBar1.Panels.Items[2].Text := ' The ' + IntToHex(OutData, 2) + 'h is written to port ' + IntToHex(OutAddr, 2) + 'h.'
    end;
  end;
end;

// Close application
procedure TForm1.Button5Click(Sender: TObject);
begin
  Form1.Close;
end;

// Coloring read-only properties
procedure TForm1.ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
  Grid: TValueListEditor;
begin
  Grid := TValueListEditor(Sender);
  if (aRow > 0) and
     (aRow < Grid.RowCount-1) and
     (Grid.ItemProps[Grid.Keys[aRow]].ReadOnly) and
     (not (Grid.ItemProps[Grid.Keys[aRow]].EditStyle = esPickList)) and
     (aCol = 0)  then
    with Grid.Canvas do
    begin
      Brush.Color := clBtnFace;
      Font.Color := clGrayText;
      Font.Style := [fsItalic];
      FillRect(aRect);
      TextRect(aRect, aRect.Left + 4, aRect.Top + 6, Grid.Cells[ACol, ARow]);
    end;
end;

// Refresh P... variables
procedure TForm1.ValueListEditor1EditingDone(Sender: TObject);
begin
  RefreshProperties(opList2Var);
  ImpExpProperties(opVar2Plugin);
end;

// OnCreate event
procedure TForm1.FormCreate(Sender: TObject);
begin
  CreatePort := nil;
  CurrentPort := nil;
  CreatePort := nil;
  DestroyPort := nil;
  CreatePanel := nil;
  ShowPanel := nil;
  HidePanel := nil;
  FreePanel := nil;
  SetSizePosPanel := nil;
  LibHandle := NilHandle;
  Form1.Caption := Application.Title;
  ValueListEditor2.Cells[0,1] := 'BA+0';
  ValueListEditor2.Cells[1,1] := '0';
  ValueListEditor2.Enabled := false;
  Button1.Enabled := false;
  Button2.Enabled := false;
  Button3.Enabled := false;
  Button4.Click;
end;

// OnDestroy event
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // UI
  if LoadedPlugin.PHasGUI and
    Assigned(CreatePanel) and Assigned(ShowPanel) and
    Assigned(HidePanel) and Assigned(FreePanel) then FreePanel;
  // port
  if Assigned(CurrentPort) then
  begin
    DestroyPort(CurrentPort);
    CurrentPort := nil;
  end;
  // module
  if LibHandle <> NilHandle then
  begin
    UnloadLibrary(LibHandle);
    LibHandle := NilHandle;
    CreatePort := nil;
    DestroyPort := nil;
    CreatePanel := nil;
    ShowPanel := nil;
    HidePanel := nil;
    FreePanel := nil;
    SetSizePosPanel := nil;
  end;
end;

end.
