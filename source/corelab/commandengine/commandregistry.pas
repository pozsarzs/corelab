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
  TCommandDict = specialize TObjectDictionary<string, TCommand>;
  // Abstract command registry class
  TCommandRegistry = class
  protected
    FCommands: TCommandDict;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function TryGetCommand(const CommandName: string; var Command: TCommand): Boolean; virtual;
    procedure RegisterCommand(const AName: string; ACommand: TCommand); virtual;
  end;

implementation

// CREATE TCOMMANDREGISTRY INSTANCE
constructor TCommandRegistry.Create;
begin
  inherited Create;
end;

// DESTROY TCOMMANDREGISTRY INSTANCE
destructor TCommandRegistry.Destroy;
begin
  inherited Destroy;
end;

function TCommandRegistry.TryGetCommand(const CommandName: string; var Command: TCommand): Boolean;
begin
end;

procedure TCommandRegistry.RegisterCommand(const AName: string; ACommand: TCommand);
begin
end;

begin
end.
