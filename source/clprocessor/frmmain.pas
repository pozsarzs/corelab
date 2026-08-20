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
  Types, Process, HelpIntfs, LazHelpCHM, LazHelpIntf, core_cpu, frmabout,
  frmexdepmemory, frmrunlogger, ucommon;
const
  MEM_SIZE = 1024;
type
  TPluginAttributes = record
    PFilename:         string;                         // filename of the module
    PDescription:      string;                              // short description
    PEnabled:          Boolean;     // disable processor without detach from bus
    PInstanceID:       Integer;                            // Module instance ID
    PModname:          string;                                    // module name
  end;
  // direction pairs for data moving procedures
  TOpDirection = (opPlugin2Var, opVar2List, opList2Var, opVar2Plugin);
  // procedural types pointing to the plugin entry point
  TCreateProcessorFunc = function: TCPU; CALLTYPE;
  TDestroyProcessorProc = procedure(Processor: TCPU); CALLTYPE;
  TLoadStateProc  = function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  TSaveStateProc = function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  { TForm1 }
  TForm1 = class(TForm)
    About:                 TAction;
    ActionList1:           TActionList;
    CHMHelpDatabase1:      TCHMHelpDatabase;
    DirectoryEdit1:        TDirectoryEdit;
    ExamineDeposit:        TAction;
    Help:                  TAction;
    ImageList1:            TImageList;
    LHelpConnector1:       TLHelpConnector;
    LoadChangePlugin:      TAction;
    LoadStatus:            TAction;
    MainMenu1:             TMainMenu;
    MenuItem1:             TMenuItem;
    MenuItem10:            TMenuItem;
    MenuItem11:            TMenuItem;
    MenuItem12:            TMenuItem;
    MenuItem13:            TMenuItem;
    MenuItem14:            TMenuItem;
    MenuItem15:            TMenuItem;
    MenuItem16:            TMenuItem;
    MenuItem17:            TMenuItem;
    MenuItem18:            TMenuItem;
    MenuItem19:            TMenuItem;
    MenuItem2:             TMenuItem;
    MenuItem20:            TMenuItem;
    MenuItem21:            TMenuItem;
    MenuItem22:            TMenuItem;
    MenuItem23:            TMenuItem;
    MenuItem24:            TMenuItem;
    MenuItem25:            TMenuItem;
    MenuItem26:            TMenuItem;
    MenuItem27:            TMenuItem;
    MenuItem28:            TMenuItem;
    MenuItem29:            TMenuItem;
    MenuItem3:             TMenuItem;
    MenuItem30:            TMenuItem;
    MenuItem4:             TMenuItem;
    MenuItem5:             TMenuItem;
    MenuItem6:             TMenuItem;
    MenuItem7:             TMenuItem;
    MenuItem8:             TMenuItem;
    MenuItem9:             TMenuItem;
    NMI:                   TAction;
    OpenDialog1:           TOpenDialog;
    Panel1:                TPanel;
    Pause:                 TAction;
    Quit:                  TAction;
    RefreshPluginList:     TAction;
    Reset:                 TAction;
    RestartApplication:    TAction;
    Run:                   TAction;
    SaveDialog1:           TSaveDialog;
    SaveStatus:            TAction;
    SelectPluginDirectory: TAction;
    Separator1:            TMenuItem;
    Separator2:            TMenuItem;
    Separator3:            TMenuItem;
    Separator4:            TMenuItem;
    Separator5:            TMenuItem;
    Separator6:            TMenuItem;
    SetMemory1:            TAction;
    SetMemory2:            TAction;
    ShellListView1:        TShellListView;
    ShowRunLogger:         TAction;
    Splitter1:             TSplitter;
    StatusBar1:            TStatusBar;
    Step:                  TAction;
    Stop:                  TAction;
    Timer1:                TTimer;
    ToolBar1:              TToolBar;
    ToolButton1:           TToolButton;
    ToolButton10:          TToolButton;
    ToolButton11:          TToolButton;
    ToolButton12:          TToolButton;
    ToolButton2:           TToolButton;
    ToolButton3:           TToolButton;
    ToolButton4:           TToolButton;
    ToolButton6:           TToolButton;
    ToolButton7:           TToolButton;
    ToolButton8:           TToolButton;
    ToolButton9:           TToolButton;
    ValueListEditor1:      TValueListEditor;
    ValueListEditor2:      TValueListEditor;
    procedure AboutExecute(Sender: TObject);
    procedure DepositExecute(Sender: TObject);
    procedure ExamineDepositExecute(Sender: TObject);
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
    procedure RefreshPluginListExecute(Sender: TObject);
    procedure RestartApplicationExecute(Sender: TObject);
    procedure SaveStatusExecute(Sender: TObject);
    procedure SelectPluginDirectoryExecute(Sender: TObject);
    procedure SetMemory1Execute(Sender: TObject);
    procedure SetMemory2Execute(Sender: TObject);
    procedure ShowRunLoggerExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure ValueListEditor1EditingDone(Sender: TObject);
    procedure ValueListEditor2ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
  private
    CurrentProcessor: TCPU;                      // created object of TCPU class
    LibHandle:        TLibHandle;                 // handle of the loaded module
    LoadedPlugin:     TPluginAttributes;      // properties of the loaded module
    // pointers to the plugin entry point
    CreateProcessor:  TCreateProcessorFunc;           // create plugin processor
    DestroyProcessor: TDestroyProcessorProc;         // destroy plugin processor
    LoadState:        TLoadStateProc;                       // load plugin state
    SaveState:        TSaveStateProc;                       // save plugin state
    // general variables
    FIgnoreHelp:      Boolean;
    FLoadCounter:     Integer;
    FEXEDirectory:    string;
    FPluginDirectory: string;
    FSystemLanguage:  string;
    FUserDirectory:   string;
    // emulated memory
    // - Bank #0: Neumann common memory or Harvard code memory
    // - Bank #1: Harvard data memory
    FMemory:          array[0..1, 0..MEM_SIZE - 1] of QWord;
    procedure ImpExpProperties(Direction: TOpDirection);
    procedure RefreshProperties(Direction: TOpDirection);
    procedure SetIgnoreHelp(AIgnoreHelp: Boolean);
    procedure SetPluginDirectory(APluginDirectory: string);
  public
    function GetMemoryCell(ABank: Integer; AAddress: DWord): QWord;
    procedure SetMemoryCell(ABank: Integer; AAddress: DWord; AValue: QWord);
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
  MSG05 = 'It is not a CoreLAB processor plugin.';
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
  MSG26 = 'CoreLAB stream file|*.clstm|All file|*.*';
  MSG27 = 'Read-only!';

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
      if Assigned(CurrentProcessor.Modname)
        then PModname := String(CurrentProcessor.Modname)
        else PModname := '';
      if Assigned(CurrentProcessor.Description)
        then PDescription := String(CurrentProcessor.Description)
        else PDescription := '';
      // read processor properties
      PEnabled := CurrentProcessor.Enabled;
      {...}
    end;
  end;
  // export from variables to plugin
  if Direction = opVar2Plugin then
  begin
    with LoadedPlugin do
    begin
      // only writeable properties
      CurrentProcessor.Enabled := PEnabled;
      {...}
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
      InsertRow('InstanceID (Hex)', IntToHex(LoadedPlugin.PInstanceID, 2), True);
      ItemProps['InstanceID (Hex)'].ReadOnly := True;
      InsertRow('Enabled', BoolToStr(LoadedPlugin.PEnabled, 'true', 'false'), True);
      with ItemProps['Enabled'] do
      begin
        EditStyle := esPickList;
        PickList.CommaText := 'true,false';
        ReadOnly := True;
      end;
      {...}
    end;
  end;
  if Direction = opList2Var then
  begin
    // ValueListEditor1 to variables
    with ValueListEditor1 do
    begin
      try
        LoadedPlugin.PEnabled := StrToBool(Values['Enabled']);
        {...}
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

