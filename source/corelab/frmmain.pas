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
  CMem, Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ComCtrls, ActnList, StdCtrls, HelpIntfs, LazHelpCHM, LazHelpIntf, SynEdit,
  Process, Generics.Collections, frmabout, frmclasslist, frmmodulelist,
  frmrunlogger, frmsettings, frmexdepmemory, frmloadsavememory, frmhexviewer,
  frmregviewer, frmscripteditor, frmscriptconsole, frmintlogger, frmcaption,
  frmproperties, frmmoduleexplorer, frmbpmanager, commandengine, core_cpu,
  core_memory, core_ioport, usysconsole, ucommon, uconfig, uplugin, uproject,
  uintelhex, uactcontext, uproperties;
type
  // allocated simulation objects and its types
  TProcInfo = record
    Processor:     TCPU;
    ModuleName:    string;
    AttachedToBus: Boolean;
  end;
  TMemInfo = record
    Memory:        TMemory;
    ModuleName:    string;
    AttachedToBus: Boolean;
  end;
  TPortInfo = record
    Port:          TIOPort;
    ModuleName:    string;
    AttachedToBus: Boolean;
  end;
  TProcInstanceDict = specialize TDictionary<string, TProcInfo>;
  TMemInstanceDict = specialize TDictionary<string, TMemInfo>;
  TPortInstanceDict = specialize TDictionary<string, TPortInfo>;
  // operation mode type
  TOpMode = (omInteractive, omScript, omInterpreter);
  { TForm1 }
  TForm1 = class(TForm)
    MenuItem55: TMenuItem;
    ToolButton29: TToolButton;
    VModuleExplorer: TAction;
    ActionList1:              TActionList;
    CHMHelpDatabase1:         TCHMHelpDatabase;
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
    MenuItem14:               TMenuItem;
    MenuItem15:               TMenuItem;
    MenuItem16:               TMenuItem;
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
    MenuItem8:                TMenuItem;
    MenuItem9:                TMenuItem;
    MExamineDeposit:          TAction;
    MLoadMemoryContent:       TAction;
    MProperties:              TAction;
    MReset:                   TAction;
    MSaveMemoryContent:       TAction;
    OIRQ:                     TAction;
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
    ToolButton3:              TToolButton;
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
    ToolButton8:              TToolButton;
    ToolButton9:              TToolButton;
    VMoveResizeIOPanel:       TAction;
    VRenameIOPanel:           TAction;
    VShowBreakpointManager:   TAction;
    VShowHexViewer:           TAction;
    VShowIntLogger:           TAction;
    VShowIOPanel:             TAction;
    VShowRegViewer:           TAction;
    VShowRunLogger:           TAction;
    VShowScriptConsole:       TAction;
    VShowScriptEditor:        TAction;
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
    procedure OIRQExecute(Sender: TObject);
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
    procedure VModuleExplorerExecute(Sender: TObject);
    procedure VRenameIOPanelExecute(Sender: TObject);
    procedure VShowBreakpointManagerExecute(Sender: TObject);
    procedure VShowHexViewerExecute(Sender: TObject);
    procedure VShowIntLoggerExecute(Sender: TObject);
    procedure VShowIOPanelExecute(Sender: TObject);
    procedure VShowRegViewerExecute(Sender: TObject);
    procedure VShowRunLoggerExecute(Sender: TObject);
    procedure VShowScriptConsoleExecute(Sender: TObject);
    procedure VShowScriptEditorExecute(Sender: TObject);
  private
    // system console's command interpreter
    CommandEngine1:    TCommandEngine;
    // script buffer
    FScriptBuffer:     TStringList;
    // bridge between SysConsol and CommandEngine
    procedure SysConsole1CmdBridge(Sender: TObject; const ACommand: string);
    // check name duplication
    function InstanceNameDuplicated(AInstanceDict:  TMemInstanceDict; AKeyName: string): Boolean; overload;
    function InstanceNameDuplicated(AInstanceDict:  TPortInstanceDict; AKeyName: string): Boolean; overload;
    function InstanceNameDuplicated(AInstanceDict:  TProcInstanceDict; AKeyName: string): Boolean; overload;
    // others
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
    FOpMode:               TOpMode;                            // operation mode
    FPluginDirectory:      string;                   // directory of the plugins
    FScriptInstPointer:    integer;                   // next instruction number
    FScriptIsRunning:      Boolean;                      // script running state
    FStartupProject:       string;        // project file name from command line
    FStartupScript:        string;         // script file name from command line
    FSystemLanguage:       string;                            // system language
    FUserDirectory:        string;                           // user's directory
  public
    // active component instances
    FProcInstanceDict: TProcInstanceDict;
    FMemInstanceDict:  TMemInstanceDict;
    FPortInstanceDict: TPortInstanceDict;
    // system console
    SysConsole1:       TSysConsole;
    // action's operation metods
    // File menu
    procedure FNewProjectOperation(AActionContext: TActionContext);
    procedure FLoadProjectOperation(AActionContext: TActionContext);
    procedure FSaveProjectAsOperation(AActionContext: TActionContext);
    procedure FRestartApplicationOperation(AActionContext: TActionContext);
    procedure FExitOperation(AActionContext: TActionContext);
    // View menu
    procedure VShowModuleExplorerOperation(AActionContext: TActionContext);
    procedure VShowBreakpointManagerOperation(AActionContext: TActionContext);
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
    // Operation menu
    procedure ORunOperation(AActionContext: TActionContext);
    procedure OStepOperation(AActionContext: TActionContext);
    procedure OStopOperation(AActionContext: TActionContext);
    procedure ONMIOperation(AActionContext: TActionContext);
    procedure OIRQOperation(AActionContext: TActionContext);
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
var
  Form1: TForm1;

