{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uproject.pas                                                             | }
{ | Project file handler                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uproject;
{$MODE OBJFPC}{$H+}
interface
uses
  INIFiles, SysUtils;
type
  TAppProject = record
  end;
  var
    AppProject: TAppProject;                                // project file data

function LoadProject(AFilename: string): Boolean;
function SaveProject(AFilename: string): Boolean;

implementation

// COMBINED INI OBJECT HANDLER
function INIFileHandler(AINIFile: TIniFile; var AAppProject: TAppProject; IsSave: Boolean): Boolean;
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

begin
  Result := True;
  try
    // ...
    //section := '...';
    //LoadSave(section, 'yyy', AAppProject.xxx.yyy, 300);
  except
    Result := False;
  end;
end;

// LOAD PROJECT
function LoadProject(AFilename: string): Boolean;
var
  INIFile: TINIFile;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    Result := INIFileHandler(INIFILE, AppProject, False);
  finally
    INIFile.Free;
  end;
end;

// SAVE PROJECT
function SaveProject(AFilename: string): Boolean;
var
  INIFile: TINIFile;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    Result := INIFileHandler(INIFILE, AppProject, True);
  finally
    INIFile.Free;
  end;
end;

end.
