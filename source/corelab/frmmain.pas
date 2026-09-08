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
  ComCtrls, ActnList, StdCtrls, HelpIntfs, LazHelpCHM, LazHelpIntf, Process,
  Generics.Collections, frmabout, frmclasslist, frmmodulelist, frmrunlogger,
  frmsettings, frmexdepmemory, frmloadsavememory, core_cpu, core_memory,
  core_ioport, usysconsole, ucommon, uconfig, uplugin, uproject;
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
    IOPorperties:             TAction;
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
    MenuItem8:                TMenuItem;
    MenuItem9:                TMenuItem;
    MExamineDeposit:          TAction;
    MLoadMemoryContent:       TAction;
    MProperties:              TAction;
    MReset:                   TAction;
    MSaveMemoryContent:       TAction;
    OClearAllBreakpoints:     TAction;
    OIRQ:                     TAction;
    OMakeSnapshot:            TAction;
    ONMI:                     TAction;
    OResetAll:                TAction;
    ORestoreSnapshot:         TAction;
    ORun:                     TAction;
    OStep:                    TAction;
    OStop:                    TAction;
    OToggleBreakpoint:        TAction;
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
    procedure IOPorpertiesExecute(Sender: TObject);
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
    procedure OClearAllBreakpointsExecute(Sender: TObject);
    procedure OIRQExecute(Sender: TObject);
    procedure OMakeSnapshotExecute(Sender: TObject);
    procedure ONMIExecute(Sender: TObject);
    procedure OResetAllExecute(Sender: TObject);
    procedure ORestoreSnapshotExecute(Sender: TObject);
    procedure ORunExecute(Sender: TObject);
    procedure OStepExecute(Sender: TObject);
    procedure OStopExecute(Sender: TObject);
    procedure OToggleBreakpointExecute(Sender: TObject);
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
    procedure VMoveResizeIOPanelExecute(Sender: TObject);
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
    Memo1: TSysConsole;
    // active component instances
    FProcInstanceDict: TProcInstanceDict;
    FMemInstanceDict:  TMemInstanceDict;
    FPortInstanceDict: TPortInstanceDict;
    // script buffer
    FScriptBuffer:     TStringList;
    // global and project settings
    FAppConfig:        TAppConfig;                         // configuration data
    FAppProject:       TAppProject;                              // project data
    procedure ChangeOpMode(AOpMode: TOpMode; AForced: Boolean); // change opmode
    procedure SetIgnoreHelp(AIgnoreHelp: Boolean);
    procedure SetPluginDirectory(APluginDirectory: string);
  protected
    FActualProject:        string;                   // actual project directory
    FActualProjectIsSaved: Boolean;                  // actual project directory
    FActualScript:         string;                         // actual script file
    FActualScriptIsSaved:  Boolean;                        // actual script file
    FScriptInstPointer:    integer;                   // next instruction number
    FScriptIsRunning:      Boolean;                      // script running state
    FConfigDirectory:      string;                  // directory of the INI file
    FEXEDirectory:         string;                // directory of the executable
    FIgnoreHelp:           Boolean;                   // ignore search help file
    FOpMode:               TOpMode;                            // operation mode
    FPluginDirectory:      string;                   // directory of the plugins
    FSystemLanguage:       string;                            // system language
    FUserDirectory:        string;                           // user's directory
  public
    property IgnoreHelp: Boolean write SetIgnoreHelp;
    property PluginDirectory: string write SetPluginDirectory;
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
  MSG03 = 'NOTE:    ';                                                    { SC }
  MSG04 = 'Plugin directory does not exist.';                             { SM }
  MSG05 = 'Cannot load plugins from %s.';                                 { SM }
  MSG06 = '%s plugins loaded.';                                           { SC }
  MSG07 = 'The switch to interactive operation mode was successful.';     { SC }
  MSG08 = 'The switch to script operation mode was successful.';          { SC }
  MSG18 = 'Missing help file.';                                           { SC }
  MSG19 = 'Missing help viewer.';                                         { SC }
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
  MSG59 = 'Destroy';
  MSG60 = 'The module named ''%s'' was successfully destroyed.';          { SC }
  MSG61 = 'Reset';
  MSG62 = 'The module named ''%s'' has been restored.';                   { SC }
  MSG63 = 'Enable';
  MSG64 = 'The module named ''%s'' has been enabled.';                    { SC }
  MSG65 = 'Disable';
  MSG66 = 'The module named ''%s'' has been disabled.';                   { SC }
  MSG67 = 'Attach to the bus';
  MSG68 = 'The module named ''%s'' has been attached to the bus.';        { SC }
  MSG69 = 'Detach from the bus';
  MSG70 = 'The module named ''%s'' has been detached from the bus.';      { SC }
  MSG71 = 'Edit properties';
  MSG72 = 'Load content';
  MSG73 = 'Data loaded from ''%s'' into the module named ''%s''.';        { SC }
  MSG74 = 'Save content';
  MSG75 = 'Data saved from the module named ''%s'' to ''%s''.';           { SC }
  MSG76 = 'Rename panel';
  MSG77 = 'Move/resize panel';
  MSG78 = 'Show panel';

