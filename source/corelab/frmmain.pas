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
  CMem, Classes, DOM, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, ComCtrls, ActnList, StdCtrls, HelpIntfs, LazHelpCHM, LazHelpIntf,
  SynEdit, Generics.Collections, Process, XMLRead, XMLWrite, frmabout,
  frmclasslist, frmmodulelist, frmrunlogger, frmsettings, frmexdepmemory,
  frmloadsavememory, frmhexviewer, frmregviewer, frmscripteditor,
  frmscriptconsole, frmintlogger, frmcaption, frmproperties, frmmoduleexplorer,
  frmbpmanager, frmbuslogger, frmrdwrioport, commandengine, scriptengine,
  core_cpu, core_memory, core_ioport, core_bus, usysconsole, ucommon, uconfig,
  uplugin, uintelhex, uactcontext, uproperties, ubreakpoint, simulationthread;
  { TSysBus }
type
  TSysBus = class(TInterfacedObject, ISysBus)
    FCPUs:     array of TBusProc;
    FMemories: array of TBusMem;
    FIOPorts:  array of TBusPort;
  public
    function AttachCPU(const AModuleName: string; ACPU: TCPU): Byte;
    function AttachMemory(const AModuleName: string; AMemory: TMemory; ABaseAddress, AAddressRange: DWord): Byte;
    function AttachIOPort(const AModuleName: string; AIOPort: TIOPort; ABaseAddress, AAddressRange: DWord): Byte;
    function DetachCPU(const AModuleName: string): Byte;
    function DetachMemory(const AModuleName: string): Byte;
    function DetachIOPort(const AModuleName: string): Byte;
    function ReadMemory(AAddress: DWord): Byte;
    procedure WriteMemory(AAddress: DWord; AValue: Byte);
    function ReadPort(APort: DWord): Byte;
    procedure WritePort(APort: DWord; AValue: Byte);
  end;
  { TForm1 }
  TForm1 = class(TForm)
    ActionList1:              TActionList;
    CHMHelpDatabase1:         TCHMHelpDatabase;
    ComboBox1:                TComboBox;
    FChangeWorkDirectory:     TAction;
    FExit:                    TAction;
    FLoadProject:             TAction;
    FNewProject:              TAction;
    FRestartApplication:      TAction;
    FSaveProject:             TAction;
    FSaveProjectAs:           TAction;
    FSettings:                TAction;
    FSwitchToInteractiveMode: TAction;
    FSwitchToScriptMode:      TAction;
    HAbout:                   TAction;
    HHelp:                    TAction;
    ImageList1:               TImageList;
    IOAttachToBus:            TAction;
    IOCreate:                 TAction;
    IODestroy:                TAction;
    IODetachFromBus:          TAction;
    IODisable:                TAction;
    IOEnable:                 TAction;
    IOProperties:             TAction;
    IOReadWrite:              TAction;
    IOReset:                  TAction;
    LHelpConnector1:          TLHelpConnector;
    MainMenu1:                TMainMenu;
    MAttachToBus:             TAction;
    MCreate:                  TAction;
    MDestroy:                 TAction;
    MDetachFromBus:           TAction;
    MDisable:                 TAction;
    MEnable:                  TAction;
    MenuItem1:                TMenuItem;
    MenuItem10:               TMenuItem;
    MenuItem11:               TMenuItem;
    MenuItem12:               TMenuItem;
    MenuItem13:               TMenuItem;
    MenuItem15:               TMenuItem;
    MenuItem16:               TMenuItem;
    MenuItem17:               TMenuItem;
    MenuItem18:               TMenuItem;
    MenuItem19:               TMenuItem;
    MenuItem2:                TMenuItem;
    MenuItem20:               TMenuItem;
    MenuItem21:               TMenuItem;
    MenuItem22:               TMenuItem;
    MenuItem23:               TMenuItem;
    MenuItem24:               TMenuItem;
    MenuItem25:               TMenuItem;
    MenuItem26:               TMenuItem;
    MenuItem27:               TMenuItem;
    MenuItem28:               TMenuItem;
    MenuItem29:               TMenuItem;
    MenuItem3:                TMenuItem;
    MenuItem30:               TMenuItem;
    MenuItem31:               TMenuItem;
    MenuItem32:               TMenuItem;
    MenuItem33:               TMenuItem;
    MenuItem34:               TMenuItem;
    MenuItem35:               TMenuItem;
    MenuItem36:               TMenuItem;
    MenuItem37:               TMenuItem;
    MenuItem38:               TMenuItem;
    MenuItem39:               TMenuItem;
    MenuItem4:                TMenuItem;
    MenuItem40:               TMenuItem;
    MenuItem41:               TMenuItem;
    MenuItem42:               TMenuItem;
    MenuItem43:               TMenuItem;
    MenuItem44:               TMenuItem;
    MenuItem45:               TMenuItem;
    MenuItem46:               TMenuItem;
    MenuItem47:               TMenuItem;
    MenuItem48:               TMenuItem;
    MenuItem49:               TMenuItem;
    MenuItem5:                TMenuItem;
    MenuItem50:               TMenuItem;
    MenuItem51:               TMenuItem;
    MenuItem52:               TMenuItem;
    MenuItem53:               TMenuItem;
    MenuItem54:               TMenuItem;
    MenuItem55:               TMenuItem;
    MenuItem56:               TMenuItem;
    MenuItem57:               TMenuItem;
    MenuItem58:               TMenuItem;
    MenuItem59:               TMenuItem;
    MenuItem6:                TMenuItem;
    MenuItem60:               TMenuItem;
    MenuItem61:               TMenuItem;
    MenuItem62:               TMenuItem;
    MenuItem63:               TMenuItem;
    MenuItem64:               TMenuItem;
    MenuItem65:               TMenuItem;
    MenuItem66:               TMenuItem;
    MenuItem67:               TMenuItem;
    MenuItem68:               TMenuItem;
    MenuItem69:               TMenuItem;
    MenuItem7:                TMenuItem;
    MenuItem70:               TMenuItem;
    MenuItem71:               TMenuItem;
    MenuItem72:               TMenuItem;
    MenuItem73:               TMenuItem;
    MenuItem74:               TMenuItem;
    MenuItem8:                TMenuItem;
    MenuItem9:                TMenuItem;
    MExamineDeposit:          TAction;
    MLoadMemoryContent:       TAction;
    MProperties:              TAction;
    MReset:                   TAction;
    MSaveMemoryContent:       TAction;
    OMakeSnapshot:            TAction;
    ONMI:                     TAction;
    OResetAll:                TAction;
    ORestoreSnapshot:         TAction;
    ORun:                     TAction;
    OStep:                    TAction;
    OStop:                    TAction;
    PageControl1:             TPageControl;
    Panel1:                   TPanel;
    Panel2:                   TPanel;
    PAttachToBus:             TAction;
    PCreate:                  TAction;
    PDestroy:                 TAction;
    PDetachFromBus:           TAction;
    PDisable:                 TAction;
    PEnable:                  TAction;
    PProperties:              TAction;
    PReset:                   TAction;
    RefreshTimer:             TTimer;
    Separator1:               TMenuItem;
    Separator10:              TMenuItem;
    Separator11:              TMenuItem;
    Separator12:              TMenuItem;
    Separator13:              TMenuItem;
    Separator14:              TMenuItem;
    Separator15:              TMenuItem;
    Separator16:              TMenuItem;
    Separator17:              TMenuItem;
    Separator18:              TMenuItem;
    Separator19:              TMenuItem;
    Separator2:               TMenuItem;
    Separator20:              TMenuItem;
    Separator21:              TMenuItem;
    Separator22:              TMenuItem;
    Separator23:              TMenuItem;
    Separator3:               TMenuItem;
    Separator4:               TMenuItem;
    Separator5:               TMenuItem;
    Separator6:               TMenuItem;
    Separator7:               TMenuItem;
    Separator8:               TMenuItem;
    Separator9:               TMenuItem;
    SLoadScript:              TAction;
    SNewScript:               TAction;
    Splitter1:                TSplitter;
    SRunScript:               TAction;
    SSaveScript:              TAction;
    SSaveScriptAs:            TAction;
    SStepScript:              TAction;
    SStopScript:              TAction;
    TabSheet1:                TTabSheet;
    TabSheet2:                TTabSheet;
    TabSheet3:                TTabSheet;
    TabSheet4:                TTabSheet;
    TabSheet5:                TTabSheet;
    ToolBar1:                 TToolBar;
    ToolBar2:                 TToolBar;
    ToolBar3:                 TToolBar;
    ToolBar4:                 TToolBar;
    ToolBar5:                 TToolBar;
    ToolBar6:                 TToolBar;
    ToolBar7:                 TToolBar;
    ToolButton1:              TToolButton;
    ToolButton10:             TToolButton;
    ToolButton11:             TToolButton;
    ToolButton12:             TToolButton;
    ToolButton13:             TToolButton;
    ToolButton14:             TToolButton;
    ToolButton15:             TToolButton;
    ToolButton16:             TToolButton;
    ToolButton17:             TToolButton;
    ToolButton18:             TToolButton;
    ToolButton19:             TToolButton;
    ToolButton2:              TToolButton;
    ToolButton20:             TToolButton;
    ToolButton21:             TToolButton;
    ToolButton22:             TToolButton;
    ToolButton23:             TToolButton;
    ToolButton24:             TToolButton;
    ToolButton25:             TToolButton;
    ToolButton26:             TToolButton;
    ToolButton27:             TToolButton;
    ToolButton28:             TToolButton;
    ToolButton29:             TToolButton;
    ToolButton3:              TToolButton;
    ToolButton30:             TToolButton;
    ToolButton31:             TToolButton;
    ToolButton32:             TToolButton;
    ToolButton33:             TToolButton;
    ToolButton34:             TToolButton;
    ToolButton35:             TToolButton;
    ToolButton36:             TToolButton;
    ToolButton37:             TToolButton;
    ToolButton38:             TToolButton;
    ToolButton39:             TToolButton;
    ToolButton4:              TToolButton;
    ToolButton40:             TToolButton;
    ToolButton41:             TToolButton;
    ToolButton42:             TToolButton;
    ToolButton43:             TToolButton;
    ToolButton44:             TToolButton;
    ToolButton45:             TToolButton;
    ToolButton46:             TToolButton;
    ToolButton47:             TToolButton;
    ToolButton48:             TToolButton;
    ToolButton49:             TToolButton;
    ToolButton5:              TToolButton;
    ToolButton50:             TToolButton;
    ToolButton51:             TToolButton;
    ToolButton52:             TToolButton;
    ToolButton53:             TToolButton;
    ToolButton54:             TToolButton;
    ToolButton55:             TToolButton;
    ToolButton56:             TToolButton;
    ToolButton57:             TToolButton;
    ToolButton58:             TToolButton;
    ToolButton59:             TToolButton;
    ToolButton6:              TToolButton;
    ToolButton60:             TToolButton;
    ToolButton61:             TToolButton;
    ToolButton62:             TToolButton;
    ToolButton63:             TToolButton;
    ToolButton64:             TToolButton;
    ToolButton65:             TToolButton;
    ToolButton66:             TToolButton;
    ToolButton67:             TToolButton;
    ToolButton68:             TToolButton;
    ToolButton69:             TToolButton;
    ToolButton7:              TToolButton;
    ToolButton70:             TToolButton;
    ToolButton71:             TToolButton;
    ToolButton72:             TToolButton;
    ToolButton73:             TToolButton;
    ToolButton74:             TToolButton;
    ToolButton75:             TToolButton;
    ToolButton76:             TToolButton;
    ToolButton77:             TToolButton;
    ToolButton78:             TToolButton;
    ToolButton79:             TToolButton;
    ToolButton8:              TToolButton;
    ToolButton80:             TToolButton;
    ToolButton9:              TToolButton;
    VModuleExplorer:          TAction;
    VMoveResizeIOPanel:       TAction;
    VRenameIOPanel:           TAction;
    VShowBreakpointManager:   TAction;
    VShowBusLogger:           TAction;
    VShowHexViewer:           TAction;
    VShowIntLogger:           TAction;
    VShowIOPanel:             TAction;
    VShowRegViewer:           TAction;
    VShowRunLogger:           TAction;
    VShowScriptConsole:       TAction;
    VShowScriptEditor:        TAction;
    procedure ComboBox1Change(Sender: TObject);
    procedure CPUEventHandler(Sender: TObject; Event: TCPUEvent);
    procedure FChangeWorkDirectoryExecute(Sender: TObject);
    procedure InterruptHandler(Sender: TIOPort; AVector: Byte);
    procedure FExitExecute(Sender: TObject);
    procedure FLoadProjectExecute(Sender: TObject);
    procedure FNewProjectExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FRestartApplicationExecute(Sender: TObject);
    procedure FSaveProjectAsExecute(Sender: TObject);
    procedure FSaveProjectExecute(Sender: TObject);
    procedure FSettingsExecute(Sender: TObject);
    procedure FSwitchToInteractiveModeExecute(Sender: TObject);
    procedure FSwitchToScriptModeExecute(Sender: TObject);
    procedure HAboutExecute(Sender: TObject);
    procedure HHelpExecute(Sender: TObject);
    procedure IOAttachToBusExecute(Sender: TObject);
    procedure IOCreateExecute(Sender: TObject);
    procedure IODestroyExecute(Sender: TObject);
    procedure IODetachFromBusExecute(Sender: TObject);
    procedure IODisableExecute(Sender: TObject);
    procedure IOEnableExecute(Sender: TObject);
    procedure IOPropertiesExecute(Sender: TObject);
    procedure IOReadWriteExecute(Sender: TObject);
    procedure IOResetExecute(Sender: TObject);
    procedure MAttachToBusExecute(Sender: TObject);
    procedure MCreateExecute(Sender: TObject);
    procedure MDestroyExecute(Sender: TObject);
    procedure MDetachFromBusExecute(Sender: TObject);
    procedure MDisableExecute(Sender: TObject);
    procedure MEnableExecute(Sender: TObject);
    procedure MExamineDepositExecute(Sender: TObject);
    procedure MLoadMemoryContentExecute(Sender: TObject);
    procedure MPropertiesExecute(Sender: TObject);
    procedure MResetExecute(Sender: TObject);
    procedure MSaveMemoryContentExecute(Sender: TObject);
    procedure OMakeSnapshotExecute(Sender: TObject);
    procedure ONMIExecute(Sender: TObject);
    procedure OResetAllExecute(Sender: TObject);
    procedure ORestoreSnapshotExecute(Sender: TObject);
    procedure ORunExecute(Sender: TObject);
    procedure OStepExecute(Sender: TObject);
    procedure OStopExecute(Sender: TObject);
    procedure PAttachToBusExecute(Sender: TObject);
    procedure PCreateExecute(Sender: TObject);
    procedure PDestroyExecute(Sender: TObject);
    procedure PDetachFromBusExecute(Sender: TObject);
    procedure PDisableExecute(Sender: TObject);
    procedure PEnableExecute(Sender: TObject);
    procedure PPropertiesExecute(Sender: TObject);
    procedure PResetExecute(Sender: TObject);
    procedure SLoadScriptExecute(Sender: TObject);
    procedure SNewScriptExecute(Sender: TObject);
    procedure SRunScriptExecute(Sender: TObject);
    procedure SSaveScriptAsExecute(Sender: TObject);
    procedure SSaveScriptExecute(Sender: TObject);
    procedure SStepScriptExecute(Sender: TObject);
    procedure SStopScriptExecute(Sender: TObject);
    procedure RefreshTimerTimer(Sender: TObject);
    procedure VModuleExplorerExecute(Sender: TObject);
    procedure VRenameIOPanelExecute(Sender: TObject);
    procedure VShowBreakpointManagerExecute(Sender: TObject);
    procedure VShowBusLoggerExecute(Sender: TObject);
    procedure VShowHexViewerExecute(Sender: TObject);
    procedure VShowIntLoggerExecute(Sender: TObject);
    procedure VShowIOPanelExecute(Sender: TObject);
    procedure VShowRegViewerExecute(Sender: TObject);
    procedure VShowRunLoggerExecute(Sender: TObject);
    procedure VShowScriptConsoleExecute(Sender: TObject);
    procedure VShowScriptEditorExecute(Sender: TObject);
  private
    FSysBus:        TSysBus;                             // system bus interface
    CommandEngine1: TCommandEngine;      // system console's command interpreter
    CommandEngine2: TScriptEngine;        // script handling command interpreter
    FScriptBuffer:  TStringList;                                // script buffer
    // check if command is not allowed to run under simulation
    function ActionNotAllowedUnderCPURun(const ACommand: string): Boolean;
    // bridge between SysConsol and CommandEngine
    procedure SysConsole1CmdBridge(Sender: TObject; const ACommand: string);
    // check name duplication
    function InstanceNameDuplicated(AInstanceDict: TMemInstanceDict; AKeyName: string): Boolean; overload;
    function InstanceNameDuplicated(AInstanceDict: TPortInstanceDict; AKeyName: string): Boolean; overload;
    function InstanceNameDuplicated(AInstanceDict: TProcInstanceDict; AKeyName: string): Boolean; overload;
    // others
    function LoadProject(const AFilename: string): Boolean;      // load project
    function SaveProject(const AFilename: string): Boolean;      // save project
    procedure ChangeOpMode(AOpMode: TOpMode; AForced, ACheck: Boolean); // change opmode
    procedure DestroyAllModules(AClose: Boolean);
    procedure SetIgnoreHelp(AIgnoreHelp: Boolean);
    procedure SetPluginDirectory(APluginDirectory: string);
  protected
    FActualProject:        string;                   // actual project directory
    FActualProjectIsSaved: Boolean;                  // actual project directory
    FActualScript:         string;                         // actual script file
    FActualScriptIsSaved:  Boolean;                        // actual script file
    FAutoRunScript:        Boolean;  // auto run after loading from command line
    FConfigDirectory:      string;                  // directory of the INI file
    FEXEDirectory:         string;                // directory of the executable
    FIgnoreHelp:           Boolean;                   // ignore search help file
    FPluginDirectory:      string;                   // directory of the plugins
    FScriptIsRunning:      Boolean;                      // script running state
    FStartupProject:       string;        // project file name from command line
    FStartupScript:        string;         // script file name from command line
    FSystemLanguage:       string;                            // system language
    FUserDirectory:        string;                           // user's directory
    FWorkDirectory:        string;                           // user's directory
  public
    FOpMode:               TOpMode;                            // operation mode
    // active component instances
    FProcInstanceDict: TProcInstanceDict;
    FMemInstanceDict:  TMemInstanceDict;
    FPortInstanceDict: TPortInstanceDict;
    FBreakpointList:   TBreakpointList;                       // breakpoint list
    SysConsole1:       TSysConsole;                            // system console
    SimulationThread1: TSimulationThread;                   // simulation thread
    // action's operation metods
    // File menu
    procedure FNewProjectOperation(AActionContext: TActionContext);
    procedure FLoadProjectOperation(AActionContext: TActionContext);
    procedure FSaveProjectAsOperation(AActionContext: TActionContext);
    procedure FChangeWorkDirectoryOperation(AActionContext: TActionContext);
    procedure FRestartApplicationOperation(AActionContext: TActionContext);
    procedure FExitOperation(AActionContext: TActionContext);
    // View menu
    procedure VShowModuleExplorerOperation(AActionContext: TActionContext);
    procedure VShowBreakpointManagerOperation(AActionContext: TActionContext);
    procedure VShowBusLoggerOperation(AActionContext: TActionContext);
    procedure VShowRunLoggerOperation(AActionContext: TActionContext);
    procedure VShowIntLoggerOperation(AActionContext: TActionContext);
    procedure VShowRegViewerOperation(AActionContext: TActionContext);
    procedure VShowHexViewerOperation(AActionContext: TActionContext);
    procedure VShowScriptEditorOperation(AActionContext: TActionContext);
    procedure VShowScriptConsoleOperation(AActionContext: TActionContext);
    procedure VRenameIOPanelOperation(AActionContext: TActionContext);
    procedure VShowIOPanelOperation(AActionContext: TActionContext);
    // Processor menu
    procedure PCreateOperation(AActionContext: TActionContext);
    procedure PDestroyOperation(AActionContext: TActionContext);
    procedure PResetOperation(AActionContext: TActionContext);
    procedure PEnableOperation(AActionContext: TActionContext);
    procedure PDisableOperation(AActionContext: TActionContext);
    procedure PAttachToBusOperation(AActionContext: TActionContext);
    procedure PDetachFromBusOperation(AActionContext: TActionContext);
    procedure PPropertiesOperation(AActionContext: TActionContext);
    // Memory menu
    procedure MCreateOperation(AActionContext: TActionContext);
    procedure MDestroyOperation(AActionContext: TActionContext);
    procedure MResetOperation(AActionContext: TActionContext);
    procedure MEnableOperation(AActionContext: TActionContext);
    procedure MDisableOperation(AActionContext: TActionContext);
    procedure MAttachToBusOperation(AActionContext: TActionContext);
    procedure MDetachFromBusOperation(AActionContext: TActionContext);
    procedure MPropertiesOperation(AActionContext: TActionContext);
    procedure MLoadMemoryContentOperation(AActionContext: TActionContext);
    procedure MSaveMemoryContentOperation(AActionContext: TActionContext);
    procedure MExamineDepositOperation(AActionContext: TActionContext);
    // IO menu
    procedure IOCreateOperation(AActionContext: TActionContext);
    procedure IODestroyOperation(AActionContext: TActionContext);
    procedure IOResetOperation(AActionContext: TActionContext);
    procedure IOEnableOperation(AActionContext: TActionContext);
    procedure IODisableOperation(AActionContext: TActionContext);
    procedure IOAttachToBusOperation(AActionContext: TActionContext);
    procedure IODetachFromBusOperation(AActionContext: TActionContext);
    procedure IOPropertiesOperation(AActionContext: TActionContext);
    procedure IOReadWriteOperation(AActionContext: TActionContext);
    // Operation menu
    procedure ORunOperation(AActionContext: TActionContext);
    procedure OStepOperation(AActionContext: TActionContext);
    procedure OStopOperation(AActionContext: TActionContext);
    procedure ONMIOperation(AActionContext: TActionContext);
    procedure OResetAllOperation(AActionContext: TActionContext);
    procedure OMakeSnapshotOperation(AActionContext: TActionContext);
    procedure ORestoreSnapshotOperation(AActionContext: TActionContext);
    // Script menu
    procedure SNewScriptOperation(AActionContext: TActionContext);
    procedure SLoadScriptOperation(AActionContext: TActionContext);
    procedure SSaveScriptAsOperation(AActionContext: TActionContext);
    procedure SRunScriptOperation(AActionContext: TActionContext);
    procedure SStepScriptOperation(AActionContext: TActionContext);
    procedure SStopScriptOperation(AActionContext: TActionContext);
    // Other Operation-style methods
    procedure IOConfigureOperation(AActionContext: TActionContext);
    procedure MConfigureOperation(AActionContext: TActionContext);
    procedure PConfigureOperation(AActionContext: TActionContext);
    procedure IOMovePanelOperation(AActionContext: TActionContext);
    procedure IOResizePanelOperation(AActionContext: TActionContext);
    // other methods and properties
    procedure SetProjectMode;
    procedure SetScriptMode;
    property ActualScriptIsSaved: Boolean read FActualScriptIsSaved write FActualScriptIsSaved;
    property AutoRunScript: Boolean write FAutoRunScript;
    property IgnoreHelp: Boolean write SetIgnoreHelp;
    property PluginDirectory: string write SetPluginDirectory;
    property StartupProject: string write FStartupProject;
    property StartupScript: string write FStartupScript;
  end;