// ---- PUBLIC METHODS ----

// GET DATA FROM A CELL OF THE EMULATED MEMORY
function TForm1.GetMemoryCell(ABank: Integer; AAddress: DWord): QWord;
begin
  Result := FMemory[ABank, AAddress];
end;

// SET DATA TO A CELL OF THE EMULATED MEMORY
procedure TForm1.SetMemoryCell(ABank: Integer; AAddress: DWord; AValue: QWord);
begin
  FMemory[ABank, AAddress] := AValue;
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
  Val, MaxVal, HexDigits: Integer;
begin
  if aCol = 1 then
  begin
    NewValue := Trim(NewValue);
    if NewValue = '' then NewValue := '0';

    // maximal value
    if aRow = 1 then
    begin
      MaxVal := 16777215;
      HexDigits := 6;
    end
    else
    begin
      MaxVal := 255;
      HexDigits := 2;
    end;

    // validating hexa value
    if not TryStrToInt('$' + NewValue, Val) or (Val < 0) or (Val > MaxVal) then
    begin
      ShowMessage(MSG01 + MSG15);
      NewValue := OldValue;
    end else
      NewValue := IntToHex(Val, HexDigits);
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

procedure TForm1.ShowRunLoggerExecute(Sender: TObject);
begin
  Form4.Show;
end;

// REFRESH PLUGIN LIST
procedure TForm1.RefreshPluginListExecute(Sender: TObject);
begin
  with ShellListView1 do
  begin
    {$IFDEF WINDOWS}
    Mask := 'processor_*.dll';
    {$ELSE}
    Mask := 'libprocessor_*.so';
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
    // device
    if Assigned(CurrentProcessor) then
    begin
      DestroyProcessor(CurrentProcessor);
      CurrentProcessor := nil;
    end;
    if LibHandle <> NilHandle then
    begin
      // UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      // processor
      CreateProcessor := nil;
      DestroyProcessor := nil;
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
    // processor
    Pointer(CreateProcessor) := GetProcedureAddress(LibHandle, 'processor_create');
    Pointer(DestroyProcessor) := GetProcedureAddress(LibHandle, 'processor_destroy');
    // module
    Pointer(LoadState) := GetProcedureAddress(LibHandle, 'processor_loadstate');
    Pointer(SaveState) := GetProcedureAddress(LibHandle, 'processor_savestate');
    // load data
    if (Assigned(CreateProcessor)) and (Assigned(DestroyProcessor)) then
    begin
      CurrentProcessor := CreateProcessor();
      LoadedPlugin.PFilename := SelectedFile;
      // set InstanceID
      CurrentProcessor.InstanceID := 0;
      // get properties
      ImpExpProperties(opPlugin2Var);
      // show properties
      RefreshProperties(opVar2List);
      ValueListEditor2.Enabled := True;
      ValueListEditor1.Enabled := True;
      ExamineDeposit.Enabled := True;
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
      ExamineDeposit.Enabled := False;
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

