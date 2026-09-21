{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uconfig.pas                                                              | }
{ | Configuration file handler                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uconfig;
{$MODE OBJFPC}{$H+}
{$I defcolors.pas}
interface
uses
  Graphics, INIFiles, SysUtils;
type
  // configuration data types
  TBPManagerConfig = record
    left, top, height, width: Integer;
  end;
  THexViewerConfig = record
    left, top, height, width:                      Integer;
    address_color, data_color, lineselector_color: TColor;
    bgodd_color, bgeven_color:                     TColor;
  end;
  TBusLoggerConfig = record
    left, top, height, width:                      Integer;
    column0_width, column1_width, column2_width:   Integer;
    column3_width, column4_width, column5_width:   Integer;
    operation_color, device_color, address_color:  TColor;
    reladdress_color, data_color, status_color:    TColor;
    lineselector_color, bgodd_color, bgeven_color: TColor;
  end;
  TIntLoggerConfig = record
    left, top, height, width:                                   Integer;
    column0_width, column1_width, column2_width, column3_width: Integer;
    sender_color, vector_color, status_color, flag_color:       TColor;
    lineselector_color, bgodd_color, bgeven_color:              TColor;
  end;
  TMainFormConfig = record
    left, top, height, width, splitter: Integer;
  end;
  TModuleExplorerConfig = record
    column0_width, left, top, height, width, splitter: Integer;
    visible:                                           Boolean;
  end;
  TModulePropertiesConfig = record
    column0_width,left, top, height, width: Integer;
  end;
  TRegViewerConfig = record
    column0_width, left, top, height, width: Integer;
  end;
  TRunLoggerConfig = record
    left, top, height, width:                                     Integer;
    column0_width, column1_width, column2_width, column3_width:   Integer;
    instcount_color, address_color, opcode_color, mnemonic_color: TColor;
    lineselector_color, bgodd_color, bgeven_color:                TColor;
  end;
  TScriptConsoleConfig = record
    left, top, height, width: Integer;
    bg_color, font_color:     TColor;
  end;
  TScriptEditorConfig = record
    left, top, height, width:               Integer;
    bg_color, font_color, gutterfont_color: TColor;
    linenumber, syntax:                     Boolean;
  end;
  TSettingsConfig = record
    left, top, height, width: Integer;
  end;
  TSysConsoleConfig = record
    left, top, height, width: Integer;
    bg_color, font_color:     TColor;
  end;
  TAppConfig = record
    BPManagerConfig:        TBPManagerConfig;
    BusLoggerConfig:        TBusLoggerConfig;
    HexViewerConfig:        THexViewerConfig;
    IntLoggerConfig:        TIntLoggerConfig;
    MainFormConfig:         TMainFormConfig;
    ModuleExplorerConfig:   TModuleExplorerConfig;
    ModulePropertiesConfig: TModulePropertiesConfig;
    RegViewerConfig:        TRegViewerConfig;
    RunLoggerConfig:        TRunLoggerConfig;
    ScriptConsoleConfig:    TScriptConsoleConfig;
    ScriptEditorConfig:     TScriptEditorConfig;
    SettingsConfig:         TSettingsConfig;
    SysConsoleConfig:       TSysConsoleConfig;
  end;
  var
    AppConfig: TAppConfig;                          // global configuration data

function LoadConfiguration(AFilename: string): Boolean;
function SaveConfiguration(AFilename: string): Boolean;

implementation

// COMBINED INI OBJECT HANDLER
function INIFileHandler(AINIFile: TIniFile; var AAppConfig: TAppConfig; IsSave: Boolean): Boolean;
var
  section: string;
  
  // READ/WRITE PROCEDURES
  procedure LoadSave(ASection, AKey: string; var AValue: Boolean; ADefault: Boolean); overload;
  begin
    with AINIFile do
      if not IsSave
        then AValue := ReadBool(ASection, AKey, ADefault)
        else WriteBool(ASection, AKey, AValue);
  end;
  procedure LoadSave(ASection, AKey: string; var AValue: Integer; ADefault: Integer); overload;
  begin
    with AINIFile do
      if not IsSave
        then AValue := ReadInteger(ASection, AKey, ADefault)
        else WriteInteger(ASection, AKey, AValue);
  end;
  procedure LoadSave(ASection, AKey: string; var AValue: string; ADefault: string); overload;
  begin
    with AINIFile do
      if not IsSave
        then AValue := ReadString(ASection, AKey, ADefault)
        else WriteString(ASection, AKey, AValue);
  end;
  procedure LoadSave(ASection, AKey: string; var AValue: TColor; ADefault: string); overload;
  begin
    with AINIFile do
      if not IsSave
        then AValue := StringToColor(ReadString(ASection, AKey, ADefault))
        else WriteString(ASection, AKey, ColorToString(AValue));
  end;

begin
  Result := True;
  try
    // BusLogger
    section := 'BusLogger';
    LoadSave(section, 'height', AAppConfig.BusLoggerConfig.height, 280);
    LoadSave(section, 'left', AAppConfig.BusLoggerConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.BusLoggerConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.BusLoggerConfig.width, 518);
    LoadSave(section, 'column0_width', AAppConfig.BusLoggerConfig.column0_width, 80);
    LoadSave(section, 'column1_width', AAppConfig.BusLoggerConfig.column1_width, 80);
    LoadSave(section, 'column2_width', AAppConfig.BusLoggerConfig.column2_width, 80);
    LoadSave(section, 'column3_width', AAppConfig.BusLoggerConfig.column3_width, 100);
    LoadSave(section, 'column4_width', AAppConfig.BusLoggerConfig.column4_width, 80);
    LoadSave(section, 'column5_width', AAppConfig.BusLoggerConfig.column5_width, 80);
    LoadSave(section, 'operation_color', AAppConfig.BusLoggerConfig.operation_color, BUSLOGGER_OPERATION_DEFAULT);
    LoadSave(section, 'device_color', AAppConfig.BusLoggerConfig.device_color, BUSLOGGER_DEVICE_DEFAULT);
    LoadSave(section, 'address_color', AAppConfig.BusLoggerConfig.address_color, BUSLOGGER_ADDRESS_DEFAULT);
    LoadSave(section, 'reladdress_color', AAppConfig.BusLoggerConfig.reladdress_color, BUSLOGGER_RELADDRESS_DEFAULT);
    LoadSave(section, 'data_color', AAppConfig.BusLoggerConfig.data_color, BUSLOGGER_DATA_DEFAULT);
    LoadSave(section, 'status_color', AAppConfig.BusLoggerConfig.status_color, BUSLOGGER_STATUS_DEFAULT);
    LoadSave(section, 'lineselector_color', AAppConfig.BusLoggerConfig.lineselector_color, BUSLOGGER_LINESELECTOR_DEFAULT);
    LoadSave(section, 'bgodd_color', AAppConfig.BusLoggerConfig.bgodd_color, BUSLOGGER_BGCOLOR_ODD_DEFAULT);
    LoadSave(section, 'bgeven_color', AAppConfig.BusLoggerConfig.bgeven_color, BUSLOGGER_BGCOLOR_EVEN_DEFAULT);
    // Breakpoint Manager
    section := 'BreakPointManager';
    LoadSave(section, 'height', AAppConfig.BPManagerConfig.height, 208);
    LoadSave(section, 'left', AAppConfig.BPManagerConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.BPManagerConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.BPManagerConfig.width, 290);
    // HexViewer
    section := 'HexViewer';
    LoadSave(section, 'height', AAppConfig.HexViewerConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.HexViewerConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.HexViewerConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.HexViewerConfig.width, 480);
    LoadSave(section, 'address_color', AAppConfig.HexViewerConfig.address_color, HEXVIEWER_ADDRESS_DEFAULT);
    LoadSave(section, 'data_color', AAppConfig.HexViewerConfig.data_color, HEXVIEWER_DATA_DEFAULT);
    LoadSave(section, 'lineselector_color', AAppConfig.HexViewerConfig.lineselector_color, HEXVIEWER_LINESELECTOR_DEFAULT);
    LoadSave(section, 'bgodd_color', AAppConfig.HexViewerConfig.bgodd_color, HEXVIEWER_BGCOLOR_ODD_DEFAULT);
    LoadSave(section, 'bgeven_color', AAppConfig.HexViewerConfig.bgeven_color, HEXVIEWER_BGCOLOR_EVEN_DEFAULT);
    // IntLogger
    section := 'IntLogger';
    LoadSave(section, 'height', AAppConfig.IntLoggerConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.IntLoggerConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.IntLoggerConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.IntLoggerConfig.width, 480);
    LoadSave(section, 'column0_width', AAppConfig.IntLoggerConfig.column0_width, 150);
    LoadSave(section, 'column1_width', AAppConfig.IntLoggerConfig.column1_width, 80);
    LoadSave(section, 'column2_width', AAppConfig.IntLoggerConfig.column2_width, 100);
    LoadSave(section, 'column3_width', AAppConfig.IntLoggerConfig.column3_width, 50);
    LoadSave(section, 'sender_color', AAppConfig.IntLoggerConfig.sender_color, INTLOGGER_SENDER_DEFAULT);
    LoadSave(section, 'vector_color', AAppConfig.IntLoggerConfig.vector_color, INTLOGGER_VECTOR_DEFAULT);
    LoadSave(section, 'status_color', AAppConfig.IntLoggerConfig.status_color, INTLOGGER_STATUS_DEFAULT);
    LoadSave(section, 'flag_color', AAppConfig.IntLoggerConfig.flag_color, INTLOGGER_FLAG_DEFAULT);
    LoadSave(section, 'lineselector_color', AAppConfig.IntLoggerConfig.lineselector_color, INTLOGGER_LINESELECTOR_DEFAULT);
    LoadSave(section, 'bgodd_color', AAppConfig.IntLoggerConfig.bgodd_color, INTLOGGER_BGCOLOR_ODD_DEFAULT);
    LoadSave(section, 'bgeven_color', AAppConfig.IntLoggerConfig.bgeven_color, INTLOGGER_BGCOLOR_EVEN_DEFAULT);
    // Main Form
    section := 'MainForm';
    LoadSave(section, 'height', AAppConfig.MainFormConfig.height, 160);
    LoadSave(section, 'left', AAppConfig.MainFormConfig.left, 12);
    LoadSave(section, 'top', AAppConfig.MainFormConfig.top, 12);
    LoadSave(section, 'width', AAppConfig.MainFormConfig.width, 800);
    LoadSave(section, 'splitter', AAppConfig.MainFormConfig.splitter, 210);
    // Module Explorer
    section := 'ModuleExplorer';
    LoadSave(section, 'height', AAppConfig.ModuleExplorerConfig.height, 628);
    LoadSave(section, 'left', AAppConfig.ModuleExplorerConfig.left, 12);
    LoadSave(section, 'top', AAppConfig.ModuleExplorerConfig.top, 207);
    LoadSave(section, 'width', AAppConfig.ModuleExplorerConfig.width, 265);
    LoadSave(section, 'splitter', AAppConfig.ModuleExplorerConfig.splitter, 160);
    LoadSave(section, 'visible', AAppConfig.ModuleExplorerConfig.visible, True);
    LoadSave(section, 'column0_width', AAppConfig.ModuleExplorerConfig.column0_width, 127);
    // Module properties
    section := 'ModuleProperties';
    LoadSave(section, 'height', AAppConfig.ModulePropertiesConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.ModulePropertiesConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.ModulePropertiesConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.ModulePropertiesConfig.width, 480);
    LoadSave(section, 'column0_width', AAppConfig.ModulePropertiesConfig.column0_width, 150);
    // RegViewer
    section := 'RegViewer';
    LoadSave(section, 'height', AAppConfig.RegViewerConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.RegViewerConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.RegViewerConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.RegViewerConfig.width, 480);
    LoadSave(section, 'column0_width', AAppConfig.RegViewerConfig.column0_width, 150);
    // RunLogger
    section := 'RunLogger';
    LoadSave(section, 'height', AAppConfig.RunLoggerConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.RunLoggerConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.RunLoggerConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.RunLoggerConfig.width, 480);
    LoadSave(section, 'column0_width', AAppConfig.RunLoggerConfig.column0_width, 80);
    LoadSave(section, 'column1_width', AAppConfig.RunLoggerConfig.column1_width, 80);
    LoadSave(section, 'column2_width', AAppConfig.RunLoggerConfig.column2_width, 150);
    LoadSave(section, 'column3_width', AAppConfig.RunLoggerConfig.column3_width, 150);
    LoadSave(section, 'instcount_color', AAppConfig.RunLoggerConfig.instcount_color, RUNLOGGER_INSTCOUNT_DEFAULT);
    LoadSave(section, 'address_color', AAppConfig.RunLoggerConfig.address_color, RUNLOGGER_ADDRESS_DEFAULT);
    LoadSave(section, 'opcode_color', AAppConfig.RunLoggerConfig.opcode_color, RUNLOGGER_OPCODE_DEFAULT);
    LoadSave(section, 'mnemonic_color', AAppConfig.RunLoggerConfig.mnemonic_color, RUNLOGGER_MNEMONIC_DEFAULT);
    LoadSave(section, 'lineselector_color', AAppConfig.RunLoggerConfig.lineselector_color, RUNLOGGER_LINESELECTOR_DEFAULT);
    LoadSave(section, 'bgodd_color', AAppConfig.RunLoggerConfig.bgodd_color, RUNLOGGER_BGCOLOR_ODD_DEFAULT);
    LoadSave(section, 'bgeven_color', AAppConfig.RunLoggerConfig.bgeven_color, RUNLOGGER_BGCOLOR_EVEN_DEFAULT);
    // ScriptConsole
    section := 'ScriptConsole';
    LoadSave(section, 'height', AAppConfig.ScriptConsoleConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.ScriptConsoleConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.ScriptConsoleConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.ScriptConsoleConfig.width, 480);
    LoadSave(section, 'bg_color', AAppConfig.ScriptConsoleConfig.bg_color, SCRIPTCONSOLE_BG_COLOR_DEFAULT);
    LoadSave(section, 'font_color', AAppConfig.ScriptConsoleConfig.font_color, SCRIPTCONSOLE_FONT_COLOR_DEFAULT);
    // ScriptEditor
    section := 'ScriptEditor';
    LoadSave(section, 'height', AAppConfig.ScriptEditorConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.ScriptEditorConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.ScriptEditorConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.ScriptEditorConfig.width, 480);
    LoadSave(section, 'bg_color', AAppConfig.ScriptEditorConfig.bg_color, SCRIPTEDITOR_BG_COLOR_DEFAULT);
    LoadSave(section, 'font_color', AAppConfig.ScriptEditorConfig.font_color, SCRIPTEDITOR_FONT_COLOR_DEFAULT);
    LoadSave(section, 'gutterfont_color', AAppConfig.ScriptEditorConfig.gutterfont_color, SCRIPTEDITOR_GUTTERFONT_COLOR_DEFAULT);
    LoadSave(section, 'linenumber', AAppConfig.ScriptEditorConfig.linenumber, True);
    LoadSave(section, 'syntax', AAppConfig.ScriptEditorConfig.syntax, True);
    // Settings
    section := 'Settings';
    LoadSave(section, 'height', AAppConfig.SettingsConfig.height, 350);
    LoadSave(section, 'left', AAppConfig.SettingsConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.SettingsConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.SettingsConfig.width, 363);
    // SysConsole
    section := 'SysConsole';
    LoadSave(section, 'height', AAppConfig.SysConsoleConfig.height, 300);
    LoadSave(section, 'left', AAppConfig.SysConsoleConfig.left, 8);
    LoadSave(section, 'top', AAppConfig.SysConsoleConfig.top, 8);
    LoadSave(section, 'width', AAppConfig.SysConsoleConfig.width, 480);
    LoadSave(section, 'bg_color', AAppConfig.SysConsoleConfig.bg_color, SYSCONSOLE_BG_COLOR_DEFAULT);
    LoadSave(section, 'font_color', AAppConfig.SysConsoleConfig.font_color, SYSCONSOLE_FONT_COLOR_DEFAULT);
  except
    Result := False;
  end;
end;

// LOAD CONFIGURATION
function LoadConfiguration(AFilename: string): Boolean;
var
  INIFile: TINIFile;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    Result := INIFileHandler(INIFILE, AppConfig, False);
  finally
    INIFile.Free;
  end;
end;

// SAVE CONFIGURATION
function SaveConfiguration(AFilename: string): Boolean;
var
  INIFile: TINIFile;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    Result := INIFileHandler(INIFILE, AppConfig, True);
  finally
    INIFile.Free;
  end;
end;

end.