implementation

{$R *.lfm}
{ TForm1 }

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
  MSG86 = 'Unknown command.';                                             { SC }
  MSG87 = 'Invalid number of arguments.';                                 { SC }
  MSG88 = 'Cannot be used in command line.';                              { SC }
  MSG89 = 'Cannot be used in script.';                                    { SC }
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

// ---- PRIVATE METHODS ----

// BRIDGE BETWEEN SYSCONSOL AND COMMANDENGINE
procedure TForm1.SysConsole1CmdBridge(Sender: TObject; const ACommand: string);
begin
  case CommandEngine1.ExecuteLine(ACommand) of
    -1 : SysConsole1.WriteMessage(MSG01 + MSG86);
    -2 : SysConsole1.WriteMessage(MSG01 + MSG88);
    -3 : SysConsole1.WriteMessage(MSG01 + MSG87);
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
  FOpMode := AOpMode;
  // stop running script or simulation
  if FOpMode <> omInteractive
    then SStopScriptExecute(Nil)
    else OStopExecute(Nil);
  // enable/disable MenuItems and ToolBars for required OpMode
  if FOpMode = omInteractive then
  begin
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
    ToolBar2.Enabled := True;
    ToolBar3.Enabled := True;
    ToolBar4.Enabled := True;
    ToolBar5.Enabled := True;
    ToolBar6.Enabled := False;
    ToolButton64.Enabled := False;
    ToolButton65.Enabled := False;
  end else
  begin
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
    ToolBar2.Enabled := False;
    ToolBar3.Enabled := False;
    ToolBar4.Enabled := False;
    ToolBar5.Enabled := False;
    ToolBar6.Enabled := True;
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
  FScriptInstPointer := 0;
  // clear active component instances
  DestroyAllModules(False);
  FProcInstanceDict.Clear;
  FMemInstanceDict.Clear;
  FPortInstanceDict.Clear;
  // clear script buffer and refresh ScriptEditor;
  FScriptBuffer.Clear;
  // clear content of the internal modules
  if Assigned(Form3) then Form3.Invalidate;                         // HexViewer
  if Assigned(Form4) then Form4.ClearContent;                       // RunLogger
  if Assigned(Form6) then Form6.CopyBufferToEditor;              // ScriptEditor
  if Assigned(Form8) then Form8.ClearContent;                       // IntLogger
  if Assigned(Form12) then Form12.ClearContent;                 // ScriptConsole
  // close internal modules
  for i := Screen.FormCount - 1 downto 0 do
    if (Screen.Forms[i] <> Application.MainForm) and
        Screen.Forms[i].Visible then Screen.Forms[i].Close;
  // write message to console
  if FOpMode = omInteractive
    then SysConsole1.WriteMessage(MSG03 + MSG07)
    else SysConsole1.WriteMessage(MSG03 + MSG08);
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
      FPortInstanceDict.Remove(KeyName);
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
      FProcInstanceDict.Remove(KeyName);
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
      FMemInstanceDict.Remove(KeyName);
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
begin
  ChangeOpMode(omInteractive, False, False);
  if Length(FStartupProject) > 0 then LoadProject(FStartupProject);
