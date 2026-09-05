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
  Generics.Collections, frmabout, frmscripteditor, core_cpu, core_memory,
  core_ioport, ucommon, uconfig, uplugin, uproject;
type
  // allocated simulation objects
  TProcInstanceDict = specialize TDictionary<string, TCPU>;
  TMemInstanceDict = specialize TDictionary<string, TMemory>;
  TPortInstanceDict = specialize TDictionary<string, TIOPort>;
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
    IOPorperties:             TAction;
    IOReset:                  TAction;
    LHelpConnector1:          TLHelpConnector;
    MainMenu1:                TMainMenu;
    MAttachToBus:             TAction;
    MCreate:                  TAction;
    MDestroy:                 TAction;
    MDetachFromBus:           TAction;
    Memo1:                    TMemo;
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
    MenuItem66:               TMenuItem;
    MenuItem68:               TMenuItem;
    MenuItem69:               TMenuItem;
    MenuItem7:                TMenuItem;
    MenuItem70:               TMenuItem;
    MenuItem71:               TMenuItem;
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
    PopupMenu1:               TPopupMenu;
    PopupMenu2:               TPopupMenu;
    PopupMenu3:               TPopupMenu;
    PProperties:              TAction;
    PReset:                   TAction;
    SClearScriptBuffer:       TAction;
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
    Separator23:              TMenuItem;
    Separator24:              TMenuItem;
    Separator25:              TMenuItem;
    Separator26:              TMenuItem;
    Separator27:              TMenuItem;
    Separator28:              TMenuItem;
    Separator29:              TMenuItem;
    Separator3:               TMenuItem;
    Separator30:              TMenuItem;
    Separator31:              TMenuItem;
    Separator32:              TMenuItem;
    Separator33:              TMenuItem;
    Separator34:              TMenuItem;
    Separator35:              TMenuItem;
    Separator36:              TMenuItem;
    Separator37:              TMenuItem;
    Separator38:              TMenuItem;
    Separator39:              TMenuItem;
    Separator4:               TMenuItem;
    Separator40:              TMenuItem;
    Separator41:              TMenuItem;
    Separator42:              TMenuItem;
    Separator43:              TMenuItem;
    Separator44:              TMenuItem;
    Separator45:              TMenuItem;
    Separator46:              TMenuItem;
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
    ToolButton6:              TToolButton;
    ToolButton7:              TToolButton;
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
    procedure IOCreateExecute(Sender: TObject);
    procedure MCreateExecute(Sender: TObject);
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
    procedure PCreateExecute(Sender: TObject);
    procedure SClearScriptBufferExecute(Sender: TObject);
    procedure SLoadScriptExecute(Sender: TObject);
    procedure SNewScriptExecute(Sender: TObject);
    procedure SRunScriptExecute(Sender: TObject);
    procedure SSaveScriptAsExecute(Sender: TObject);
    procedure SSaveScriptExecute(Sender: TObject);
    procedure SStepScriptExecute(Sender: TObject);
    procedure SStopScriptExecute(Sender: TObject);
    procedure VShowBreakpointManagerExecute(Sender: TObject);
    procedure VShowIntLoggerExecute(Sender: TObject);
    procedure VShowRunLoggerExecute(Sender: TObject);
    procedure VShowScriptConsoleExecute(Sender: TObject);
    procedure VShowScriptEditorExecute(Sender: TObject);
  private
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

resourcestring
  MSG01 = 'ERROR: ';
  MSG03 = 'Plugin directory does not exist.';
  MSG04 = 'Cannot load plugins from %s.';
  MSG05 = 'It is not a CoreLAB processor plugin.';
  MSG18 = 'Missing help file.';
  MSG19 = 'Missing help viewer.';
  MSG40 = 'Cannot load ''%s'' configuration file.';
  MSG41 = 'Cannot save ''%s'' configuration file.';
  MSG42 = 'No script, create or load one.';
  MSG43 = 'Confirmation';
  MSG44 = 'There is already a script, do you want to delete it?';
  MSG45 = 'CoreLAB scriptembly file|*.clsce|All file|*.*';
  MSG46 = 'Load script';
  MSG47 = 'Save script';
  MSG48 = 'Cannot load script from ''%s'' file.';
  MSG49 = 'Cannot save script to ''%s'' file.';
  MSG50 = 'The script is unsaved, should I continue?';
  MSG51 = 'There is already a project, do you want to delete it?';
  MSG52 = 'CoreLAB project file|*.clprj|All file|*.*';
  MSG53 = 'Load project';
  MSG54 = 'Save project';
  MSG55 = 'Cannot load project from ''%s'' file.';
  MSG56 = 'Cannot save project to ''%s'' file.';
  MSG57 = 'The project is unsaved, should I continue?';

// ---- PRIVATE METHODS ----

// CHANGE OPERATION MODE
procedure TForm1.ChangeOpMode(AOpMode: TOpMode; AForced: Boolean);
var
  i: integer;