// ---- PRIVATE METHODS ----

// CHANGE OPERATION MODE
procedure TForm1.ChangeOpMode(AOpMode: TOpMode; AForced: Boolean);
var
  i: integer;
begin
  // forced change
  if (FOpMode = AOpMode) and (not AForced) then Exit;
  // change
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
    ToolBar2.Enabled := True;
    ToolBar3.Enabled := True;
    ToolBar4.Enabled := True;
    ToolBar5.Enabled := True;
    ToolBar6.Enabled := False;
  end else
  begin
    MenuItem3.Enabled := False;
    MenuItem4.Enabled := False;
    MenuItem5.Enabled := False;
    MenuItem6.Enabled := False;
    MenuItem7.Enabled := True;
    ToolBar2.Enabled := False;
    ToolBar3.Enabled := False;
    ToolBar4.Enabled := False;
    ToolBar5.Enabled := False;
    ToolBar6.Enabled := True;
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
  FProcInstanceDict.Clear;
  FMemInstanceDict.Clear;
  FPortInstanceDict.Clear;
  // clear script buffer and refresh ScriptEditor;
  FScriptBuffer.Clear;
  // clear content of the internal modules
  // if Assigned(Form3) then Form3.ClearContent;                    // HexViewer
  if Assigned(Form4) then Form4.ClearContent;                       // RunLogger
  // if Assigned(Form6) then Form6.ClearContent;                 // ScriptEditor
  // if Assigned(Form8) then Form8.ClearContent;                    // IntLogger
  // if Assigned(Form11) then Form11.ClearContent;                  // RegViewer
  // if Assigned(Form12) then Form12.ClearContent;              // ScriptConsole
  // close internal modules
  for i := Screen.FormCount - 1 downto 0 do
    if (Screen.Forms[i] <> Application.MainForm) and
        Screen.Forms[i].Visible then Screen.Forms[i].Close;
  // write message to console
  if FOpMode = omInteractive
    then Memo1.WriteMessage(MSG03 + MSG07)
    else Memo1.WriteMessage(MSG03 + MSG08);
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
      if not CHMFileExists then Memo1.WriteMessage(MSG02 + MSG18);
      if not CHMViewerExists then Memo1.WriteMessage(MSG02 + MSG19);
    end;
  end;
  HHelp.Enabled := CHMFileExists and CHMViewerExists and not FIgnoreHelp;
end;

// SET PLUGIN DIRECTORY
procedure TForm1.SetPluginDirectory(APluginDirectory: string);
begin
  FPluginDirectory := APluginDirectory;
end;

// ---- ACTION HANDLER METHODS ----

// FILE/SWITCH TO INTERACTIVE MODE
procedure TForm1.FSwitchToInteractiveModeExecute(Sender: TObject);
begin
  ChangeOpMode(omInteractive, False);
end;

// FILE/SWITCH TO SCRIPT MODE
procedure TForm1.FSwitchToScriptModeExecute(Sender: TObject);
begin
  ChangeOpMode(omScript, False);
end;

// FILE/CREATE NEW PROJECT
procedure TForm1.FNewProjectExecute(Sender: TObject);
begin
  ChangeOpMode(omInteractive, True)
end;

// FILE/LOAD EXISTING PROJECT
procedure TForm1.FLoadProjectExecute(Sender: TObject);
var
  Filename:   string;
  OpenDialog: TOpenDialog;