end;

// SET SCRIPT MODE AT STARTUP
procedure TForm1.SetScriptMode;
begin
  ChangeOpMode(omScript, False, False);
  if Length(FStartupScript) > 0 then
  begin
    try
      FScriptBuffer.LoadFromFile(FStartupScript);
      SysConsole1.WriteMessage(MSG03 + Format(MSG82, [FStartupScript]));
    except
      ShowMessage(MSG01 + Format(MSG48, [FStartupScript]));
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
  ChangeOpMode(omInteractive, False, True);
end;

// FILE/SWITCH TO SCRIPT MODE ACTION -------------------------------------------
procedure TForm1.FSwitchToScriptModeExecute(Sender: TObject);
begin
  ChangeOpMode(omScript, False, True);
end;

// FILE/CREATE NEW PROJECT ACTION ----------------------------------------------
procedure TForm1.FNewProjectExecute(Sender: TObject);
begin
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
          InitialDir := GetUserDir;
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
begin
  Filename := AActionContext.SArg1;
  FActualProjectIsSaved := True;
  // clearing
  ChangeOpMode(omScript, True, True);
  // loading
  try
    LoadProject(Filename);
    SysConsole1.WriteMessage(MSG03 + Format(MSG80, [Filename]));
  except
    ShowMessage(MSG01 + Format(MSG55, [Filename]));
    exit;
  end;
  FActualProject := Filename;                                 // with filename
  FActualProjectIsSaved := True;                            // no need to save
  Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualScript);
end;

// FILE/SAVE PROJECT ACTION ----------------------------------------------------
procedure TForm1.FSaveProjectExecute(Sender: TObject);
begin
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
      ShowMessage(MSG01 + Format(MSG56, [FActualProject]));
      Exit;
    end else SysConsole1.WriteMessage(MSG03 + Format(MSG81, [FActualProject]));
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
          InitialDir := GetUserDir;
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
    ShowMessage(MSG01 + Format(MSG56, [Filename]));
    Exit;
  end else SysConsole1.WriteMessage(MSG03 + MSG81);
  FActualProject := Filename;                                           // named
  FActualProjectIsSaved := True;                              // no need to save
  Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualProject);
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
      Form8.RefreshColors;                                          // IntLogger
      Form4.RefreshColors;                                          // RunLogger
      Form12.RefreshColors;                                     // ScriptConsole
      Form6.RefreshColors;                                       // ScriptEditor
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
  Form10.ShowModal;
end;