begin
  // forced change
  if (FOpMode = AOpMode) and (not AForced) then Exit;
  // change
  if AOpMode = omInteractive then
  begin
    if not FActualScriptIsSaved then
      if MessageDlg(MSG43, MSG50, mtConfirmation, [mbYes, mbNo], 0) = mrNo
        then Exit;
    FOpMode := AOpMode;
    // enable/disable MenuItems and ToolBars
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
    if not FActualProjectIsSaved then
      if MessageDlg(MSG43, MSG57, mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
    FOpMode := AOpMode;
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
  // set new project value
  FActualProject := '';
  FActualProjectIsSaved := False;
  FActualScript := '';
  FActualScriptIsSaved := False;
  // clear active component instances
  FProcInstanceDict.Clear;
  FMemInstanceDict.Clear;
  FPortInstanceDict.Clear;
  // clear script buffer and refresh ScriptEditor;
  FScriptBuffer.Clear;
  // clear content of the internal modules
  // Form3.ClearContent;                                          // HexViewer
  // Form4.ClearContent;                                          // RunLogger
  // Form6.ClearContent;                                       // ScriptEditor
  // Form8.ClearContent;                                          // IntLogger
  // Form11.ClearContent;                                         // RegViewer
  // Form12.ClearContent;                                     // ScriptConsole
  // close internal modules
  for i := Screen.FormCount - 1 downto 0 do
    if (Screen.Forms[i] <> Application.MainForm) and
        Screen.Forms[i].Visible then Screen.Forms[i].Close;
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
      if not CHMFileExists then ShowMessage(MSG01 + MSG18);
      if not CHMViewerExists then ShowMessage(MSG01 + MSG19);
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
  {...}
  Form1.Caption := Application.Title;
end;

// FILE/LOAD EXISTING PROJECT
procedure TForm1.FLoadProjectExecute(Sender: TObject);
var
  Filename:   string;
  OpenDialog: TOpenDialog;
begin
  if MessageDlg(MSG43, MSG44, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    OpenDialog := TOpenDialog.Create(Form1);
    with OpenDialog do
    begin
      InitialDir := GetUserDir;
      Title := MSG53;
      Filter := MSG52;
    end;
    if OpenDialog.Execute then
    begin
      Filename := OpenDialog.FileName;
      try
        if not SaveProject(FActualProject, FAppProject) then
        begin
          ShowMessage(MSG01 + Format(MSG55, [FActualProject]));
          Exit;
        end;
        FActualProject := Filename;                             // with filename
        FActualProjectIsSaved := True;                        // no need to save
        Form1.Caption := Application.Title + ' - ' + FActualProject;
      finally
        OpenDialog.Free;
      end;
    end;
  end;
end;

// FILE/SAVE PROJECT
procedure TForm1.FSaveProjectExecute(Sender: TObject);
begin
  if Length(FActualProject) = 0 then Exit;
  if not SaveProject(FActualProject, FAppProject) then
  begin
    ShowMessage(MSG01 + Format(MSG56, [FActualProject]));
    Exit;
  end;
  FActualProjectIsSaved := True;                              // no need to save
end;

// FILE/SAVE PROJECT AS
procedure TForm1.FSaveProjectAsExecute(Sender: TObject);
var
  Filename:   string;
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(Form1);
  with SaveDialog do
  begin
    InitialDir := GetUserDir;
    Title := MSG54;
    Filter := MSG52;
  end;
  if SaveDialog.Execute then
  begin
    Filename := SaveDialog.FileName;
    try
      if not SaveProject(FActualProject, FAppProject) then
      begin
        ShowMessage(MSG01 + Format(MSG56, [FActualProject]));
        Exit;
      end;
      FActualProject := Filename;                                       // named
      FActualProjectIsSaved := True;                          // no need to save
      FSaveProject.Enabled := True;                             // enable 'Save'
      Form1.Caption := Application.Title + ' - ' + FActualProject;
    finally
      SaveDialog.Free;
    end;
  end;
end;

// FILE/SETTINGS
procedure TForm1.FSettingsExecute(Sender: TObject);
begin
  {...}
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

// VIEW/SHOW RUNLOGGER
procedure TForm1.VShowRunLoggerExecute(Sender: TObject);
begin
  {...}
end;

// VIEW/SHOW INTLOGGER
procedure TForm1.VShowIntLoggerExecute(Sender: TObject);
begin
  {...}
end;

// VIEW/SHOW SCRIPTEDITOR
procedure TForm1.VShowScriptEditorExecute(Sender: TObject);
begin
  {...}
end;

// VIEW/SHOW SCRIPTCONSOLE
procedure TForm1.VShowScriptConsoleExecute(Sender: TObject);
begin
  {...}
end;

// PROCESSOR/CREATE
procedure TForm1.PCreateExecute(Sender: TObject);
begin
  {...}
end;

// MEMORY/CREATE
procedure TForm1.MCreateExecute(Sender: TObject);
begin
  {...}
end;

// IO PORT/CREATE
procedure TForm1.IOCreateExecute(Sender: TObject);
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
  if (FScriptBuffer.Count > 0) and (not FActualScriptIsSaved) then
    if MessageDlg(MSG43, MSG44, mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
  {...}                                                   // clear OOP items
  SClearScriptBufferExecute(Sender);                  // clear script buffer
  Form6.ReLoad;                                    // refresh editor content
  FActualScript := '';                                   // without filename
  FActualScriptIsSaved := True;                           // no need to save
  if not Form6.Visible then Form6.Show;                // open script editor
  SSaveScript.Enabled := False;                            // disable 'Save'
  Form1.Caption := Application.Title;
end;

// ACTIONS/SCRIPT/LOAD SCRIPT
procedure TForm1.SLoadScriptExecute(Sender: TObject);
var
  Filename:   string;
  OpenDialog: TOpenDialog;
begin
  if FScriptBuffer.Count > 0 then
    if MessageDlg(MSG43, MSG44, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      OpenDialog := TOpenDialog.Create(Form1);
      with OpenDialog do
      begin
        InitialDir := GetUserDir;
        Title := MSG46;
        Filter := MSG45;
      end;
      if OpenDialog.Execute then
      begin
        Filename := OpenDialog.FileName;
        try
          try
            FScriptBuffer.LoadFromFile(FileName);
          except
            ShowMessage(MSG01 + Format(MSG48, [FileName]));
            exit;
          end;
          FActualScript := Filename;                            // with filename
          FActualScriptIsSaved := True;                       // no need to save
          Form1.Caption := Application.Title + ' - ' + FActualScript;
          { ha nincs megnyitva a ScriptEditor, akkor itt meg kell nyitni}
        finally
          OpenDialog.Free;
        end;
      end;
    end;
end;

// ACTIONS/SCRIPT/SAVE SCRIPT
procedure TForm1.SSaveScriptExecute(Sender: TObject);
begin
  if Length(FActualScript) = 0 then Exit;
  try
    FScriptBuffer.SaveToFile(FActualScript);
  except
    ShowMessage(MSG01 + Format(MSG49, [FActualScript]));
    Exit;
  end;
  FActualScriptIsSaved := True;                               // no need to save
end;

// ACTIONS/SCRIPT/SAVE SCRIPT AS
procedure TForm1.SSaveScriptAsExecute(Sender: TObject);
var
  Filename:   string;
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(Form1);
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
      try
        FScriptBuffer.SaveToFile(FileName);
      except
        ShowMessage(MSG01 + Format(MSG49, [FileName]));
        Exit;
      end;
      FActualScript := Filename;                                        // named
      FActualScriptIsSaved := True;                           // no need to save
      SSaveScript.Enabled := True;                              // enable 'Save'
      Form1.Caption := Application.Title + ' - ' + FActualScript;
    finally
      SaveDialog.Free;
    end;
  end;
end;

// ACTIONS/SCRIPT/CLEAR SCRIPT BUFFER AND REFRESH SCRIPTEDITOR
procedure TForm1.SClearScriptBufferExecute(Sender: TObject);
begin
  FScriptBuffer.Clear;
  { ScriptEditor frissítése }
end;

// ACTIONS/SCRIPT/RUN SCRIPT
procedure TForm1.SRunScriptExecute(Sender: TObject);
begin
  if FScriptBuffer.Count = 0 then ShowMessage(MSG42) else
  begin
    {...}
  end;
end;

// ACTIONS/SCRIPT/RUN SCRIPT STEP BY STEP
procedure TForm1.SStepScriptExecute(Sender: TObject);
begin
  if FScriptBuffer.Count = 0 then ShowMessage(MSG42) else
  begin
    {...}
  end;
end;

// ACTIONS/SCRIPT/STOP SCRIPT
procedure TForm1.SStopScriptExecute(Sender: TObject);
begin
  {...}
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
begin
  Error := False;
  Form1.Caption := Application.Title;
  // set actual project/script property
  FActualProject := '';
  FActualProjectIsSaved := True;
  FActualScript := '';
  FActualScriptIsSaved := True;
  // save without dialog buttons
  FSaveProject.Enabled := False;
  SSaveScript.Enabled := False;
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
    then ShowMessage(MSG01 + Format(MSG40, [FConfigDirectory + CONFIGFILE]));
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
      FPluginDirectory := './lib';
      if not DirectoryExists(FPluginDirectory) then
      begin
        FPluginDirectory := '/usr/lib/corelab';
        if not DirectoryExists(FPluginDirectory) then
        begin
          FPluginDirectory := '/usr/local/lib/corelab';
          if not DirectoryExists(FPluginDirectory) then
          begin
            ShowMessage(MSG01 + MSG03);
            Error := True;
          end;
        end;
      end;
    {$ELSE}
      FPluginDirectory := '.\lib';
      if not DirectoryExists(FPluginDirectory) then
      begin
        ShowMessage(MSG01 + MSG03);
        Error := True;
      end;
    {$ENDIF}
  end;
  if not Error then
    if not LoadAllPlugins(FPluginDirectory) then
    begin
      ShowMessage(MSG01 + Format(MSG04, [FPluginDirectory]));
      Error := True;
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
    // main form
    frmmain_top := Top;
    frmmain_left := Left;
    frmmain_height := Height;
    frmmain_width := Width;
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

