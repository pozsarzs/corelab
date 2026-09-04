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
  ComCtrls, ActnList, StdCtrls, HelpIntfs, LazHelpCHM, LazHelpIntf, frmabout,
  core_cpu, core_memory, core_ioport, ucommon, uconfig;
type
  // operation mode type
  TOpMode = (omInteractive, omScript, omInterpreter);
  // procedural types pointing to the plugin entry point
  TIOPortCreateFunc = function: TIOPort; CALLTYPE;
  TIOPortDestroyProc = procedure(AIOPort: TIOPort); CALLTYPE;
  TIOPortLoadStateFunc = function(AIOPort: TIOPort; AStream: TStream): Boolean; CALLTYPE;
  TIOPortSaveStateFunc = function(AIOPort: TIOPort; AStream: TStream): Boolean; CALLTYPE;
  TIOPortCreatePanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortShowPanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortHidePanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortFreePanelProc = procedure(APort: TIOPort); CALLTYPE;
  TIOPortRenamePanelProc = procedure(APort: TIOPort; Caption: PChar); CALLTYPE;
  TIOPortResizePanelFunc = function(APort: TIOPort; Width, Height: Integer): Boolean; CALLTYPE;
  TIOPortMovePanelFunc = function(APort: TIOPort; Left, Top: Integer): Boolean; CALLTYPE;
  TIOPortSetIntHandlerProc = procedure(APort: TIOPort; IntProc: TInterruptCallback; IntVector: Byte); CALLTYPE;
  TMemoryCreateFunc = function: TMemory; CALLTYPE;
  TMemoryDestroyProc = procedure(AMemory: TMemory); CALLTYPE;
  TMemoryLoadStateFunc = function(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE;
  TMemorySaveStateFunc = function(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE;
  TProcessorCreateFunc = function: TCPU; CALLTYPE;
  TProcessorDestroyProc = procedure(Processor: TCPU); CALLTYPE;
  TProcessorLoadStateFunc = function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  TProcessorSaveStateFunc = function(Processor: TCPU; AStream: TStream): Boolean; CALLTYPE;
  { TForm1 }
  TForm1 = class(TForm)
    ActionList1:              TActionList;
    CHMHelpDatabase1:         TCHMHelpDatabase;
    CoolBar1:                 TCoolBar;
    FExit:                    TAction;
    FLoadWorkspace:           TAction;
    FNewWorkspace:            TAction;
    FRestartApplication:      TAction;
    FSaveWorkspace:           TAction;
    FSaveWorkspaceAs:         TAction;
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
    PAttachToBus:             TAction;
    PCreate:                  TAction;
    PDestroy:                 TAction;
    PDetachFromBus:           TAction;
    PopupMenu1:               TPopupMenu;
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
    Separator22:              TMenuItem;
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
    ToolBar2:                 TToolBar;
    ToolBar3:                 TToolBar;
    ToolBar4:                 TToolBar;
    ToolBar5:                 TToolBar;
    ToolBar6:                 TToolBar;
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
    ToolButton4:              TToolButton;
    ToolButton5:              TToolButton;
    ToolButton6:              TToolButton;
    ToolButton7:              TToolButton;
    ToolButton8:              TToolButton;
    ToolButton9:              TToolButton;
    VMoveResizeIOPanel:       TAction;
    VRenameIOPanel:           TAction;
    VShowBreakpointManager:   TAction;
    VShowHexViewer:           TAction;
    VShowHideIOPanel:         TAction;
    VShowHideSystemConsole:   TAction;
    VShowIntLogger:           TAction;
    VShowObjectManager:       TAction;
    VShowRegViewer:           TAction;
    VShowRunLogger:           TAction;
    VShowScriptConsole:       TAction;
    VShowScriptEditor:        TAction;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HAboutExecute(Sender: TObject);
    procedure HHelpExecute(Sender: TObject);
    procedure SClearScriptBufferExecute(Sender: TObject);
    procedure SLoadScriptExecute(Sender: TObject);
    procedure SNewScriptExecute(Sender: TObject);
    procedure SRunScriptExecute(Sender: TObject);
    procedure SSaveScriptAsExecute(Sender: TObject);
    procedure SSaveScriptExecute(Sender: TObject);
    procedure SStepScriptExecute(Sender: TObject);
    procedure SStopScriptExecute(Sender: TObject);
  private
    // simulation objects
    FProcessors: array of TCPU;               // created objects from TCPU class
    FMemories:   array of TMemory;         // created objects from TMemory class
    FOPorts:     array of TIOPort;         // created objects from TIOPort class
    FAppConfig:  TAppConfig;                        // application configuration
    procedure SetIgnoreHelp(AIgnoreHelp: Boolean);
    procedure SetPluginDirectory(APluginDirectory: string);
  protected
    FActualProject:    string;                       // actual project directory
    FActualScript:     string;                             // actual script file
    FConfigDirectory:  string;                      // directory of the INI file
    FEXEDirectory:     string;                    // directory of the executable
    FIgnoreHelp:       Boolean;                       // ignore search help file
    FOpMode:           TOpMode;                                // operation mode
    FPluginDirectory:  string;                       // directory of the plugins
    FScriptBuffer:     TStringList;                             // script buffer
    FSystemLanguage:   string;                                // system language
    FUserDirectory:    string;                               // user's directory
  public
  end;
var
  Form1: TForm1;

implementation

{$R *.lfm}
{ TForm1 }

resourcestring
  MSG01 = 'ERROR: ';
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

  // ---- PRIVATE METHODS ----

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

// ---- EVENT HANDLER METHODS ----

// ACTIONS/SCRIPT/CREATE NEW SCRIPT, CLEAR BUFFER AND OPEN/REFRESH SCRIPTEDITOR
procedure TForm1.SNewScriptExecute(Sender: TObject);
begin
  if FScriptBuffer.Count > 0 then
    if MessageDlg(MSG43, MSG44, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      SClearScriptBufferExecute(Sender);
      { ha nincs megnyitva a ScriptEditor, akkor meg kell nyitni}
    end;
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
          { ha nincs megnyitva a ScriptEditor, akkor meg kell nyitni}
        finally
          OpenDialog.Free;
        end;
      end;
    end;
end;

// ACTIONS/SCRIPT/SAVE SCRIPT
procedure TForm1.SSaveScriptExecute(Sender: TObject);
begin

end;

// ACTIONS/SCRIPT/SAVE SCRIPT AS
procedure TForm1.SSaveScriptAsExecute(Sender: TObject);
begin

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

// ---- CREATE AND DESTROY EVENT HANDLER ----

// ONCREATE EVENT
procedure TForm1.FormCreate(Sender: TObject);
begin
  // set actual project/script property
  FActualProject := '';
  FActualScript := '';
  // set general fields
  FEXEDirectory := GetExeDir;
  FIgnoreHelp := false;
  FPluginDirectory := '.';
  FOpMode := omInteractive;
  FSystemLanguage := GetLang;
  FUserDirectory := GetUserDir;
  Form1.Caption := Application.Title;
  // enable/disable actions
  // - depends on opmode
  if FOpMode = omInteractive then
  begin

  end else
  begin

  end;
  // set directory and load configuration
  {$IFDEF WINDOWS}
    FConfigDirectory := FUserDirectory + DirectorySeparator +
                        'Appdata' + DirectorySeparator +
                        'Local' + DirectorySeparator +
                        BASENAME + DirectorySeparator;
  {$ELSE}
    {$IFDEF UNIX}
      FConfigDirectory := FUserDirectory + DirectorySeparator +
                          '.config' + DirectorySeparator +
                          BASENAME + DirectorySeparator;
    {$ELSE}
      {$FATAL Not supported operation system!}
    {$ENDIF}
  {$ENDIF}
  ForceDirectories(FConfigDirectory);
  if not LoadConfiguration(FConfigDirectory + CONFIGFILE, FAppConfig)
    then ShowMessage(MSG01 + Format(MSG40, [FConfigDirectory + CONFIGFILE]));;
  // - depends on system status
  {...}
end;

// JOBS BEFORE CLOSE FORM
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // save configuration
  if not SaveConfiguration(FConfigDirectory + CONFIGFILE, FAppConfig)
    then ShowMessage(MSG01 + Format(MSG41, [FConfigDirectory + CONFIGFILE]));;
  CanClose := True;
end;

// DESTROY EVENT
procedure TForm1.FormDestroy(Sender: TObject);
begin
end;

end.