// VIEW/SHOW RUNLOGGER ACTION --------------------------------------------------
procedure TForm1.VShowRunLoggerExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
  except
    // error
    ShowMessage(MSG01 + Format(MSG91, [InstanceName]));
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
  InstanceName: string;
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
  except
    // error
    ShowMessage(MSG01 + Format(MSG91, [InstanceName]));
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
            SArg1 := PanelCaption;
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
  NewCaption:      string;
  InstanceName: string;
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
    ShowMessage(MSG01 + Format(MSG92, [InstanceName]));
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
    ShowMessage(MSG01 + Format(MSG93, [InstanceName]));
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
          for KeyName in FProcPluginDict.Keys do StringList.Add(KeyName);
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
      ShowMessage(MSG01 + Format(MSG90, ['processor', InstanceName]));
      Exit;
    end;
    // store
    FProcInstanceDict.Add(InstanceName, ProcInfo);
    // add to Module Explorer
    Form9.AddNode('Processor', InstanceName);
    // report
    SysConsole1.WriteMessage(MSG03 + Format(MSG58, ['cpu', InstanceName]));
  end else ShowMessage(MSG01 + Format(MSG85, [InstanceName]));
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
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // destroy
    FProcPluginDict[ProcInfo.ModuleName].FDestroy(ProcInfo.Processor);
  except
    // error
    ShowMessage(MSG01 + Format(MSG94, [InstanceName]));
    Exit;
  end;
  // remove from dict
  FProcInstanceDict.Remove(InstanceName);
  // remove from Module Explorer
  Form9.DeleteNode('Processor', InstanceName);
  Form9.ValueListEditor1.Clear;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG60, [InstanceName]));
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
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // reset
    ProcInfo.Processor.Reset;
  except
    // error
    ShowMessage(MSG01 + Format(MSG95, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG62, [InstanceName]));
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
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // enable
    ProcInfo.Processor.Enabled := True;
  except
    // error
    ShowMessage(MSG01 + Format(MSG96, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG64, [InstanceName]));
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
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // disable
    ProcInfo.Processor.Enabled := False;
  except
    // error
    ShowMessage(MSG01 + Format(MSG97, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG66, [InstanceName]));
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
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // attach to bus
    {...}
  except
    // error
    ShowMessage(MSG01 + Format(MSG98, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG68, [InstanceName]));
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
  ProcInfo:     TProcInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    ProcInfo := FProcInstanceDict[InstanceName];
    // detach to bus
    {...}
  except
    // error
    ShowMessage(MSG01 + Format(MSG99, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG70, [InstanceName]));
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
          for KeyName in FMemPluginDict.Keys do StringList.Add(KeyName);
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
      ShowMessage(MSG01 + Format(MSG90, ['memory', InstanceName]));
      Exit;
    end;
    // store
    FMemInstanceDict.Add(InstanceName, MemInfo);
    // add to Module Explorer
    Form9.AddNode('Memory', InstanceName);
    // report
    SysConsole1.WriteMessage(MSG03 + Format(MSG58, ['memory', InstanceName]));
  end else ShowMessage(MSG01 + Format(MSG85, [InstanceName]));
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
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // destroy
    FMemPluginDict[MemInfo.ModuleName].FDestroy(MemInfo.Memory);
  except
    // error
    ShowMessage(MSG01 + Format(MSG94, [InstanceName]));
    Exit;
  end;
  // remove from dict
  FMemInstanceDict.Remove(InstanceName);
  // remove from Module Explorer
  Form9.DeleteNode('Memory', InstanceName);
  Form9.ValueListEditor1.Clear;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG60, [InstanceName]));
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
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // reset
    MemInfo.Memory.Reset;
  except
    // error
    ShowMessage(MSG01 + Format(MSG95, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG62, [InstanceName]));
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
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // enable
    MemInfo.Memory.Enabled := True;
  except
    // error
    ShowMessage(MSG01 + Format(MSG96, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG64, [InstanceName]));
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
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // disable
    MemInfo.Memory.Enabled := False;
  except
    // error
    ShowMessage(MSG01 + Format(MSG97, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG66, [InstanceName]));
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
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // attach to bus
    {...}
  except
    // error
    ShowMessage(MSG01 + Format(MSG98, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG68, [InstanceName]));
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
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // detach to bus
    {...}
  except
    // error
    ShowMessage(MSG01 + Format(MSG99, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG70, [InstanceName]));
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
begin
  InstanceName := AActionContext.SArg1;
  begin
    try
      MemInfo := FMemInstanceDict[InstanceName];
    except
      ShowMessage(MSG01 + Format(MSG101, [InstanceName]));
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
            InitialDir := GetUserDir;
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
procedure TForm1.MLoadMemoryContentOperation(
  AActionContext: TActionContext);
var
  AddressFrom:  DWord;
  ByteCount:    DWord;
  Filename:     string;
  InstanceName: string;
  LoadStream:   TMemoryStream;
  MemInfo:      TMemInfo;
