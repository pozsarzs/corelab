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

{$DEFINE NOT_A_LIBRARY_BUT_A_UNIT}

unit frmmain;
{$MODE OBJFPC}{$H+}
{$I define.pas}
interface
uses
  CMem, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, ValEdit,
  ExtCtrls, EditBtn, ShellCtrls, DynLibs, Grids, Menus, ComCtrls, ActnList,
  Types, Process, HelpIntfs, LazHelpCHM, LazHelpIntf, StdCtrls, core_cpu,
  core_bus, core_ioport, frmabout, frmhexviewer, frmrunlogger, frmexdepmemory,
  frmloadsavememory, ioport_console, ioport_standard, ucommon, uintelhex;
const
  MEM_SIZE = 1024;
  IOADD_CONSOLE = $A0;
  IVECT_CONSOLE = $CF;
  IOADD_STDPORT = $B0;
type
  // Handled plugin attributes
  TPluginAttributes = record
    PFilename:         string;                         // filename of the module
    PDescription:      string;                              // short description
    PEnabled:          Boolean;     // disable processor without detach from bus
    PModname:          string;                                    // module name
    PAddressWidth:     Byte;                        // Address bus width in bits
    PArchitecture:     TArchitecture;                    // Type of architecture
    PEndianness:       TEndianness;                                // Byte order
    PMaxCodeAddress:   DWord;                 // The highest code memory address
    PMaxIOPortAddress: DWord;                    // The highest I/O port address
    PMaxMemAddress:    DWord;               // The highest (data) memory address
    PHasSeparateIOBus: Boolean;       // Indicates separate memory and I/O buses
  end;
  // direction pairs for data moving procedures
  TOpDirection = (opPlugin2Var, opVar2List, opList2Var, opVar2Plugin);
  // procedural types pointing to the plugin entry point
  TCreateProcessorFunc = function: TCPU; CALLTYPE;
  TDestroyProcessorProc = procedure(AProcessor: TCPU); CALLTYPE;
  TLoadStateFunc  = function(AProcessor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  TSaveStateFunc = function(AProcessor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  { TTestSysBus }
  TTestSysBus = class(TInterfacedObject, ISysBus)
    function ReadMemory(AAddress: DWord): Byte;
    procedure WriteMemory(AAddress: DWord; AValue: Byte);
    function ReadPort(APort: DWord): Byte;
    procedure WritePort(APort: DWord; AValue: Byte);
  end;
  { TForm1 }
  TForm1 = class(TForm)
    About:                     TAction;
    ActionList1:               TActionList;
    ASCIIConsole:              TAction;
    CHMHelpDatabase1:          TCHMHelpDatabase;
    ClearCodeMemory:           TAction;
    ClearDataMemory:           TAction;
    DirectoryEdit1:            TDirectoryEdit;
    Edit1:                     TEdit;
    ExamineDeposit:            TAction;
    Help:                      TAction;
    ImageList1:                TImageList;
    IRQ:                       TAction;
    Label1:                    TLabel;
    Label2:                    TLabel;
    LHelpConnector1:           TLHelpConnector;
    LoadChangePlugin:          TAction;
    LoadMemoryContent:         TAction;
    LoadRegisterValuesFromCPU: TAction;
    LoadStatus:                TAction;
    MainMenu1:                 TMainMenu;
    MenuItem10:                TMenuItem;
    MenuItem11:                TMenuItem;
    MenuItem12:                TMenuItem;
    MenuItem13:                TMenuItem;
    MenuItem14:                TMenuItem;
    MenuItem15:                TMenuItem;
    MenuItem16:                TMenuItem;
    MenuItem17:                TMenuItem;
    MenuItem18:                TMenuItem;
    MenuItem19:                TMenuItem;
    MenuItem1:                 TMenuItem;
    MenuItem20:                TMenuItem;
    MenuItem21:                TMenuItem;
    MenuItem22:                TMenuItem;
    MenuItem23:                TMenuItem;
    MenuItem24:                TMenuItem;
    MenuItem25:                TMenuItem;
    MenuItem26:                TMenuItem;
    MenuItem27:                TMenuItem;
    MenuItem28:                TMenuItem;
    MenuItem29:                TMenuItem;
    MenuItem2:                 TMenuItem;
    MenuItem30:                TMenuItem;
    MenuItem31:                TMenuItem;
    MenuItem32:                TMenuItem;
    MenuItem33:                TMenuItem;
    MenuItem34:                TMenuItem;
    MenuItem35:                TMenuItem;
    MenuItem36:                TMenuItem;
    MenuItem37:                TMenuItem;
    MenuItem38:                TMenuItem;
    MenuItem39:                TMenuItem;
    MenuItem3:                 TMenuItem;
    MenuItem40:                TMenuItem;
    MenuItem4:                 TMenuItem;
    MenuItem5:                 TMenuItem;
    MenuItem6:                 TMenuItem;
    MenuItem7:                 TMenuItem;
    MenuItem8:                 TMenuItem;
    MenuItem9:                 TMenuItem;
    NMI:                       TAction;
    OpenDialog1:               TOpenDialog;
    Panel1:                    TPanel;
    Panel2:                    TPanel;
    Quit:                      TAction;
    RefreshPluginList:         TAction;
    ResetPorts:                TAction;
    Reset:                     TAction;
    RestartApplication:        TAction;
    Run:                       TAction;
    SaveDialog1:               TSaveDialog;
    SaveMemoryContent:         TAction;
    SaveRegisterValuesToCPU:   TAction;
    SaveStatus:                TAction;
    SelectPluginDirectory:     TAction;
    Separator10:               TMenuItem;
    Separator1:                TMenuItem;
    Separator2:                TMenuItem;
    Separator3:                TMenuItem;
    Separator4:                TMenuItem;
    Separator5:                TMenuItem;
    Separator6:                TMenuItem;
    Separator7:                TMenuItem;
    Separator8:                TMenuItem;
    Separator9:                TMenuItem;
    ShellListView1:            TShellListView;
    ShowHexViewer:             TAction;
    ShowRunLogger:             TAction;
    Splitter1:                 TSplitter;
    StandardPort:              TAction;
    StatusBar1:                TStatusBar;
    Step:                      TAction;
    Stop:                      TAction;
    Timer1:                    TTimer;
    Timer2:                    TTimer;
    ToolBar1:                  TToolBar;
    ToolButton10:              TToolButton;
    ToolButton11:              TToolButton;
    ToolButton12:              TToolButton;
    ToolButton13:              TToolButton;
    ToolButton14:              TToolButton;
    ToolButton15:              TToolButton;
    ToolButton16:              TToolButton;
    ToolButton1:               TToolButton;
    ToolButton2:               TToolButton;
    ToolButton3:               TToolButton;
    ToolButton4:               TToolButton;
    ToolButton5:               TToolButton;
    ToolButton6:               TToolButton;
    ToolButton7:               TToolButton;
    ToolButton8:               TToolButton;
    ToolButton9:               TToolButton;
    TrackBar1:                 TTrackBar;
    ValueListEditor1:          TValueListEditor;
    ValueListEditor2:          TValueListEditor;
    procedure AboutExecute(Sender: TObject);
    procedure ASCIIConsoleExecute(Sender: TObject);
    procedure ClearCodeMemoryExecute(Sender: TObject);
    procedure ClearDataMemoryExecute(Sender: TObject);
    procedure CPUEventHandler(Sender: TObject; Event: TCPUEvent);
    procedure Edit1EditingDone(Sender: TObject);
    procedure ExamineDepositExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpExecute(Sender: TObject);
    procedure IRQExecute(Sender: TObject);
    procedure LoadChangePluginExecute(Sender: TObject);
    procedure LoadRegisterValuesFromCPUExecute(Sender: TObject);
    procedure LoadStatusExecute(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure NMIExecute(Sender: TObject);
    procedure QuitExecute(Sender: TObject);
    procedure RefreshPluginListExecute(Sender: TObject);
    procedure ResetExecute(Sender: TObject);
    procedure ResetPortsExecute(Sender: TObject);
    procedure RestartApplicationExecute(Sender: TObject);
    procedure RunExecute(Sender: TObject);
    procedure SaveRegisterValuesToCPUExecute(Sender: TObject);
    procedure SaveStatusExecute(Sender: TObject);
    procedure SelectPluginDirectoryExecute(Sender: TObject);
    procedure LoadMemoryContentExecute(Sender: TObject);
    procedure SaveMemoryContentExecute(Sender: TObject);
    procedure ShowHexViewerExecute(Sender: TObject);
    procedure ShowRunLoggerExecute(Sender: TObject);
    procedure StandardPortExecute(Sender: TObject);
    procedure StepExecute(Sender: TObject);
    procedure StopExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ValueListEditor1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
    procedure ValueListEditor1EditingDone(Sender: TObject);
    procedure ValueListEditor2ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
  private
    CurrentProcessor: TCPU;                    // created object from TCPU class
    LibHandle:        TLibHandle;                 // handle of the loaded module
    LoadedPlugin:     TPluginAttributes;      // properties of the loaded module
    FTestSysBus:      ISysBus;                      // Test system bus interface
    // pointers to the plugin entry point
    CreateProcessor:  TCreateProcessorFunc;           // create plugin processor
    DestroyProcessor: TDestroyProcessorProc;         // destroy plugin processor
    LoadState:        TLoadStateFunc;                       // load plugin state
    SaveState:        TSaveStateFunc;                       // save plugin state
    // registers
    RegNames:         array of PChar;                 // imported register names
    RegValues:        array of Word;                 // imported register values
    RegSize:          array of Byte;                 // register size in nibbles
    RegCount:         Byte;                       // number of the all registers
    // general variables
    FIgnoreHelp:      Boolean;
    FLoadCounter:     Integer;
    FEXEDirectory:    string;
    FPluginDirectory: string;
    FSystemLanguage:  string;
    FUserDirectory:   string;
    // I/O ports
    FSendIOIntReq:    Boolean;    // Enable/disable sending INT request from I/O
    FPortIntVector:   Byte;                          // Console interrupt vector
    FPortConsole:     TConsole;            // created object from TConsole class
    FPortStandard:    TStandardPort;  // created object from TStandardPort class
    FPortConsoleCap:  string;                          // created object caption
    FPortStandardCap: string;                          // created object caption
    // emulated memory
    // - Bank #0: Neumann common memory or Harvard code memory
    // - Bank #1: Harvard data memory
    FMemory:          array[0..1, 0..MEM_SIZE - 1] of Byte;
    procedure ImpExpProperties(Direction: TOpDirection);
    procedure InterruptHandler(Sender: TIOPort; AVector: Byte);
    procedure RefreshProperties(Direction: TOpDirection);
    procedure RefreshRegisters(Direction: TOpDirection);
    procedure SetIgnoreHelp(AIgnoreHelp: Boolean);
    procedure SetPluginDirectory(APluginDirectory: string);
  public
    function GetMemoryCell(ABank: Integer; AAddress: DWord): Byte;
    procedure SetMemoryCell(ABank: Integer; AAddress: DWord; AValue: Byte);
    property IgnoreHelp: Boolean read FIgnoreHelp write SetIgnoreHelp;
    property EXEDirectory: string read FEXEDirectory;
    property PluginDirectory: string read FPluginDirectory write SetPluginDirectory;
    property SystemLanguage: string read FSystemLanguage;
    property UserDirectory: string read FUserDirectory;
  end;
var
  Form1: TForm1;

implementation

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
  MSG11 = 'Reg.';
  MSG12 = 'INT required (vector: %sh)';
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
  MSG28 = 'Save memory content to file';
  MSG29 = 'Cannot save memory content to ''%s'' binary file.';
  MSG30 = 'Load memory content from file';
  MSG31 = 'Cannot load memory content from ''%s'' binary file.';
  MSG32 = 'Binary file|*.bin|Intel hexa file|*.hex|All file|*.*';
  MSG33 = 'ASCII console (address: %sh)';
  MSG34 = 'I/O port (address: %sh)';
  MSG35 = 'Cannot load memory content from ''%s'' Intel hexa file.';
  MSG36 = 'Cannot save memory content to ''%s'' Intel hexa file.';
  MSG37 = 'Data converting error.';
  MSG38 = 'Checksum error.';
  MSG39 = 'Unexpected error.';

{$R *.lfm}

{ TTestSysBus }

// READ MEMORY METHOD OF THE SYSTEM BUS
function TTestSysBus.ReadMemory(AAddress: DWord): Byte;
begin
  Result := Form1.GetMemoryCell(0, AAddress);
end;

// WRITE MEMORY METHOD OF THE SYSTEM BUS
procedure TTestSysBus.WriteMemory(AAddress: DWord; AValue: Byte);
begin
  Form1.SetMemoryCell(0, AAddress, AValue)
end;

// READ PORT METHOD OF THE SYSTEM BUS
function TTestSysBus.ReadPort(APort: DWord): Byte;
begin
  case APort of
    IOADD_CONSOLE: Result := Form1.FPortConsole.ReadPort(0);
    IOADD_STDPORT: Result := Form1.FPortStandard.ReadPort(0);
  else
    Result := 0;
  end;
end;

// WRITE PORT METHOD OF THE SYSTEM BUS
procedure TTestSysBus.WritePort(APort: DWord; AValue: Byte);
begin
  case APort of
    IOADD_CONSOLE: Form1.FPortConsole.WritePort(APort, AValue);
    IOADD_STDPORT: Form1.FPortStandard.WritePort(APort, AValue);
  end;
end;

{ TForm1 }

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
      PAddressWidth := CurrentProcessor.AddressWidth;
      PArchitecture := CurrentProcessor.Architecture;
      PEndianness := CurrentProcessor.Endianness;
      PMaxCodeAddress := CurrentProcessor.MaxCodeAddress;
      PMaxIOPortAddress := CurrentProcessor.MaxIOPortAddress;
      PMaxMemAddress := CurrentProcessor.MaxMemAddress;
      PHasSeparateIOBus := CurrentProcessor.HasSeparateIOBus;
    end;
  end;
  // export from variables to plugin
  if Direction = opVar2Plugin then
  begin
    with LoadedPlugin do
    begin
      // only writeable properties
      CurrentProcessor.Enabled := PEnabled;
    end;
  end;
end;

// INTERRUPT HANDLER
procedure TForm1.InterruptHandler(Sender: TIOPort; AVector: Byte);
begin
  if FSendIOIntReq then
  begin
    StatusBar1.Panels.Items[2].Text := Format(MSG12, [IntToHex(AVector, 2)]);
    Timer1.Enabled := True;
    if Assigned(CurrentProcessor) then
    begin
      CurrentProcessor.IRQ(AVector);
      RefreshRegisters(opVar2List);
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
      InsertRow('AddressWidth', IntToStr(LoadedPlugin.PAddressWidth), True);
      ItemProps['AddressWidth'].ReadOnly := True;
      InsertRow('Architecture', LoadedPlugin.PArchitecture.ToString, True);
      ItemProps['Architecture'].ReadOnly := True;
      InsertRow('Endianness', LoadedPlugin.PEndianness.ToString, True);
      ItemProps['Endianness'].ReadOnly := True;
      InsertRow('HasSeparateIOBus', BoolToStr(LoadedPlugin.PHasSeparateIOBus, 'true', 'false'), True);
      ItemProps['HasSeparateIOBus'].ReadOnly := True;
      InsertRow('MaxCodeAddress', IntToHex(LoadedPlugin.PMaxCodeAddress, 6), True);
      ItemProps['MaxCodeAddress'].ReadOnly := True;
      InsertRow('MaxIOPortAddress', IntToHex(LoadedPlugin.PMaxIOPortAddress, 6), True);
      ItemProps['MaxIOPortAddress'].ReadOnly := True;
      InsertRow('MaxMemAddress', IntToHex(LoadedPlugin.PMaxMemAddress, 6), True);
      ItemProps['MaxMemAddress'].ReadOnly := True;
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
        LoadedPlugin.PEnabled := StrToBool(Values['Enabled']);
      except
        ShowMessage(MSG01 + MSG02);
      end;
    end;
  end;
end;

// REFRESH REGISTER LIST
procedure TForm1.RefreshRegisters(Direction: TOpDirection);
var
  b: Byte;
begin
  if Assigned(CurrentProcessor) then
  begin
    // get number of registers
    RegCount := CurrentProcessor.GetRegisterCount;
    SetLength(RegNames, RegCount);
    SetLength(RegValues, RegCount);
    SetLength(RegSize, RegCount);
    // get registers' name
    for b := 0 to RegCount - 1 do
    begin
      RegNames[b] := CurrentProcessor.GetRegisterName(b);
      RegSize[b] := CurrentProcessor.GetRegisterSize(b);
    end;
    if Direction = opVar2List then
    begin
      with ValueListEditor2 do
      begin
        Col := 0;
        Row := 1;
        Clear;
        DefaultRowHeight := 20;
        Strings.BeginUpdate;
        for b := 0 to RegCount - 1 do
        begin
          // registers to array
          RegValues[b] := CurrentProcessor.GetRegister(RegNames[b]);
          // array to ValueListEditor2
          Strings.Add(StrPas(RegNames[b]) + '=' + IntToHex(RegValues[b], RegSize[b]));
        end;
        Strings.EndUpdate;
      end;
    end else
    begin
      for b := 0 to RegCount - 1 do
      begin
        // ValueListEditor2 to array
        RegValues[b] := StrToInt('$' + ValueListEditor2.Values[StrPas(RegNames[b])]);
        // array to registers
        CurrentProcessor.SetRegister(RegNames[b], RegValues[b]);
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
function TForm1.GetMemoryCell(ABank: Integer; AAddress: DWord): Byte;
begin
  Result := FMemory[ABank, AAddress];
end;

// SET DATA TO A CELL OF THE EMULATED MEMORY
procedure TForm1.SetMemoryCell(ABank: Integer; AAddress: DWord; AValue: Byte);
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

// RUN TIMER
procedure TForm1.Timer2Timer(Sender: TObject);
begin
  CurrentProcessor.Step;
  RefreshRegisters(opVar2List);
  Timer2.Enabled := True;
end;

// CHANGE DELAY
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Timer2.Interval := TrackBar1.Position;
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

// VALIDATE DATA
procedure TForm1.ValueListEditor2ValidateEntry(Sender: TObject; aCol, aRow: Integer; const OldValue: string; var NewValue: String);
var
  Val, MaxVal, HexDigits: LongInt;
  b:                      Byte;
  i:                      Integer;
begin
  if aCol = 1 then
  begin
    NewValue := Trim(NewValue);
    if NewValue = '' then NewValue := '0';

    // hexa digits and upper limit
    with ValueListEditor2 do
    begin
      i := -1;
      for b := 0 to RegCount - 1 do
        if Cells[0, aRow] = StrPas(RegNames[b]) then i := b;
      if i > -1 then HexDigits := RegSize[i];
    end;
    MaxVal := (1 shl (HexDigits * 4)) - 1;

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
    Mask := 'cpu_*.dll';
    {$ELSE}
    Mask := 'libcpu_*.so';
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
    Pointer(CreateProcessor) := GetProcedureAddress(LibHandle, 'cpu_create');
    Pointer(DestroyProcessor) := GetProcedureAddress(LibHandle, 'cpu_destroy');
    // module
    Pointer(LoadState) := GetProcedureAddress(LibHandle, 'cpu_loadstate');
    Pointer(SaveState) := GetProcedureAddress(LibHandle, 'cpu_savestate');
    // load data
    if (Assigned(CreateProcessor)) and (Assigned(DestroyProcessor)) then
    begin
      // instantiate processor
      CurrentProcessor := CreateProcessor();
      CurrentProcessor.OnEvent := @CPUEventHandler;
      // instantiate and connect system bus
      FTestSysBus := TTestSysBus.Create;
      CurrentProcessor.ConnectBus(FTestSysBus);
      // get filename
      LoadedPlugin.PFilename := SelectedFile;
      // get properties
      ImpExpProperties(opPlugin2Var);
      // show properties
      RefreshProperties(opVar2List);
      // show registers
      RefreshRegisters(opVar2List);
      ValueListEditor2.Enabled := True;
      ValueListEditor1.Enabled := True;
      // enable/disable actions
      LoadRegisterValuesFromCPU.Enabled := True;
      SaveRegisterValuesToCPU.Enabled := True;
      Reset.Enabled := True;
      NMI.Enabled := True;
      IRQ.Enabled := True;
      Step.Enabled := True;
      Run.Enabled := True;
      Stop.Enabled := True;
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
      ValueListEditor2.Clear;
      with ValueListEditor2 do
      begin
        TitleCaptions.Strings[0] := MSG11;
        TitleCaptions.Strings[1] := MSG17;
        Cells[0, 1] := '';
        Enabled := False;
      end;
      UnloadLibrary(LibHandle);
      LibHandle := NilHandle;
      ValueListEditor1.Enabled := False;
      ValueListEditor2.Enabled := False;
      // enable/disable actions
      LoadRegisterValuesFromCPU.Enabled := False;
      SaveRegisterValuesToCPU.Enabled := False;
      Reset.Enabled := False;
      NMI.Enabled := False;
      IRQ.Enabled := False;
      Step.Enabled := False;
      Run.Enabled := False;
      Stop.Enabled := False;
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

// SHOW RUNLOGGER WINDOW
procedure TForm1.ShowRunLoggerExecute(Sender: TObject);
begin
  Form4.Show;
end;

// LOAD REGISTER CONTENT FROM CPU
procedure TForm1.LoadRegisterValuesFromCPUExecute(Sender: TObject);
begin
  RefreshRegisters(opVar2List);
end;

// SAVE REGISTER CONTENT TO CPU
procedure TForm1.SaveRegisterValuesToCPUExecute(Sender: TObject);
begin
  RefreshRegisters(opList2Var);
end;

// RESET PROCESSOR
procedure TForm1.ResetExecute(Sender: TObject);
begin
  CurrentProcessor.Reset;
  RefreshRegisters(opVar2List);
end;

// REQUEST NMI
procedure TForm1.NMIExecute(Sender: TObject);
begin
  CurrentProcessor.NMI;
  RefreshRegisters(opVar2List);
end;

// REQUEST IRQ
procedure TForm1.IRQExecute(Sender: TObject);
begin
  begin
    StatusBar1.Panels.Items[2].Text := Format(MSG12, [IntToHex(FPortIntVector, 2)]);
    Timer1.Enabled := True;
    if Assigned(CurrentProcessor) then
    begin
      CurrentProcessor.IRQ(FPortIntVector);
      RefreshRegisters(opVar2List);
    end;
  end;
end;

// RUN PROGRAM BY STEP
procedure TForm1.StepExecute(Sender: TObject);
begin
  CurrentProcessor.Step;
  RefreshRegisters(opVar2List);
end;

// RUN PROGRAM
procedure TForm1.RunExecute(Sender: TObject);
begin
  RefreshRegisters(opVar2List);
  Timer2.Enabled := True;
end;

// STOP PROGRAM
procedure TForm1.StopExecute(Sender: TObject);
begin
  Timer2.Enabled := False;
  RefreshRegisters(opVar2List);
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
      if not LoadState(CurrentProcessor, LoadStream) then ShowMessage(MSG01 + MSG25) else
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
      if not SaveState(CurrentProcessor, SaveStream) then ShowMessage(MSG01 + MSG20) else
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

// SHOW HEXVIEWER WINDOW
procedure TForm1.ShowHexViewerExecute(Sender: TObject);
begin
  with Form3 do
  begin
    Architecture := LoadedPlugin.PArchitecture;
    MemSize := MEM_SIZE;
    Show;
  end;
end;

// LOAD MEMORY CONTENT
procedure TForm1.LoadMemoryContentExecute(Sender: TObject);
var
  Filename:   string;
  LoadStream: TMemoryStream;
  i:          DWord;
  Data:       Byte;
begin
  Data := 0;
  with OpenDialog1 do
  begin
    InitialDir := GetUserDir;
    Title := MSG30;
    Filter := MSG32;
  end;
  if OpenDialog1.Execute then
  begin
    Filename := OpenDialog1.FileName;
    if Assigned(CurrentProcessor)
      then Form7.Architecture := CurrentProcessor.Architecture
      else Form7.Architecture := arNeumann;
    Form7.Direction := true;
    Form7.MemSize := MEM_SIZE;
    if Form7.ShowModal = mrCancel then exit else
    begin
      LoadStream := TMemoryStream.Create;
      try
        if OpenDialog1.FilterIndex <> 2 then
        begin
          // load from .bin file
          try
            LoadStream.LoadFromFile(FileName);
            LoadStream.Position := 0;
            for i := Form7.AddressFrom to Form7.AddressTo do
            begin
              LoadStream.ReadBuffer(Data, 1);
              Form1.FMemory[Form7.Bank, i] := Data;
            end;
          except
            ShowMessage(MSG01 + Format(MSG31, [FileName]));
          end;
        end else
        begin
          // clear target memory
          case Form7.Bank of
            0: ClearCodeMemoryExecute(Sender);
            1: ClearDataMemoryExecute(Sender);
          end;
          // load from .hex file
          case LoadFromIntelHex(Filename, FMemory[Form7.Bank]) of
            1: ShowMessage(MSG01 + Format(MSG35, [FileName]));
            2: ShowMessage(MSG01 + MSG37);
            3: ShowMessage(MSG01 + MSG38);
            255: ShowMessage(MSG01 + MSG39);
          end;
        end;
      finally
        LoadStream.Free;
      end;
    end;
  end;
end;

// SAVE MEMORY CONTENT
procedure TForm1.SaveMemoryContentExecute(Sender: TObject);
var
  Filename:   string;
  SaveStream: TMemoryStream;
  i:          DWord;
  Data:       Byte;
begin
  if Assigned(CurrentProcessor)
    then Form7.Architecture := CurrentProcessor.Architecture
    else Form7.Architecture := arNeumann;
  Form7.Direction := false;
  Form7.MemSize := MEM_SIZE;
  if Form7.ShowModal = mrCancel then Exit else
  begin
    with SaveDialog1 do
    begin
      InitialDir := GetUserDir;
      Title := MSG28;
      Filter := MSG32;
    end;
    if SaveDialog1.Execute then
    begin
      Filename := SaveDialog1.FileName;
      SaveStream := TMemoryStream.Create;
      try
        if SaveDialog1.FilterIndex <> 2 then
        begin
          // save to .bin file
          try
            for i := Form7.AddressFrom to Form7.AddressTo do
            begin
              Data := FMemory[Form7.Bank, i];
              SaveStream.WriteBuffer(Data, 1);
            end;
            SaveStream.SaveToFile(FileName);
          except
            ShowMessage(MSG01 + Format(MSG29, [FileName]));
          end;
        end else
        begin
          // save to .hex file
          case SaveToIntelHex(Filename, FMemory[Form7.Bank]) of
            1: ShowMessage(MSG01 + Format(MSG36, [FileName]));
            255: ShowMessage(MSG01 + MSG39);
          end;
        end;
      finally
        SaveStream.Free;
      end;
    end;
  end;
end;

// EXAMINE/DEPOSIT
procedure TForm1.ExamineDepositExecute(Sender: TObject);
begin
  with Form5 do
  begin
    Architecture := LoadedPlugin.PArchitecture;
    MemSize := MEM_SIZE;
    ShowModal;
  end;
end;

// CLEAR BANK0 (Neumann and Harvard code memory)
procedure TForm1.ClearCodeMemoryExecute(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(FMemory) - 1 do FMemory[0, i] := 0;
end;

// CLEAR BANK1 (Harvard data memory)
procedure TForm1.ClearDataMemoryExecute(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to Length(FMemory) - 1 do FMemory[1, i] := 0;
end;

// SHOW ASCII CONSOLE
procedure TForm1.ASCIIConsoleExecute(Sender: TObject);
begin
  if not Assigned(FPortConsole) then FPortConsole := TConsole.Create;
  with FPortConsole do
  begin
    CreatePanel;
    ShowPanel;
    FPortConsoleCap := Format(MSG33,[IntToHex(IOADD_CONSOLE, 2)]);
    RenamePanel(PChar(FPortConsoleCap));
    FPortConsole.OnInterrupt:= @InterruptHandler;
    FPortConsole.IntVector := FPortIntVector;
    Enabled := true;
  end;
end;

// SHOW STANDARD I/O PORT
procedure TForm1.StandardPortExecute(Sender: TObject);
begin
  if not Assigned(FPortStandard) then FPortStandard := TStandardPort.Create;
  with FPortStandard do
  begin
    CreatePanel;
    ShowPanel;
    FPortStandardCap := Format(MSG34,[IntToHex(IOADD_STDPORT, 2)]);
    RenamePanel(PChar(FPortStandardCap));
    Enabled := true;
  end;
end;

// ENABLE/DISABLE INTERRUPT REQUEST FROM I/O PORT
procedure TForm1.MenuItem38Click(Sender: TObject);
begin
  FSendIOIntReq := MenuItem38.Checked;
end;

// RESET I/O PORTS
procedure TForm1.ResetPortsExecute(Sender: TObject);
begin
  if Assigned(FPortConsole) then FPortConsole.Reset;
  if Assigned(FPortStandard) then FPortStandard.Reset;
end;

// HELP
procedure TForm1.HelpExecute(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','html/applications/cprocessor.html');
end;

// ABOUT
procedure TForm1.AboutExecute(Sender: TObject);
begin
  Form2.ShowModal;
end;

// CPU EVENT HANDLER
procedure TForm1.CPUEventHandler(Sender: TObject; Event: TCPUEvent);
begin
  if Event = ceInstructionBoundary then
    Form4.AppendRecord(CurrentProcessor.GetCurrentInstruction);
end;

// VALIDATE VECTOR VALUE
procedure TForm1.Edit1EditingDone(Sender: TObject);
var
  PrevText, NewText: string;
begin
  PrevText := Edit1.Text;
  NewText := '';
  if FormatHexValue(Edit1.Text, 2, NewText) then
  begin
    Edit1.Text := NewText;
    FPortIntVector := StrToInt('$' + Edit1.Text);
  end else
  begin
    ShowMessage(MSG01 + MSG02);
    Edit1.Text := PrevText;
  end;
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
  FSendIOIntReq := True;
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
    TitleCaptions.Strings[1] := MSG17;
    Cells[0, 1] := '';
    Enabled := False;
  end;
  // enable/disable actions
  LoadChangePlugin.Enabled := False;
  LoadRegisterValuesFromCPU.Enabled := False;
  SaveRegisterValuesToCPU.Enabled := False;
  Reset.Enabled := False;
  NMI.Enabled := False;
  IRQ.Enabled := False;
  Step.Enabled := False;
  Run.Enabled := False;
  Stop.Enabled := False;
  LoadStatus.Enabled := False;
  SaveStatus.Enabled := False;
  // enable/disable menuitems
  if not DirectoryExists(MenuItem15.Caption, True) then MenuItem15.Free;
  if not DirectoryExists(MenuItem16.Caption, True) then MenuItem16.Free;
  if not DirectoryExists(MenuItem17.Caption, True) then MenuItem17.Free;
  if not DirectoryExists(MenuItem18.Caption, True) then MenuItem18.Free;
  // default i/o irq vector value
  FPortIntVector := IVECT_CONSOLE;
  Edit1.Text := IntToHex(FPortIntVector, 2);
  // run timer
  Timer2.Interval := TrackBar1.Position;
  // refresh plugin list
  RefreshPluginList.Execute;
end;

// ONDESTROY EVENT
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // i/o port and device
  if Assigned(FPortConsole) then
    with FPortConsole do
    begin
      FreePanel;
      Free;
      FPortConsole := nil;
    end;
  if Assigned(FPortStandard) then
    with FPortStandard do
    begin
      FreePanel;
      Free;
      FPortStandard := nil;
    end;
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
