{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uconfig                                                                  | }
{ | Configuration file handler                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uconfig;
{$MODE OBJFPC}{$H+}
{$I define.pas}
{$I defcolors.pas}
interface
uses
  Graphics, INIFiles, SysUtils;
type
  // configuration data type
  TAppConfig = record
    directory_project:                                                  string;
    // Main form
    frmmain_left, frmmain_top, frmmain_height, frmmain_width:           Integer;
    // HexViewer
    hexviewer_left, hexviewer_top, hexviewer_height, hexviewer_width:   Integer;
    hexviewer_address_color, hexviewer_data_color:                      TColor;
    hexviewer_lineselector_color, hexviewer_bgcolor_odd:                TColor;
    hexviewer_bgcolor_even:                                             TColor;
    // RunLogger
    runlogger_left, runlogger_top, runlogger_height, runlogger_width:   Integer;
    runlogger_instcount_color, runlogger_address_color:                 TColor;
    runlogger_opcode_color, runlogger_mnemonic_color:                   TColor;
    runlogger_lineselector_color, runlogger_bgcolor_odd:                TColor;
    runlogger_bgcolor_even:                                             TColor;
    // SysConsole
    sysconsole_bg_color, sysconsole_font_color:                         TColor;
  end;
const
  SECTION: array[0..2] of string = ('directories', 'forms', 'colors');
  KEY1: array[0..4] of string =    ('directory_',
                                    'frmmain_',
                                    'runlogger_',
                                    'sysconsole_',
                                    'hexviewer_');
  KEY2: array[0..14] of string =   ('project',
                                    'top',
                                    'left',
                                    'height',
                                    'width',
                                    'instcount_color',
                                    'address_color',
                                    'opcode_color',
                                    'mnemonic_color',
                                    'lineselector_color',
                                    'bgcolor_odd',
                                    'bgcolor_even',
                                    'bg_color',
                                    'font_color',
                                    'data_color');

function LoadConfiguration(AFilename: string; var AAppConfig: TAppConfig): Boolean;
function SaveConfiguration(AFilename: string; var AAppConfig: TAppConfig): Boolean;

implementation

// LOAD CONFIGURATION
function LoadConfiguration(AFilename: string; var AAppConfig: TAppConfig): Boolean;
var
  INIFile: TINIFile;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    try
      with INIFile do
      begin
        // Directories
        AAppConfig.directory_project := ReadString(SECTION[0], KEY1[0] + KEY2[0], '');
        // Forms
        AAppConfig.frmmain_left := ReadInteger(SECTION[1], KEY1[1] + KEY2[1], 8);
        AAppConfig.frmmain_top := ReadInteger(SECTION[1], KEY1[1] + KEY2[2], 8);
        AAppConfig.frmmain_height := ReadInteger(SECTION[1], KEY1[1] + KEY2[3], 174);
        AAppConfig.frmmain_width := ReadInteger(SECTION[1], KEY1[1] + KEY2[4], 930);
        AAppConfig.hexviewer_left := ReadInteger(SECTION[1], KEY1[4] + KEY2[1], 8);
        AAppConfig.hexviewer_top := ReadInteger(SECTION[1], KEY1[4] + KEY2[2], 8);
        AAppConfig.hexviewer_height := ReadInteger(SECTION[1], KEY1[4] + KEY2[3], 174);
        AAppConfig.hexviewer_width := ReadInteger(SECTION[1], KEY1[4] + KEY2[4], 930);
        AAppConfig.runlogger_left := ReadInteger(SECTION[1], KEY1[2] + KEY2[1], 8);
        AAppConfig.runlogger_top := ReadInteger(SECTION[1], KEY1[2] + KEY2[2], 8);
        AAppConfig.runlogger_height := ReadInteger(SECTION[1], KEY1[2] + KEY2[3], 174);
        AAppConfig.runlogger_width := ReadInteger(SECTION[1], KEY1[2] + KEY2[4], 930);
        // Colors
        AAppConfig.hexviewer_address_color :=
          StringToColor(ReadString(SECTION[2], KEY1[4] + KEY2[6], HEXVIEWER_ADDRESS_DEFAULT));
        AAppConfig.hexviewer_address_color :=
          StringToColor(ReadString(SECTION[2], KEY1[4] + KEY2[14], HEXVIEWER_DATA_DEFAULT));
        AAppConfig.hexviewer_lineselector_color :=
          StringToColor(ReadString(SECTION[2], KEY1[4] + KEY2[9], HEXVIEWER_LINESELECTOR_DEFAULT));
        AAppConfig.hexviewer_bgcolor_odd :=
          StringToColor(ReadString(SECTION[2], KEY1[4] + KEY2[10], HEXVIEWER_BGCOLOR_ODD_DEFAULT));
        AAppConfig.hexviewer_bgcolor_even :=
          StringToColor(ReadString(SECTION[2], KEY1[4] + KEY2[11], HEXVIEWER_BGCOLOR_EVEN_DEFAULT));
        AAppConfig.runlogger_instcount_color :=
          StringToColor(ReadString(SECTION[2], KEY1[2] + KEY2[5], RUNLOGGER_INSTCOUNT_DEFAULT));
        AAppConfig.runlogger_address_color :=
          StringToColor(ReadString(SECTION[2], KEY1[2] + KEY2[6], RUNLOGGER_ADDRESS_DEFAULT));
        AAppConfig.runlogger_opcode_color :=
          StringToColor(ReadString(SECTION[2], KEY1[2] + KEY2[7], RUNLOGGER_OPCODE_DEFAULT));
        AAppConfig.runlogger_mnemonic_color :=
          StringToColor(ReadString(SECTION[2], KEY1[2] + KEY2[8], RUNLOGGER_MNEMONIC_DEFAULT));
        AAppConfig.runlogger_lineselector_color :=
          StringToColor(ReadString(SECTION[2], KEY1[2] + KEY2[9], RUNLOGGER_LINESELECTOR_DEFAULT));
        AAppConfig.runlogger_bgcolor_odd :=
          StringToColor(ReadString(SECTION[2], KEY1[2] + KEY2[10], RUNLOGGER_BGCOLOR_ODD_DEFAULT));
        AAppConfig.runlogger_bgcolor_even :=
          StringToColor(ReadString(SECTION[2], KEY1[2] + KEY2[11], RUNLOGGER_BGCOLOR_EVEN_DEFAULT));
        AAppConfig.sysconsole_bg_color :=
          StringToColor(ReadString(SECTION[2], KEY1[3] + KEY2[12], SYSCONSOLE_BG_COLOR_DEFAULT));
        AAppConfig.sysconsole_font_color :=
          StringToColor(ReadString(SECTION[2], KEY1[3] + KEY2[13], SYSCONSOLE_FONT_COLOR_DEFAULT));
      end;
    except
      Result := False;
    end;
  finally
    INIFile.Free;
  end;
end;

// SAVE CONFIGURATION
function SaveConfiguration(AFilename: string; var AAppConfig: TAppConfig): Boolean;
var
  INIFile: TINIFile;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    try
      with INIFile do
      begin
        // Directories
        WriteString(SECTION[0], KEY1[0] + KEY2[0], AAppConfig.directory_project);
        // Forms
        WriteInteger(SECTION[1], KEY1[1] + KEY2[1], AAppConfig.frmmain_left);
        WriteInteger(SECTION[1], KEY1[1] + KEY2[2], AAppConfig.frmmain_top);
        WriteInteger(SECTION[1], KEY1[1] + KEY2[3], AAppConfig.frmmain_height);
        WriteInteger(SECTION[1], KEY1[1] + KEY2[4], AAppConfig.frmmain_width);
        WriteInteger(SECTION[1], KEY1[4] + KEY2[1], AAppConfig.hexviewer_left);
        WriteInteger(SECTION[1], KEY1[4] + KEY2[2], AAppConfig.hexviewer_top);
        WriteInteger(SECTION[1], KEY1[4] + KEY2[3], AAppConfig.hexviewer_height);
        WriteInteger(SECTION[1], KEY1[4] + KEY2[4], AAppConfig.hexviewer_width);
        WriteInteger(SECTION[1], KEY1[2] + KEY2[1], AAppConfig.runlogger_left);
        WriteInteger(SECTION[1], KEY1[2] + KEY2[2], AAppConfig.runlogger_top);
        WriteInteger(SECTION[1], KEY1[2] + KEY2[3], AAppConfig.runlogger_height);
        WriteInteger(SECTION[1], KEY1[2] + KEY2[4], AAppConfig.runlogger_width);
        // Colors
        WriteString(SECTION[2], KEY1[4] + KEY2[6], ColorToString(AAppConfig.hexviewer_address_color));
        WriteString(SECTION[2], KEY1[4] + KEY2[14], ColorToString(AAppConfig.hexviewer_data_color));
        WriteString(SECTION[2], KEY1[4] + KEY2[9], ColorToString(AAppConfig.hexviewer_lineselector_color));
        WriteString(SECTION[2], KEY1[4] + KEY2[10], ColorToString(AAppConfig.hexviewer_bgcolor_odd));
        WriteString(SECTION[2], KEY1[4] + KEY2[11], ColorToString(AAppConfig.hexviewer_bgcolor_even));
        WriteString(SECTION[2], KEY1[2] + KEY2[5], ColorToString(AAppConfig.runlogger_instcount_color));
        WriteString(SECTION[2], KEY1[2] + KEY2[6], ColorToString(AAppConfig.runlogger_address_color));
        WriteString(SECTION[2], KEY1[2] + KEY2[7], ColorToString(AAppConfig.runlogger_opcode_color));
        WriteString(SECTION[2], KEY1[2] + KEY2[8], ColorToString(AAppConfig.runlogger_mnemonic_color));
        WriteString(SECTION[2], KEY1[2] + KEY2[9], ColorToString(AAppConfig.runlogger_lineselector_color));
        WriteString(SECTION[2], KEY1[2] + KEY2[10], ColorToString(AAppConfig.runlogger_bgcolor_odd));
        WriteString(SECTION[2], KEY1[2] + KEY2[11], ColorToString(AAppConfig.runlogger_bgcolor_even));
        WriteString(SECTION[2], KEY1[3] + KEY2[12], ColorToString(AAppConfig.sysconsole_bg_color));
        WriteString(SECTION[2], KEY1[3] + KEY2[13], ColorToString(AAppConfig.sysconsole_font_color));
      end;
    except
      Result := False;
    end;
  finally
    INIFile.Free;
  end;
end;

end.