begin
  InstanceName := AActionContext.SArg1;
  Filename := AActionContext.SArg2;
  try
    MemInfo := FMemInstanceDict[InstanceName];
  except
    on E: Exception do
    begin
      ShowMessage(MSG01 + Format(MSG93, [InstanceName]));
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
        ShowMessage(MSG01 + Format(MSG31, [Filename]));
        Exit;
      end;
    end else
    begin
      // load from .hex
      MemInfo.Memory.Reset;
      case LoadFromIntelHexToStream(Filename, LoadStream) of
        1: begin ShowMessage(MSG01 + Format(MSG35, [Filename])); Exit; end;
        2: begin ShowMessage(MSG01 + MSG37); Exit; end;
        3: begin ShowMessage(MSG01 + MSG38); Exit; end;
      255: begin ShowMessage(MSG01 + MSG39); Exit; end;
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
    SysConsole1.WriteMessage(MSG03 + Format(MSG73, [Filename, InstanceName]));
  finally
    LoadStream.Free;
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
          InitialDir := GetUserDir;
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
begin
  Filename := AActionContext.SArg1;
  InstanceName := AActionContext.SArg2;
  try
    MemInfo := FMemInstanceDict[InstanceName];
  except
    on E: Exception do
    begin
      ShowMessage(MSG01 + Format(MSG93, [InstanceName]));
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
            ShowMessage(MSG01 + Format(MSG29, [Filename]));
            Exit;
          end;
        end;
      end else
      begin
        // save to .hex
        // complete memory image
        MemInfo.Memory.SaveToStream(SaveStream, 0, MemInfo.Memory.AddressRangeSize);
        case SaveToIntelHexFromStream(Filename, SaveStream) of
          1: begin ShowMessage(MSG01 + Format(MSG36, [Filename])); Exit; end;
        255: begin ShowMessage(MSG01 + MSG39); Exit; end;
        end;
      end;
      // report
      SysConsole1.WriteMessage(MSG03 + Format(MSG75, [Filename, InstanceName]));
    finally
      SaveStream.Free;
    end;
  finally
    // restore original module state
    MemInfo.Memory.Enabled := CurrentStatus;
  end;
end;

// MEMORY/EXAMINE-DEPOSIT ------------------------------------------------------
procedure TForm1.MExamineDepositExecute(Sender: TObject);
var
  Caller:         TComponent;
  KeyName:        string;
  ActionContext:  TActionContext;
  StringList:     TStringList;
begin
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
begin
  InstanceName := AActionContext.SArg1;
  try
    MemInfo := FMemInstanceDict[InstanceName];
    // store original status and enable module
    CurrentStatus := MemInfo.Memory.Enabled;
    MemInfo.Memory.Enabled := True;
    // examine/deposit
    With Form5 do
    begin
      MemInstance := MemInfo.Memory;
      ShowModal;
    end;
    // restore original status
    MemInfo.Memory.Enabled := CurrentStatus;
  except
    // error
    ShowMessage(MSG01 + Format(MSG93, [InstanceName]));
    MemInfo.Memory.Enabled := CurrentStatus;
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
          for KeyName in FPortPluginDict.Keys do StringList.Add(KeyName);
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
  ModuleType:   string;
  PortInfo:      TPortInfo;
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
      ShowMessage(MSG01 + Format(MSG90, ['i/o port', InstanceName]));
      Exit;
    end;
    // store
    FPortInstanceDict.Add(InstanceName, PortInfo);
    // add to Module Explorer
    Form9.AddNode('I/O port & device', InstanceName);
    // report
    SysConsole1.WriteMessage(MSG03 + Format(MSG58, ['i/o port', InstanceName]));
  end else ShowMessage(MSG01 + Format(MSG85, [InstanceName]));
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
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // destroy
    FPortPluginDict[PortInfo.ModuleName].FDestroy(PortInfo.Port);
  except
    // error
    ShowMessage(MSG01 + Format(MSG94, [InstanceName]));
    Exit;
  end;
  // remove from dict
  FPortInstanceDict.Remove(InstanceName);
  // remove from Module Explorer
  Form9.DeleteNode('I/O port & device', InstanceName);
  Form9.ValueListEditor1.Clear;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG60, [InstanceName]));
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
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // reset
    PortInfo.Port.Reset;
  except
    // error
    ShowMessage(MSG01 + Format(MSG95, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG62, [InstanceName]));
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
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // enable
    PortInfo.Port.Enabled := True;
  except
    // error
    ShowMessage(MSG01 + Format(MSG96, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG64, [InstanceName]));
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
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // disable
    PortInfo.Port.Enabled := False;
  except
    // error
    ShowMessage(MSG01 + Format(MSG97, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG66, [InstanceName]));
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
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // attach to bus
    {...}
  except
    // error
    ShowMessage(MSG01 + Format(MSG98, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG68, [InstanceName]));
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
  PortInfo:     TPortInfo;
begin
  InstanceName := AActionContext.SArg1;
  try
    PortInfo := FPortInstanceDict[InstanceName];
    // detach to bus
    {...}
  except
    // error
    ShowMessage(MSG01 + Format(MSG99, [InstanceName]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG70, [InstanceName]));
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

// OPERATION/RUN SIMULATION ACTION =============================================
procedure TForm1.ORunExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
  {...}
end;