begin
  // check actual script status
  if not FActualProjectIsSaved then
    if MessageDlg(MSG43, MSG51, mtConfirmation, [mbYes, mbNo], 0) = mrNo
      then Exit;
  // select file
  OpenDialog := TOpenDialog.Create(Form1);
  try
    with OpenDialog do
    begin
      InitialDir := GetUserDir;
      Title := MSG53;
      Filter := MSG52;
    end;
    if OpenDialog.Execute then
    begin
      Filename := OpenDialog.FileName;
      FActualProjectIsSaved := True;
      // clearing
      ChangeOpMode(omScript, True);
      // loading
      try
        LoadProject(FileName, FAppProject)
      except
        ShowMessage(MSG01 + Format(MSG55, [FileName]));
        exit;
      end;
      FActualProject := Filename;                               // with filename
      FActualProjectIsSaved := True;                          // no need to save
      Form1.Caption := Application.Title + ' - ' + FActualScript;
    end;
  finally
    OpenDialog.Free;
  end; end;

// FILE/SAVE PROJECT
procedure TForm1.FSaveProjectExecute(Sender: TObject);
begin
  if FActualProjectIsSaved then Exit;
  if Length(FActualProject) = 0 then FSaveProjectAsExecute(Sender) else
  begin
    if not SaveProject(FActualProject, FAppProject) then
    begin
      ShowMessage(MSG01 + Format(MSG56, [FActualProject]));
      Exit;
    end;
    FActualProjectIsSaved := True;                            // no need to save
  end;
end;

// FILE/SAVE PROJECT AS
procedure TForm1.FSaveProjectAsExecute(Sender: TObject);
var
  Filename:   string;
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(Form1);
  try
    with SaveDialog do
    begin
      InitialDir := GetUserDir;
      Title := MSG54;
      Filter := MSG52;
    end;
    if SaveDialog.Execute then
    begin
      Filename := SaveDialog.FileName;
      if not SaveProject(Filename, FAppProject) then
      begin
        ShowMessage(MSG01 + Format(MSG56, [Filename]));
        Exit;
      end;
      FActualProject := Filename;                                       // named
      FActualProjectIsSaved := True;                          // no need to save
      Form1.Caption := Application.Title + ' - ' + FActualProject;
    end;
  finally
    SaveDialog.Free;
  end;
end;

// FILE/SETTINGS
procedure TForm1.FSettingsExecute(Sender: TObject);
begin
  with Form18 do
  begin
    // original settings
    SetFAppConfig(FAppConfig);
    if ShowModal = mrOk then
    begin
      // new settings
      FAppConfig := AppConfig;
      with FAppConfig do
      begin
        // refresh RunLogger
        Form4.InstCountColor := runlogger_instcount_color;
        Form4.AddressColor := runlogger_address_color;
        Form4.OpCodeColor := runlogger_opcode_color;
        Form4.MnemonicColor := runlogger_mnemonic_color;
        Form4.LineSelectorColor := runlogger_lineselector_color;
        Form4.BGColorOddLines := runlogger_bgcolor_odd;
        Form4.BGColorEvenLines := runlogger_bgcolor_even;
        Form4.Invalidate;
        // refresh SysConsole
        Memo1.Font.Color := sysconsole_font_color;
        Memo1.Color := sysconsole_bg_color;
        Memo1.Invalidate;
      end;
    end;
  end;
end;

// FILE/RESTART APPLICATION
procedure TForm1.FRestartApplicationExecute(Sender: TObject);
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

// FILE/EXIT TO OS
procedure TForm1.FExitExecute(Sender: TObject);
begin
  Close;
end;

// VIEW/SHOW BREAKPOINT MANAGER
procedure TForm1.VShowBreakpointManagerExecute(Sender: TObject);
begin
  {...}
end;

procedure TForm1.VShowHexViewerExecute(Sender: TObject);
begin

end;

// VIEW/SHOW RUNLOGGER
procedure TForm1.VShowRunLoggerExecute(Sender: TObject);
begin
  with FAppConfig do
  begin
    Form4.Top := runlogger_top;
    Form4.Left := runlogger_left;
    Form4.Height := runlogger_height;
    Form4.Width := runlogger_width;
    Form4.InstCountColor := runlogger_instcount_color;
    Form4.AddressColor := runlogger_address_color;
    Form4.OpCodeColor := runlogger_opcode_color;
    Form4.MnemonicColor := runlogger_mnemonic_color;
    Form4.LineSelectorColor := runlogger_lineselector_color;
    Form4.BGColorOddLines := runlogger_bgcolor_odd;
    Form4.BGColorEvenLines := runlogger_bgcolor_even;
  end;
  Form4.Show;
  Form4.BringToFront;
end;

