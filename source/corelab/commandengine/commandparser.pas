{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | commandparser.pas                                                        | }
{ | Command parser class                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit commandparser;
{$MODE OBJFPC}{$H+}
//{$MODESWITCH TYPEHELPERS}
interface
uses
   commandcontext, token;
type
  // Abstract command parser class
  TCommandParser = class
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Tokenize(ALine: string; AContext: TCommandContext): TTokenList; virtual;
  end;

implementation

// CREATE TCOMMANDPARSER INSTANCE
constructor TCommandParser.Create;
begin
  inherited Create;
end;

// DESTROY TCOMMANDPARSER INSTANCE
destructor TCommandParser.Destroy;
begin
  inherited Destroy;
end;

function TCommandParser.Tokenize(ALine: string; AContext: TCommandContext): TTokenList;
begin
end;

begin
end.