// OPERATION/RUN SIMULATION STEP BY STEP ACTION --------------------------------
procedure TForm1.OStepExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
  {...}
end;

// OPERATION/STOP SIMULATION ACTION --------------------------------------------
procedure TForm1.OStopExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
  {...}
end;

// OPERATION/REQUEST NMI ACTION ------------------------------------------------
procedure TForm1.ONMIExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
  {...}
end;

// OPERATION/REQUEST IRQ ACTION ------------------------------------------------
procedure TForm1.OIRQExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
    OIRQOperation(ActionContext);
  finally
    ActionContext.Free;
  end;
end;

// OPERATION/REQUEST IRQ OPERATION
procedure TForm1.OIRQOperation(AActionContext: TActionContext);
begin
  {...}
end;

// OPERATION/RESET SIMULATION ACTION -------------------------------------------
procedure TForm1.OResetAllExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
begin
  {...}
end;

// OPERATION/MAKE SNAPSHOT ACTION ----------------------------------------------
procedure TForm1.OMakeSnapshotExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
            InitialDir := GetUserDir;
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
begin
  Filename := AActionContext.SArg1;
  FActualScriptIsSaved := True;
  // clearing
  ChangeOpMode(omScript, True, True);
  // loading
  try
    FScriptBuffer.LoadFromFile(FileName);
    SysConsole1.WriteMessage(MSG03 + Format(MSG82, [FileName]));
  except
    ShowMessage(MSG01 + Format(MSG48, [FileName]));
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
begin
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
      SysConsole1.WriteMessage(MSG03 + Format(MSG83, [FActualScript]));
      // refresh ScriptEditor
      Form6.ClearModified;
    except
      ShowMessage(MSG01 + Format(MSG49, [FActualScript]));
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
          InitialDir := GetUserDir;
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
  Filename:   string;
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
    SysConsole1.WriteMessage(MSG03 + Format(MSG83, [FActualScript]));
  except
    ShowMessage(MSG01 + Format(MSG49, [FileName]));
    Exit;
  end;
  FActualScript := Filename;                                        // named
  FActualScriptIsSaved := True;                           // no need to save
  Form1.Caption := Application.Title + ' - ' + ExtractFilename(FActualScript);
  // refresh and show ScriptEditor
  Form6.ClearModified;
  Form6.SetFilename(FActualScript);
end;

// SCRIPT/RUN SCRIPT ACTION ----------------------------------------------------
procedure TForm1.SRunScriptExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
begin
  if FScriptIsRunning then Exit;
  // Form6.Store(FScriptBuffer);         // store ScriptEditor content to buffer
  if FScriptBuffer.Count = 0 then ShowMessage(MSG42) else
  begin
    // Form12.Clear;                                      // clear ScriptConsole
    // if not Form12.Visible then Form12.Show;             // show ScriptConsole
    FScriptInstPointer := 0;
    {...}
  end;
end;

// SCRIPT/RUN SCRIPT STEP BY STEP ACTION ---------------------------------------
procedure TForm1.SStepScriptExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
begin
  if FScriptIsRunning then Exit;
  // if FScriptInstPointer = 0 then
  //   Form6.Store(FScriptBuffer);       // store ScriptEditor content to buffer
  if FScriptBuffer.Count = 0 then ShowMessage(MSG42) else
  begin
    // Form12.Clear;                                      // clear ScriptConsole
    // if not Form12.Visible then Form12.Show;             // show ScriptConsole
    {...}
  end;
end;

// SCRIPT/STOP SCRIPT ACTION ---------------------------------------------------
procedure TForm1.SStopScriptExecute(Sender: TObject);
var
  ActionContext: TActionContext;
  Caller:        TComponent;
begin
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
  FScriptInstPointer := 0;
  {...}
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
    ShowMessage(MSG01 + Format(MSG101, [InstanceName]));
    Exit;
  end;
  // set property
  try
    with PortInfo.Port do
    begin
      if SameText(PropertyName, uproperties.IOPropertyInfoArray[2].Name)
        then Enabled := StrToBool(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[6].Name)
             then IntVector := StrToInt(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[7].Name)
             then DataInMode := DataInMode.FromString(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[8].Name)
             then DataInNegation := StrToBool(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[9].Name)
             then DataOutMode := DataOutMode.FromString(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[10].Name)
             then DataOutNegation := StrToBool(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[11].Name)
             then SelMode := SelMode.FromString(Value)

      else if SameText(PropertyName, uproperties.IOPropertyInfoArray[12].Name)
             then SelNegation := StrToBool(Value)
      else
      begin
        // property does not exist or is read-only
        ShowMessage(MSG01 + Format(MSG102, [InstanceName + '.' + PropertyName]));
        Exit;
      end;
    end;
  except
    // invalid value
    ShowMessage(MSG01 + Format(MSG103, [InstanceName + '.' + PropertyName, Value]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG104, [InstanceName + '.' +
                           PropertyName, Value]));
