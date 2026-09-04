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
{$I define.pas}
interface
uses
  CMem, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ValEdit,
  ExtCtrls, EditBtn, ShellCtrls, DynLibs, Grids, Menus, ComCtrls, ActnList,
  Types, Process, HelpIntfs, LazHelpCHM, LazHelpIntf, core_memory,
  frmabout, ucommon;
type
  TPluginAttributes = record
    PFilename:         string;                         // filename of the module
    PAddressRangeSize: DWord;                              // address range size
    PDescription:      string;                              // short description
    PEnabled:          Boolean;        // disable memory without detach from bus
    PInstanceID:       Integer;                            // Module instance ID
    PMemoryMode:       TMemoryMode;                      //Memory operation mode
    PModname:          string;                                    // Module name
  end;
  // direction pairs for data moving procedures
  TOpDirection = (opPlugin2Var, opVar2List, opList2Var, opVar2Plugin);
  // procedural types pointing to the plugin entry point
  TCreateMemoryFunc = function: TMemory; CALLTYPE;
  TDestroyMemoryProc = procedure(AMemory: TMemory); CALLTYPE;
  TLoadStateFunc  = function(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE;
  TSaveStateFunc = function(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE;
  { TForm1 }
  TForm1 = class(TForm)
    About:                 TAction;
    ActionList1:           TActionList;
    CHMHelpDatabase1:      TCHMHelpDatabase;
    Deposit:               TAction;
    DirectoryEdit1:        TDirectoryEdit;
    Examine:               TAction;
    Help:                  TAction;
    ImageList1:            TImageList;
    LHelpConnector1:       TLHelpConnector;
    LoadChangePlugin:      TAction;
    LoadStatus:            TAction;
    MainMenu1:             TMainMenu;
    MenuItem10:            TMenuItem;
    MenuItem11:            TMenuItem;
    MenuItem12:            TMenuItem;
    MenuItem13:            TMenuItem;
    MenuItem14:            TMenuItem;
    MenuItem15:            TMenuItem;
    MenuItem16:            TMenuItem;
    MenuItem17:            TMenuItem;
    MenuItem18:            TMenuItem;
    MenuItem1:             TMenuItem;
    MenuItem21:            TMenuItem;
    MenuItem24:            TMenuItem;
    MenuItem2:             TMenuItem;
    MenuItem3:             TMenuItem;
    MenuItem4:             TMenuItem;
    MenuItem5:             TMenuItem;
    MenuItem6:             TMenuItem;
    MenuItem7:             TMenuItem;
    MenuItem8:             TMenuItem;
    MenuItem9:             TMenuItem;
    OpenDialog1:           TOpenDialog;
    Panel1:                TPanel;
    Quit:                  TAction;
    RefreshPluginList:     TAction;
    RestartApplication:    TAction;
    SaveDialog1:           TSaveDialog;
    SaveStatus:            TAction;
    SelectPluginDirectory: TAction;
    Separator1:            TMenuItem;
    Separator2:            TMenuItem;
    Separator3:            TMenuItem;
    Separator4:            TMenuItem;
    Separator6:            TMenuItem;
    ShellListView1:        TShellListView;
    Splitter1:             TSplitter;
    StatusBar1:            TStatusBar;
    Timer1:                TTimer;
    ToolBar1:              TToolBar;
    ToolButton1:           TToolButton;
    ToolButton2:           TToolButton;
    ToolButton3:           TToolButton;
    ToolButton4:           TToolButton;
    ToolButton5:           TToolButton;
    ToolButton6:           TToolButton;
    ValueListEditor1:      TValueListEditor;
    ValueListEditor2:      TValueListEditor;
    procedure AboutExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpExecute(Sender: TObject);
    procedure LoadChangePluginExecute(Sender: TObject);
    procedure LoadStatusExecute(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure QuitExecute(Sender: TObject);
    procedure ExamineExecute(Sender: TObject);
    procedure RefreshPluginListExecute(Sender: TObject);
    procedure RestartApplicationExecute(Sender: TObject);
    procedure SaveStatusExecute(Sender: TObject);
    procedure SelectPluginDirectoryExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure ValueListEditor1EditingDone(Sender: TObject);
    procedure ValueListEditor1ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
    procedure ValueListEditor2ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
    procedure DepositExecute(Sender: TObject);
  private
    CurrentMemory:    TMemory;                // created object of TMemory class
    LibHandle:        TLibHandle;                 // handle of the loaded module
    LoadedPlugin:     TPluginAttributes;      // properties of the loaded module
    // pointers to the plugin entry point
    CreateMemory:     TCreateMemoryFunc;                 // create plugin memory
    DestroyMemory:    TDestroyMemoryProc;               // destroy plugin memory
    LoadState:        TLoadStateFunc;                       // load plugin state
    SaveState:        TSaveStateFunc;                       // save plugin state
    // general variables
    FIgnoreHelp:      Boolean;
    FLoadCounter:     Integer;
    FEXEDirectory:    string;
    FPluginDirectory: string;
    FSystemLanguage:  string;
    FUserDirectory:   string;
    procedure ImpExpProperties(Direction: TOpDirection);
    procedure RefreshProperties(Direction: TOpDirection);
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
  Form1: TForm1;

implementation

{$R *.lfm}
{ TForm1 }

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Data type conversion error.';
  MSG03 = 'Directory ''%s'' does not exist.';
  MSG04 = 'Cannot load ''%s'' plugin%s(%s).';
  MSG05 = 'It is not a CoreLAB memory plugin.';
  MSG06 = 'Filename';
  MSG07 = 'Size';
  MSG08 = 'Type';
  MSG09 = 'Property';
  MSG10 = 'Value';
  MSG11 = 'Address';
  MSG12 = 'Data';
  MSG13 = ' %sh read from address %sh.';
  MSG14 = ' %sh write to address %sh.';
  MSG15 = 'Only hexadecimal values can be entered!';
  MSG16 = 'Out of range!';
  MSG17 = 'Value (Hex)';
  MSG18 = 'Missing help file.';
  MSG19 = 'Missing help viewer.';
  MSG20 = 'Cannot read state data from plugin.';
  MSG21 = 'Save plugin state to file';
  MSG22 = 'Cannot save ''%s'' plugin data.';
  MSG23 = 'Load plugin state from file';
  MSG24 = 'Cannot load ''%s'' plugin data.';
  MSG25 = 'Cannot write state data to plugin.';
  MSG26 = 'CoreLAB plugin status file|*.clpst|All file|*.*';
  MSG27 = 'Read-only!';
  MSG28 = 'The memory size can be 16 B-16 MB';
  
// ---- PRIVATE METHODS ----

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
      // read memory properties
      PAddressRangeSize := CurrentMemory.AddressRangeSize;
      PEnabled := CurrentMemory.Enabled;
      PMemoryMode := CurrentMemory.MemoryMode;
    end;
  end;
  // export from variables to plugin
  if Direction = opVar2Plugin then
  begin
    with LoadedPlugin do
    begin
      // only writeable properties
      CurrentMemory.AddressRangeSize := PAddressRangeSize;
      CurrentMemory.Enabled := PEnabled;
      CurrentMemory.MemoryMode := PMemoryMode;
    end;
  end;
end;

// REFRESH PROPERTY LIST
procedure TForm1.RefreshProperties(Direction: TOpDirection);
var
  mm: TMemoryMode;
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
      InsertRow('InstanceID (Hex)', IntToHex(LoadedPlugin.PInstanceID, 2), True);
      ItemProps['InstanceID (Hex)'].ReadOnly := True;
      InsertRow('Enabled', BoolToStr(LoadedPlugin.PEnabled, 'true', 'false'), True);
      with ItemProps['Enabled'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := True;
      end;
      InsertRow('MemoryMode', LoadedPlugin.PMemoryMode.ToString, True);
      with ItemProps['MemoryMode'] do
      begin
        EditStyle := esPickList;
        for mm := Low(TMemoryMode) to High(TMemoryMode) do PickList.Add(mm.ToString);
        ReadOnly := True;
      end;
      InsertRow('AddressRangeSize', LoadedPlugin.PAddressRangeSize.ToString, True);
      ItemProps['AddressRangeSize'].ReadOnly := False;
      Row := 1;
      AutoSizeColumn(0);
    end;
  end;
  if Direction = opList2Var then
  begin
    // ValueListEditor1 to variables
    with ValueListEditor1 do
    begin
      try
        LoadedPlugin.PAddressRangeSize := StrToInt(Values['AddressRangeSize']);
        LoadedPlugin.PEnabled := StrToBool(Values['Enabled']);
        LoadedPlugin.PMemoryMode := mm.fromString(Values['MemoryMode']);
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

// ---- EVENT HANDLER METHODS ----

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

// REFRESH P... VARIABLES
procedure TForm1.ValueListEditor1EditingDone(Sender: TObject);
begin
  RefreshProperties(opList2Var);
  ImpExpProperties(opVar2Plugin);
end;

// VALIDATE ENTERED DATA IN THE PROPERTY TABLE
procedure TForm1.ValueListEditor1ValidateEntry(Sender: TObject; aCol,
  aRow: Integer; const OldValue: string; var NewValue: String);
begin
  if (aCol = 1) then
  begin
    // address range
    if ValueListEditor1.Keys[aRow] = 'AddressRangeSize' then
    begin
      NewValue := Trim(NewValue);
      if NewValue = '' then NewValue := '0';
      if (StrToInt(NewValue) < 16) or (StrToInt(NewValue) > (1 shl 24)) then
      begin
        ShowMessage(MSG01 + MSG28);
        NewValue := OldValue;
      end;
    end;
  end;
end;

// VALIDATE ENTERED DATA IN THE LEFT TABLE
procedure TForm1.ValueListEditor2ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
var
  Val, MaxVal: Integer;
begin
  if aCol = 1 then
  begin
    NewValue := Trim(NewValue);
    if NewValue = '' then NewValue := '0';
    // maximal value
    if aRow = 1 then MaxVal := High(Byte);
    // validating hexa value
    if not TryStrToInt('$' + NewValue, Val) or (Val > MaxVal) then
    begin
      ShowMessage(MSG01 + MSG15);
      NewValue := OldValue;
    end else
      NewValue := IntToHex(Val, 0);
  end;
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
  if DirectoryExists(MenuItem17.Caption, True)
    then PluginDirectory := MenuItem17.Caption
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
    Mask := 'memory_*.dll';
    {$ELSE}
    Mask := 'libmemory_*.so';
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
  SelectedFile: String;
begin
  if ShellListView1.Selected <> nil then
  begin
    SelectedFile := ShellListView1.GetPathFromItem(ShellListView1.Selected);
    // remove previous loaded module
    // device
    if Assigned(CurrentMemory) then
    begin
      DestroyMemory(CurrentMemory);
      CurrentMemory := nil;
    end;
    if LibHandle <> NilHandle then
    begin
      // UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      // memory
      CreateMemory := nil;
      DestroyMemory := nil;
      // module
      LoadState := nil;
      SaveState := nil;
    end;
    // load new module
    LibHandle := LoadLibrary(SelectedFile);
    if LibHandle = NilHandle then
    begin
      ShowMessage(MSG01 + Format(MSG04, [SelectedFile, LineEnding, GetLoadErrorStr]));
      exit;
    end;
    // search exported function and instantiation
    // memory
    Pointer(CreateMemory) := GetProcedureAddress(LibHandle, 'memory_create');
    Pointer(DestroyMemory) := GetProcedureAddress(LibHandle, 'memory_destroy');
    // module
    Pointer(LoadState) := GetProcedureAddress(LibHandle, 'memory_loadstate');
    Pointer(SaveState) := GetProcedureAddress(LibHandle, 'memory_savestate');
    // load data
    if (Assigned(CreateMemory)) and (Assigned(DestroyMemory)) then
    begin
      CurrentMemory := CreateMemory();
      LoadedPlugin.PFilename := SelectedFile;
      // set InstanceID
      CurrentMemory.InstanceID := 0;
      // get properties
      ImpExpProperties(opPlugin2Var);
      // show properties
      RefreshProperties(opVar2List);
      ValueListEditor2.Enabled := True;
      ValueListEditor1.Enabled := True;
      // enable plugin relevant actions
      Examine.Enabled := True;
      Deposit.Enabled := True;
      LoadStatus.Enabled := True;
      SaveStatus.Enabled := True;
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
      with ValueListEditor2 do
      begin
        Cells[1, 1] := '0';
        Cells[1, 2] := '0';
      end;
      UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      ValueListEditor1.Enabled := False;
      ValueListEditor2.Enabled := False;
      // disable plugin relevant actions
      Examine.Enabled := False;
      Deposit.Enabled := False;
      LoadStatus.Enabled := False;
      SaveStatus.Enabled := False;
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
procedure TForm1.ExamineExecute(Sender: TObject);
var
  InAddr: DWord;
  InData: Byte;
begin
  InData := 0;
  InAddr := 0;
  if TryStrToDWord('$' + ValueListEditor2.Cells[1, 1], InAddr) then
  begin
    if Assigned(CurrentMemory) then
    begin
      InData := CurrentMemory.ReadMemory(InAddr);
      ValueListEditor2.Cells[1, 2] := IntToHex(InData, 0);
      StatusBar1.Panels[2].Text := Format(MSG13, [IntToHex(InData, 0), IntToHex(InAddr, 0)]);
      // out of address range
      if InAddr > CurrentMemory.AddressRangeSize then
        StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ' (' + MSG16 + ')';
      Timer1.Enabled := True;
    end;
  end;
end;

// WRITE A BYTE
procedure TForm1.DepositExecute(Sender: TObject);
var
  OutAddr: DWord;
  OutData: Integer;
  OutRange, ReadOnly: Boolean;
begin
  OutData := 0;
  OutAddr := 0;
  if (TryStrToDWord('$' + ValueListEditor2.Cells[1, 1], OutAddr)) and
     (TryStrToInt('$' + ValueListEditor2.Cells[1, 2], OutData)) then
  begin
    if Assigned(CurrentMemory) then
    begin
      CurrentMemory.WriteMemory(OutAddr, OutData);
      StatusBar1.Panels.Items[2].Text := Format(MSG14, [IntToHex(OutData, 0), IntToHex(OutAddr, 0)]);
      OutRange := OutAddr >= CurrentMemory.AddressRangeSize;
      ReadOnly := CurrentMemory.MemoryMode = mmROM;
      // out of address range
      if OutRange or ReadOnly then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ' (';
      if OutRange then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + MSG16;
      if OutRange then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ' ';
      // write ROM
      if ReadOnly then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + MSG27;
      if OutRange or ReadOnly then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ')';
      Timer1.Enabled := True;
    end;
  end;
end;

// LOAD PLUGIN STATUS
procedure TForm1.LoadStatusExecute(Sender: TObject);
var
  Filename: string;
  LoadStream: TMemoryStream;
begin
  with OpenDialog1 do
  begin
    InitialDir := GetUserDir;
    Title := MSG23;
    Filter := MSG26;
  end;
  if OpenDialog1.Execute then
  begin
    Filename := OpenDialog1.FileName;
    LoadStream := TMemoryStream.Create;
    try
      try
        LoadStream.LoadFromFile(FileName);
      except
        ShowMessage(MSG01 + Format(MSG24, [FileName]));
        exit;
      end;
      if not LoadState(CurrentMemory, LoadStream) then ShowMessage(MSG01 + MSG25) else
      begin
        ImpExpProperties(opPlugin2Var);
        RefreshProperties(opVar2List);
      end;
    finally
      LoadStream.Free;
    end;
  end;
end;

//SAVE PLUGIN STATUS
procedure TForm1.SaveStatusExecute(Sender: TObject);
var
  Filename: string;
  SaveStream: TMemoryStream;
begin
  with SaveDialog1 do
  begin
    InitialDir := GetUserDir;
    Title := MSG21;
    Filter := MSG26;
  end;
  if SaveDialog1.Execute then
  begin
    Filename := SaveDialog1.FileName;
    SaveStream := TMemoryStream.Create;
    try
      if not SaveState(CurrentMemory, SaveStream) then ShowMessage(MSG01 + MSG20) else
        try
          SaveStream.SaveToFile(FileName);
        except
          ShowMessage(MSG01 + Format(MSG22, [FileName]));
        end;
    finally
      SaveStream.Free;
    end;
  end;
end;

// HELP
procedure TForm1.HelpExecute(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','html/applications/clmemory.html');
end;

// ABOUT
procedure TForm1.AboutExecute(Sender: TObject);
begin
  Form2.ShowModal;
end;

// ONCREATE EVENT
procedure TForm1.FormCreate(Sender: TObject);
begin
  CurrentMemory := nil;
  LibHandle := NilHandle;
  // memory
  CreateMemory := nil;
  DestroyMemory := nil;
  // module
  LoadState := nil;
  SaveState := nil;
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
    TitleCaptions.Strings[0] := '';
    TitleCaptions.Strings[1] := MSG17;
    Cells[0, 1] := MSG11;
    Cells[0, 2] := MSG12;
    Cells[1, 1] := '0';
    Cells[1, 2] := '0';
    Enabled := False;
  end;
  // enable/disable menuitems
  if not DirectoryExists(MenuItem15.Caption, True) then MenuItem15.Free;
  if not DirectoryExists(MenuItem16.Caption, True) then MenuItem16.Free;
  if not DirectoryExists(MenuItem17.Caption, True) then MenuItem17.Free;
  if not DirectoryExists(MenuItem18.Caption, True) then MenuItem18.Free;
  LoadChangePlugin.Enabled := False;
  // disable plugin relevant actions
  Examine.Enabled := False;
  Deposit.Enabled := False;
  LoadStatus.Enabled := False;
  SaveStatus.Enabled := False;
  // refresh plugin list
  RefreshPluginList.Execute;
end;

// ONDESTROY EVENT
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // memory
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
    // memory
    CreateMemory := nil;
    DestroyMemory := nil;
    // module
    LoadState := nil;
    SaveState := nil;
  end;
end;

end.
