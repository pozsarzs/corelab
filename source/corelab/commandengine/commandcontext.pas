{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | commandcontext.pas                                                       | }
{ | Command context class                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit commandcontext;
{$MODE OBJFPC}{$H+}
interface
uses
  Generics.Collections, Classes;
type
  // Data storing type
  TContextValue = record
    RawValue:   string;
    IsReadOnly: Boolean;
  end;
  TContextDict = specialize TDictionary<string, TContextValue>;
  // Abstract command context class
  TCommandContext = class
  protected
    FOutput: TStrings;
    FVariables: TContextDict;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function GetConst(const AName: string): string; virtual;
    function GetVar(const AName: string): string; virtual;
    function SetConst(const AName, AValue: string): Boolean; virtual;
    function SetVar(const AName, AValue: string): Boolean; virtual;
    procedure Clear; virtual;
    procedure WriteOutput(const AText: string);
    property Output: TStrings read FOutput write FOutput;
   end;

implementation

// CREATE TCOMMANDCONTEXT INSTANCE
constructor TCommandContext.Create;
begin
  inherited Create;
  FOutPut := nil;
  FVariables := TContextDict.Create;
end;

// DESTROY TCOMMANDCONTEXT INSTANCE
destructor TCommandContext.Destroy;
begin
  FVariables.Free;
  inherited Destroy;
end;

// GET VALUE OF CONSTANT
function TCommandContext.GetConst(const AName: string): string;
begin
end;

// GET VALUE OF VARIABLE
function TCommandContext.GetVar(const AName: string): string;
begin
end;

// CREATE AND/OR SET VALUE OF CONSTANT
function TCommandContext.SetConst(const AName, AValue: string): Boolean;
var
  CValue: TContextValue;
begin
  if Length(AName) > 0 then
  begin
    CValue.RawValue := AValue;
    CValue.IsReadOnly := true;
    FVariables.AddOrSetValue(LowerCase(AName), CValue);
  end;
end;

// CREATE AND/OR GET VALUE OF VARIABLE
function TCommandContext.SetVar(const AName, AValue: string): Boolean;
var
  CValue: TContextValue;
begin
  if Length(AName) > 0 then
  begin
    CValue.RawValue := AValue;
    CValue.IsReadOnly := false;
    FVariables.AddOrSetValue(LowerCase(AName), CValue);
  end;
end;

// CLEAR ALL VARIABLES AND CONSTANTS
procedure TCommandContext.Clear;
begin
  FVariables.Clear;
end;

// WRITE TEXT TO OUTPUT OBJECT
procedure TCommandContext.WriteOutput(const AText: string);
begin
  if Assigned(FOutput)
    then FOutput.Add(AText)
    else writeln(AText);
end;

begin
end.
