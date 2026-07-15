{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | command.pas                                                              | }
{ | Command class                                                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit command;
{$MODE OBJFPC}{$H+}
interface
uses
   token, commandcontext;
type
  // Abstract command class
  TCommand = class
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(Tokens: TTokenList; AContext: TCommandContext): integer; virtual;
  end;

implementation

// CREATE TCOMMAND INSTANCE
constructor TCommand.Create;
begin
  inherited Create;
end;

// DESTROY TCOMMAND INSTANCE
destructor TCommand.Destroy;
begin
  inherited Destroy;
end;

function TCommand.Execute(Tokens: TTokenList; AContext: TCommandContext): integer;
begin
end;

begin
end.
