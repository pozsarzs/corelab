{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | uproject                                                                 | }
{ | Project file handler                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit uproject;
{$MODE OBJFPC}{$H+}
{$I define.pas}
interface
uses
  INIFiles, SysUtils;
type
  // project data type
  TAppProject = record
  end;
var
  INIFile: TINIFile;
//const
//  KEY: array of string;
//  SECTION: array of string;

function LoadProject(AFilename: string; var AAppProject: TAppProject): Boolean;
function SaveProject(AFilename: string; var AAppProject: TAppProject): Boolean;

implementation

// LOAD PROJECT
function LoadProject(AFilename: string; var AAppProject: TAppProject): Boolean;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    try
      with INIFile do
      begin
      end;
    except
      Result := False;
    end;
  finally
    INIFile.Free;
  end;
end;

// SAVE PROJECT
function SaveProject(AFilename: string; var AAppProject: TAppProject): Boolean;
begin
  Result := True;
  INIFile := TINIFile.Create(AFilename);
  try
    try
      with INIFile do
      begin
      end;
    except
      Result := False;
    end;
  finally
    INIFile.Free;
  end;
end;

end.