const
  CPUProperties:    array[0..1] of string =  ('Enabled',
                                              'AttachedToBus');
  IOPortProperties: array[0..12] of string = ('BaseAddress',
                                              'DataInMode',
                                              'DataInNegation',
                                              'DataOutMode',
                                              'DataOutNegation',
                                              'Enabled',
                                              'IntVector',
                                              'SelMode',
                                              'SelNegation',
                                              'PanelCaption',
                                              'PanelSize',
                                              'PanelPosition',
                                              'AttachedToBus');
  MemoryProperties: array[0..4] of string =  ('BaseAddress',
                                              'AddressRangeSize',
                                              'MemoryMode',
                                              'Enabled',
                                              'AttachedToBus');
var
  Form1:         TForm1;
//  GlobalSimLock: TCriticalSection;      // global locker for simulation thread

implementation

// Message targets:
// - MD: MsgDialog
// - SC: SysConsole
// - SM: ShowMessage

resourcestring
  MSG01 = 'ERROR: ';                                                      { SM }
  MSG02 = 'WARNING: ';                                                    { SC }
  MSG03 = 'NOTE: ';                                                       { SC }
  MSG04 = 'Plugin directory does not exist.';                             { SM }
  MSG05 = 'Cannot load plugins from %s.';                                 { SM }
  MSG06 = '%s plugins loaded.';                                           { SC }
  MSG07 = 'New, empty project has been created.';                         { SC }
  MSG08 = 'New, empty script has been created.';                          { SC }
  MSG09 = 'Cannot destroy attached module named ''%s''.';                 { SM }
  MSG10 = 'Cannot be used ''%s'' in interactive mode.';                   { SC }
  MSG11 = 'Cannot be used ''%s'' in script mode.';                        { SC }
  MSG12 = 'Command ''%s'' execute error.';                                { SC }
  MSG13 = 'No continuous viewer updates during a 100 ms execution delay.';{ SC }
  MSG18 = 'Missing help file.';                                           { SC }
  MSG19 = 'Missing help viewer.';                                         { SC }
  MSG28 = 'Save memory content to file';
  MSG29 = 'Cannot save memory content to ''%s'' binary file.';            { SM }
  MSG30 = 'Load memory content from file';
  MSG31 = 'Cannot load memory content from ''%s'' binary file.';          { SM }
  MSG32 = 'Binary file|*.bin|Intel hexa file|*.hex|All file|*.*';
  MSG35 = 'Cannot load memory content from ''%s'' Intel hexa file.';      { SM }
  MSG36 = 'Cannot save memory content to ''%s'' Intel hexa file.';        { SM }
  MSG37 = 'Data converting error.';                                       { SM }
  MSG38 = 'Checksum error.';                                              { SM }
  MSG39 = 'Unexpected error.';                                            { SM }
  MSG40 = 'Cannot load ''%s'' configuration file, using default values.'; { SC }
  MSG41 = 'Cannot save ''%s'' configuration file.';                       { SM }
  MSG42 = 'No script, create or load one.';                               { SM }
  MSG43 = 'Confirmation';
  MSG44 = 'There is already a script, do you want to delete it?';         { MD }
  MSG45 = 'CoreLAB scriptembly file|*.clsce|All file|*.*';
  MSG46 = 'Load script';
  MSG47 = 'Save script';
  MSG48 = 'Cannot load script from ''%s'' file.';                         { SM }
  MSG49 = 'Cannot save script to ''%s'' file.';                           { SM }
  MSG50 = 'The script is unsaved, should I continue?';                    { MD }
  MSG51 = 'There is already a project, do you want to delete it?';        { MD }
  MSG52 = 'CoreLAB project file|*.clprj|All file|*.*';
  MSG53 = 'Load project';
  MSG54 = 'Save project';
  MSG55 = 'Cannot load project from ''%s'' file.';                        { SM }
  MSG56 = 'Cannot save project to ''%s'' file.';                          { SM }
  MSG57 = 'The project is unsaved, should I continue?';                   { MD }
  MSG58 = 'The %s module named ''%s'' was successfully created.';         { SC }
  MSG59 = '&Destroy';
  MSG60 = 'The module named ''%s'' was successfully destroyed.';          { SC }
  MSG61 = '&Reset';
  MSG62 = 'The module named ''%s'' has been reseted.';                    { SC }
  MSG63 = '&Enable';
  MSG64 = 'The module named ''%s'' has been enabled.';                    { SC }
  MSG65 = '&Disable';
  MSG66 = 'The module named ''%s'' has been disabled.';                   { SC }
  MSG67 = '&Attach to the bus';
  MSG68 = 'The module named ''%s'' has been attached to the bus.';        { SC }
  MSG69 = '&Detach from the bus';
  MSG70 = 'The module named ''%s'' has been detached from the bus.';      { SC }
  MSG71 = 'Edit properties';
  MSG72 = '&Load content';
  MSG73 = 'Data loaded from ''%s'' into the module named ''%s''.';        { SC }
  MSG74 = '&Save content';
  MSG75 = 'Data saved from the module named ''%s'' to ''%s''.';           { SC }
  MSG76 = '&Rename panel';
  MSG77 = '&Move/resize panel';
  MSG78 = '&Show panel';
  MSG79 = '&Show';
  MSG80 = 'Project loaded from ''%s''.';                                  { SC }
  MSG81 = 'Project saved to ''%s''.';                                     { SC }
  MSG82 = 'Script loaded from ''%s''.';                                   { SC }
  MSG83 = 'Script saved to ''%s''.';                                      { SC }
  MSG84 = 'Cannot create backup file.';                                   { SC }
  MSG85 = 'Module named ''%s'' exists.';                                  { SM }
  MSG86 = 'Unknown command: ''%s''.';                                     { SC }
  MSG87 = 'Invalid number of ''%s'' arguments.';                          { SC }
  MSG88 = 'Cannot be used ''%s'' in command line.';                       { SC }
  MSG89 = 'Cannot be used ''%s'' in script.';                             { SC }
  MSG90 = 'Cannot create %s module named ''%s''.';                        { SM }
  MSG91 = 'Cannot view module content named ''%s''.';                     { SM }
  MSG92 = 'Cannot rename module named ''%s''.';                           { SM }
  MSG93 = 'Cannot show module named ''%s''.';                             { SM }
  MSG94 = 'Cannot destroy module named ''%s''.';                          { SM }
  MSG95 = 'Cannot reset module named ''%s''.';                            { SM }
  MSG96 = 'Cannot enable module named ''%s''.';                           { SM }
  MSG97 = 'Cannot disable module named ''%s''.';                          { SM }
  MSG98 = 'Cannot attach module named ''%s'' to bus.';                    { SM }
  MSG99 = 'Cannot detach module named ''%s'' from bus.';                  { SM }
  MSG100 = 'Cannot use it in this operation mode.';                       { SC }
  MSG101 = 'Module named ''%s'' not exists.';                             { SM }
  MSG102 = 'Property ''%s'' is read only or not exists.';                 { SM }
  MSG103 = 'Value ''%s'' is bad.';                                        { SM }
  MSG104 = 'Property ''%s'' set to value ''%s''.';                        { SC }
  MSG105 = 'Module named ''%s'' has been already attached.';              { SM }
  MSG106 = 'Module named ''%s'' has been already detached.';              { SM }
  MSG107 = 'Only one CPU connection is allowed.';                         { SM }
  MSG108 = 'Select new work directory';                                   { SC }
  MSG109 = 'Work directory is set to ''%s''.';                            { SC }
  MSG110 = 'none';
  MSG111 = 'Success';
  MSG112 = 'Unsuccess';
  MSG113 = 'Command ''%S'' is not available while simulation is running.';{ SC }
  MSG114 = 'All attached modules have been reseted.';                     { SC }
  MSG115 = 'Run simulation.';                                             { SC }
  MSG116 = 'Step simulation.';                                            { SC }
  MSG117 = 'Stop simulation.';                                            { SC }
  MSG118 = 'Non-maskable interrupt requested.';                           { SC }

  {$R *.lfm}

{ TSysBus }

// ---- PUBLIC METHODS ----

// ATTACH CPU TO SYSTEM BUS
function TSysBus.AttachCPU(const AModuleName: string; ACPU: TCPU): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if (AModuleName = '') or not Assigned(ACPU) then Exit;
  // one CPU is allowed
  Result := 3;
  if Length(FCPUs) >= 1 then Exit;
  // already is attached?
  Result := 2;
  for i := 0 to High(FCPUs) do
    if FCPUs[i].ModuleName = AModuleName then Exit;
  // create entry
  SetLength(FCPUs, Length(FCPUs) + 1);
  with FCPUs[High(FCPUs)] do
  begin
    ModuleName := AModuleName;
    CPU := ACPU;
  end;
  Result := 0;
end;

// ATTACH MEMORY TO SYSTEM BUS
function TSysBus.AttachMemory(const AModuleName: string; AMemory: TMemory; ABaseAddress, AAddressRange: DWord): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if (AModuleName = '') or not Assigned(AMemory) then Exit;
  // already is attached?
  Result := 2;
  for i := 0 to High(FMemories) do
    if FMemories[i].ModuleName = AModuleName then Exit;
  // create entry
  SetLength(FMemories, Length(FMemories) + 1);
  with FMemories[High(FMemories)] do
  begin
    ModuleName := AModuleName;
    Memory := AMemory;
  end;
  Result := 0;
end;

// ATTACH I/O PORT TO SYSTEM BUS
function TSysBus.AttachIOPort(const AModuleName: string; AIOPort: TIOPort; ABaseAddress, AAddressRange: DWord): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if (AModuleName = '') or not Assigned(AIOPort) then Exit;
  // already is attached?
  Result := 2;
  for i := 0 to High(FIOPorts) do
    if FIOPorts[i].ModuleName = AModuleName then Exit;
  // create entry
  SetLength(FIOPorts, Length(FIOPorts) + 1);
  with FIOPorts[High(FIOPorts)] do
  begin
    ModuleName := AModuleName;
    IOPort := AIOPort;
  end;
  Result := 0;
end;

// DETACH CPU FROM SYSTEM BUS
function TSysBus.DetachCPU(const AModuleName: string): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if AModuleName = '' then Exit;
  // already is detached?
  Result := 2;
  for i := 0 to High(FCPUs) do
    if FCPUs[i].ModuleName = AModuleName then
    begin
      // remove entry
      if i < High(FCPUs) then FCPUs[i] := FCPUs[High(FCPUs)];
      SetLength(FCPUs, Length(FCPUs) - 1);
      Result := 0;
      Exit;
    end;
end;

// DETACH MEMORY FROM SYSTEM BUS
function TSysBus.DetachMemory(const AModuleName: string): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if AModuleName = '' then Exit;
  // already is detached?
  Result := 2;
  for i := 0 to High(FMemories) do
    if FMemories[i].ModuleName = AModuleName then
    begin
      // remove entry
      if i < High(FMemories) then FMemories[i] := FMemories[High(FMemories)];
      SetLength(FMemories, Length(FMemories) - 1);
      Result := 0;
      Exit;
    end;
end;

// DETACH I/O PORT FROM SYSTEM BUS
function TSysBus.DetachIOPort(const AModuleName: string): Byte;
var
  i: Integer;
begin
  // module name is valid?
  Result := 1;
  if AModuleName = '' then Exit;
  // already detached?
  Result := 2;
  for i := 0 to High(FIOPorts) do
    if FIOPorts[i].ModuleName = AModuleName then
    begin
      // remove entry
      if i < High(FIOPorts) then FIOPorts[i] := FIOPorts[High(FIOPorts)];
      SetLength(FIOPorts, Length(FIOPorts) - 1);
      Result := 0;
      Exit;
    end;
end;