// VIEW/SHOW INTLOGGER
procedure TForm1.VShowIntLoggerExecute(Sender: TObject);
begin
  {...}
end;

procedure TForm1.VShowIOPanelExecute(Sender: TObject);
begin

end;

procedure TForm1.VShowRegViewerExecute(Sender: TObject);
begin

end;

// VIEW/SHOW SCRIPTEDITOR
procedure TForm1.VShowScriptEditorExecute(Sender: TObject);
begin
  // Form6.Reload(FScriptBuffer);     // reload ScriptEditor content from buffer
  // if not Form6.Visible then Form6.Show;
end;

// VIEW/SHOW SCRIPTCONSOLE
procedure TForm1.VShowScriptConsoleExecute(Sender: TObject);
begin
  {...}
end;

// PROCESSOR/CREATE
procedure TForm1.PCreateExecute(Sender: TObject);
var
  KeyName:    string;
  ProcInfo:   TProcInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FProcPluginDict.Keys do StringList.Add(KeyName);
    with Form16 do
    begin
      PluginList := StringList;
      if ShowModal = mrOk then
      begin
        // create
        if Assigned(FProcPluginDict[SelectedKey].FCreate) then
        begin
          ProcInfo.Processor := FProcPluginDict[SelectedKey].FCreate();
          ProcInfo.ModuleName := SelectedKey;
          ProcInfo.AttachedToBus := False;
        end;
        // store
        FProcInstanceDict.Add(SelectedName, ProcInfo);
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG58, ['cpu', SelectedName]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// PROCESSOR/DESTROY
procedure TForm1.PDestroyExecute(Sender: TObject);
var
  KeyName:    string;
  ProcInfo:   TProcInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG59;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        ProcInfo := FProcInstanceDict[SelectedKey];
        // destroy
        FProcPluginDict[ProcInfo.ModuleName].FDestroy(ProcInfo.Processor);
        // remove from dict
        FProcInstanceDict.Remove(SelectedKey);
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG60, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// PROCESSOR/RESET
procedure TForm1.PResetExecute(Sender: TObject);
var
  KeyName:    string;
  ProcInfo:   TProcInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG61;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        ProcInfo := FProcInstanceDict[SelectedKey];
        // reset
        ProcInfo.Processor.Reset;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG62, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// PROCESSOR/ENABLE
procedure TForm1.PEnableExecute(Sender: TObject);
var
  KeyName:    string;
  ProcInfo:   TProcInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG63;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        ProcInfo := FProcInstanceDict[SelectedKey];
        // enable
        ProcInfo.Processor.Enabled := True;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG64, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end; end;

// PROCESSOR/DISABLE
procedure TForm1.PDisableExecute(Sender: TObject);
var
  KeyName:    string;
  ProcInfo:   TProcInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FProcInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG65;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        ProcInfo := FProcInstanceDict[SelectedKey];
        // disable
        ProcInfo.Processor.Enabled := False;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG66, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// PROCESSOR/ATTACH TO BUS
procedure TForm1.PAttachToBusExecute(Sender: TObject);
begin
  {...}
end;

// PROCESSOR/DETACH FROM BUS
procedure TForm1.PDetachFromBusExecute(Sender: TObject);
begin
  {...}
end;

// PROCESSOR/PROPERTIES
procedure TForm1.PPropertiesExecute(Sender: TObject);
begin
  {...}
end;

// MEMORY/CREATE
procedure TForm1.MCreateExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemPluginDict.Keys do StringList.Add(KeyName);
    with Form16 do
    begin
      PluginList := StringList;
      if ShowModal = mrOk then
      begin
        // create
        if Assigned(FMemPluginDict[SelectedKey].FCreate) then
        begin
          MemInfo.Memory := FMemPluginDict[SelectedKey].FCreate();
          MemInfo.ModuleName := SelectedKey;
          MemInfo.AttachedToBus := False;
        end;
        // store
        FMemInstanceDict.Add(SelectedName, MemInfo);
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG58, ['memory', SelectedName]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// MEMORY/DESTROY
procedure TForm1.MDestroyExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG59;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        MemInfo := FMemInstanceDict[SelectedKey];
        // destroy
        FMemPluginDict[MemInfo.ModuleName].FDestroy(MemInfo.Memory);
        // remove from dict
        FMemInstanceDict.Remove(SelectedKey);
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG60, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// MEMORY/RESET
procedure TForm1.MResetExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG61;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        MemInfo := FMemInstanceDict[SelectedKey];
        // reset
        MemInfo.Memory.Reset;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG62, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// MEMORY/ENABLE