end;

// CONFIGURE MEMORY MODULE
procedure TForm1.MConfigureOperation(AActionContext: TActionContext);
var
  InstanceName: string;
  MemInfo:      TMemInfo;
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
    ShowMessage(MSG01 + Format(MSG101, [InstanceName]));
    Exit;
  end;
  // set property
  try
    with MemInfo.Memory do
    begin
      if SameText(PropertyName, uproperties.MPropertyInfoArray[3].Name)
        then Enabled := StrToBool(Value)

      else if SameText(PropertyName, uproperties.MPropertyInfoArray[5].Name)
             then AddressRangeSize := StrToInt(Value)

      else if SameText(PropertyName, uproperties.MPropertyInfoArray[6].Name)
             then MemoryMode := MemoryMode.FromString(Value)
      else
      begin
        // property does not exist or is read-only
        ShowMessage(MSG01 + Format(MSG102, [InstanceName + '.' + PropertyName]));
        Exit;
      end;
    end;
  except
    // invalid value
    ShowMessage(MSG01 + Format(MSG103, [Value]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG104, [InstanceName + '.' +
                           PropertyName, Value]));
end;

// CONFIGURE CPU MODULE
procedure TForm1.PConfigureOperation(AActionContext: TActionContext);
var
  InstanceName: string;
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
    ShowMessage(MSG01 + Format(MSG101, [InstanceName]));
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
        ShowMessage(MSG01 + Format(MSG102, [InstanceName + '.' + PropertyName]));
        Exit;
      end;
    end;
  except
    // invalid value
    ShowMessage(MSG01 + Format(MSG103, [InstanceName + '.' + PropertyName, Value]));
    Exit;
  end;
  // report
  SysConsole1.WriteMessage(MSG03 + Format(MSG104, [InstanceName + '.' +
                           PropertyName, Value]));
end;

// ---- CREATE AND DESTROY EVENT HANDLERS ----

// ONCREATE EVENT
procedure TForm1.FormCreate(Sender: TObject);
var
  Error: Boolean;
  i:     Integer;
begin
  // SysConsole and its command interpreter
  CommandEngine1 := TCommandEngine.Create;
  SysConsole1 := TSysConsole.Create(Self);
  SysConsole1.OnCommand := @SysConsole1CmdBridge;
  with SysConsole1 do
  begin
    Parent := Form1;
    Align := alClient;
  end;
  // general settings
  Error := False;
  Form1.Caption := Application.Title;
  // set actual project/script property
  FActualProject := '';
  FActualProjectIsSaved := True;
  FActualScript := '';
  FActualScriptIsSaved := True;
  FScriptInstPointer := 0;
  // set general fields
  FEXEDirectory := GetExeDir;
  FSystemLanguage := GetLang;
  FUserDirectory := GetUserDir;
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
          FPluginDirectory := './lib';
          if not DirectoryExists(FPluginDirectory) then
          begin
            ShowMessage(MSG01 + MSG04);
            Error := True;
          end;
        end;
      end;
    {$ELSE}
      FPluginDirectory := '.\lib';
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
    end else SysConsole1.WriteMessage(MSG03 + Format(MSG06, [IntToStr(i)]));
  end;
  if not Error then
  begin
    // create dictionaries for active component instances
    FProcInstanceDict := TProcInstanceDict.Create;
    FMemInstanceDict := TMemInstanceDict.Create;
    FPortInstanceDict := TPortInstanceDict.Create;
    // create script buffer
    FScriptBuffer := TStringList.Create;
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
  // clear and destroy script buffer
  if Assigned(FScriptBuffer) then
  begin
    FScriptBuffer.Clear;
    FScriptBuffer.Free;
  end;
  // unload plugins
  UnLoadAllPlugins;
end;

end.

