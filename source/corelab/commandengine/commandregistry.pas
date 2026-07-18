{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | commandregistry.pas                                                      | }
{ | Command registry class                                                   | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit commandregistry;
{$MODE OBJFPC}{$H+}
interface
uses
  Generics.Collections, SysUtils, command;
type
  // Class-reference type for registration
  TCommandClass = class of TCommand;  
  // Dictionary with <command name, command class> elements
  TCommandDict = specialize TDictionary<string, TCommandClass>;
  // Abstract command registry class
  TCommandRegistry = class
  protected
    FCommands: TCommandDict;                // Dictionary of registered commands
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function TryGetCommand(const AName: string; var ACommandClass: TCommandClass): Boolean; virtual;
    procedure RegisterCommand(const AName: string; ACommandClass: TCommandClass); virtual;
  end;

implementation

// CREATE TCOMMANDREGISTRY INSTANCE
constructor TCommandRegistry.Create;
begin
  inherited Create;
  FCommands := TCommandDict.Create;
end;

// DESTROY TCOMMANDREGISTRY INSTANCE
destructor TCommandRegistry.Destroy;
begin
  FCommands.Free;
  inherited Destroy;
end;

// TRY TO GET THE COMMAND CLASS FROM COMMAND NAME
function TCommandRegistry.TryGetCommand(const AName: string; var ACommandClass: TCommandClass): Boolean;
var
  Key: string;
begin
  Result := FCommands.TryGetValue(LowerCase(AName), ACommandClass);
  if not Result then ACommandClass := nil; 
end;

// ADD COMMAND TO REGISTRY
procedure TCommandRegistry.RegisterCommand(const AName: string; ACommandClass: TCommandClass);
begin
  if (Length(AName) = 0) or (ACommandClass = nil)
    then exit
    else FCommands.AddOrSetValue(LowerCase(AName), ACommandClass);
end;

begin
end.
