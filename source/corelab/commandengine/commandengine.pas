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
    FActionList:   TActionList;
    FContext:      TCommandContext;
    FLastExitCode: integer;
    FParser:       TCommandParser;
    FRegistry:     TCommandRegistry;
    FRunningMode:  TCommandScope;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function ExecuteAction(const AName: string): Boolean; virtual;
    function ExecuteLine(const ALine: string): Integer;  virtual;
    property LastExitCode: integer read FLastExitCode;
    property Registry: TCommandRegistry read FRegistry write FRegistry;
    property RunningMode: TCommandScope read FRunningMode write FRunningMode;
    property ActionList: TActionList read FActionList write FActionList;
  end;

implementation

// CREATE TCOMMANDENGINE INSTANCE
constructor TCommandEngine.Create;
begin
  inherited Create;
  FContext := TCommandContext.Create;
  FParser := TCommandParser.Create;
end;

// DESTROY TCOMMANDENGINE INSTANCE
destructor TCommandEngine.Destroy;
begin
  FContext.Free;
  FParser.Free;
  inherited Destroy;
end;

// EXECUTE ACTION
function TCommandEngine.ExecuteAction(const AName: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  if FActionList = nil then Exit;
  for i := 0 to FActionList.ActionCount - 1 do
  begin
    if SameText(FActionList.Actions[i].Name, AName) then
    begin
      FActionList.Actions[i].Execute;
      exit(True);
    end;
  end;
end;

// EXECUTE COMMAND WITH PARAMETERS
function TCommandEngine.ExecuteLine(const ALine: string): Integer;
var
  Command:      TCommand;  
  CommandClass: TCommandClass;
  CommandName:  string;
  Tokens:       TTokenList;
begin
  Result := 0;
  // If ALine is empty line or comment
  if (Trim(ALine) = '') or (ALine[1] = '#') then exit;
  // Get tokens to a TTokenList instance
  Tokens := FParser.Tokenize(ALine, FContext);
  try
    // If no any token
    if Tokens.Count = 0 then exit;
    // Get name of command
    CommandName := LowerCase(Tokens[0].RawText);
    // Get command class with command name from CommandRegistry
    if FRegistry.TryGetCommand(CommandName, CommandClass) then
    begin
      // Create, execute and destroy command instance
      Command := CommandClass.Create;
      try
        if (Command.CommandScope = FRunningMode) then
        begin
          Command.ParamCount := Tokens.Count - 1;
          Result := Command.Execute(Tokens, FContext);
          ExecuteAction(Command.ActionName);
        end;
      finally
        Command.Free;
      end;  
    end else
      // Unknown command
      Result := -1;
  finally
    // Destroy TokenList instance
    Tokens.Free;
  end;
  FLastExitCode := Result;
end;

begin
end.
