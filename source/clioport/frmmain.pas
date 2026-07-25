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
{$MODE OBJFPC}{$H+}
interface
uses
  CMem, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons,
  ValEdit, ExtCtrls, EditBtn, ShellCtrls, DynLibs, Grids, Menus, ComCtrls,
  ActnList, Types, process, HelpIntfs, LazHelpCHM, LazHelpIntf, core_ioport,
  core_gioport, frmabout, frmcaption, frmsizepos, ucommon;
type
  TPluginAttributes = record
    PFilename:         String;                         // Filename of the module
    PAddressRangeSize: Byte;                               // Address range size
    PDataInMode:       TLineMode;                   // Decoding input data lines
    PDataInNegation:   Boolean;             // Negation of databit (port -> CPU)
    PDataOutMode:      TLineMode;                  // Decoding output data lines
    PDataOutNegation:  Boolean;             // Negation of databit (CPU -> port)
    PDescription:      String;                              // Short description
    PEnabled:          Boolean;           // Enable port without detach from bus
    PHasPanel:         Boolean;           // Does the implementation have a GUI?
    PLatchedOutput:    Boolean;                                // Latched output
    PModname:          String;                                    // Module name
    PReadBackOutput:   Boolean;         // Output port with read-back capability
    PSelMode:          TLineMode;              // Decoding matrix selector lines
    PSelNegation:      Boolean;              // Negation of matrix selector bits
  end;
  // Direction pairs for data moving procedures
  TOpDirection    = (opPlugin2Var, opVar2List, opList2Var, opVar2Plugin);
  // - port
  TCreatePortFunc = function: TIOPort; cdecl;
  TDestroyPortProc = procedure(Port: TIOPort); cdecl;
  // - panel
  TCreatePanelProc = procedure(Port: TIOPort); cdecl;
  TShowPanelProc = procedure(Port: TIOPort); cdecl;
  THidePanelProc = procedure(Port: TIOPort); cdecl;
  TFreePanelProc = procedure(Port: TIOPort); cdecl;
  TMovePanelProc = function(Port: TIOPort; Left, Top: Integer): Boolean; cdecl;
  TRenamePanelProc = procedure(Port: TIOPort; Caption: PChar); cdecl;
  TResizePanelProc = function(Port: TIOPort; Width, Height: Integer): Boolean; cdecl;
  { TForm1 }
  TForm1 = class(TForm)
    About:                       TAction;
    ActionList1:                 TActionList;
    CHMHelpDatabase1:            TCHMHelpDatabase;
    DirectoryEdit1:              TDirectoryEdit;
    Help:                        TAction;
    ImageList1:                  TImageList;
    LHelpConnector1:             TLHelpConnector;
    LoadChangePlugin:            TAction;
    MainMenu1:                   TMainMenu;
    MenuItem1:                   TMenuItem;
    MenuItem10:                  TMenuItem;
    MenuItem11:                  TMenuItem;
    MenuItem12:                  TMenuItem;
    MenuItem13:                  TMenuItem;
    MenuItem14:                  TMenuItem;
    MenuItem15:                  TMenuItem;
    MenuItem16:                  TMenuItem;
    MenuItem17:                  TMenuItem;
    MenuItem18:                  TMenuItem;
    MenuItem19:                  TMenuItem;
    MenuItem2:                   TMenuItem;
    MenuItem20:                  TMenuItem;
    MenuItem22:                  TMenuItem;
    MenuItem23:                  TMenuItem;
    MenuItem3:                   TMenuItem;
    MenuItem4:                   TMenuItem;
    MenuItem5:                   TMenuItem;
    MenuItem6:                   TMenuItem;
    MenuItem7:                   TMenuItem;
    MenuItem8:                   TMenuItem;
    MenuItem9:                   TMenuItem;
    Panel1:                      TPanel;
    Quit:                        TAction;
    ReadAByte:                   TAction;
    RefreshPluginList:           TAction;
    RestartApplication:          TAction;
    SelectPluginDirectory:       TAction;
    Separator1:                  TMenuItem;
    Separator2:                  TMenuItem;
    Separator3:                  TMenuItem;
    Separator4:                  TMenuItem;
    Separator5:                  TMenuItem;
    SetPluginWindowCaption:      TAction;
    SetPluginWindowSizePosition: TAction;
    ShellListView1:              TShellListView;
    ShowPluginWindow:            TAction;
    Splitter1:                   TSplitter;
    StatusBar1:                  TStatusBar;
    Timer1:                      TTimer;
    ToolBar1:                    TToolBar;
    ToolButton1:                 TToolButton;
    ToolButton2:                 TToolButton;
    ToolButton3:                 TToolButton;
    ToolButton4:                 TToolButton;
    ToolButton5:                 TToolButton;
    ToolButton6:                 TToolButton;
    ToolButton7:                 TToolButton;
    ValueListEditor1:            TValueListEditor;
    ValueListEditor2:            TValueListEditor;
    WriteAByte:                  TAction;
    procedure AboutExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpExecute(Sender: TObject);
    procedure LoadChangePluginExecute(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure QuitExecute(Sender: TObject);
    procedure ReadAByteExecute(Sender: TObject);
    procedure RefreshPluginListExecute(Sender: TObject);
    procedure RestartApplicationExecute(Sender: TObject);
    procedure SelectPluginDirectoryExecute(Sender: TObject);
    procedure SetPluginWindowCaptionExecute(Sender: TObject);
    procedure SetPluginWindowSizePositionExecute(Sender: TObject);
    procedure ShowPluginWindowExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure ValueListEditor1EditingDone(Sender: TObject);
    procedure ValueListEditor2EditingDone(Sender: TObject);
    procedure ValueListEditor2ValidateEntry(Sender: TObject; aCol,
      aRow: Integer; const OldValue: string; var NewValue: String);
    procedure WriteAByteExecute(Sender: TObject);
  private
    // port
    CreatePort:      TCreatePortFunc;
    DestroyPort:     TDestroyPortProc;
    CurrentPort:     TIOPort;                 // Created object of TIOPort class
    // panel
    CreatePanel:     TCreatePanelProc;
    ShowPanel:       TShowPanelProc;
    HidePanel:       THidePanelProc;
    FreePanel:       TFreePanelProc;
    MovePanel:       TMovePanelProc;
    RenamePanel:     TRenamePanelProc;
    ResizePanel:     TResizePanelProc;
    // module
    LibHandle:       TLibHandle;                  // Handle of the loaded module
    LoadedPlugin:    TPluginAttributes;       // Properties of the loaded module
    // general
    FIgnoreHelp:      Boolean;
    FLoadCounter:     Integer;
    FEXEDirectory:    string;
    FPluginDirectory: string;
    FSystemLanguage:  string;
    FUserDirectory:   string;
    procedure RefreshProperties(Direction: TOpDirection);
    procedure ImpExpProperties(Direction: TOpDirection);
    procedure SetIgnoreHelp(AIgnoreHelp: Boolean);
    procedure SetPluginDirectory(APluginDirectory: string);
  public
    property IgnoreHelp: Boolean read FIgnoreHelp write SetIgnoreHelp;
    property EXEDirectory: string read FEXEDirectory;
    property PluginDirectory: string read FPluginDirectory write SetPluginDirectory;
    property SystemLanguage: string read FSystemLanguage;
    property UserDirectory: string read FUserDirectory;
  end;
var
  Form1:           TForm1;

implementation

{$R *.lfm}
{ TForm1 }

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Data type conversion error.';
  MSG03 = 'Directory ''%s'' does not exist.';
  MSG04 = 'Cannot load ''%s'' plugin%s(%s).';
  MSG05 = 'It is not a CoreLAB IOPort plugin.';
  MSG06 = 'Filename';
  MSG07 = 'Size';
  MSG08 = 'Type';
  MSG09 = 'Property';
  MSG10 = 'Value';
  MSG11 = 'Address';
  MSG12 = 'Data (Hex)';
  MSG13 = ' %sh read from port %sh.';
  MSG14 = ' %sh write to port %sh.';
  MSG15 = 'Only 8-bit hexadecimal values can be entered (00 - FF)!';
  MSG16 = 'Caption';
  MSG17 = 'This is not a graphics plugin.';
  MSG18 = 'Missing help file.';
  MSG19 = 'Missing help viewer.';

// IMPORT/EXPORT PROPERTIES
procedure TForm1.ImpExpProperties(Direction: TOpDirection);
begin
  // import from plugin to variables
  if Direction = opPlugin2Var then
  begin
    // check and read Modname and Description
    with LoadedPlugin do
    begin
      if Assigned(CurrentPort.Modname)
        then PModname := String(CurrentPort.Modname)
        else PModname := '';
      if Assigned(CurrentPort.Description)
        then PDescription := String(CurrentPort.Description)
        else PDescription := '';
      // read port properties
      PAddressRangeSize := CurrentPort.AddressRangeSize;
      PDataInMode := CurrentPort.DataInMode;
      PDataInNegation := CurrentPort.DataInNegation;
      PDataOutMode := CurrentPort.DataOutMode;
      PDataOutNegation := CurrentPort.DataOutNegation;
      PEnabled := CurrentPort.Enabled;
      PHasPanel := CurrentPort.HasPanel;
      PLatchedOutput := CurrentPort.LatchedOutput;
      PReadBackOutput := CurrentPort.ReadBackOutput;
      PSelMode := CurrentPort.SelMode;
      PSelNegation := CurrentPort.SelNegation;
    end;
  end;
  // export from variables to plugin
  if Direction = opVar2Plugin then
  begin
    with LoadedPlugin do
    begin
      // only writeable properties
      CurrentPort.DataInMode := PDataInMode;
      CurrentPort.DataInNegation := PDataInNegation;
      CurrentPort.DataOutMode := PDataOutMode;
      CurrentPort.DataOutNegation := PDataOutNegation;
      CurrentPort.Enabled := PEnabled;
      CurrentPort.SelMode := PSelMode;
      CurrentPort.SelNegation := PSelNegation;
    end;
  end;
end;

// REFRESH PROPERTY LIST
procedure TForm1.RefreshProperties(Direction: TOpDirection);
var
  lm: TLineMode;
begin
  if Direction = opVar2List then
  begin
    // variables to ValueListEditor1
    with ValueListEditor1 do
    begin
      Clear;
      DefaultRowHeight := 30;
      InsertRow('Filename', LoadedPlugin.PFilename, True);
      ItemProps['Filename'].ReadOnly := True;
      InsertRow('Modname', LoadedPlugin.PModname, True);
      ItemProps['Modname'].ReadOnly := True;
      InsertRow('Description', LoadedPlugin.PDescription, True);
      ItemProps['Description'].ReadOnly := True;
      InsertRow('HasPanel', BoolToStr(LoadedPlugin.PHasPanel, 'true', 'false'), True);
      ItemProps['HasPanel'].ReadOnly := True;
      InsertRow('Enabled', BoolToStr(LoadedPlugin.PEnabled, 'true', 'false'), True);
      with ItemProps['Enabled'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := True;
      end;
      InsertRow('AddressRangeSize', LoadedPlugin.PAddressRangeSize.ToString, True);
      ItemProps['AddressRangeSize'].ReadOnly := True;
      InsertRow('LatchedOutput', BoolToStr(LoadedPlugin.PLatchedOutput, 'true', 'false'), True);
      ItemProps['LatchedOutput'].ReadOnly := True;
      InsertRow('ReadBackOutput', BoolToStr(LoadedPlugin.PReadBackOutput, 'true', 'false'), True);
      ItemProps['ReadBackOutput'].ReadOnly := True;
      InsertRow('DataInMode', LoadedPlugin.PDataInMode.ToString, True);
      with ItemProps['DataInMode'] do
      begin
        EditStyle := esPickList;
        for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
        ReadOnly := True;
      end;
      InsertRow('DataInNegation', BoolToStr(LoadedPlugin.PDataInNegation, 'true', 'false'), True);
      with ItemProps['DataInNegation'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := True;
      end;
      InsertRow('DataOutMode', LoadedPlugin.PDataOutMode.ToString, True);
      with ItemProps['DataOutMode'] do
      begin
        EditStyle := esPickList;
        for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
        ReadOnly := True;
      end;
      InsertRow('DataOutNegation', BoolToStr(LoadedPlugin.PDataOutNegation, 'true', 'false'), True);
      with ItemProps['DataOutNegation'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := True;
      end;
      InsertRow('SelMode', LoadedPlugin.PSelMode.ToString, True);
      with ItemProps['SelMode'] do
      begin
        EditStyle := esPickList;
        for lm := Low(TLineMode) to High(TLineMode) do PickList.Add(lm.ToString);
        ReadOnly := True;
      end;
      InsertRow('SelNegation', BoolToStr(LoadedPlugin.PSelNegation, 'true', 'false'), True);
      with ItemProps['SelNegation'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := True;
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
        LoadedPlugin.PDataInMode := lm.fromString(Values['DataInMode']);
        LoadedPlugin.PDataInNegation := StrToBool(Values['DataInNegation']);
        LoadedPlugin.PDataOutMode := lm.fromString(Values['DataOutMode']);
        LoadedPlugin.PDataOutNegation := StrToBool(Values['DataOutNegation']);
        LoadedPlugin.PSelMode := lm.fromString(Values['SelMode']);
        LoadedPlugin.PSelNegation := StrToBool(Values['SelNegation']);
      except
        ShowMessage(MSG01 + MSG02);
      end;
    end;
  end;
end;

// SET HELP SYSTEM
procedure TForm1.SetIgnoreHelp(AIgnoreHelp: Boolean);
var
  CHMFile, CHMViewer: string;
  CHMFileExists, CHMViewerExists: boolean;
begin
  FIgnoreHelp := AIgnoreHelp;
  if not FIgnoreHelp then
  begin
  // - search help file
  {$IFDEF UNIX}
    CHMFile := FileSearch('corelab_' + FSystemLanguage + '.chm',
      './:./help/:/usr/share/corelab/help/:/usr/local/share/corelab/help/');
    if Length(CHMFile) = 0 then
      CHMFile := FileSearch('corelab_en.chm',
        './:./help/:/usr/share/corelab/help/:/usr/local/share/corelab/help/');
  {$ELSE}
    CHMFile := FileSearch('corelab_' + FSystemLanguage + '.chm','.\;.\help\');
    if Length(CHMFile) = 0 then
      CHMFile := FileSearch('modshell_en.chm','.\;.\help\');
  {$ENDIF}
  // - search LHelp application
  {$IFDEF UNIX}
    CHMViewer := FileSearch('lhelp', GetEnvironmentVariable('PATH'));
  {$ELSE}
    CHMViewer := FileSearch('lhelp.exe', GetEnvironmentVariable('PATH'));
  {$ENDIF}
    CHMFileExists := FileExists(CHMFile);
    CHMViewerExists := FileExists(CHMFile);
    if CHMFileExists and CHMViewerExists then
    begin
      CreateLCLHelpSystem;
      with CHMHelpDatabase1 do
      begin
        Autoregister := true;
        Filename := CHMFile;
        KeywordPrefix := 'html'
      end;
      with LHelpConnector1 do
      begin
        Autoregister := true;
        LHelpPath := CHMViewer;
      end;
    end else
    begin
      if not CHMFileExists then ShowMessage(MSG01 + MSG18);
      if not CHMViewerExists then ShowMessage(MSG01 + MSG19);
    end;
  end;
  Help.Enabled := CHMFileExists and CHMViewerExists and not FIgnoreHelp;
end;

// SET PLUGIN DIRECTORY
procedure TForm1.SetPluginDirectory(APluginDirectory: string);
begin
  FPluginDirectory := APluginDirectory;
  DirectoryEdit1.Directory := FPluginDirectory;
  RefreshPluginList.Execute;
end;

// TIMED STATUS MESSAGE CLEARING
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  StatusBar1.Panels.Items[2].Text := '';
end;

// COLORING READ-ONLY PROPERTIES
procedure TForm1.ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  Grid: TValueListEditor;
begin
  Grid := TValueListEditor(Sender);
  if (aRow > 0) and
    (aRow < Grid.RowCount - 1) and
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

// REFRESH P... VARIABLES
procedure TForm1.ValueListEditor1EditingDone(Sender: TObject);
begin
  RefreshProperties(opList2Var);
  ImpExpProperties(opVar2Plugin);
end;

// VALIDATE DATA
procedure TForm1.ValueListEditor2ValidateEntry(Sender: TObject; aCol,
  aRow: Integer; const OldValue: string; var NewValue: String);
var
  Val: Integer;
begin
  if aCol = 1 then
  begin
    NewValue := Trim(NewValue);
    if NewValue = '' then NewValue := '00';
    // validating hexa value
    if not TryStrToInt('$' + NewValue, Val) or (Val < 0) or (Val > 255) then
    begin
      ShowMessage(MSG01 + MSG15);
      NewValue := OldValue;
    end else NewValue := IntToHex(Val, 2);
  end;
end;

// WRITE TO PORT
procedure TForm1.ValueListEditor2EditingDone(Sender: TObject);
begin
  WriteAByte.Execute;
end;

// --- MAIN MENU ---

// MAIN MENU: FILE/USUAL PLACES/
procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  if MenuItem14.Enabled then PluginDirectory := MenuItem14.Caption;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
  if DirectoryExists(MenuItem15.Caption, True)
    then PluginDirectory := MenuItem15.Caption
    else MenuItem15.Enabled := False;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
  if DirectoryExists(MenuItem16.Caption, True)
    then PluginDirectory := MenuItem16.Caption
    else MenuItem16.Enabled := False;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  if DirectoryExists(MenuItem18.Caption, True)
    then PluginDirectory := MenuItem18.Caption
    else MenuItem18.Enabled := False;
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  if DirectoryExists(MenuItem18.Caption, True)
    then PluginDirectory := MenuItem18.Caption
    else MenuItem18.Enabled := False;
end;

// --- ACTIONS ---

// SELECT PLUGIN DIRECTORY
procedure TForm1.SelectPluginDirectoryExecute(Sender: TObject);
begin
  DirectoryEdit1.RunDialog;
end;

// REFRESH PLUGIN LIST
procedure TForm1.RefreshPluginListExecute(Sender: TObject);
begin
  with ShellListView1 do
  begin
    {$IFDEF WINDOWS}
    Mask := 'ioport_*.dll';
    {$ELSE}
    Mask := 'libioport_*.so';
    {$ENDIF}
    try
      Root := DirectoryEdit1.Directory;
      LoadChangePlugin.Enabled := True;
    except
      ShowMessage(MSG01 + Format(MSG03, [DirectoryEdit1.Directory]));
      Root := '.';
      LoadChangePlugin.Enabled := False;
    end;
  end;
end;

// LOAD/CHANGE PLUGIN
procedure TForm1.LoadChangePluginExecute(Sender: TObject);
var
  b: Byte;
  SelectedFile: String;
begin
  if ShellListView1.Selected <> nil then
  begin
    SelectedFile := ShellListView1.GetPathFromItem(ShellListView1.Selected);
    // remove previous loaded module
    // - panel
    if Assigned(FreePanel) then
    begin
      if Assigned(HidePanel) then HidePanel(CurrentPort);
      FreePanel(CurrentPort);
      Application.ProcessMessages;
    end;
    // - port
    if Assigned(CurrentPort) then
    begin
      DestroyPort(CurrentPort);
      CurrentPort := nil;
    end;
    // - module
    if LibHandle <> NilHandle then
    begin
      // UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      CreatePort := nil;
      DestroyPort := nil;
      CreatePanel := nil;
      ShowPanel := nil;
      HidePanel := nil;
      FreePanel := nil;
      MovePanel := nil;
      RenamePanel := nil;
      ResizePanel := nil;
    end;
    // load new module
    LibHandle := LoadLibrary(SelectedFile);
    if LibHandle = NilHandle then
    begin
      ShowMessage(MSG01 + Format(MSG04, [SelectedFile, LineEnding, GetLoadErrorStr]));
      exit;
    end;
    // search exported function and instantiation
    // - port
    Pointer(CreatePort) := GetProcedureAddress(LibHandle, 'ioport_create');
    Pointer(DestroyPort) := GetProcedureAddress(LibHandle, 'ioport_destroy');
    // - panel
    Pointer(CreatePanel) := GetProcedureAddress(LibHandle, 'ioport_createpanel');
    Pointer(ShowPanel) := GetProcedureAddress(LibHandle, 'ioport_showpanel');
    Pointer(HidePanel) := GetProcedureAddress(LibHandle, 'ioport_hidepanel');
    Pointer(FreePanel) := GetProcedureAddress(LibHandle, 'ioport_freepanel');
    Pointer(MovePanel) := GetProcedureAddress(LibHandle, 'ioport_movepanel');
    Pointer(RenamePanel) := GetProcedureAddress(LibHandle, 'ioport_renamepanel');
    Pointer(ResizePanel) := GetProcedureAddress(LibHandle, 'ioport_resizepanel');
    // load data
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
        ValueListEditor2.InsertRow('BA+' + b.ToString, '', True);
        ValueListEditor2.Cells[1, b + 1] := '0';
      end;
      ValueListEditor2.Enabled := True;
      // show panel
      if LoadedPlugin.PHasPanel and
        Assigned(CreatePanel) and Assigned(ShowPanel) and
        Assigned(HidePanel) and Assigned(FreePanel) then
      begin
        CreatePanel(CurrentPort);
        ShowPanel(CurrentPort);
      end;
      ValueListEditor1.Enabled := True;
      ReadAByte.Enabled := True;
      WriteAByte.Enabled := True;
      // show info
      Form1.Caption := Application.Title + ' - ' + LoadedPlugin.PModName;
      Inc(FLoadCounter);
      with StatusBar1.Panels do
      begin
        Items[0].Text := '#' + FLoadCounter.ToString + ' ';
        Items[1].Text := ' ' + ShellListView1.Selected.Caption;
        Items[2].Text := '';
      end;
      ShowPluginWindow.Enabled := LoadedPlugin.PHasPanel;
      SetPluginWindowCaption.Enabled := LoadedPlugin.PHasPanel;
      SetPluginWindowSizePosition.Enabled := LoadedPlugin.PHasPanel;
    end else
    begin
      // loading error
      ShowMessage(MSG01 + MSG05);
      ValueListEditor1.Clear;
      ValueListEditor2.Clear;
      UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      ValueListEditor1.Enabled := False;
      ValueListEditor2.Enabled := False;
      ReadAByte.Enabled := False;
      WriteAByte.Enabled := False;
      ShowPluginWindow.Enabled := False;
      SetPluginWindowCaption.Enabled := False;
      SetPluginWindowSizePosition.Enabled := False;
    end;
  end;
end;

// RESTART APPLICATION
procedure TForm1.RestartApplicationExecute(Sender: TObject);
var
  NewProcess: TProcess;
begin
  NewProcess := TProcess.Create(nil);
  try
    NewProcess.Executable := ParamStr(0);
    NewProcess.Execute;
  finally
    NewProcess.Free;
  end;
  Application.Terminate;
end;

// EXIT
procedure TForm1.QuitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

// SHOW PLUGIN WINDOW
procedure TForm1.ShowPluginWindowExecute(Sender: TObject);
begin
  if LoadedPlugin.PHasPanel and
     Assigned(CreatePanel) and Assigned(ShowPanel) and
     Assigned(HidePanel) and Assigned(FreePanel) then
  begin
    ShowPanel(CurrentPort);
  end;
end;

// SET PANEL CAPTION
procedure TForm1.SetPluginWindowCaptionExecute(Sender: TObject);
begin
  if LoadedPlugin.PHasPanel and
     Assigned(CreatePanel) and Assigned(ShowPanel) and
     Assigned(HidePanel) and Assigned(FreePanel) then
  begin
    with Form3 do
    begin
      PanelCaption := TGIOPort(CurrentPort).PanelCaption;
      if ShowModal =  mrOK then
        RenamePanel(CurrentPort, PChar(PanelCaption));
    end;
  end else ShowMessage(MSG01 + MSG17);
end;

// MOVE AND RESIZE PANEL
procedure TForm1.SetPluginWindowSizePositionExecute(Sender: TObject);
begin
  if LoadedPlugin.PHasPanel and
     Assigned(CreatePanel) and Assigned(ShowPanel) and
     Assigned(HidePanel) and Assigned(FreePanel) then
  begin
    with Form4 do
    begin
      PanelHeight := TGIOPort(CurrentPort).PanelHeight;
      PanelLeft := TGIOPort(CurrentPort).PanelLeft;
      PanelTop := TGIOPort(CurrentPort).PanelTop;
      PanelWidth := TGIOPort(CurrentPort).PanelWidth;
      if ShowModal =  mrOK then
      begin
        ResizePanel(CurrentPort, PanelWidth, PanelHeight);
        MovePanel(CurrentPort, PanelLeft, PanelTop);
      end;
    end;
  end else ShowMessage(MSG01 + MSG17);
end;

// READ A BYTE
procedure TForm1.ReadAByteExecute(Sender: TObject);
var
  InAddr, InData: Byte;
begin
  InData := 0;
  InAddr := ValueListEditor2.Row - 1;
  if Assigned(CurrentPort) then
  begin
    InData := CurrentPort.ReadPort(InAddr);
    StatusBar1.Panels.Items[2].Text := Format(MSG13, [IntToHex(InData, 2), IntToHex(InAddr, 2)]);
    Timer1.Enabled := True;
    ValueListEditor2.Cells[1, ValueListEditor2.Row] := IntToHex(InData, 2);
  end;
end;

// WRITE A BYTE
procedure TForm1.WriteAByteExecute(Sender: TObject);
var
  OutAddr, OutData: Integer;
begin
  OutAddr := ValueListEditor2.Row - 1;
  OutData := 0;
  if TryStrToInt('$' + ValueListEditor2.Cells[1, ValueListEditor2.Row], OutData) then
  begin
    if Assigned(CurrentPort) then
    begin
      CurrentPort.WritePort(OutAddr, OutData);
      StatusBar1.Panels.Items[2].Text := Format(MSG14, [IntToHex(OutData, 2), IntToHex(OutAddr, 2)]);
      Timer1.Enabled := True;
    end;
  end;
end;

// HELP
procedure TForm1.HelpExecute(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','html/clioport.htm');
end;

// ABOUT
procedure TForm1.AboutExecute(Sender: TObject);
begin
  Form2.ShowModal;
end;

// ONCREATE EVENT
procedure TForm1.FormCreate(Sender: TObject);
begin
  // port
  CreatePort := nil;
  CurrentPort := nil;
  CreatePort := nil;
  DestroyPort := nil;
  // panel
  CreatePanel := nil;
  ShowPanel := nil;
  HidePanel := nil;
  FreePanel := nil;
  MovePanel := nil;
  RenamePanel := nil;
  ResizePanel := nil;
  // module
  LibHandle := NilHandle;
  // general
  FIgnoreHelp := false;
  FLoadCounter := 0;
  FEXEDirectory := GetExeDir;
  FPluginDirectory := '.';
  FSystemLanguage := GetLang;
  FUserDirectory := GetUserDir;
  Form1.Caption := Application.Title;
  DirectoryEdit1.Directory := FPluginDirectory;
  // set headers
  with ShellListView1 do
  begin
    Columns[0].Caption := MSG06;
    Columns[1].Caption := MSG07;
    Columns[2].Caption := MSG08;
  end;
  with ValueListEditor1 do
  begin
    TitleCaptions.Strings[0] := MSG09;
    TitleCaptions.Strings[1] := MSG10;
    Enabled := False;
  end;
  with ValueListEditor2 do
  begin
    TitleCaptions.Strings[0] := MSG11;
    TitleCaptions.Strings[1] := MSG12;
    Cells[0, 1] := 'BA + 0';
    Cells[1, 1] := '0';
    Enabled := False;
  end;
  // enable/disable menuitems
  if DirectoryExists(MenuItem15.Caption, True) then MenuItem15.Enabled := True;
  if DirectoryExists(MenuItem16.Caption, True) then MenuItem16.Enabled := True;
  if DirectoryExists(MenuItem17.Caption, True) then MenuItem17.Enabled := True;
  if DirectoryExists(MenuItem18.Caption, True) then MenuItem18.Enabled := True;
  LoadChangePlugin.Enabled := False;
  ReadAByte.Enabled := False;
  WriteAByte.Enabled := False;
  // refresh plugin list
  RefreshPluginList.Execute;
end;

// ONDESTROY EVENT
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // panel
  if LoadedPlugin.PHasPanel and
    Assigned(CreatePanel) and Assigned(ShowPanel) and
    Assigned(HidePanel) and Assigned(FreePanel) then FreePanel(CurrentPort);
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
    MovePanel := nil;
    RenamePanel := nil;
    ResizePanel := nil;
  end;
end;

end.