// READ MEMORY
function TSysBus.ReadMemory(AAddress: DWord): Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  Result := 0;
  with BusLogRec do
  begin
    Operation := 'MEMRD';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(AAddress, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    Data := MSG110;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      if Enabled and
       (AAddress >= BaseAddress) and
       (AAddress < BaseAddress + AddressRangeSize) then
      begin
        // operation
        Result := ReadMemory(AAddress - BaseAddress);
        with BusLogRec do
        begin
          Device := FMemories[i].ModuleName;
          FormatHexValue(IntToHex(AAddress - FMemories[i].Memory.BaseAddress, 6), 6, s);
          RelAddress := s;
          FormatHexValue(IntToHex(Result, 2), 2, s);
          Data := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE MEMORY
procedure TSysBus.WriteMemory(AAddress: DWord; AValue: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'MEMWR';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(AAddress, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    FormatHexValue(IntToHex(AValue, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FMemories) do
    with FMemories[i].Memory do
      if Enabled and
       (AAddress >= BaseAddress) and
       (AAddress < BaseAddress + AddressRangeSize) then
      begin
        WriteMemory(AAddress - BaseAddress, AValue);
        with BusLogRec do
        begin
          Device := FMemories[i].ModuleName;
          FormatHexValue(IntToHex(AAddress - FMemories[i].Memory.BaseAddress, 6), 6, s);
          RelAddress := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// READ I/O PORT
function TSysBus.ReadPort(APort: DWord): Byte;
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  Result := 0;
  with BusLogRec do
  begin
    Operation := 'IORD';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(APort, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    Data := MSG110;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FIOPorts) do
    with FIOPorts[i].IOPort do
      if Enabled and
       (APort >= BaseAddress) and
       (APort < BaseAddress + AddressRangeSize) then
      begin
        Result := ReadPort(APort - BaseAddress);
        with BusLogRec do
        begin
          Device := FIOPorts[i].ModuleName;
          FormatHexValue(IntToHex(APort - FIOPorts[i].IOPort.BaseAddress, 6), 6, s);
          RelAddress := s;
          FormatHexValue(IntToHex(Result, 2), 2, s);
          Data := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

// WRITE I/O PORT
procedure TSysBus.WritePort(APort: DWord; AValue: Byte);
var
  BusLogRec: TBusLogRec;
  i:         Integer;
  s:         string;
begin
  s := '';
  // default output values
  with BusLogRec do
  begin
    Operation := 'IOWR';
    Device := MSG110;                                                 { 'none' }
    FormatHexValue(IntToHex(APort, 6), 6, s);
    Address := s;
    RelAddress := MSG110;
    FormatHexValue(IntToHex(AValue, 2), 2, s);
    Data := s;
    Status := MSG112;                                            { 'Unsuccess' }
  end;
  // check address-conflict
  for i := 0 to High(FIOPorts) do
    with FIOPorts[i].IOPort do
      if Enabled and
       (APort >= BaseAddress) and
       (APort < BaseAddress + AddressRangeSize) then
      begin
        WritePort(APort - BaseAddress, AValue);
        with BusLogRec do
        begin
          Device := FIOPorts[i].ModuleName;
          FormatHexValue(IntToHex(APort - FIOPorts[i].IOPort.BaseAddress, 6), 6, s);
          RelAddress := s;
          Status := MSG111;                                        { 'Success' }
        end;
        Break;
      end;
  if Assigned(Form14) then Form14.AppendRecord(BusLogrec);
end;

{ TForm1 }

// ---- PRIVATE METHODS ----

// CHECK IF COMMAND IS NOT ALLOWED TO RUN UNDER SIMULATION
function TForm1.ActionNotAllowedUnderCPURun(const ACommand: string): Boolean;
begin
  Result := (SimulationThread1.Mode = smCPURun) and
            not CommandEngine1.Registry.FindCommand(ACommand).AllowedUnderCPURun;

  if Result then
    SysConsole1.WriteMessage(MSG02 + Format(MSG113, [ACommand]));
end;

// BRIDGE BETWEEN SYSCONSOL AND COMMANDENGINE
procedure TForm1.SysConsole1CmdBridge(Sender: TObject; const ACommand: string);
begin
  case CommandEngine1.ExecuteLine(ACommand) of
    -1: SysConsole1.WriteMessage(MSG01 + Format(MSG86, [ACommand]));
    -2: SysConsole1.WriteMessage(MSG01 + Format(MSG88, [ACommand]));
    -3: SysConsole1.WriteMessage(MSG01 + Format(MSG89, [ACommand]));
    -4: SysConsole1.WriteMessage(MSG01 + Format(MSG87, [ACommand]));
    -5: SysConsole1.WriteMessage(MSG02 + Format(MSG113, [ACommand]));
    -6: SysConsole1.WriteMessage(MSG01 + Format(MSG10, [ACommand]));
    -7: SysConsole1.WriteMessage(MSG01 + Format(MSG11, [ACommand]));
    -8: SysConsole1.WriteMessage(MSG01 + Format(MSG12, [ACommand]));
  end
end;

// CHECK NAME DUPLICATION
function TForm1.InstanceNameDuplicated(AInstanceDict: TMemInstanceDict; AKeyName: string): Boolean; overload;
var
  KeyName: string;
begin
  Result := False;
  for KeyName in AInstanceDict.Keys do
    if KeyName = AKeyName then Result := True;
end;

function TForm1.InstanceNameDuplicated(AInstanceDict: TPortInstanceDict; AKeyName: string): Boolean; overload;
var
  KeyName: string;
begin
  Result := False;
  for KeyName in AInstanceDict.Keys do
    if KeyName = AKeyName then Result := True;
end;

function TForm1.InstanceNameDuplicated(AInstanceDict: TProcInstanceDict; AKeyName: string): Boolean; overload;
var
  KeyName: string;
begin
  Result := False;
  for KeyName in AInstanceDict.Keys do
    if KeyName = AKeyName then Result := True;
end;

// LOAD PROJECT FROM FILE
function TForm1.LoadProject(const AFilename: string): Boolean;   // load project
var
  ActionContext:    TActionContext;
  FileVersion:      string;
  i, j:             Integer;
  InstanceName:     string;
  ModulesNode:      TDOMNode;
  Node, ChildNode:  TDOMNode;
  NodeList:         TDOMNodeList;
  ProjectFile:      TXMLDocument;
  WorkspaceNode:    TDOMNode;
begin
  Result := False;
  try
    ReadXMLFile(ProjectFile, AFilename);
  except
    Exit;
  end;
  ActionContext := TActionContext.Create;
  try
    ActionContext.ActionSource := asProject;
    // <Workspace>
    WorkspaceNode := ProjectFile.FindNode('CoreLAB_Workspace');
    if Assigned(WorkspaceNode) then
    begin
      // get project file version
      FileVersion := string(TDOMElement(WorkspaceNode).GetAttribute('version'));
      // <Modules>
      ModulesNode := WorkspaceNode.FindNode('Modules');
      if Assigned(ModulesNode) then
      begin
        // <TCPU>
        NodeList := TDOMElement(ModulesNode).GetElementsByTagName('TCPU');
        if Assigned(NodeList) then
        begin
          for i := 0 to NodeList.Count - 1 do
          begin
            Node := NodeList.Item[i];
            {
              <TCPU id="Processor" type="cpu_8080">
                <Enabled>true</Enabled>
                <AttachedToBus>true</AttachedToBus>
              </TCPU>
            }
            // create instance
            InstanceName := string(TDOMElement(Node).GetAttribute('id'));
            ActionContext.SArg1 := string(TDOMElement(Node).GetAttribute('type'));
            ActionContext.SArg2 := InstanceName;
            PCreateOperation(ActionContext);
            // if instance has created
            if not ActionContext.HasError then
            begin
            // set properties
              for j := 0 to Length(CPUProperties) - 1 do
              begin
                ActionContext.SArg1 := InstanceName + '.' + CPUProperties[j];
                ChildNode := Node.FindNode(DOMString(CPUProperties[j]));
                if Assigned(ChildNode) and Assigned(ChildNode.FirstChild) then
                begin
                  ActionContext.SArg2 := string(ChildNode.FirstChild.NodeValue);
                  case j of
                    1: PAttachToBusOperation(ActionContext);
                  else
                    PConfigureOperation(ActionContext);
                  end;
                  if ActionContext.HasError then Break;
                end;
              end;
            end;
          end;
          NodeList.Free;
        end;
        // <TIOPort>
        NodeList := TDOMElement(ModulesNode).GetElementsByTagName('TIOPort');
        if Assigned(NodeList) then
        begin
          for i := 0 to NodeList.Count - 1 do
          begin
            Node := NodeList.Item[i];
            {
              <TIOPort id="Keyboard" type="ioport_button16bcd">
                <BaseAddress>81</BaseAddress>
                <DataInMode>lmBCD</DataInMode>
                <DataInNegation>false</DataInNegation>
                <DataOutMode>lmBCD</DataOutMode>
                <DataOutNegation>false</DataOutNegation>
                <Enabled>true</Enabled>
                <IntVector>CF</IntVector>
                <SelMode>lmBCD</SelMode>
                <SelNegation>false</SelNegation>
                <PanelCaption>Display</PanelCaption>
                <PanelPosition>100-300</PanelPosition>
                <AttachedToBus>true</AttachedToBus>
              </TIOPort>
            }
            // create instance
            InstanceName := string(TDOMElement(Node).GetAttribute('id'));
            ActionContext.SArg1 := string(TDOMElement(Node).GetAttribute('type'));
            ActionContext.SArg2 := InstanceName;
            IOCreateOperation(ActionContext);
            // if instance has created
            if not ActionContext.HasError then
            begin
            // set properties
              for j := 0 to Length(IOPortProperties) - 1 do
              begin
                case j of
                  9: ActionContext.SArg1 := InstanceName;
                  10: ActionContext.SArg1 := InstanceName;
                  11: ActionContext.SArg1 := InstanceName;
                else
                  ActionContext.SArg1 := InstanceName + '.' + IOPortProperties[j];
                end;
                ChildNode := Node.FindNode(DOMString(IOPortProperties[j]));
                if Assigned(ChildNode) and Assigned(ChildNode.FirstChild) then
                begin
                  ActionContext.SArg2 := string(ChildNode.FirstChild.NodeValue);
                  case j of
                    9: VRenameIOPanelOperation(ActionContext);
                    10: IOMovePanelOperation(ActionContext);
                    11: IOResizePanelOperation(ActionContext);
                    12: IOAttachToBusOperation(ActionContext);
                  else
                    IOConfigureOperation(ActionContext);
                  end;
                  if ActionContext.HasError then Break;
                end;
              end;
            end;
          end;
          NodeList.Free;
        end;
        // <TMemory>
        NodeList := TDOMElement(ModulesNode).GetElementsByTagName('TMemory');
        if Assigned(NodeList) then
        begin
          for i := 0 to NodeList.Count - 1 do
          begin
            Node := NodeList.Item[i];
            {
              <TMemory id="RAM" type="memory_standard">
                <AddressRangeSize>1024</AddressRangeSize>
                <BaseAddress>0</BaseAddress>
                <Enabled>true</Enabled>
                <MemoryMode>mmRAM</MemoryMode>
                <AttachedToBus>true</AttachedToBus>
              </TMemory>
            }
            // create instance
            InstanceName := string(TDOMElement(Node).GetAttribute('id'));
            ActionContext.SArg1 := string(TDOMElement(Node).GetAttribute('type'));
            ActionContext.SArg2 := InstanceName;
            MCreateOperation(ActionContext);
            // if instance has created
            if not ActionContext.HasError then
            begin
              // set properties
              for j := 0 to Length(MemoryProperties) - 1 do
              begin
                ActionContext.SArg1 := InstanceName + '.' + MemoryProperties[j];
                ChildNode := Node.FindNode(DOMString(MemoryProperties[j]));
                if Assigned(ChildNode) and Assigned(ChildNode.FirstChild) then
                begin
                  ActionContext.SArg2 := string(ChildNode.FirstChild.NodeValue);
                  case j of
                    4: MAttachToBusOperation(ActionContext);
                  else
                    MConfigureOperation(ActionContext);
                  end;
                  if ActionContext.HasError then Break;
                end;
              end;
            end;
          end;
          NodeList.Free;
        end;
      end;
    end;
  finally
    ActionContext.Free;
    ProjectFile.Free;
  end;
  Result := True;
end;

// SAVE PROJECT TO FILE
function TForm1.SaveProject(const AFilename: string): Boolean;   // save project
const
  FileVersion = '1.0';
var
  MemInfo:       TMemInfo;
  PortInfo:      TPortInfo;
  ProcInfo:      TProcInfo;
  KeyName:       string;
  ModulesNode:   TDOMElement;
  ProjectFile:   TXMLDocument;
  WorkspaceNode: TDOMElement;
  Node:          TDOMElement;

  procedure AppendChildElement(Parent: TDOMNode; const TagName, Value: string);
  var
    Element: TDOMElement;
  begin
    Element := ProjectFile.CreateElement(DOMString(TagName));
    Element.AppendChild(ProjectFile.CreateTextNode(DOMString(Value)));
    Parent.AppendChild(Element);
  end;

begin
  Result := False;
  ProjectFile := TXMLDocument.Create;
  try
    WorkspaceNode := ProjectFile.CreateElement('CoreLAB_Workspace');
    WorkspaceNode.SetAttribute('version', FileVersion);
    ProjectFile.AppendChild(WorkspaceNode);
    // <Modules>
    ModulesNode := ProjectFile.CreateElement('Modules');
    WorkspaceNode.AppendChild(ModulesNode);
    // <TCPU>
    for KeyName in FProcInstanceDict.Keys do
    begin
      Node := ProjectFile.CreateElement('TCPU');
      ProcInfo := FProcInstanceDict[KeyName];
      Node.SetAttribute('id', DOMString(KeyName));
      Node.SetAttribute('type', DOMString(ProcInfo.ModuleName));
      AppendChildElement(Node, CPUProperties[0], BoolToStr(ProcInfo.Processor.Enabled, 'true', 'false'));
      AppendChildElement(Node, CPUProperties[1], BoolToStr(ProcInfo.AttachedToBus, 'true', 'false'));
      ModulesNode.AppendChild(Node);
    end;
    // <TIOPort>
    for KeyName in FPortInstanceDict.Keys do
    begin
      Node := ProjectFile.CreateElement('TIOPort');
      PortInfo := FPortInstanceDict[KeyName];
      Node.SetAttribute('id', DOMString(KeyName));
      Node.SetAttribute('type', DOMString(PortInfo.ModuleName));
      AppendChildElement(Node, IOPortProperties[0], IntToHex(PortInfo.Port.BaseAddress));
      AppendChildElement(Node, IOPortProperties[1], PortInfo.Port.DataInMode.ToString);
      AppendChildElement(Node, IOPortProperties[2], BoolToStr(PortInfo.Port.DataInNegation, 'true', 'false'));
      AppendChildElement(Node, IOPortProperties[3], PortInfo.Port.DataOutMode.ToString);
      AppendChildElement(Node, IOPortProperties[4], BoolToStr(PortInfo.Port.DataOutNegation, 'true', 'false'));
      AppendChildElement(Node, IOPortProperties[5], BoolToStr(PortInfo.Port.Enabled, 'true', 'false'));
      AppendChildElement(Node, IOPortProperties[6], IntToHex(PortInfo.Port.IntVector));
      AppendChildElement(Node, IOPortProperties[7], PortInfo.Port.SelMode.ToString);
      AppendChildElement(Node, IOPortProperties[8], BoolToStr(PortInfo.Port.SelNegation, 'true', 'false'));
      if PortInfo.Port.HasPanel then
      begin
//        'PanelCaption', 'PanelSize', 'PanelPosition',

//        AppendChildElement(Node, IOPortProperties[9], PortInfo.Port
//        AppendChildElement(Node, IOPortProperties[10], IntToStr(PortInfo.Port.
//        AppendChildElement(Node, IOPortProperties[11], IntToStr(PortInfo.Port.
      end;
      AppendChildElement(Node, IOPortProperties[12], BoolToStr(PortInfo.AttachedToBus, 'true', 'false'));
      ModulesNode.AppendChild(Node);
    end;
    // <TMemory>
    for KeyName in FMemInstanceDict.Keys do
    begin
      Node := ProjectFile.CreateElement('TMemory');
      MemInfo := FMemInstanceDict[KeyName];
      Node.SetAttribute('id', DOMString(KeyName));
      Node.SetAttribute('type', DOMString(MemInfo.ModuleName));
      AppendChildElement(Node, MemoryProperties[0], IntToHex(MemInfo.Memory.BaseAddress));
      AppendChildElement(Node, MemoryProperties[1], IntToStr(MemInfo.Memory.AddressRangeSize));
      AppendChildElement(Node, MemoryProperties[2], MemInfo.Memory.MemoryMode.ToString);
      AppendChildElement(Node, MemoryProperties[3], BoolToStr(MemInfo.Memory.Enabled, 'true', 'false'));
      AppendChildElement(Node, MemoryProperties[4], BoolToStr(MemInfo.AttachedToBus, 'true', 'false'));
      ModulesNode.AppendChild(Node);
    end;
    // write to file
    try
      WriteXMLFile(ProjectFile, AFileName);
    except
      Exit;
    end;
  finally
    ProjectFile.Free;
  end;
  Result := True;
end;

// CHANGE OPERATION MODE
procedure TForm1.ChangeOpMode(AOpMode: TOpMode; AForced, ACheck: Boolean);
var
  i: integer;
begin
  // forced change
  if (FOpMode = AOpMode) and (not AForced) then Exit;
  // change
  if ACheck then
  begin
    // check actual project or script status
    if FOpMode = omInteractive then
    begin
      if not FActualProjectIsSaved then
        if MessageDlg(MSG43, MSG57, mtConfirmation, [mbYes, mbNo], 0) = mrNo
          then Exit;
    end else
    begin
      if not FActualScriptIsSaved then
        if MessageDlg(MSG43, MSG50, mtConfirmation, [mbYes, mbNo], 0) = mrNo
          then Exit;
    end;
  end;
  // stop running script or simulation
  if FOpMode <> omInteractive
    then SStopScriptExecute(Nil)
    else OStopExecute(Nil);
  FOpMode := AOpMode;
  // enable/disable MenuItems and ToolBars for required OpMode
  if FOpMode = omInteractive then
  begin
    // interactive mode
    MenuItem3.Enabled := True;
    MenuItem4.Enabled := True;
    MenuItem5.Enabled := True;
    MenuItem6.Enabled := True;
    MenuItem7.Enabled := False;
    MenuItem37.Enabled := True;
    MenuItem38.Enabled := True;
    MenuItem39.Enabled := True;
    MenuItem40.Enabled := True;
    MenuItem51.Enabled := False;
    MenuItem52.Enabled := False;
    MenuItem55.Enabled := True;
    ToolBar2.Enabled := True;
    ToolBar3.Enabled := True;
    ToolBar4.Enabled := True;
    ToolBar5.Enabled := True;
    ToolBar6.Enabled := False;
    ToolButton29.Enabled := True;
    ToolButton64.Enabled := False;
    ToolButton65.Enabled := False;
  end else
  begin
    // script mode
    MenuItem3.Enabled := False;
    MenuItem4.Enabled := False;
    MenuItem5.Enabled := False;
    MenuItem6.Enabled := False;
    MenuItem7.Enabled := True;
    MenuItem37.Enabled := False;
    MenuItem38.Enabled := False;
    MenuItem39.Enabled := False;
    MenuItem40.Enabled := False;
    MenuItem51.Enabled := True;
    MenuItem52.Enabled := True;
    MenuItem55.Enabled := False;
    ToolBar2.Enabled := False;
    ToolBar3.Enabled := False;
    ToolBar4.Enabled := False;
    ToolBar5.Enabled := False;
    ToolBar6.Enabled := True;
    ToolButton29.Enabled := False;
    ToolButton64.Enabled := True;
    ToolButton65.Enabled := True;
  end;
  // restore mainform caption
  Form1.Caption := Application.Title;
  // set new project value
  FActualProject := '';
  FActualProjectIsSaved := False;
  FActualScript := '';
  FActualScriptIsSaved := False;
  // remove all attached components from system bus
  SetLength(FSysBus.FIOPorts, 0);
  SetLength(FSysBus.FMemories, 0);
  SetLength(FSysBus.FCPUs, 0);
  // clear active component instances
  DestroyAllModules(False);
  // clear instance dictionaries
  FProcInstanceDict.Clear;
  FMemInstanceDict.Clear;
  FPortInstanceDict.Clear;
  // clear script buffer and refresh ScriptEditor;
  FScriptBuffer.Clear;
  // set script counter
  CommandEngine2.FScriptRuntime.SetRegister('C', 0, True);
  // clear content of the internal modules
  if Assigned(Form3) then Form3.Invalidate;                         // HexViewer
  if Assigned(Form4) then Form4.ClearContent;                       // RunLogger
  if Assigned(Form6) then Form6.CopyBufferToEditor;              // ScriptEditor
  if Assigned(Form8) then Form8.ClearContent;                       // IntLogger
  if Assigned(Form12) then Form12.ClearContent;                 // ScriptConsole
  if Assigned(Form14) then Form14.ClearContent;                     // BusLogger
  // close internal modules
  for i := Screen.FormCount - 1 downto 0 do
    if (Screen.Forms[i] <> Application.MainForm) and
        Screen.Forms[i].Visible then Screen.Forms[i].Close;
  CommandEngine1.OpMode := FOpMode;
  // write message to console
  if FOpMode = omInteractive
    then SysConsole1.WriteMessage(MSG07)
    else SysConsole1.WriteMessage(MSG08);
end;

// DESTROY ALL MODULE (AND DICTIONARIES)
procedure TForm1.DestroyAllModules(AClose: Boolean);
var
  KeyName:  string;
  PortInfo: TPortInfo;
  ProcInfo: TProcInfo;
  MemInfo:  TMemInfo;
begin
  // destroy I/O port modules and theirs dictionary
  if Assigned(FPortInstanceDict) then
  begin
    for KeyName in FPortInstanceDict.Keys do
    begin
      PortInfo := FPortInstanceDict[KeyName];
      // destroy panel
      if PortInfo.Port.HasPanel then FPortPluginDict[PortInfo.ModuleName].FFreePanel(PortInfo.Port);
      // destroy module
      FPortPluginDict[PortInfo.ModuleName].FDestroy(PortInfo.Port);
      // remove from dict
      // FPortInstanceDict.Remove(KeyName);
      // remove from Module Explorer
      if not AClose then Form9.DeleteNode('I/O port & device', KeyName);
    end;
    if AClose then FPortInstanceDict.Free;
  end;
  // destroy processor modules and theirs dictionary
  if Assigned(FProcInstanceDict) then
  begin
    for KeyName in FProcInstanceDict.Keys do
    begin
      ProcInfo := FProcInstanceDict[KeyName];
      // destroy module
      FProcPluginDict[ProcInfo.ModuleName].FDestroy(ProcInfo.Processor);
      // remove from dict
      // FProcInstanceDict.Remove(KeyName);
      // remove from Module Explorer
      if not AClose then Form9.DeleteNode('Processor', KeyName);
    end;
    if AClose then FProcInstanceDict.Free;
  end;
  // destroy memory modules and theirs dictionary
  if Assigned(FMemInstanceDict) then
  begin
    for KeyName in FMemInstanceDict.Keys do
    begin
      MemInfo := FMemInstanceDict[KeyName];
      // destroy module
      FMemPluginDict[MemInfo.ModuleName].FDestroy(MemInfo.Memory);
      // remove from dict
      // FMemInstanceDict.Remove(KeyName);
      // remove from Module Explorer
      if not AClose then Form9.DeleteNode('Memory', KeyName);
    end;
    if AClose then FMemInstanceDict.Free;
  end;
end;

// SET HELP SYSTEM
procedure TForm1.SetIgnoreHelp(AIgnoreHelp: Boolean);
var
  CHMFile, CHMViewer:             string;
  CHMFileExists, CHMViewerExists: Boolean;
begin
  FIgnoreHelp := AIgnoreHelp;
  if not FIgnoreHelp then
  begin
  // search help file
  {$IFDEF UNIX}
    CHMFile := FileSearch('corelab_' + FSystemLanguage + '.chm',
      './:./help/:/usr/share/corelab/help/:/usr/local/share/corelab/help/');
    if Length(CHMFile) = 0 then
      CHMFile := FileSearch('corelab_en.chm',
        './:./help/:/usr/share/corelab/help/:/usr/local/share/corelab/help/');
  {$ELSE}
    CHMFile := FileSearch('corelab_' + FSystemLanguage + '.chm','.\;.\help\');
    if Length(CHMFile) = 0 then
      CHMFile := FileSearch('corelab_en.chm','.\;.\help\');
  {$ENDIF}
  // - search LHelp application
  {$IFDEF UNIX}
    CHMViewer := FileSearch('lhelp', GetEnvironmentVariable('PATH'));
  {$ELSE}
    CHMViewer := FileSearch('lhelp.exe', GetEnvironmentVariable('PATH'));
  {$ENDIF}
    CHMFileExists := FileExists(CHMFile);
    CHMViewerExists := FileExists(CHMViewer);
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
      if not CHMFileExists then SysConsole1.WriteMessage(MSG02 + MSG18);
      if not CHMViewerExists then SysConsole1.WriteMessage(MSG02 + MSG19);
    end;
  end;
  HHelp.Enabled := CHMFileExists and CHMViewerExists and not FIgnoreHelp;
end;

// SET PLUGIN DIRECTORY
procedure TForm1.SetPluginDirectory(APluginDirectory: string);
begin
  FPluginDirectory := APluginDirectory;
end;

// ---- PUBLIC METHODS ----

// SET PROJECT MODE AT STARTUP
procedure TForm1.SetProjectMode;
var
  Message: string;
begin
  ChangeOpMode(omInteractive, False, False);
  if Length(FStartupProject) > 0 then
    if LoadProject(FStartupProject)
      then SysConsole1.WriteMessage(Format(MSG80, [FStartupProject])) else
      begin
        Message := MSG01 + Format(MSG55, [FStartupProject]);
        ShowMessage(Message);
        SysConsole1.WriteMessage(Message);
      end;
end;

// SET SCRIPT MODE AT STARTUP
procedure TForm1.SetScriptMode;
var
  Message: string;
begin
  ChangeOpMode(omScript, False, False);
  if Length(FStartupScript) > 0 then
  begin
    try
      FScriptBuffer.LoadFromFile(FStartupScript);
      SysConsole1.WriteMessage(Format(MSG82, [FStartupScript]));
    except
      Message := MSG01 + Format(MSG48, [FStartupScript]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      Exit;
    end;
    FActualScript := FStartupScript;
    FActualScriptIsSaved := True;                             // no need to save
    Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualScript);
    Form6.SetFilename(FActualScript);
    if FAutoRunScript
      then SRunScriptExecute(nil)
      else VShowScriptEditorExecute(nil);
  end;
end;

// ---- ACTION HANDLER METHODS ----

// FILE/SWITCH TO INTERACTIVE MODE ACTION ======================================
procedure TForm1.FSwitchToInteractiveModeExecute(Sender: TObject);
begin
  if ActionNotAllowedUnderCPURun('NWPR') then Exit;
  ChangeOpMode(omInteractive, False, True);
end;

// FILE/SWITCH TO SCRIPT MODE ACTION -------------------------------------------
procedure TForm1.FSwitchToScriptModeExecute(Sender: TObject);
begin
  if ActionNotAllowedUnderCPURun('NWSC') then Exit;
  ChangeOpMode(omScript, False, True);
end;

// FILE/CREATE NEW PROJECT ACTION ----------------------------------------------
procedure TForm1.FNewProjectExecute(Sender: TObject);
begin
  if ActionNotAllowedUnderCPURun('NWPR') then Exit;
  ChangeOpMode(omInteractive, True, True)
end;

// FILE/CREATE NEW PROJECT OPERATION
procedure TForm1.FNewProjectOperation(AActionContext: TActionContext);
begin
  ChangeOpMode(omInteractive, True, False)
end;

// FILE/LOAD EXISTING PROJECT ACTION -------------------------------------------
procedure TForm1.FLoadProjectExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
  OpenDialog:    TOpenDialog;
begin
  if ActionNotAllowedUnderCPURun('LDPR') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      // select file
      OpenDialog := TOpenDialog.Create(Form1);
      try
        with OpenDialog do
        begin
          InitialDir := FWorkDirectory;
          Title := MSG53;
          Filter := MSG52;
        end;
        if OpenDialog.Execute then SArg1 := OpenDialog.FileName else Exit;
      finally
        OpenDialog.Free;
      end;
      FLoadProjectOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// FILE/LOAD EXISTING PROJECT OPERATION
procedure TForm1.FLoadProjectOperation(AActionContext: TActionContext);
var
  Filename: string;
  Message:  string;
begin
  Filename := AActionContext.SArg1;
  // FActualProjectIsSaved := True;
  // clearing
  ChangeOpMode(omInteractive, True, False);
  // loading
  if LoadProject(Filename)
    then SysConsole1.WriteMessage(Format(MSG80, [Filename])) else
    begin
      Message := MSG01 + Format(MSG55, [Filename]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      AActionContext.HasError := True;
      Exit;
    end;
  FActualProject := Filename;                                   // with filename
  FActualProjectIsSaved := True;                              // no need to save
  Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualProject);
end;

// FILE/SAVE PROJECT ACTION ----------------------------------------------------
procedure TForm1.FSaveProjectExecute(Sender: TObject);
var
  Message: string;
begin
  if ActionNotAllowedUnderCPURun('SVPR') then Exit;
  if FActualProjectIsSaved then Exit;
  if Length(FActualProject) = 0 then FSaveProjectAsExecute(Sender) else
  begin
    // create backup
    try
      if FileExists(FActualProject) then RenameFile(FActualProject, FActualProject + '.bak');
    except
      SysConsole1.WriteMessage(MSG02 + MSG84);
    end;
    // save file
    if not SaveProject(FActualProject) then
    begin
      Message := MSG01 + Format(MSG56, [FActualProject]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      Exit;
    end else SysConsole1.WriteMessage(Format(MSG81, [FActualProject]));
    FActualProjectIsSaved := True;                            // no need to save
  end;
end;

// FILE/SAVE PROJECT AS ACTION -------------------------------------------------
procedure TForm1.FSaveProjectAsExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
  SaveDialog:    TSaveDialog;
begin
  if ActionNotAllowedUnderCPURun('SVPR') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      // save file
      SaveDialog := TSaveDialog.Create(Form1);
      try
        with SaveDialog do
        begin
          InitialDir := FWorkDirectory;
          Title := MSG54;
          Filter := MSG52;
        end;
        if SaveDialog.Execute then SArg1 := SaveDialog.FileName else Exit;
      finally
        SaveDialog.Free;
      end;
      FSaveProjectAsOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// FILE/SAVE PROJECT AS OPERATION ----------------------------------------------
procedure TForm1.FSaveProjectAsOperation(AActionContext: TActionContext);
var
  Filename:   string;
  Message: string;
begin
  Filename := AActionContext.SArg1;
  // create backup
  try
    if FileExists(Filename) then RenameFile(Filename, Filename + '.bak');
  except
    SysConsole1.WriteMessage(MSG02 + MSG84);
  end;
  // save file
  if not SaveProject(Filename) then
  begin
    Message := MSG01 + Format(MSG56, [Filename]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  SysConsole1.WriteMessage(Format(MSG81, [Filename]));
  FActualProject := Filename;                                           // named
  FActualProjectIsSaved := True;                              // no need to save
  Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualProject);
end;

// FILE/CHANGE WORK DIRECTORY ACTION -------------------------------------------
procedure TForm1.FChangeWorkDirectoryExecute(Sender: TObject);
var
  ActionContext:         TActionContext;
  Caller:                TComponent;
  SelectDirectoryDialog: TSelectDirectoryDialog;
begin
  if ActionNotAllowedUnderCPURun('CHWD') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      // select directory
      SelectDirectoryDialog := TSelectDirectoryDialog.Create(Form1);
      try
        with SelectDirectoryDialog do
        begin
          InitialDir := FWorkDirectory;
          Title := MSG108;
        end;
        if SelectDirectoryDialog.Execute
          then SArg1 := SelectDirectoryDialog.FileName else Exit;
      finally
        SelectDirectoryDialog.Free;
      end;
      FChangeWorkDirectoryOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// FILE/CHANGE WORK DIRECTORY OPERATION
procedure TForm1.FChangeWorkDirectoryOperation(AActionContext: TActionContext);
begin
  FWorkDirectory := AActionContext.SArg1;
  CommandEngine2.FScriptRuntime.SetRegister('B', FWorkDirectory, True);
  SysConsole1.WriteMessage(Format(MSG109, [FWorkDirectory]));
end;

// FILE/SETTINGS ACTION --------------------------------------------------------
procedure TForm1.FSettingsExecute(Sender: TObject);
begin
  if Form18.ShowModal = mrOk then
  begin
    // refresh colors
    with uconfig.AppConfig do
    begin
      Form3.RefreshColors;                                          // HexViewer
      Form4.RefreshColors;                                          // RunLogger
      Form6.RefreshColors;                                       // ScriptEditor
      Form8.RefreshColors;                                          // IntLogger
      Form12.RefreshColors;                                     // ScriptConsole
      Form14.RefreshColors;                                         // BusLogger
      with SysConsoleConfig do                                     // SysConsole
      begin
        SysConsole1.Font.Color := font_color;
        SysConsole1.Color := bg_color;
        SysConsole1.Invalidate;
      end;
    end;
  end;
end;

// FILE/RESTART APPLICATION ACTION ---------------------------------------------
procedure TForm1.FRestartApplicationExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('RSAP') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      FRestartApplicationOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// FILE/RESTART APPLICATION OPERATION ------------------------------------------
procedure TForm1.FRestartApplicationOperation(AActionContext: TActionContext);
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

// FILE/EXIT TO OS ACTION ------------------------------------------------------
procedure TForm1.FExitExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('EXAP') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      FExitOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// FILE/EXIT TO OS OPERATION ---------------------------------------------------
procedure TForm1.FExitOperation(AActionContext: TActionContext);
begin
  Close;
end;

// VIEW/SHOW MODULE MANAGER ACTION =============================================
procedure TForm1.VModuleExplorerExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SHME') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    VShowModuleExplorerOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW MODULE MANAGER OPERATION
procedure TForm1.VShowModuleExplorerOperation(AActionContext: TActionContext);
begin
  Form9.Show;
  Form9.BringToFront;
end;

// VIEW/SHOW BREAKPOINT MANAGER ACTION -----------------------------------------
procedure TForm1.VShowBreakpointManagerExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SHBM') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    VShowBreakpointManagerOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW BREAKPOINT MANAGER OPERATION
procedure TForm1.VShowBreakpointManagerOperation(AActionContext: TActionContext);
begin
  Form10.BreakpointList := FBreakpointList;
  Form10.ShowModal;
end;

// VIEW/SHOW BUSLOGGER ACTION --------------------------------------------------
procedure TForm1.VShowBusLoggerExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SHBL') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    VShowBusLoggerOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW BUSLOGGER OPERATION
procedure TForm1.VShowBusLoggerOperation(AActionContext: TActionContext);
begin
  Form14.Show;
  Form14.BringToFront;
end;

// VIEW/SHOW RUNLOGGER ACTION --------------------------------------------------
procedure TForm1.VShowRunLoggerExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SHRL') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    VShowRunLoggerOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW RUNLOGGER OPERATION
procedure TForm1.VShowRunLoggerOperation(AActionContext: TActionContext);
begin
  Form4.Show;
  Form4.BringToFront;
end;

// VIEW/SHOW INTLOGGER ACTION --------------------------------------------------
procedure TForm1.VShowIntLoggerExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SHIL') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    VShowIntLoggerOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW INTLOGGER OPERATION
procedure TForm1.VShowIntLoggerOperation(AActionContext: TActionContext);
begin
  Form8.Show;
  Form8.BringToFront;
end;

// VIEW/SHOW REGVIEWER ACTION --------------------------------------------------
procedure TForm1.VShowRegViewerExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
  if ActionNotAllowedUnderCPURun('SHRV') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      // call from others
      StringList := TStringList.Create;
      try
        for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG79;
          ModuleList := StringList;
          if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
        end;
      finally
        StringList.Free;
      end;
    end;
    VShowRegviewerOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW REGVIEWER OPERATION
procedure TForm1.VShowRegviewerOperation(AActionContext: TActionContext);
var
  ProcInfo:     TProcInfo;
  InstanceName: string;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
  except
    // error
    Message := MSG01 + Format(MSG91, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // show HexViewer
  Form11.ProcInstance := ProcInfo.Processor;
  Form11.Show;
end;

// VIEW/SHOW HEXVIEWER ACTION --------------------------------------------------
procedure TForm1.VShowHexViewerExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
  if ActionNotAllowedUnderCPURun('SHHV') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      // call from others
      StringList := TStringList.Create;
      try
        for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG79;
          ModuleList := StringList;
          if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
        end;
      finally
        StringList.Free;
      end;
    end;
    VShowHexViewerOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW HEXVIEWER OPERATION
procedure TForm1.VShowHexViewerOperation(AActionContext: TActionContext);
var
  MemInfo:      TMemInfo;
  Message:      string;
  InstanceName: string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
  except
    // error
    Message := MSG01 + Format(MSG91, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // show HexViewer
  Form3.MemInstance := MemInfo.Memory;
  Form3.Show;
end;

// VIEW/SHOW SCRIPTEDITOR ACTION -----------------------------------------------
procedure TForm1.VShowScriptEditorExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SHSE') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    VShowScriptEditorOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW SCRIPTEDITOR OPERATION
procedure TForm1.VShowScriptEditorOperation(AActionContext: TActionContext);
begin
  if FOpMode = omInteractive then
  begin
    // warning
    SysConsole1.WriteMessage(MSG02 + MSG100);
    Exit;
  end;
  Form6.ExtBuffer := FScriptBuffer;
  Form6.CopyBufferToEditor;
  Form6.Show;
  Form6.BringToFront;
end;

// VIEW/SHOW SCRIPTCONSOLE ACTION ----------------------------------------------
procedure TForm1.VShowScriptConsoleExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SHSC') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    VShowScriptConsoleOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW SCRIPTCONSOLE OPERATION
procedure TForm1.VShowScriptConsoleOperation(AActionContext: TActionContext);
begin
  if FOpMode = omInteractive then
  begin
    // warning
    SysConsole1.WriteMessage(MSG02 + MSG100);
    Exit;
  end;
  Form12.Show;
  Form12.BringToFront;
end;

// VIEW/RENAME IO PORT PANEL ACTION --------------------------------------------
procedure TForm1.VRenameIOPanelExecute(Sender: TObject);
var
  Caller:          TComponent;
  ActionContext:   TActionContext;
  KeyName:         string;
  StringList:      TStringList;
begin
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      StringList := TStringList.Create;
      try
        for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG76;
          ModuleList := StringList;
          if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          // rename panel
          with Form13 do
          begin
            PanelCaption := SelectedKey;
            Form13.ShowModal;
            SArg2 := PanelCaption;
          end;
        end;
      finally
        StringList.Free;
      end;
    end;
    VRenameIOPanelOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/RENAME IO PORT PANEL OPERATION
procedure TForm1.VRenameIOPanelOperation(AActionContext: TActionContext);
var
  NewCaption:   string;
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  NewCaption := AActionContext.SArg2;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // rename panel
    if Length(Caption) > 0 then
      if PortInfo.Port.HasPanel
        then FPortPluginDict[PortInfo.ModuleName].FRenamePanel(PortInfo.Port,
                                                               PChar(NewCaption));
  except
    // error
    Message := MSG01 + Format(MSG92, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
end;

// VIEW/SHOW IO PORT PANEL ACTION
procedure TForm1.VShowIOPanelExecute(Sender: TObject);
var
  Caller:          TComponent;
  ActionContext:   TActionContext;
  KeyName:         string;
  StringList:      TStringList;
begin
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      StringList := TStringList.Create;
      try
        for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG76;
          ModuleList := StringList;
          if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
        end;
      finally
        StringList.Free;
      end;
    end;
    VShowIOPanelOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// VIEW/SHOW IO PORT PANEL OPERATION
procedure TForm1.VShowIOPanelOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // show panel
    if PortInfo.Port.HasPanel
      then FPortPluginDict[PortInfo.ModuleName].FShowPanel(PortInfo.Port);
  except
    // error
    Message := MSG01 + Format(MSG93, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
end;

// PROCESSOR/CREATE ACTION =====================================================
procedure TForm1.PCreateExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
  if ActionNotAllowedUnderCPURun('CRPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      StringList := TStringList.Create;
        try
          for KeyName in FProcPluginDict.Keys do
            if KeyName.StartsWith('lib', True)
              then StringList.Add(Copy(KeyName, 4, Length(KeyName)))
              else StringList.Add(KeyName);
          with Form16 do
          begin
            PluginList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
            SArg2 := Edit1.Text;
          end;
        finally
          StringList.Free;
        end;
      end;
      PCreateOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/CREATE OPERATION
procedure TForm1.PCreateOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ModuleType:   string;
  ProcInfo:     TProcInfo;
begin
  ModuleType := AActionContext.SArg1;
  InstanceName := AActionContext.SArg2;
  // check existing names
  if not InstanceNameDuplicated(FProcInstanceDict, InstanceName) then
  begin
    // create
    try
      if Assigned(FProcPluginDict[ModuleType].FCreate) then
      begin
        ProcInfo.Processor := FProcPluginDict[ModuleType].FCreate();
        ProcInfo.ModuleName := ModuleType;
        ProcInfo.AttachedToBus := False;
      end;
    except
      // error
      Message := MSG01 + Format(MSG90, ['processor', InstanceName]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      AActionContext.HasError := True;
      Exit;
    end;
    // store
    FProcInstanceDict.Add(InstanceName, ProcInfo);
    // add to Module Explorer
    Form9.AddNode('Processor', InstanceName);
    // report
    SysConsole1.WriteMessage(Format(MSG58, ['cpu', InstanceName]));
  end else
  begin
    Message := MSG01 + Format(MSG85, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
  end;
end;

// PROCESSOR/DESTROY ACTION ----------------------------------------------------
procedure TForm1.PDestroyExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DSPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG59;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      PDestroyOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/DESTROY OPERATION
procedure TForm1.PDestroyOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  // check attach
  ProcInfo := FProcInstanceDict[InstanceName];
  if ProcInfo.AttachedToBus then
  begin
    // error
    Message := MSG01 + Format(MSG09, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  try
    // destroy
    FProcPluginDict[ProcInfo.ModuleName].FDestroy(ProcInfo.Processor);
  except
    // error
    Message := MSG01 + Format(MSG94, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // remove from dict
  FProcInstanceDict.Remove(InstanceName);
  // remove from Module Explorer
  Form9.DeleteNode('Processor', InstanceName);
  Form9.ValueListEditor1.Clear;
  // report
  SysConsole1.WriteMessage(Format(MSG60, [InstanceName]));
end;

// PROCESSOR/RESET ACTION ------------------------------------------------------
procedure TForm1.PResetExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('RSPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG61;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      PResetOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/RESET OPERATION
procedure TForm1.PResetOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // reset
    ProcInfo.Processor.Reset;
  except
    // error
    Message := MSG01 + Format(MSG95, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // RegViewer refresh
  if Assigned(Form11) and Form11.Visible and
    (Form11.ProcInstance = ProcInfo.Processor) then Form11.RefreshContent;
  // report
  SysConsole1.WriteMessage(Format(MSG62, [InstanceName]));
end;

// PROCESSOR/ENABLE ACTION -----------------------------------------------------
procedure TForm1.PEnableExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('ENPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG63;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      PEnableOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/ENABLE OPERATION
procedure TForm1.PEnableOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // enable
    ProcInfo.Processor.Enabled := True;
  except
    // error
    Message := MSG01 + Format(MSG96, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG64, [InstanceName]));
end;

// PROCESSOR/DISABLE ACTION ----------------------------------------------------
procedure TForm1.PDisableExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DIPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG65;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      PDisableOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/DISABLE OPERATION
procedure TForm1.PDisableOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // disable
    ProcInfo.Processor.Enabled := False;
  except
    // error
    Message := MSG01 + Format(MSG97, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG66, [InstanceName]));
end;

// PROCESSOR/ATTACH TO BUS ACTION ----------------------------------------------
procedure TForm1.PAttachToBusExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('ATPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG67;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      PAttachToBusOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/ATTACH TO BUS OPERATION
procedure TForm1.PAttachToBusOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // attach to bus
    case FSysBus.AttachCPU(InstanceName, ProcInfo.Processor) of
      1: begin
           Message := MSG01 + Format(MSG98, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
      2: begin
           Message := MSG01 + Format(MSG105, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
      3: begin
           Message := MSG01 + Format(MSG107, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
    else
      ProcInfo.Processor.ConnectBus(FSysBus);
      ProcInfo.AttachedToBus := True;
      FProcInstanceDict[InstanceName] := ProcInfo;
      ProcInfo.Processor.OnEvent := @CPUEventHandler;
    end;
  except
    // other error
    Message := MSG01 + Format(MSG98, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG68, [InstanceName]));
end;

// PROCESSOR/DETACH FROM BUS ACTION --------------------------------------------
procedure TForm1.PDetachFromBusExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DTPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG67;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      PDetachFromBusOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/DETACH FROM BUS OPERATION
procedure TForm1.PDetachFromBusOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    case FSysBus.DetachCPU(InstanceName) of
      1: begin
           Message := MSG01 + Format(MSG99, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
      2: begin
           Message := MSG01 + Format(MSG106, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
    else
      ProcInfo.AttachedToBus := False;
      ProcInfo.Processor.OnEvent := nil;
      FProcInstanceDict[InstanceName] := ProcInfo;
    end;
  except
    // other error
    Message := MSG01 + Format(MSG99, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG70, [InstanceName]));
end;

// PROCESSOR/PROPERTIES ACTION -------------------------------------------------
procedure TForm1.PPropertiesExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext: TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('CFPU') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG71;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      PPropertiesOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// PROCESSOR/PROPERTIES OPERATION
procedure TForm1.PPropertiesOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  begin
    ProcInfo := FProcInstanceDict[InstanceName];
    // show properties
    with Form15 do
    begin
      ProcInstance := ProcInfo.Processor;
      ShowModal;
    end;
  end;
end;

// MEMORY/CREATE ACTION =====================================================
procedure TForm1.MCreateExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
  if ActionNotAllowedUnderCPURun('CRME') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      StringList := TStringList.Create;
        try
          for KeyName in FMemPluginDict.Keys do
            if KeyName.StartsWith('lib', True)
              then StringList.Add(Copy(KeyName, 4, Length(KeyName)))
              else StringList.Add(KeyName);
          with Form16 do
          begin
            PluginList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
            SArg2 := Edit1.Text;
          end;
        finally
          StringList.Free;
        end;
      end;
      MCreateOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/CREATE OPERATION
procedure TForm1.MCreateOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  ModuleType:   string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  ModuleType := AActionContext.SArg1;
  InstanceName := AActionContext.SArg2;
  // check existing names
  if not InstanceNameDuplicated(FMemInstanceDict, InstanceName) then
  begin
    // create
    try
      if Assigned(FMemPluginDict[ModuleType].FCreate) then
      begin
        MemInfo.Memory := FMemPluginDict[ModuleType].FCreate();
        MemInfo.ModuleName := ModuleType;
        MemInfo.AttachedToBus := False;
      end;
    except
      // error
      Message := MSG01 + Format(MSG90, ['memory', InstanceName]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      AActionContext.HasError := True;
      Exit;
    end;
    // store
    FMemInstanceDict.Add(InstanceName, MemInfo);
    // add to Module Explorer
    Form9.AddNode('Memory', InstanceName);
    // report
    SysConsole1.WriteMessage(Format(MSG58, ['memory', InstanceName]));
  end else
  begin
    Message := MSG01 + Format(MSG85, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
  end;
end;

// MEMORY/DESTROY ACTION ----------------------------------------------------
procedure TForm1.MDestroyExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DSME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG59;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      MDestroyOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/DESTROY OPERATION
procedure TForm1.MDestroyOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  // check attach
  MemInfo := FMemInstanceDict[InstanceName];
  if MemInfo.AttachedToBus then
  begin
    // error
    Message := MSG01 + Format(MSG09, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  try
    // destroy
    FMemPluginDict[MemInfo.ModuleName].FDestroy(MemInfo.Memory);
  except
    // error
    Message := MSG01 + Format(MSG94, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // remove from dict
  FMemInstanceDict.Remove(InstanceName);
  // remove from Module Explorer
  Form9.DeleteNode('Memory', InstanceName);
  Form9.ValueListEditor1.Clear;
  // report
  SysConsole1.WriteMessage(Format(MSG60, [InstanceName]));
end;

// MEMORY/RESET ACTION ------------------------------------------------------
procedure TForm1.MResetExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('RSME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG61;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      MResetOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/RESET OPERATION
procedure TForm1.MResetOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // reset
    MemInfo.Memory.Reset;
  except
    // error
    Message := MSG01 + Format(MSG95, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG62, [InstanceName]));
end;

// MEMORY/ENABLE ACTION -----------------------------------------------------
procedure TForm1.MEnableExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('ENME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG63;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      MEnableOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/ENABLE OPERATION
procedure TForm1.MEnableOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // enable
    MemInfo.Memory.Enabled := True;
  except
    // error
    Message := MSG01 + Format(MSG96, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG64, [InstanceName]));
end;

// MEMORY/DISABLE ACTION ----------------------------------------------------
procedure TForm1.MDisableExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DIME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG65;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      MDisableOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/DISABLE OPERATION
procedure TForm1.MDisableOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // disable
    MemInfo.Memory.Enabled := False;
  except
    // error
    Message := MSG01 + Format(MSG97, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG66, [InstanceName]));
end;

// MEMORY/ATTACH TO BUS ACTION ----------------------------------------------
procedure TForm1.MAttachToBusExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('ATME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG67;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      MAttachToBusOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/ATTACH TO BUS OPERATION
procedure TForm1.MAttachToBusOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FmemInstanceDict[InstanceName];
    // attach to bus
    case FSysBus.AttachMemory(InstanceName, MemInfo.Memory,
                              MemInfo.Memory.BaseAddress,
                              MemInfo.Memory.AddressRangeSize) of
      1: begin
           Message := MSG01 + Format(MSG98, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
      2: begin
           Message := MSG01 + Format(MSG105, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
    else
      MemInfo.AttachedToBus := True;
      FMemInstanceDict[InstanceName] := MemInfo;
    end;
  except
    // other error
    Message := MSG01 + Format(MSG98, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG68, [InstanceName]));
end;

// MEMORY/DETACH FROM BUS ACTION --------------------------------------------
procedure TForm1.MDetachFromBusExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DTME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG67;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      MDetachFromBusOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/DETACH FROM BUS OPERATION
procedure TForm1.MDetachFromBusOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    case FSysBus.DetachMemory(InstanceName) of
      1: begin
           Message := MSG01 + Format(MSG99, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
      2: begin
           Message := MSG01 + Format(MSG106, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
    else
      MemInfo.AttachedToBus := False;
      FMemInstanceDict[InstanceName] := MemInfo;
    end;
  except
    // other error
    Message := MSG01 + Format(MSG99, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG70, [InstanceName]));
end;

// MEMORY/PROPERTIES ACTION -------------------------------------------------
procedure TForm1.MPropertiesExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('CFME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG71;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      MPropertiesOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/PROPERTIES OPERATION
procedure TForm1.MPropertiesOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  begin
    try
      MemInfo := FMemInstanceDict[InstanceName];
    except
      Message := MSG01 + Format(MSG101, [InstanceName]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      AActionContext.HasError := True;
      Exit;
    end;
    // show properties
    with Form15 do
    begin
      MemInstance := MemInfo.Memory;
      ShowModal;
    end;
  end;
end;

// MEMORY/LOAD MEMORY CONTENT ACTION -------------------------------------------
procedure TForm1.MLoadMemoryContentExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
  CurrentStatus: Boolean;
  MemInfo:       TMemInfo;
  OpenDialog1:   TOpenDialog;
  StringList:    TStringList;
  KeyName:       string;
begin
  if ActionNotAllowedUnderCPURun('LDME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if Caller is TMenuItem then
      begin
        if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      // select memory instance
      StringList := TStringList.Create;
      try
        for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG72;
          ModuleList := StringList;
        end;
        if Form17.ShowModal <> mrOk then  Exit;
        SArg1 := Form17.SelectedKey;
      finally
        StringList.Free;
      end;
      MemInfo := FMemInstanceDict[SArg1];
      // enable memory module temporarily
      CurrentStatus := MemInfo.Memory.Enabled;
      MemInfo.Memory.Enabled := True;
      try
        // select file
        OpenDialog1 := TOpenDialog.Create(Form1);
        try
          with OpenDialog1 do
          begin
            InitialDir := FWorkDirectory;
            Title := MSG30;
            Filter := MSG32;
          end;
          if not OpenDialog1.Execute then Exit;
          SArg2 := OpenDialog1.FileName;
          // HEX: load complete file from address 0
          if SArg2.EndsWith('.hex', True) then
          begin
            DArg1 := 0;
            DArg2 := 0;
          end else
          begin
            // BIN: select address range
            Form7.Direction := True;
            Form7.MemSize := MemInfo.Memory.AddressRangeSize - 1;
            if Form7.ShowModal <> mrOk then Exit;
            DArg1 := Form7.AddressFrom;
            DArg2 := Form7.AddressTo - Form7.AddressFrom + 1;
          end;
          // execute operation
          MLoadMemoryContentOperation(ActionContext);
        finally
          OpenDialog1.Free;
        end;
      finally
        // restore original module state
        MemInfo.Memory.Enabled := CurrentStatus;
      end;
    end;
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/LOAD MEMORY CONTENT OPERATION ---------------------------------------
procedure TForm1.MLoadMemoryContentOperation(AActionContext: TActionContext);
var
  AddressFrom:  DWord;
  ByteCount:    DWord;
  Filename:     string;
  InstanceName: string;
  LoadStream:   TMemoryStream;
  MemInfo:      TMemInfo;
  Message:      string;
begin
  InstanceName := AActionContext.SArg1;
  Filename := AActionContext.SArg2;
  // if there is only filename, insert the name of the working directory
  if ExtractFilePath(Filename) = ''
    then Filename := IncludeTrailingPathDelimiter(FWorkDirectory) + Filename;
  try
    MemInfo := FMemInstanceDict[InstanceName];
  except
    on E: Exception do
    begin
      Message := MSG01 + Format(MSG93, [InstanceName]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      AActionContext.HasError := True;
      Exit;
    end;
  end;
  LoadStream := TMemoryStream.Create;
  try
    if not Filename.EndsWith('.hex', True) then
    begin
      // load from .bin
      try
        LoadStream.LoadFromFile(Filename);
        // 0,0 = complete file from address 0
        if (AActionContext.DArg1 = 0) and (AActionContext.DArg2 = 0) then
        begin
          AddressFrom := 0;
          ByteCount := LoadStream.Size;
        end else
        begin
          AddressFrom := AActionContext.DArg1;
          ByteCount := AActionContext.DArg2;
          // do not read beyond file
          if ByteCount > LoadStream.Size then ByteCount := LoadStream.Size;
        end;
        // do not write beyond memory
        if AddressFrom >= MemInfo.Memory.AddressRangeSize then ByteCount := 0 else
          if ByteCount > MemInfo.Memory.AddressRangeSize - AddressFrom
            then ByteCount := MemInfo.Memory.AddressRangeSize - AddressFrom;
        LoadStream.Position := 0;
        if ByteCount > 0 then MemInfo.Memory.LoadFromStream(LoadStream,
                                                            AddressFrom,
                                                            ByteCount);
      except
        Message := MSG01 + Format(MSG31, [Filename]);
        ShowMessage(Message);
        SysConsole1.WriteMessage(Message);
        AActionContext.HasError := True;
        Exit;
      end;
    end else
    begin
      // load from .hex
      MemInfo.Memory.Reset;
      case LoadFromIntelHexToStream(Filename, LoadStream) of
        1: begin
             Message := MSG01 + Format(MSG35, [Filename]);
             ShowMessage(Message);
             SysConsole1.WriteMessage(Message);
             AActionContext.HasError := True;
             Exit;
           end;
        2: begin
             Message := MSG01 + MSG37;
             ShowMessage(Message);
             SysConsole1.WriteMessage(Message);
             AActionContext.HasError := True;
             Exit;
           end;
        3: begin
             Message := MSG01 + MSG38;
             ShowMessage(Message);
             SysConsole1.WriteMessage(Message);
             AActionContext.HasError := True;
             Exit;
           end;
      255: begin
             Message := MSG01 + MSG39;
             ShowMessage(Message);
             SysConsole1.WriteMessage(Message);
             AActionContext.HasError := True;
             Exit;
           end;
      end;
      LoadStream.Position := 0;
      // DArg1/DArg2 are ignored.
      ByteCount := LoadStream.Size;
      if ByteCount > MemInfo.Memory.AddressRangeSize
        then ByteCount := MemInfo.Memory.AddressRangeSize;
      if ByteCount > 0
        then MemInfo.Memory.LoadFromStream(LoadStream, 0, ByteCount);
    end;
    // report
    SysConsole1.WriteMessage(Format(MSG73, [Filename, InstanceName]));
  finally
    LoadStream.Free;
    AActionContext.DArg1 := 0;
    AActionContext.DArg2 := 0;
  end;
end;

// MEMORY/SAVE MEMORY CONTENT ACTION -------------------------------------------
procedure TForm1.MSaveMemoryContentExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
  KeyName:       string;
  MemInfo:       TMemInfo;
  SaveDialog1:   TSaveDialog;
  StringList:    TStringList;
begin
  if ActionNotAllowedUnderCPURun('SVME') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if Caller is TMenuItem then
      begin
        if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      // select memory instance
      StringList := TStringList.Create;
      try
        for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG74;
          ModuleList := StringList;
        end;
        if Form17.ShowModal <> mrOk then Exit;
        SArg2 := Form17.SelectedKey;
      finally
        StringList.Free;
      end;
      MemInfo := FMemInstanceDict[SArg2];
      // select output file
      SaveDialog1 := TSaveDialog.Create(Form1);
      try
        with SaveDialog1 do
        begin
          InitialDir := FWorkDirectory;
          Title := MSG28;
          Filter := MSG32;
        end;
        if not SaveDialog1.Execute then Exit;
        SArg1 := SaveDialog1.FileName;
        // .hex: complete memory, no address selection
        if SArg1.EndsWith('.hex', True) then
        begin
          DArg1 := 0;
          DArg2 := 0;
        end else
        begin
          // .bin: select address range
          Form7.Direction := False;
          Form7.MemSize := MemInfo.Memory.AddressRangeSize - 1;
          if Form7.ShowModal <> mrOk then Exit;
          DArg1 := Form7.AddressFrom;
          DArg2 := Form7.AddressTo - Form7.AddressFrom + 1;
        end;
        // execute operation
        MSaveMemoryContentOperation(ActionContext);
      finally
        SaveDialog1.Free;
      end;
    end;
  finally
    ActionContext.Free;
  end;
end;


// MEMORY/SAVE MEMORY CONTENT OPERATION ----------------------------------------
procedure TForm1.MSaveMemoryContentOperation(
  AActionContext: TActionContext);
var
  AddressFrom:   DWord;
  ByteCount:     DWord;
  CurrentStatus: Boolean;
  Filename:      string;
  InstanceName:  string;
  SaveStream:    TMemoryStream;
  MemInfo:       TMemInfo;
  Message:       string;
begin
  Filename := AActionContext.SArg1;
  // if there is only filename, insert the name of the working directory
  if ExtractFilePath(Filename) = ''
    then Filename := IncludeTrailingPathDelimiter(FWorkDirectory) + Filename;
  InstanceName := AActionContext.SArg2;
  try
    MemInfo := FMemInstanceDict[InstanceName];
  except
    on E: Exception do
    begin
      Message := MSG01 + Format(MSG93, [InstanceName]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      AActionContext.HasError := True;
      Exit;
    end;
  end;
  CurrentStatus := MemInfo.Memory.Enabled;
  MemInfo.Memory.Enabled := True;
  try
    SaveStream := TMemoryStream.Create;
    try
      if not Filename.EndsWith('.hex', True) then
      begin
        // save to .bin
        if (AActionContext.DArg1 = 0) and (AActionContext.DArg2 = 0) then
        begin
          // complete memory from address 0
          AddressFrom := 0;
          ByteCount := MemInfo.Memory.AddressRangeSize;
        end else
        begin
          AddressFrom := AActionContext.DArg1;
          ByteCount := AActionContext.DArg2;
          // do not read beyond memory
          if AddressFrom >= MemInfo.Memory.AddressRangeSize
            then ByteCount := 0
            else
              if ByteCount > MemInfo.Memory.AddressRangeSize - AddressFrom
                then ByteCount := MemInfo.Memory.AddressRangeSize - AddressFrom;
        end;
        if ByteCount > 0 then
        begin
          // create backup
          try
            if FileExists(Filename) then RenameFile(Filename, Filename + '.bak');
          except
            SysConsole1.WriteMessage(MSG02 + MSG84);
          end;
          try
            SaveStream.Clear;
            MemInfo.Memory.SaveToStream(SaveStream, AddressFrom, ByteCount);
            SaveStream.SaveToFile(Filename);
          except
            Message := MSG01 + Format(MSG29, [Filename]);
            ShowMessage(Message);
            SysConsole1.WriteMessage(Message);
            AActionContext.HasError := True;
            Exit;
          end;
        end;
      end else
      begin
        // save to .hex
        // complete memory image
        MemInfo.Memory.SaveToStream(SaveStream, 0, MemInfo.Memory.AddressRangeSize);
        case SaveToIntelHexFromStream(Filename, SaveStream) of
          1: begin
               Message := MSG01 + Format(MSG36, [Filename]);
               ShowMessage(Message);
               SysConsole1.WriteMessage(Message);
               AActionContext.HasError := True;
               Exit;
             end;
        255: begin
               Message := MSG01 + MSG39;
               ShowMessage(Message);
               SysConsole1.WriteMessage(Message);
               AActionContext.HasError := True;
               Exit;
             end;
        end;
      end;
      // report
      SysConsole1.WriteMessage(Format(MSG75, [Filename, InstanceName]));
    finally
      SaveStream.Free;
    end;
  finally
    // restore original module state
    MemInfo.Memory.Enabled := CurrentStatus;
  end;
end;

// MEMORY/EXAMINE-DEPOSIT ACTION -----------------------------------------------
procedure TForm1.MExamineDepositExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
  if ActionNotAllowedUnderCPURun('EDME') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      StringList := TStringList.Create;
      try
        for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG79;
          ModuleList := StringList;
          if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
        end;
      finally
        StringList.Free;
      end;
    end;
    MExamineDepositOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// MEMORY/EXAMINE-DEPOSIT OPERATION
procedure TForm1.MExamineDepositOperation(AActionContext: TActionContext);
var
  CurrentStatus: Boolean;
  InstanceName:  string;
  MemInfo:       TMemInfo;
  Message:       string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // store original status and enable module
    CurrentStatus := MemInfo.Memory.Enabled;
    MemInfo.Memory.Enabled := True;
    // examine/deposit
    with Form5 do
    begin
      MemInstance := MemInfo.Memory;
      ShowModal;
    end;
    // restore original status
    MemInfo.Memory.Enabled := CurrentStatus;
  except
    // error
    Message := MSG01 + Format(MSG93, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    MemInfo.Memory.Enabled := CurrentStatus;
    AActionContext.HasError := True;
    Exit;
  end;
end;

// IO PORT/CREATE ACTION =====================================================
procedure TForm1.IOCreateExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
  if ActionNotAllowedUnderCPURun('CRIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      StringList := TStringList.Create;
        try
          for KeyName in FPortPluginDict.Keys do
            if KeyName.StartsWith('lib', True)
              then StringList.Add(Copy(KeyName, 4, Length(KeyName)))
              else StringList.Add(KeyName);
          with Form16 do
          begin
            PluginList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
            SArg2 := Edit1.Text;
          end;
        finally
          StringList.Free;
        end;
      end;
      IOCreateOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/CREATE OPERATION
procedure TForm1.IOCreateOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ModuleType:   string;
  PortInfo:     TPortInfo;
begin
  ModuleType := AActionContext.SArg1;
  InstanceName := AActionContext.SArg2;
  // check existing names
  if not InstanceNameDuplicated(FPortInstanceDict, InstanceName) then
  begin
    // create
    try
      if Assigned(FPortPluginDict[ModuleType].FCreate) then
      begin
        PortInfo.Port := FPortPluginDict[ModuleType].FCreate();
        PortInfo.ModuleName := ModuleType;
        PortInfo.AttachedToBus := False;
        // create and show panel
        if PortInfo.Port.HasPanel
          then FPortPluginDict[ModuleType].FCreatePanel(PortInfo.Port);
        if PortInfo.Port.HasPanel
          then FPortPluginDict[ModuleType].FShowPanel(PortInfo.Port);
      end;
    except
      // error
      Message := MSG01 + Format(MSG90, ['i/o port', InstanceName]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      AActionContext.HasError := True;
      Exit;
    end;
    // store
    FPortInstanceDict.Add(InstanceName, PortInfo);
    // add to Module Explorer
    Form9.AddNode('I/O port & device', InstanceName);
    // report
    SysConsole1.WriteMessage(Format(MSG58, ['i/o port', InstanceName]));
  end else
  begin
    Message := MSG01 + Format(MSG85, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
  end;
end;

// IO PORT/DESTROY ACTION ----------------------------------------------------
procedure TForm1.IODestroyExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DTIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG59;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      IODestroyOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/DESTROY OPERATION
procedure TForm1.IODestroyOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  // check attach
  PortInfo := FPortInstanceDict[InstanceName];
  if PortInfo.AttachedToBus then
  begin
    // error
    Message := MSG01 + Format(MSG09, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  try
    // destroy
    FPortPluginDict[PortInfo.ModuleName].FDestroy(PortInfo.Port);
  except
    // error
    Message := MSG01 + Format(MSG94, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // remove from dict
  FPortInstanceDict.Remove(InstanceName);
  // remove from Module Explorer
  Form9.DeleteNode('I/O port & device', InstanceName);
  Form9.ValueListEditor1.Clear;
  // report
  SysConsole1.WriteMessage(Format(MSG60, [InstanceName]));
end;

// IO PORT/RESET ACTION ------------------------------------------------------
procedure TForm1.IOResetExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('RSIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG61;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      IOResetOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/RESET OPERATION
procedure TForm1.IOResetOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // reset
    PortInfo.Port.Reset;
  except
    // error
    Message := MSG01 + Format(MSG95, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG62, [InstanceName]));
end;

// IO PORT/ENABLE ACTION -----------------------------------------------------
procedure TForm1.IOEnableExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('ENIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG63;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      IOEnableOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/ENABLE OPERATION
procedure TForm1.IOEnableOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // enable
    PortInfo.Port.Enabled := True;
  except
    // error
    Message := MSG01 + Format(MSG96, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG64, [InstanceName]));
end;

// IO PORT/DISABLE ACTION ----------------------------------------------------
procedure TForm1.IODisableExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DIIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG65;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      IODisableOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/DISABLE OPERATION
procedure TForm1.IODisableOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // disable
    PortInfo.Port.Enabled := False;
  except
    // error
    Message := MSG01 + Format(MSG97, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG66, [InstanceName]));
end;

// IO PORT/ATTACH TO BUS ACTION ----------------------------------------------
procedure TForm1.IOAttachToBusExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('ATIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG67;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      IOAttachToBusOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/ATTACH TO BUS OPERATION
procedure TForm1.IOAttachToBusOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // attach to bus
    case FSysBus.AttachIOPort(InstanceName, PortInfo.Port,
                              PortInfo.Port.BaseAddress,
                              PortInfo.Port.AddressRangeSize) of
      1: begin
           Message := MSG01 + Format(MSG98, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
      end;
      2: begin
           Message := MSG01 + Format(MSG105, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
    else
      PortInfo.AttachedToBus := True;
      FPortInstanceDict[InstanceName] := PortInfo;
      PortInfo.Port.OnInterrupt:= @InterruptHandler;
    end;
  except
    // other error
    Message := MSG01 + Format(MSG98, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG68, [InstanceName]));
end;

// IO PORT/DETACH FROM BUS ACTION --------------------------------------------
procedure TForm1.IODetachFromBusExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('DTIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG67;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      IODetachFromBusOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/DETACH FROM BUS OPERATION
procedure TForm1.IODetachFromBusOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    case FSysBus.DetachIOPort(InstanceName) of
      1: begin
           Message := MSG01 + Format(MSG99, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
      2: begin
           Message := MSG01 + Format(MSG106, [InstanceName]);
           ShowMessage(Message);
           SysConsole1.WriteMessage(Message);
           AActionContext.HasError := True;
           Exit;
         end;
    else
      PortInfo.AttachedToBus := False;
      FPortInstanceDict[InstanceName] := PortInfo;
      PortInfo.Port.OnInterrupt:= nil;
    end;
  except
    // other error
    Message := MSG01 + Format(MSG99, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG70, [InstanceName]));
end;

// IO PORT/PROPERTIES ACTION -------------------------------------------------
procedure TForm1.IOPropertiesExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext: TActionContext;
  StringList:     TStringList;
  Tree:           TTreeView;
begin
  if ActionNotAllowedUnderCPURun('CFIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    Caller := (Sender as TAction).ActionComponent;
    with ActionContext do
    begin
      // detect action source object
      if (Caller is TMenuItem) then
      begin
        if (TMenuItem(Caller).GetParentMenu = Form9.PopupMenu1)
          then ActionSource := asModuleExplorer;
        if (TMenuItem(Caller).GetParentMenu = Form1.MainMenu1)
          then ActionSource := asMainMenu;
      end else ActionSource := asToolBar;
      if ActionSource = asModuleExplorer then
      begin
        // call from Module Explorer
        if Form9.PopupMenu1.PopupComponent is TTreeView then
        begin
          Tree := TTreeView(Form9.PopupMenu1.PopupComponent);
          if Assigned(Tree.Selected) then SArg1 := Tree.Selected.Text;
        end;
      end else
      begin
        // call from others
        StringList := TStringList.Create;
        try
          for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
          with Form17 do
          begin
            OKButtonCaption := MSG71;
            ModuleList := StringList;
            if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
          end;
        finally
          StringList.Free;
        end;
      end;
      IOPropertiesOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// IO PORT/PROPERTIES OPERATION
procedure TForm1.IOPropertiesOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  PortInfo:      TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  begin
    PortInfo := FPortInstanceDict[InstanceName];
    // show properties
    with Form15 do
    begin
      PortInstance := PortInfo.Port;
      ShowModal;
    end;
  end;
end;

// I/O PORT/READ-WRITE ACTION --------------------------------------------------
procedure TForm1.IOReadWriteExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
  if ActionNotAllowedUnderCPURun('RWIO') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      StringList := TStringList.Create;
      try
        for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
        with Form17 do
        begin
          OKButtonCaption := MSG79;
          ModuleList := StringList;
          if ShowModal = mrOk then SArg1 := SelectedKey else Exit;
        end;
      finally
        StringList.Free;
      end;
    end;
    IOReadWriteOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// I/O PORT/READ-WRITE OPERATION
procedure TForm1.IOReadWriteOperation(AActionContext: TActionContext);
var
  CurrentStatus: Boolean;
  InstanceName:  string;
  PortInfo:      TPortInfo;
  Message:       string;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // store original status and enable module
    CurrentStatus := PortInfo.Port.Enabled;
    PortInfo.Port.Enabled := True;
    // read/write
    with Form51 do
    begin
      PortInstance := PortInfo.Port;
      ShowModal;
    end;
    // restore original status
    PortInfo.Port.Enabled := CurrentStatus;
  except
    // error
    Message := MSG01 + Format(MSG93, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    PortInfo.Port.Enabled := CurrentStatus;
    AActionContext.HasError := True;
    Exit;
  end;
end;

// OPERATION/RUN SIMULATION ACTION =============================================
procedure TForm1.ORunExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('RUN') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    ORunOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/RUN SIMULATION OPERATION
procedure TForm1.ORunOperation(AActionContext: TActionContext);
begin
  try
    SimulationThread1.CPU := FSysBus.FCPUs[0].CPU;
    SimulationThread1.CPURun;
    //report
    SysConsole1.WriteMessage(MSG115);
  except
  end;
end;

// OPERATION/RUN SIMULATION STEP BY STEP ACTION --------------------------------
procedure TForm1.OStepExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('STEP') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    OStepOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/RUN SIMULATION STEP BY STEP OPERATION
procedure TForm1.OStepOperation(AActionContext: TActionContext);
begin
  try
    SimulationThread1.CPU := FSysBus.FCPUs[0].CPU;
    SimulationThread1.CPUStep;
    //report
    SysConsole1.WriteMessage(MSG116);
  except
  end;
end;

// OPERATION/STOP SIMULATION ACTION --------------------------------------------
procedure TForm1.OStopExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('STOP') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    OStopOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/STOP SIMULATION OPERATION
procedure TForm1.OStopOperation(AActionContext: TActionContext);
begin
  if Length(FSysBus.FCPUs) > 0 then
  begin
    SimulationThread1.CPU := FSysBus.FCPUs[0].CPU;
    SimulationThread1.CPUStop;
    //report
    SysConsole1.WriteMessage(MSG117);
  end;
end;

// OPERATION/REQUEST NMI ACTION ------------------------------------------------
procedure TForm1.ONMIExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('NMI') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    ONMIOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/REQUEST NMI OPERATION
procedure TForm1.ONMIOperation(AActionContext: TActionContext);
begin
  try
    SimulationThread1.CPU := FSysBus.FCPUs[0].CPU;
    SimulationThread1.CPUNMI;
    //report
    SysConsole1.WriteMessage(MSG118);
  except
  end;
end;

// OPERATION/RESET SIMULATION ACTION -------------------------------------------
procedure TForm1.OResetAllExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('RST') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    OResetAllOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/RESET SIMULATION OPERATION
procedure TForm1.OResetAllOperation(AActionContext: TActionContext);
var
  i: Integer;
begin
  // reset modules
  with FSysBus do
  begin
    for i := 0 to High(FMemories) do with FMemories[i].Memory do Reset;
    for i := 0 to High(FCPUs) do with FCPUs[i].CPU do Reset;
    for i := 0 to High(FIOPorts) do with FIOPorts[i].IOPort do Reset;
  end;
  // clear loggers and viewers
  if Assigned(Form3) then Form3.RefreshContent;                     // HexViewer
  if Assigned(Form4) then Form4.ClearContent;                       // RunLogger
  if Assigned(Form8) then Form8.ClearContent;                       // IntLogger
  if Assigned(Form11) then Form11.RefreshContent;                   // RegViewer
  if Assigned(Form14) then Form14.ClearContent  ;                   // BusLogger
  //report
  SysConsole1.WriteMessage(MSG114);
end;

// OPERATION/MAKE SNAPSHOT ACTION ----------------------------------------------
procedure TForm1.OMakeSnapshotExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SVSS') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    OMakeSnapshotOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/MAKE SNAPSHOT OPERATION
procedure TForm1.OMakeSnapshotOperation(AActionContext: TActionContext);
begin
  {...}
end;

// OPERATION/RESTORE SNAPSHOT ACTION -------------------------------------------
procedure TForm1.ORestoreSnapshotExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('LDSS') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    ORestoreSnapshotOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/RESTORE SNAPSHOT OPERATION
procedure TForm1.ORestoreSnapshotOperation(AActionContext: TActionContext);
begin
  {...}
end;

// SCRIPT/CREATE NEW SCRIPT ACTION =============================================
procedure TForm1.SNewScriptExecute(Sender: TObject);
begin
  if ActionNotAllowedUnderCPURun('NWSC') then Exit;
  ChangeOpMode(omScript, True, True);
  // refresh and show ScriptEditor
  Form6.ClearModified;
  Form6.SetFilename('');
  VShowScriptEditorExecute(nil);
end;

// SCRIPT/CREATE NEW SCRIPT OPERATION
procedure TForm1.SNewScriptOperation(AActionContext: TActionContext);
begin
  ChangeOpMode(omScript, True, False);
  // refresh and show ScriptEditor
  Form6.ClearModified;
  Form6.SetFilename('');
  VShowScriptEditorExecute(nil);
end;

// SCRIPT/LOAD SCRIPT ACTION ---------------------------------------------------
procedure TForm1.SLoadScriptExecute(Sender: TObject);
  var
    ActionContext: TActionContext;
    Caller:        TComponent;
    OpenDialog:    TOpenDialog;
  begin
    if ActionNotAllowedUnderCPURun('LDSC') then Exit;
    ActionContext := TActionContext.Create;
    try
      with ActionContext do
      begin
        ActionSource := asOther;
        if Sender is TAction then
        begin
          Caller := TAction(Sender).ActionComponent;
          if Caller is TMenuItem then
          begin
            if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
              then ActionSource := asMainMenu;
          end else ActionSource := asToolBar;
        end;
        // check actual script status
        if not FActualScriptIsSaved then
          if MessageDlg(MSG43, MSG44, mtConfirmation, [mbYes, mbNo], 0) = mrNo
            then Exit;
        // select file
        OpenDialog := TOpenDialog.Create(Form1);
        try
          with OpenDialog do
          begin
            InitialDir := FWorkDirectory;
            Title := MSG46;
            Filter := MSG45;
          end;
          if OpenDialog.Execute then SArg1 := OpenDialog.FileName else Exit;
        finally
          OpenDialog.Free;
        end;
        SLoadScriptOperation(ActionContext);
      end;
    finally
      ActionContext.Free;
    end;
end;

// SCRIPT/LOAD SCRIPT OPERATION
procedure TForm1.SLoadScriptOperation(AActionContext: TActionContext);
var
  Filename:   string;
  Message:    string;
begin
  Filename := AActionContext.SArg1;
  //  FActualScriptIsSaved := True;
  // clearing
  ChangeOpMode(omScript, True, False);
  // loading
  try
    FScriptBuffer.LoadFromFile(FileName);
    SysConsole1.WriteMessage(Format(MSG82, [FileName]));
  except
    Message := MSG01 + Format(MSG48, [FileName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    exit;
  end;
  FActualScript := Filename;                                // with filename
  FActualScriptIsSaved := True;                           // no need to save
  Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualScript);
  // refresh and show ScriptEditor
  Form6.ClearModified;
  Form6.SetFilename(FActualScript);
  VShowScriptEditorExecute(nil);
end;

// SCRIPT/SAVE SCRIPT ACTION ---------------------------------------------------
procedure TForm1.SSaveScriptExecute(Sender: TObject);
var
  Message: string;
begin
  if ActionNotAllowedUnderCPURun('SVSC') then Exit;
  if FActualScriptIsSaved then Exit;
  if Length(FActualScript) = 0 then SSaveScriptAsExecute(Sender) else
  begin
    // create backup
    try
      if FileExists(FActualScript) then RenameFile(FActualScript, FActualScript + '.bak');
    except
      SysConsole1.WriteMessage(MSG02 + MSG84);
    end;
    // save file
    try
      FScriptBuffer.SaveToFile(FActualScript);
      SysConsole1.WriteMessage(Format(MSG83, [FActualScript]));
      // refresh ScriptEditor
      Form6.ClearModified;
    except
      Message := MSG01 + Format(MSG49, [FActualScript]);
      ShowMessage(Message);
      SysConsole1.WriteMessage(Message);
      Exit;
    end;
    FActualScriptIsSaved := True;                             // no need to save
  end;
end;

// SCRIPT/SAVE SCRIPT AS ACTION ------------------------------------------------
procedure TForm1.SSaveScriptAsExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
  SaveDialog:    TSaveDialog;
begin
  if ActionNotAllowedUnderCPURun('SVSC') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
      // save file
      SaveDialog := TSaveDialog.Create(Form1);
      try
        with SaveDialog do
        begin
          InitialDir := FWorkDirectory;
          Title := MSG47;
          Filter := MSG45;
        end;
        if SaveDialog.Execute then SArg1 := SaveDialog.FileName else Exit;
      finally
        SaveDialog.Free;
      end;
      SSaveScriptAsOperation(ActionContext);
    end;
  finally
    ActionContext.Free;
  end;
end;

// SCRIPT/SAVE SCRIPT AS OPERATION
procedure TForm1.SSaveScriptAsOperation(AActionContext: TActionContext);
var
  Filename: string;
  Message:  string;
begin
  Filename := AActionContext.SArg1;
  // create backup
  try
    if FileExists(Filename) then RenameFile(Filename, Filename + '.bak');
  except
    SysConsole1.WriteMessage(MSG02 + MSG84);
  end;
  // save file
  try
    FScriptBuffer.SaveToFile(FileName);
  except
    Message := MSG01 + Format(MSG49, [FileName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  SysConsole1.WriteMessage(Format(MSG83, [FActualScript]));
  FActualScript := Filename;                                            // named
  Form6.SetFilename(FActualScript);
  FActualScriptIsSaved := True;                               // no need to save
  Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualScript);
  // refresh and show ScriptEditor
  Form6.ClearModified;
end;

// SCRIPT/RUN SCRIPT ACTION ----------------------------------------------------
procedure TForm1.SRunScriptExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('RUSC') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    SRunScriptOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// SCRIPT/RUN SCRIPT OPERATION
procedure TForm1.SRunScriptOperation(AActionContext: TActionContext);
var
  Counter:    Variant;
  CmdResult:  Integer;
  CurrentCmd: string;
  i:          Integer;
  NewCounter: Variant;
begin
  if FScriptIsRunning then Exit;
  //
  CommandEngine2.FScriptRuntime.GetRegister('C', Counter);
  // initialization, if starting from the beginning of the script
  if Counter = 0 then
  begin
    // clear content of the internal modules
    if Assigned(Form3) then Form3.Invalidate;                       // HexViewer
    if Assigned(Form4) then Form4.ClearContent;                     // RunLogger
    if Assigned(Form6) then Form6.CopyBufferToEditor;            // ScriptEditor
    if Assigned(Form8) then Form8.ClearContent;                     // IntLogger
    if Assigned(Form12) then Form12.ClearContent;               // ScriptConsole
    if Assigned(Form14) then Form14.ClearContent;                   // BusLogger
    // removal of remaining modules and bus contacts
    DestroyAllModules(False);
    FProcInstanceDict.Clear;
    FMemInstanceDict.Clear;
    FPortInstanceDict.Clear;
    SetLength(FSysBus.FIOPorts, 0);
    SetLength(FSysBus.FMemories, 0);
    SetLength(FSysBus.FCPUs, 0);
    // close visual components
    for i := Screen.FormCount - 1 downto 0 do
      if (Screen.Forms[i] <> Application.MainForm) and
         (Screen.Forms[i] <> Form6) and
         Screen.Forms[i].Visible
        then Screen.Forms[i].Close;
    // copy ScriptEditor content to script buffer
    Form6.CopyEditorToBuffer;
    if FScriptBuffer.Count = 0 then
    begin
      ShowMessage(MSG42);
      Exit;
    end;
    Form12.ClearContent;                                  // clear ScriptConsole
  end else
  begin
    // if the script buffer is empty
    if FScriptBuffer.Count = 0 then Exit;
  end;
  // open ScriptConsole
  if not Form12.Visible then Form12.Show;
  // run script
  FScriptIsRunning := True;
  try
    while Counter < FScriptBuffer.Count do
    begin
      // save line counter for compare next position
      CommandEngine2.FScriptRuntime.GetRegister('C', Counter);
      // execute line
      CurrentCmd := FScriptBuffer.Strings[Counter];
      CmdResult := CommandEngine2.ExecuteLine(CurrentCmd);
      if CmdResult < 0 then
      begin
        case CmdResult of
          -1: SysConsole1.WriteMessage(MSG01 + Format(MSG86, [CurrentCmd]));
          -2: SysConsole1.WriteMessage(MSG01 + Format(MSG88, [CurrentCmd]));
          -3: SysConsole1.WriteMessage(MSG01 + Format(MSG89, [CurrentCmd]));
          -4: SysConsole1.WriteMessage(MSG01 + Format(MSG87, [CurrentCmd]));
          -5: SysConsole1.WriteMessage(MSG02 + Format(MSG113, [CurrentCmd]));
          -6: SysConsole1.WriteMessage(MSG01 + Format(MSG10, [CurrentCmd]));
          -7: SysConsole1.WriteMessage(MSG01 + Format(MSG11, [CurrentCmd]));
          -8: SysConsole1.WriteMessage(MSG01 + Format(MSG12, [CurrentCmd]));
        end;
        Exit;
      end;
      // check whether there was a jump
      CommandEngine2.FScriptRuntime.GetRegister('C', NewCounter);
      if Counter = NewCounter then
      begin
        Counter := Counter + 1;
        CommandEngine2.FScriptRuntime.SetRegister('C', Counter, True);
      end else Counter := NewCounter;
      // refresh the GUI (to handle the Stop button or other one)
      Application.ProcessMessages;
      // if the Stop button was pressed
      if not FScriptIsRunning then Break;
    end;
  finally
    // post-stop cleanup
    if FScriptIsRunning then SStopScriptExecute(nil);
  end;
end;

// SCRIPT/RUN SCRIPT STEP BY STEP ACTION ---------------------------------------
procedure TForm1.SStepScriptExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('SESC') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    SStepScriptOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// SCRIPT/RUN SCRIPT STEP BY STEP OPERATION
procedure TForm1.SStepScriptOperation(AActionContext: TActionContext);
var
  CmdResult:  Byte;
  Counter:    Variant;
  CurrentCmd: string;
  i:          Integer;
  NewCounter: Variant;
begin
  if FScriptIsRunning then Exit;
  // position check
  CommandEngine2.FScriptRuntime.GetRegister('C', Counter);
  if (FScriptBuffer.Count > 0) and (Counter >= FScriptBuffer.Count) then Exit;
  // initialization, if starting from the beginning of the script
  if Counter = 0 then
  begin
    // removal of remaining modules and bus contacts
    DestroyAllModules(False);
    FProcInstanceDict.Clear;
    FMemInstanceDict.Clear;
    FPortInstanceDict.Clear;
    SetLength(FSysBus.FIOPorts, 0);
    SetLength(FSysBus.FMemories, 0);
    SetLength(FSysBus.FCPUs, 0);
    // clear content of the internal modules
    if Assigned(Form3) then Form3.Invalidate;                       // HexViewer
    if Assigned(Form4) then Form4.ClearContent;                     // RunLogger
    if Assigned(Form8) then Form8.ClearContent;                     // IntLogger
    if Assigned(Form11) then Form11.RefreshContent;                 // RegViewer
    if Assigned(Form12) then Form12.ClearContent;               // ScriptConsole
    if Assigned(Form14) then Form14.ClearContent;                   // BusLogger
    // close visual components
    for i := Screen.FormCount - 1 downto 0 do
      if (Screen.Forms[i] <> Application.MainForm) and
         (Screen.Forms[i] <> Form6) and Screen.Forms[i].Visible
        then Screen.Forms[i].Close;
    // copy ScriptEditor content to script buffer
    Form6.CopyEditorToBuffer;
    if FScriptBuffer.Count = 0 then
    begin
      ShowMessage(MSG42);
      Exit;
    end;
  end else
  begin
    // if the script buffer is empty
    if FScriptBuffer.Count = 0 then Exit;
  end;
  // open ScriptConsole
  if not Form12.Visible then Form12.Show;
  // run script
  FScriptIsRunning := True;
  try
    // execute line
    CurrentCmd := FScriptBuffer.Strings[Counter];
    CmdResult := CommandEngine2.ExecuteLine(CurrentCmd);
    if CmdResult < 0 then
    begin
      case CmdResult of
        -1: SysConsole1.WriteMessage(MSG01 + Format(MSG86, [CurrentCmd]));
        -2: SysConsole1.WriteMessage(MSG01 + Format(MSG88, [CurrentCmd]));
        -3: SysConsole1.WriteMessage(MSG01 + Format(MSG89, [CurrentCmd]));
        -4: SysConsole1.WriteMessage(MSG01 + Format(MSG87, [CurrentCmd]));
        -5: SysConsole1.WriteMessage(MSG02 + Format(MSG113, [CurrentCmd]));
        -6: SysConsole1.WriteMessage(MSG01 + Format(MSG10, [CurrentCmd]));
        -7: SysConsole1.WriteMessage(MSG01 + Format(MSG11, [CurrentCmd]));
        -8: SysConsole1.WriteMessage(MSG01 + Format(MSG12, [CurrentCmd]));
      end;
      Exit;
    end;
    // check whether there was a jump
    CommandEngine2.FScriptRuntime.GetRegister('C', NewCounter);
    if Counter = NewCounter then
    begin
      Counter := Counter + 1;
      CommandEngine2.FScriptRuntime.SetRegister('C', Counter, True);
    end;
  finally
    FScriptIsRunning := False;
    CommandEngine2.FScriptRuntime.GetRegister('C', Counter);
    // post-stop cleanup
    if Counter >= FScriptBuffer.Count then
    begin
      SStopScriptExecute(nil);
    end;
  end;
end;

// SCRIPT/STOP SCRIPT ACTION ---------------------------------------------------
procedure TForm1.SStopScriptExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
  if ActionNotAllowedUnderCPURun('STSC') then Exit;
  ActionContext := TActionContext.Create;
  try
    with ActionContext do
    begin
      ActionSource := asOther;
      if Sender is TAction then
      begin
        Caller := TAction(Sender).ActionComponent;
        if Caller is TMenuItem then
        begin
          if TMenuItem(Caller).GetParentMenu = Form1.MainMenu1
            then ActionSource := asMainMenu;
        end else ActionSource := asToolBar;
      end;
    end;
    SStopScriptOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// SCRIPT/STOP SCRIPT OPERATION
procedure TForm1.SStopScriptOperation(AActionContext: TActionContext);
begin
  CommandEngine2.FScriptRuntime.SetRegister('C', 0, True);
  FScriptIsRunning := False;
  Form12.ClearContent;                                    // clear ScriptConsole
  // stop simualtion
  try
    if Length(FSysBus.FCPUs) > 0 then
    begin
      SimulationThread1.CPU := FSysBus.FCPUs[0].CPU;
      SimulationThread1.CPUStop;
    end;
  except
  end;
end;

// HELP/SHOW HELP ACTION =======================================================
procedure TForm1.HHelpExecute(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','html/framework/index.html');
end;

// HELP/SHOW ABOUT ACTION ------------------------------------------------------
procedure TForm1.HAboutExecute(Sender: TObject);
begin
  Form2.ShowModal;
end;

// CONFIGURE I/O PORT MODULE
procedure TForm1.IOConfigureOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PortInfo:     TPortInfo;
  PropertyName: string;
  Value:        string;
begin
  InstanceName := Copy(AActionContext.SArg1, 1, Pos('.', AActionContext.SArg1) - 1);
  PropertyName := Copy(AActionContext.SArg1, Pos('.', AActionContext.SArg1) + 1, MaxInt);
  Value := AActionContext.SArg2;
  // find instance
  try
    PortInfo := FPortInstanceDict[InstanceName];
  except
    Message := MSG01 + Format(MSG101, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // set property
  try
    with PortInfo.Port do
    begin
      if SameText(PropertyName, uproperties.IOPropertyInfoArray[3].Name)
        then Enabled := StrToBool(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[5].Name)
             then BaseAddress := StrToInt('$' + Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[7].Name)
             then IntVector := StrToInt('$' + Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[8].Name)
             then DataInMode := DataInMode.FromString(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[9].Name)
             then DataInNegation := StrToBool(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[10].Name)
             then DataOutMode := DataOutMode.FromString(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[11].Name)
             then DataOutNegation := StrToBool(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[12].Name)
             then SelMode := SelMode.FromString(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[13].Name)
             then SelNegation := StrToBool(Value)
      else
      begin
        // property does not exist or is read-only
        Message := MSG01 + Format(MSG102, [InstanceName + '.' + PropertyName]);
        ShowMessage(Message);
        SysConsole1.WriteMessage(Message);
        AActionContext.HasError := True;
        Exit;
      end;
    end;
  except
    // invalid value
    Message := MSG01 + Format(MSG103, [InstanceName + '.' + PropertyName, Value]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG104, [InstanceName + '.' +
                           PropertyName, Value]));
end;

// CONFIGURE MEMORY MODULE
procedure TForm1.MConfigureOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
  Message:      string;
  PropertyName: string;
  Value:        string;
begin
  InstanceName := Copy(AActionContext.SArg1, 1, Pos('.', AActionContext.SArg1) - 1);
  PropertyName := Copy(AActionContext.SArg1, Pos('.', AActionContext.SArg1) + 1, MaxInt);
  Value := AActionContext.SArg2;
  // find instance
  try
    MemInfo := FMemInstanceDict[InstanceName];
  except
    Message := MSG01 + Format(MSG101, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // set property
  try
    with MemInfo.Memory do
    begin
      if SameText(PropertyName, uproperties.MPropertyInfoArray[3].Name)
        then Enabled := StrToBool(Value)

      else if SameText(PropertyName, uproperties.MPropertyInfoArray[4].Name)
             then BaseAddress := StrToInt(Value)

      else if SameText(PropertyName, uproperties.MPropertyInfoArray[5].Name)
             then AddressRangeSize := StrToInt(Value)

      else if SameText(PropertyName, uproperties.MPropertyInfoArray[6].Name)
             then MemoryMode := MemoryMode.FromString(Value)
      else
      begin
        // property does not exist or is read-only
        Message := MSG01 + Format(MSG102, [InstanceName + '.' + PropertyName]);
        ShowMessage(Message);
        SysConsole1.WriteMessage(Message);
        AActionContext.HasError := True;
        Exit;
      end;
    end;
  except
    // invalid value
    Message := MSG01 + Format(MSG103, [Value]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG104, [InstanceName + '.' +
                           PropertyName, Value]));
end;

// CONFIGURE CPU MODULE
procedure TForm1.PConfigureOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  ProcInfo:     TProcInfo;
  PropertyName: string;
  Value:        string;
begin
  InstanceName := Copy(AActionContext.SArg1, 1, Pos('.', AActionContext.SArg1) - 1);
  PropertyName := Copy(AActionContext.SArg1, Pos('.', AActionContext.SArg1) + 1, MaxInt);
  Value := AActionContext.SArg2;
  // find instance
  try
    ProcInfo := FProcInstanceDict[InstanceName];
  except
    Message := MSG01 + Format(MSG101, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // set property
  try
    with ProcInfo.Processor do
    begin
      if SameText(PropertyName, uproperties.PPropertyInfoArray[3].Name)
        then Enabled := StrToBool(Value) else
      begin
        // property does not exist or is read-only
        Message := MSG01 + Format(MSG102, [InstanceName + '.' + PropertyName]);
        ShowMessage(Message);
        SysConsole1.WriteMessage(Message);
        AActionContext.HasError := True;
        Exit;
      end;
    end;
  except
    // invalid value
    Message := MSG01 + Format(MSG103, [InstanceName + '.' + PropertyName, Value]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(Format(MSG104, [InstanceName + '.' +
                           PropertyName, Value]));
end;

// MOVE I/O MODUL PANEL
procedure TForm1.IOMovePanelOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  Message:      string;
  PLeft, PTop:  Integer;
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PLeft := StrToInt(Copy(AActionContext.SArg2, 1, Pos('-', AActionContext.SArg2) - 1));
    PTop := StrToInt(Copy(AActionContext.SArg2, Pos('-', AActionContext.SArg2) + 1, MaxInt));
  except
    Message := MSG01 + Format(MSG103, [AActionContext.SArg2]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // find instance
  try
    PortInfo := FPortInstanceDict[InstanceName];
  except
    Message := MSG01 + Format(MSG101, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // move panel
  try
    if PortInfo.Port.HasPanel
      then FPortPluginDict[PortInfo.ModuleName].FMovePanel(PortInfo.Port, PLeft, PTop);
  except
    // invalid value
    Message := MSG01 + Format(MSG103, [AActionContext.SArg2]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
end;

// RESIZE I/O MODUL PANEL
procedure TForm1.IOResizePanelOperation(AActionContext: TActionContext);
var
  InstanceName:    string;
  Message:         string;
  PWidth, PHeight: Integer;
  PortInfo:        TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PWidth := StrToInt(Copy(AActionContext.SArg2, 1, Pos('-', AActionContext.SArg2) - 1));
    PHeight := StrToInt(Copy(AActionContext.SArg2, Pos('-', AActionContext.SArg2) + 1, MaxInt));
  except
    Message := MSG01 + Format(MSG103, [AActionContext.SArg2]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // find instance
  try
    PortInfo := FPortInstanceDict[InstanceName];
  except
    Message := MSG01 + Format(MSG101, [InstanceName]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
  // resize panel
  try
    if PortInfo.Port.HasPanel
      then FPortPluginDict[PortInfo.ModuleName].FResizePanel(PortInfo.Port, PWidth, PHeight);
  except
    // invalid value
    Message := MSG01 + Format(MSG103, [AActionContext.SArg2]);
    ShowMessage(Message);
    SysConsole1.WriteMessage(Message);
    AActionContext.HasError := True;
    Exit;
  end;
end;

// ---- CREATE AND DESTROY EVENT HANDLERS ----

// CPU EVENT HANDLER
procedure TForm1.CPUEventHandler(Sender: TObject; Event: TCPUEvent);
begin
  if (Event = ceInstructionBoundary) { and (Sender is TCPU) } then
  begin
    // RunLogger
    Form4.AppendRecord(TCPU(Sender).GetCurrentInstruction);
    // RegViewer
    if Assigned(Form11) and Form11.Visible and
      (Form11.ProcInstance = TCPU(Sender)) then Form11.RefreshContent;
  end;
end;

// INTERRUPT HANDLER
procedure TForm1.InterruptHandler(Sender: TIOPort; AVector: Byte);
var
  IntLogRec: TIntLogRec;
  Pair: specialize TPair<string, TPortInfo>;
begin
  if Assigned(FSysBus.FCPUs[0].CPU) then
  begin
    // current processor
    FSysBus.FCPUs[0].CPU.IRQ(AVector);
    // IntLogger
    IntLogRec := FSysBus.FCPUs[0].CPU.GetCurrentInterrupt;
    for Pair in FPortInstanceDict do
      if Pair.Value.Port = Sender then
      begin
        IntLogRec.Sender := Pair.Key;
        Break;
      end;
    if Assigned(Form8) and Form8.Visible then Form8.AppendRecord(IntLogRec);
    // RegViewer
    if Assigned(Form11) and Form11.Visible and
      (Form11.ProcInstance = FSysBus.FCPUs[0].CPU) then Form11.RefreshContent;
  end;
end;

// GLOBAL REFRESH TICK FOR LOGS AND OTHERS
procedure TForm1.RefreshTimerTimer(Sender: TObject);
begin
  if SimulationThread1.Delay >= 100 then
  begin
    if Assigned(Form3) then Form3.RefreshContent;                   // HexViewer
    if Assigned(Form4) then Form4.RefreshContent;                   // RunLogger
    if Assigned(Form8) then Form8.RefreshContent;                   // IntLogger
    if Assigned(Form11) then Form11.RefreshContent;                 // RegViewer
    if Assigned(Form14) then Form14.RefreshContent;                 // BusLogger
  end;
end;

// CHANGE RUN DELAY
procedure TForm1.ComboBox1Change(Sender: TObject);
var
  s: string;
begin
  s := ComboBox1.Items[ComboBox1.ItemIndex];
  s := Copy(ComboBox1.Items[ComboBox1.ItemIndex], 1, Length(s) - 3);
  SimulationThread1.Delay := StrToInt(s);
  if SimulationThread1.Delay < 100 then SysConsole1.WriteMessage(MSG02 + MSG13);
end;

// ONCREATE EVENT
procedure TForm1.FormCreate(Sender: TObject);
var
  Error:   Boolean;
  i:       Integer;
begin
  // system bus
  FSysBus := TSysBus.Create;
  // command interpreters
  CommandEngine1 := TCommandEngine.Create;
  CommandEngine2 := TScriptEngine.Create;
  with CommandEngine2 do
  begin
    FReadPortFunc := @FSysBus.ReadPort;
    FReadMemoryFunc := @FSysBus.ReadMemory;
    FWritePortProc := @FSysBus.WritePort;
    FWriteMemoryProc := @FSysBus.WriteMemory;
  end;
  // SysConsole
  SysConsole1 := TSysConsole.Create(Self);
  SysConsole1.OnCommand := @SysConsole1CmdBridge;
  with SysConsole1 do
  begin
    Parent := Form1;
    Align := alClient;
  end;
  // simulation thread
  SimulationThread1 := TSimulationThread.Create;
  SimulationThread1.Start;
  ComboBox1Change(Sender);                                 // running delay time
  // general settings
  Error := False;
  Form1.Caption := Application.Title;
  // set actual project/script property
  FActualProject := '';
  FActualProjectIsSaved := True;
  FActualScript := '';
  FActualScriptIsSaved := True;
  CommandEngine2.FScriptRuntime.SetRegister('C', '0', True);
  // system language
  FSystemLanguage := GetLang;
  // directories
  FEXEDirectory := GetExeDir;
  FUserDirectory := GetUserDir;
  FWorkDirectory := FUserDirectory;
  SysConsole1.WriteMessage(Format(MSG109, [FWorkDirectory]));
  CommandEngine2.FScriptRuntime.SetRegister('B', FWorkDirectory, True);
  // set directory and load configuration
  {$IFDEF WINDOWS}
    FConfigDirectory := FUserDirectory + DirectorySeparator +
                        'Appdata' + DirectorySeparator +
                        'Local' + DirectorySeparator +
                        BASENAME + DirectorySeparator;
  {$ELSE}
    FConfigDirectory := FUserDirectory + DirectorySeparator +
                        '.config' + DirectorySeparator +
                        BASENAME + DirectorySeparator;
  {$ENDIF}
  ForceDirectories(FConfigDirectory);
  // load settings
  if not LoadConfiguration(FConfigDirectory + CONFIGFILE)
    then SysConsole1.WriteMessage(MSG01 + Format(MSG40, [FConfigDirectory + CONFIGFILE]))
    else
      with uconfig.AppConfig do
      begin
        // Main Form
        with MainFormConfig do
        begin
          Form1.Top := top;
          Form1.Left := left;
          Form1.Height := height;
          Form1.Width := width;
          Form1.Panel2.Width := splitter;
        end;
        // SysConsole
        with SysConsoleConfig do
        begin
          SysConsole1.Font.Color := font_color;
          SysConsole1.Color := bg_color;
        end;
      end;
  // set plugin directory and load plugins
  if FPluginDirectory = '' then
  begin
    {$IFDEF UNIX}
      FPluginDirectory := '/usr/local/lib/corelab';
      if not DirectoryExists(FPluginDirectory) then
      begin
        FPluginDirectory := '/usr/lib/corelab';
        if not DirectoryExists(FPluginDirectory) then
        begin
          FPluginDirectory := './library';
          if not DirectoryExists(FPluginDirectory) then
          begin
            ShowMessage(MSG01 + MSG04);
            Error := True;
          end;
        end;
      end;
    {$ELSE}
      FPluginDirectory := '.\library';
      if not DirectoryExists(FPluginDirectory) then
      begin
        ShowMessage(MSG01 + MSG04);
        Error := True;
      end;
    {$ENDIF}
  end;
  if not Error then
  begin
    i := LoadAllPlugins(FPluginDirectory);
    if i = -1 then
    begin
      ShowMessage(MSG01 + Format(MSG05, [FPluginDirectory]));
      Error := True;
    end else SysConsole1.WriteMessage(Format(MSG06, [IntToStr(i)]));
  end;
  if not Error then
  begin
    // create dictionaries for active component instances
    FProcInstanceDict := TProcInstanceDict.Create;
    FMemInstanceDict := TMemInstanceDict.Create;
    FPortInstanceDict := TPortInstanceDict.Create;
    // create script buffer
    FScriptBuffer := TStringList.Create;
    // create breakpoint list
    FBreakpointList := TBreakpointList.Create(True);
    // change operation mode
    ChangeOpMode(omInteractive, True, True);
  end else Application.Terminate;
  ActiveControl := SysConsole1;
end;

// SHOW FORM EVENT
procedure TForm1.FormShow(Sender: TObject);
begin
  // set SysConsole to active
  SysConsole1.SetFocus;
end;

// JOBS BEFORE CLOSE FORM
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // check unsaved project or script
  if (FOpMode <> omInteractive) then
  begin
    // check script
    if FActualScriptIsSaved = False then
      if not (MessageDlg(MSG43, MSG50, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        CanClose := False;
        Exit;
      end;
  end else
  begin
    // check project
    if FActualProjectIsSaved = False then
      if not (MessageDlg(MSG43, MSG57, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        CanClose := False;
        Exit;
      end;
  end;
  // stop running script or simulation
  if FOpMode <> omInteractive
    then SStopScriptExecute(Sender)
    else OStopExecute(Sender);
  // save settings
  with uconfig.AppConfig do
  begin
    // Main Form
    with MainFormConfig do
    begin
      top := Form1.Top;
      left := Form1.Left;
      height := Form1.Height;
      width := Form1.Width;
      splitter := Form1.Panel2.Width;
    end;
    // SysConsole
    with SysConsoleConfig do
    begin
      bg_color := SysConsole1.BGColor;
      font_color := SysConsole1.Font.Color;
    end;
    // Module Explorer
    with ModuleExplorerConfig do
    begin
      visible := Form9.Visible;
      top := Form9.Top;
      left := Form9.Left;
      height := Form9.Height;
      width := Form9.Width;
      splitter := Form9.TreeView1.Height;
      column0_width := Form9.ValueListEditor1.ColWidths[0];
    end;
    // BreakPoint Manager
    with BPManagerConfig do
    begin
      top := Form10.Top;
      left := Form10.Left;
      height := Form10.Height;
      width := Form10.Width;
    end;
    // BusLogger
    with BusLoggerConfig do
    begin
      top := Form14.Top;
      left := Form14.Left;
      height := Form14.Height;
      width := Form14.Width;
      with Form14.DrawGrid1.Columns do
      begin
        column0_width := Items[0].Width;
        column1_width := Items[1].Width;
        column2_width := Items[2].Width;
        column3_width := Items[3].Width;
        column4_width := Items[4].Width;
        column5_width := Items[5].Width;
      end;
    end;
    // RunLogger
    with RunLoggerConfig do
    begin
      top := Form4.Top;
      left := Form4.Left;
      height := Form4.Height;
      width := Form4.Width;
      with Form4.DrawGrid1.Columns do
      begin
        column0_width := Items[0].Width;
        column1_width := Items[1].Width;
        column2_width := Items[2].Width;
        column3_width := Items[3].Width;
        column4_width := Items[4].Width;
        column5_width := Items[5].Width;
      end;
    end;
    // IntLogger
    with IntLoggerConfig do
    begin
      top := Form8.Top;
      left := Form8.Left;
      height := Form8.Height;
      width := Form8.Width;
      with Form8.DrawGrid1.Columns do
      begin
        column0_width := Items[0].Width;
        column1_width := Items[1].Width;
        column2_width := Items[2].Width;
        column3_width := Items[3].Width;
      end;
    end;
    // RegViewer
    with RegViewerConfig do
    begin
      top := Form11.Top;
      left := Form11.Left;
      height := Form11.Height;
      width := Form11.Width;
      column0_width := Form11.ValueListEditor1.ColWidths[0];
    end;
    // HexViewer
    with HexViewerConfig do
    begin
      top := Form3.Top;
      left := Form3.Left;
      height := Form3.Height;
      width := Form3.Width;
    end;
    // ScriptEditor
    with ScriptEditorConfig do
    begin
      top := Form6.Top;
      left := Form6.Left;
      height := Form6.Height;
      width := Form6.Width;
    end;
    // ScriptConsole
    with ScriptConsoleConfig do
    begin
      top := Form12.Top;
      left := Form12.Left;
      height := Form12.Height;
      width := Form12.Width;
    end;
  end;
  if not SaveConfiguration(FConfigDirectory + CONFIGFILE)
    then ShowMessage(MSG01 + Format(MSG41, [FConfigDirectory + CONFIGFILE]));
  // go to destroy
  CanClose := True;
end;

// DESTROY EVENT
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // destroy modules and theirs dictionaries
  DestroyAllModules(True);
  // destroy system bus
  FSysBus.Free;
  // clear and destroy breakpoint list
  if Assigned(FBreakpointList) then
  begin
    FBreakpointList.Clear;
    FBreakpointList.Free;
  end;
  // clear and destroy script buffer
  if Assigned(FScriptBuffer) then
  begin
    FScriptBuffer.Clear;
    FScriptBuffer.Free;
  end;
  // simulation thread
  SimulationThread1.Free;
  // command interpreters
  if Assigned(CommandEngine1) then CommandEngine1.Free;
  if Assigned(CommandEngine2) then CommandEngine2.Free;
  // unload plugins
  UnLoadAllPlugins;
end;

end.

