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
interface
uses
  INIFiles, SysUtils;
type
  // configuration data type
  TAppConfig = record
    directory_plugin: string;
    frmmain_left, frmmain_top, frmmain_height, frmmain_width: integer;
    sysconsole_height: integer;
  end;
var
  INIFile: TINIFile;
const
  KEY1: array[0..1] of string = ('directory_', 'frmmain_');
  KEY2: array[0..4] of string = ('plugin', 'top', 'left', 'height', 'width');
  SECTION: array[0..1] of string = ('directories', 'forms');

function LoadConfiguration(AFilename: string; var AAppConfig: TAppConfig): Boolean;
function SaveConfiguration(AFilename: string; var AAppConfig: TAppConfig): Boolean;

implementation

// LOAD CONFIGURATION
function LoadConfiguration(AFilename: string; var AAppConfig: TAppConfig): Boolean;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    try
      with INIFile do
      begin
        // Directories
        AAppConfig.directory_plugin := ReadString(SECTION[0], KEY1[0] + KEY2[0], '.');
        // Forms
        AAppConfig.frmmain_left := ReadInteger(SECTION[1], KEY1[1] + KEY2[0], 8);
        AAppConfig.frmmain_top := ReadInteger(SECTION[1], KEY1[1] + KEY2[1], 8);
        AAppConfig.frmmain_height := ReadInteger(SECTION[1], KEY1[1] + KEY2[2], 174);
        AAppConfig.frmmain_width := ReadInteger(SECTION[1], KEY1[1] + KEY2[3], 930);
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
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    try
      with INIFile do
      begin
        // Directories
        WriteString(SECTION[0], KEY1[0] + KEY2[0], AAppConfig.directory_plugin);
        // Forms
        WriteInteger(SECTION[1], KEY1[1] + KEY2[0], AAppConfig.frmmain_left);
        WriteInteger(SECTION[1], KEY1[1] + KEY2[1], AAppConfig.frmmain_top);
        WriteInteger(SECTION[1], KEY1[1] + KEY2[2], AAppConfig.frmmain_height);
        WriteInteger(SECTION[1], KEY1[1] + KEY2[3], AAppConfig.frmmain_width);
      end;
    except
      Result := False;
    end;
  finally
    INIFile.Free;
  end;
end;

end.
