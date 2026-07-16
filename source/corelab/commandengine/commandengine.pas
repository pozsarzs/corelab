{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | commandengine.pas                                                        | }
{ | Command line engine class                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit commandengine;
{$MODE OBJFPC}{$H+}
interface
uses
  ActnList, SysUtils, command, commandcontext, commandparser, commandregistry,
  token;
type
  // Abstract command engine class
  TCommandEngine = class
  protected
    FActionList: TActionList;
    FContext: TCommandContext;
    FLastExitCode: integer;
    FParser: TCommandParser;
    FRegistry: TCommandRegistry;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function ExecuteLine(const ALine: string): Integer;  virtual;
    property LastExitCode: integer read FLastExitCode;
  end;

implementation

// CREATE TCOMMANDENGINE INSTANCE
constructor TCommandEngine.Create;
begin
  inherited Create;
  FActionList := TActionList.Create(nil);
  FContext := TCommandContext.Create;
  FParser := TCommandParser.Create;
  FRegistry := TCommandRegistry.Create;
end;

// DESTROY TCOMMANDENGINE INSTANCE
destructor TCommandEngine.Destroy;
begin
  FActionList.Free;
  FContext.Free;
  FParser.Free;
  FRegistry.Free;
  inherited Destroy;
end;

function TCommandEngine.ExecuteLine(const ALine: string): Integer;
var
  Tokens: TTokenList;
  CommandName: string;
  Command: TCommand;
begin
  Result := 0;
  if (Trim(ALine) = '') or (ALine[1] = '#') then Exit;
  Tokens := FParser.Tokenize(ALine, FContext);
  try
//    if Tokens.Count = 0 then Exit;
//    CommandName := LowerCase(Tokens[0].RawText);
//    if FRegistry.TryGetCommand(CommandName, Command) then
//    begin
//      Result := Command.Execute(Tokens, FContext);
//    end
//    else Result := -1;
  finally
    Tokens.Free;
  end;
end;

begin
end.