procedure TForm1.MEnableExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG63;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        MemInfo := FMemInstanceDict[SelectedKey];
        // enable
        MemInfo.Memory.Enabled := True;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG64, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// MEMORY/DISABLE
procedure TForm1.MDisableExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG65;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        MemInfo := FMemInstanceDict[SelectedKey];
        // disable
        MemInfo.Memory.Enabled := False;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG66, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// MEMORY/ATTACH TO BUS
procedure TForm1.MAttachToBusExecute(Sender: TObject);
begin
  {...}
end;

// MEMORY/DETACH FROM BUS
procedure TForm1.MDetachFromBusExecute(Sender: TObject);
begin
  {...}
end;

// MEMORY/PROPERTIES
procedure TForm1.MPropertiesExecute(Sender: TObject);
begin
  {...}
end;

// MEMORY/LOAD MEMORY CONTENT
procedure TForm1.MLoadMemoryContentExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG72;
      ModuleList := StringList;
    end;
    if Form17.ShowModal = mrOk then
    begin
      MemInfo := FMemInstanceDict[Form17.SelectedKey];

      // examine/deposit
      With Form5 do
      begin
        SetMemInstance(MemInfo.Memory);
        ShowModal;
      end;

      // report
//      Memo1.WriteMessage(MSG03 + Format(MSG73, [Filename, SelectedKey]));
    end;
  finally
    StringList.Free;
  end;
end;

// MEMORY/LOAD MEMORY CONTENT
procedure TForm1.MSaveMemoryContentExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG74;
      ModuleList := StringList;
    end;
    if Form17.ShowModal = mrOk then
    begin
      MemInfo := FMemInstanceDict[Form17.SelectedKey];

      // examine/deposit
      With Form5 do
      begin
        SetMemInstance(MemInfo.Memory);
        ShowModal;
      end;

      // report
//      Memo1.WriteMessage(MSG03 + Format(MSG75, [Filename, SelectedKey]));
    end;
  finally
    StringList.Free;
  end;
end;

// MEMORY/EXAMINE-DEPOSIT
procedure TForm1.MExamineDepositExecute(Sender: TObject);
var
  KeyName:    string;
  MemInfo:    TMemInfo;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FMemInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG61;
      ModuleList := StringList;
    end;
    if Form17.ShowModal = mrOk then
    begin
      MemInfo := FMemInstanceDict[Form17.SelectedKey];
      // examine/deposit
      With Form5 do
      begin
        SetMemInstance(MemInfo.Memory);
        ShowModal;
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// IO PORT/CREATE
procedure TForm1.IOCreateExecute(Sender: TObject);
var
  PortInfo: TPortInfo;
  KeyName:    string;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FPortPluginDict.Keys do StringList.Add(KeyName);
    with Form16 do
    begin
      PluginList := StringList;
      if ShowModal = mrOk then
      begin
        // create
        if Assigned(FPortPluginDict[SelectedKey].FCreate) then
        begin
          PortInfo.Port := FPortPluginDict[SelectedKey].FCreate();
          PortInfo.ModuleName := SelectedKey;
          PortInfo.AttachedToBus := False;
        end;
        // store
        FPortInstanceDict.Add(SelectedName, PortInfo);
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG58, ['i/o port', SelectedName]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// IO PORT/DESTROY
procedure TForm1.IODestroyExecute(Sender: TObject);
var
  KeyName:    string;
  StringList: TStringList;
  PortInfo: TPortInfo;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG59;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        PortInfo := FPortInstanceDict[SelectedKey];
        // destroy
        FPortPluginDict[PortInfo.ModuleName].FDestroy(PortInfo.Port);
        // remove from dict
        FPortInstanceDict.Remove(SelectedKey);
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG60, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// IO PORT/RESET
procedure TForm1.IOResetExecute(Sender: TObject);
var
  KeyName:    string;
  StringList: TStringList;
  PortInfo: TPortInfo;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG61;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        PortInfo := FPortInstanceDict[SelectedKey];
        // reset
        PortInfo.Port.Reset;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG62, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// IO PORT/ENABLE
procedure TForm1.IOEnableExecute(Sender: TObject);
var
  KeyName:    string;
  StringList: TStringList;
  PortInfo: TPortInfo;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG63;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        PortInfo := FPortInstanceDict[SelectedKey];
        // enable
        PortInfo.Port.Enabled := True;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG64, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// IO PORT/DISABLE
