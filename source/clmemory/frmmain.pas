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
  ActnList, Types, process, HelpIntfs, LazHelpCHM, LazHelpIntf, core_memory,
  frmabout, ucommon;
type
  TPluginAttributes = record
    PFilename:         String;                         // Filename of the module
    PAddressRangeSize: Byte;                               // Address range size
    PDescription:      String;                              // Short description
    PEnabled:          Boolean;           // Enable port without detach from bus
    PHasPanel:         Boolean;           // Does the implementation have a GUI?
    PLatchedOutput:    Boolean;                                // Latched output
    PModname:          String;                                    // Module name
    PReadBackOutput:   Boolean;         // Output port with read-back capability
  end;
  // Direction pairs for data moving procedures
  TOpDirection    = (opPlugin2Var, opVar2List, opList2Var, opVar2Plugin);
  // - port
  TCreateMemoryFunc = function: TMemory; cdecl;
  TDestroyMemoryProc = procedure(Memory: TMemory); cdecl;
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
    MenuItem2:                   TMenuItem;
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
    ShellListView1:              TShellListView;
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
    procedure Timer1Timer(Sender: TObject);
    procedure ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure ValueListEditor1EditingDone(Sender: TObject);
    procedure ValueListEditor2EditingDone(Sender: TObject);
    procedure ValueListEditor2ValidateEntry(Sender: TObject; aCol,
      aRow: Integer; const OldValue: string; var NewValue: String);
    procedure WriteAByteExecute(Sender: TObject);
  private
    // port
    CreateMemory:      TCreateMemoryFunc;
    DestroyMemory:     TDestroyMemoryProc;
    CurrentMemory:     TMemory;                 // Created object of TIOPort class
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
      if Assigned(CurrentMemory.Modname)
        then PModname := String(CurrentMemory.Modname)
        else PModname := '';
      if Assigned(CurrentMemory.Description)
        then PDescription := String(CurrentMemory.Description)
        else PDescription := '';
      // read port properties
      PAddressRangeSize := CurrentMemory.AddressRangeSize;
      PEnabled := CurrentMemory.Enabled;
    end;
  end;
  // export from variables to plugin
  if Direction = opVar2Plugin then
  begin
    with LoadedPlugin do
    begin
      // only writeable properties
      CurrentMemory.Enabled := PEnabled;
    end;
  end;
end;

// REFRESH PROPERTY LIST
procedure TForm1.RefreshProperties(Direction: TOpDirection);
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
    // - port
    if Assigned(CurrentMemory) then
    begin
      DestroyMemory(CurrentMemory);
      CurrentMemory := nil;
    end;
    // - module
    if LibHandle <> NilHandle then
    begin
      // UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      CreateMemory := nil;
      DestroyMemory := nil;
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
    Pointer(CreateMemory) := GetProcedureAddress(LibHandle, 'memory_create');
    Pointer(DestroyMemory) := GetProcedureAddress(LibHandle, 'memory_destroy');
    // load data
    if (Assigned(CreateMemory)) and (Assigned(DestroyMemory)) then
    begin
      CurrentMemory := CreateMemory();
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

// READ A BYTE
procedure TForm1.ReadAByteExecute(Sender: TObject);
var
  InAddr, InData: Byte;
begin
  InData := 0;
  InAddr := ValueListEditor2.Row - 1;
  if Assigned(CurrentMemory) then
  begin
    InData := CurrentMemory.ReadMemory(InAddr);
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
    if Assigned(CurrentMemory) then
    begin
      CurrentMemory.WriteMemory(OutAddr, OutData);
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
  CreateMemory := nil;
  CurrentMemory := nil;
  DestroyMemory := nil;
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
  // port
  if Assigned(CurrentMemory) then
  begin
    DestroyMemory(CurrentMemory);
    CurrentMemory := nil;
  end;
  // module
  if LibHandle <> NilHandle then
  begin
    UnloadLibrary(LibHandle);
    LibHandle := NilHandle;
    CreateMemory := nil;
    DestroyMemory := nil;
  end;
end;

end.