// EXAMINE/DEPOSIT
procedure TForm1.ExamineDepositExecute(Sender: TObject);
begin
  // állítsd be előtte!
  Form5.ShowModal;
end;

// WRITE A BYTE
procedure TForm1.DepositExecute(Sender: TObject);
var
  OutAddr: DWord;
  OutData: Integer;
  OutRange, ReadOnly: Boolean;
begin
{  OutData := 0;
  OutAddr := 0;
  if (TryStrToDWord('$' + ValueListEditor2.Cells[1, 1], OutAddr)) and
     (TryStrToInt('$' + ValueListEditor2.Cells[1, 2], OutData)) then
  begin
    if Assigned(CurrentProcessor) then
    begin
      CurrentProcessor.WriteProcessor(OutAddr, OutData);
      StatusBar1.Panels.Items[2].Text := Format(MSG14, [IntToHex(OutData, 1), IntToHex(OutAddr, 2)]);
      OutRange := OutAddr >= CurrentProcessor.AddressRangeSize;
      ReadOnly := CurrentProcessor.ProcessorMode = mmROM;
      // out of address range
      if OutRange or ReadOnly then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ' (';
      if OutRange then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + MSG16;
      if OutRange then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ' ';
      // write ROM
      if ReadOnly then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + MSG27;
      if OutRange or ReadOnly then StatusBar1.Panels[2].Text := StatusBar1.Panels[2].Text + ')';
      Timer1.Enabled := True;
    end;
  end;}
end;

// LOAD PLUGIN STATUS
procedure TForm1.LoadStatusExecute(Sender: TObject);
{var
  Filename: string;
  LoadStream: TProcessorStream;}
begin
{  with OpenDialog1 do
  begin
    InitialDir := GetUserDir;
    Title := MSG23;
    Filter := MSG26;
  end;
  if OpenDialog1.Execute then
  begin
    Filename := OpenDialog1.FileName;
    LoadStream := TProcessorStream.Create;
    try
      try
        LoadStream.LoadFromFile(FileName);
      except
        ShowMessage(MSG01 + Format(MSG24, [FileName]));
        exit;
      end;
      if not LoadState(CurrentProcessor, LoadStream) then ShowMessage(MSG01 + MSG25) else
      begin
        ImpExpProperties(opPlugin2Var);
        RefreshProperties(opVar2List);
      end;
    finally
      LoadStream.Free;
    end;
  end;}
end;

procedure TForm1.SetMemory1Execute(Sender: TObject);
begin

end;

procedure TForm1.SetMemory2Execute(Sender: TObject);
begin

end;

//SAVE PLUGIN STATUS
procedure TForm1.SaveStatusExecute(Sender: TObject);
{var
  Filename: string;
  SaveStream: TProcessorStream;}
begin
{  with SaveDialog1 do
  begin
    InitialDir := GetUserDir;
    Title := MSG21;
    Filter := MSG26;
  end;
  if SaveDialog1.Execute then
  begin
    Filename := SaveDialog1.FileName;
    SaveStream := TProcessorStream.Create;
    try
      if not SaveState(CurrentProcessor, SaveStream) then ShowMessage(MSG01 + MSG20) else
        try
          SaveStream.SaveToFile(FileName);
        except
          ShowMessage(MSG01 + Format(MSG22, [FileName]));
        end;
    finally
      SaveStream.Free;
    end;
  end;}
end;

// HELP
procedure TForm1.HelpExecute(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','html/clprocessor.htm');
end;

// ABOUT
procedure TForm1.AboutExecute(Sender: TObject);
begin
  Form2.ShowModal;
end;

// ONCREATE EVENT
procedure TForm1.FormCreate(Sender: TObject);
begin
  CurrentProcessor := nil;
  LibHandle := NilHandle;
  // processor
  CreateProcessor := nil;
  DestroyProcessor := nil;
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
  ExamineDeposit.Enabled := False;
  // refresh plugin list
  RefreshPluginList.Execute;
end;

// ONDESTROY EVENT
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // processor
  if Assigned(CurrentProcessor) then
  begin
    DestroyProcessor(CurrentProcessor);
    CurrentProcessor := nil;
  end;
  // module
  if LibHandle <> NilHandle then
  begin
    UnloadLibrary(LibHandle);
    LibHandle := NilHandle;
    // processor
    CreateProcessor := nil;
    DestroyProcessor := nil;
    // module
    LoadState := nil;
    SaveState := nil;
  end;
end;

end.