procedure TForm1.IODisableExecute(Sender: TObject);
var
  KeyName:    string;
  StringList: TStringList;
  PortInfo: TPortInfo;
begin
  StringList := TStringList.Create;
  try
    for KeyName in FPortInstanceDict.Keys do StringList.Add(KeyName);
    with Form17 do
    begin
      OKButtonCaption := MSG65;
      ModuleList := StringList;
      if ShowModal = mrOk then
      begin
        PortInfo := FPortInstanceDict[SelectedKey];
        // disable
        PortInfo.Port.Enabled := False;
        // report
        Memo1.WriteMessage(MSG03 + Format(MSG66, [SelectedKey]));
      end;
    end;
  finally
    StringList.Free;
  end;
end;

// IO PORT/ATTACH TO BUS
procedure TForm1.IOAttachToBusExecute(Sender: TObject);
begin

end;

// IO PORT/DETACH FROM BUS
procedure TForm1.IODetachFromBusExecute(Sender: TObject);
begin
  {...}
end;

// IO PORT/PROPERTIES
procedure TForm1.IOPorpertiesExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/RUN SIMULATION
procedure TForm1.ORunExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/RUN SIMULATION STEP BY STEP
procedure TForm1.OStepExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/STOP SIMULATION
procedure TForm1.OStopExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/REQUEST NMI
procedure TForm1.ONMIExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/REQUEST IRQ
procedure TForm1.OIRQExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/RESET SIMULATION
procedure TForm1.OResetAllExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/TOGGLE BREAKPOINTS
procedure TForm1.OToggleBreakpointExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/CLEAR ALL BREAKPOINT
procedure TForm1.OClearAllBreakpointsExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/MAKE SNAPSHOT
procedure TForm1.OMakeSnapshotExecute(Sender: TObject);
begin
  {...}
end;

// OPERATION/RESTORE SNAPSHOT
procedure TForm1.ORestoreSnapshotExecute(Sender: TObject);
begin
  {...}
end;

// SCRIPT/CREATE NEW SCRIPT, CLEAR BUFFER AND OPEN/REFRESH SCRIPTEDITOR
procedure TForm1.SNewScriptExecute(Sender: TObject);
begin
  ChangeOpMode(omScript, True);
  // Form6.Reload(FScriptBuffer);     // reload ScriptEditor content from buffer
  // if not Form6.Visible then Form6.Show;                  // show ScriptEditor
end;

// SCRIPT/LOAD SCRIPT
procedure TForm1.SLoadScriptExecute(Sender: TObject);
var
  Filename:   string;
  OpenDialog: TOpenDialog;
begin
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
    if OpenDialog.Execute then
    begin
      Filename := OpenDialog.FileName;
      FActualScriptIsSaved := True;
      // clearing
      ChangeOpMode(omScript, True);
      // loading
      try
        FScriptBuffer.LoadFromFile(FileName);
      except
        ShowMessage(MSG01 + Format(MSG48, [FileName]));
        exit;
      end;
      FActualScript := Filename;                                // with filename
      FActualScriptIsSaved := True;                           // no need to save
      Form1.Caption := Application.Title + ' - ' + FActualScript;
      // Form6.Reload(FScriptBuffer); // reload ScriptEditor content from buffer
      // if not Form6.Visible then Form6.Show;              // show ScriptEditor
    end;
  finally
    OpenDialog.Free;
  end;
end;

// SCRIPT/SAVE SCRIPT
procedure TForm1.SSaveScriptExecute(Sender: TObject);
begin
  if FActualScriptIsSaved then Exit;
  if Length(FActualScript) = 0 then SSaveScriptAsExecute(Sender) else
  begin
    try
      FScriptBuffer.SaveToFile(FActualScript);
    except
      ShowMessage(MSG01 + Format(MSG49, [FActualScript]));
      Exit;
    end;
    FActualScriptIsSaved := True;                             // no need to save
  end;
end;

// SCRIPT/SAVE SCRIPT AS
procedure TForm1.SSaveScriptAsExecute(Sender: TObject);
var
  Filename:   string;
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(Form1);
  try
    with SaveDialog do
    begin
      InitialDir := GetUserDir;
      Title := MSG47;
      Filter := MSG45;
    end;
    if SaveDialog.Execute then
    begin
      Filename := SaveDialog.FileName;
      try
        FScriptBuffer.SaveToFile(FileName);
      except
        ShowMessage(MSG01 + Format(MSG49, [FileName]));
        Exit;
      end;
      FActualScript := Filename;                                        // named
      FActualScriptIsSaved := True;                           // no need to save
      Form1.Caption := Application.Title + ' - ' + FActualScript;
    end;
  finally
    SaveDialog.Free;
  end;
end;

// SCRIPT/RUN SCRIPT
procedure TForm1.SRunScriptExecute(Sender: TObject);
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

// SCRIPT/RUN SCRIPT STEP BY STEP
procedure TForm1.SStepScriptExecute(Sender: TObject);
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

// SCRIPT/STOP SCRIPT
procedure TForm1.SStopScriptExecute(Sender: TObject);
begin
  FScriptInstPointer := 0;
  {...}
end;

procedure TForm1.VMoveResizeIOPanelExecute(Sender: TObject);
begin

end;

procedure TForm1.VRenameIOPanelExecute(Sender: TObject);
begin

end;

// ACTIONS/HELP/SHOW HELP
procedure TForm1.HHelpExecute(Sender: TObject);
begin
  ShowHelpOrErrorForKeyword('','html/framework/index.html');
end;

// ACTIONS/HELP/SHOW ABOUT
procedure TForm1.HAboutExecute(Sender: TObject);
begin
  Form2.ShowModal;
end;

// ---- CREATE AND DESTROY EVENT HANDLERS ----

// ONCREATE EVENT
procedure TForm1.FormCreate(Sender: TObject);
var
  Error: Boolean;
  i:     Integer;
begin
  Memo1 := TSysConsole.Create(Self);
  with Memo1 do
  begin
    Parent := Form1;
    Align := alClient;
    ReadOnly := True;
  end;
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
  if not LoadConfiguration(FConfigDirectory + CONFIGFILE, FAppConfig)
    then Memo1.WriteMessage(MSG01 + Format(MSG40, [FConfigDirectory + CONFIGFILE]))
    else
      with Memo1 do
      begin
        Font.Color := FAppConfig.sysconsole_font_color;
        Color := FAppConfig.sysconsole_bg_color;
      end;
  with FAppConfig do
  begin
    Top := frmmain_top;
    Left := frmmain_left;
    Height := frmmain_height;
    Width := frmmain_width;
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
    end else Memo1.WriteMessage(MSG03 + Format(MSG06, [IntToStr(i)]));
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
    ChangeOpMode(omInteractive, True);
  end else Application.Terminate;
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
  // save configuration
  with FAppConfig do
  begin
    // Form1
    frmmain_top := Top;
    frmmain_left := Left;
    frmmain_height := Height;
    frmmain_width := Width;
    sysconsole_bg_color := Memo1.BGColor;
    sysconsole_font_color := Memo1.Font.Color;
    // Form3
    {...}
    // Form4
    runlogger_top := Form4.Top;
    runlogger_left := Form4.Left;
    runlogger_height := Form4.Height;
    runlogger_width := Form4.Width;
    runlogger_instcount_color := Form4.InstCountColor;
    runlogger_address_color := Form4.AddressColor;
    runlogger_opcode_color := Form4.OpCodeColor;
    runlogger_mnemonic_color := Form4.MnemonicColor;
    runlogger_lineselector_color := Form4.LineSelectorColor;
    runlogger_bgcolor_odd := Form4.BGColorOddLines;
    runlogger_bgcolor_even := Form4.BGColorEvenLines;
    {...}
  end;
  if not SaveConfiguration(FConfigDirectory + CONFIGFILE, FAppConfig)
    then ShowMessage(MSG01 + Format(MSG41, [FConfigDirectory + CONFIGFILE]));
  // go to destroy
  CanClose := True;
end;

// DESTROY EVENT
procedure TForm1.FormDestroy(Sender: TObject);
begin
  // clear and destroy dictionaries
  if Assigned(FProcInstanceDict) then
  begin
    FProcInstanceDict.Clear;
    FProcInstanceDict.Free;
  end;
  if Assigned(FMemInstanceDict) then
  begin
    FMemInstanceDict.Clear;
    FMemInstanceDict.Free;
  end;
  if Assigned(FPortInstanceDict) then
  begin
    FPortInstanceDict.Clear;
    FPortInstanceDict.Free;
  end;
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

