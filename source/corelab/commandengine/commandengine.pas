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
  SysUtils, Classes, command, commandparser, commandregistry, uactcontext, token;
type
  { TCommandEngine }
  TCommandEngine = class
  protected
    FExitRequested: Boolean;
    FLastExitCode:  Integer;
    FParser:        TCommandParser;
    FRegistry:      TCommandRegistry;
    FRunningMode:   TCommandScope;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function ExecuteLine(const ALine: string): Integer;  virtual;
    property ExitRequested: Boolean read FExitRequested;
    property Registry: TCommandRegistry read FRegistry write FRegistry;
    property LastExitCode: Integer read FLastExitCode;
    property RunningMode: TCommandScope read FRunningMode write FRunningMode;
  end;

implementation
uses
  frmmain;

{ TCommandEngine }

// CREATE TCOMMANDENGINE INSTANCE
constructor TCommandEngine.Create;
begin
  inherited Create;
  FRegistry := TCommandRegistry.Create;
  // commands
  with FRegistry do
  begin
    {$I cmd-f.pas}
    {$I cmd-v.pas}
    {$I cmd-p.pas}
    {$I cmd-m.pas}
    {$I cmd-io.pas}
    {$I cmd-o.pas}
    {$I cmd-s.pas}
  end;
  FParser := TCommandParser.Create;
end;

// DESTROY TCOMMANDENGINE INSTANCE
destructor TCommandEngine.Destroy;
begin
  FParser.Free;
  FRegistry.Free;
  inherited Destroy;
end;

// EXECUTE COMMAND WITH PARAMETERS
function TCommandEngine.ExecuteLine(const ALine: string): Integer;
var
  ActionContext: TActionContext;
  Command:       TCommand;  
  CommandName:   string;
  i:             Integer;
  Line:          string;
  Tokens:        TTokenList;
  InfoText:      string;
  InfoList:      TStringList;
begin
  Result := 0;
  // empty line or comment
  if (Trim(ALine) = '') or (ALine[1] = '#') or (ALine[1] = ';') then exit;
  // remove comment at end of line
  Line := ALine;
  i := Pos(';', Line);
  if i > 0 then Delete(Line, i, MaxInt);
  // get tokens to a TTokenList instance
  Tokens := FParser.Tokenize(Line);
  try
    // if no any token
    if Tokens.Count = 0 then exit;
    // get name of command
    CommandName := LowerCase(Tokens[0].RawText);
    // at HELP command
    if CommandName = 'gato' then
    begin
      Infotext := LineEnding + '  /\_/\' + LineEnding +' ( o.o )' + LineEnding +
                  '  > ^ <' + LineEnding +'  /   \' +  LineEnding;
      Form1.SysConsole1.WriteMessage(InfoText);
      Result := 0;
      Exit;
    end;
    // at HELP command
    if CommandName = 'help' then
    begin
      // command list
      if Tokens.Count = 1 then
      begin
        InfoList := TStringList.Create;
        try
          for Command in FRegistry.Commands.Values do
            InfoList.Add(Format('%-10s %s', [Command.Name, Command.Description]));
          InfoList.Sort;
          for i := 0 to InfoList.Count -1 do
            Form1.SysConsole1.WriteMessage(InfoList.Strings[i]);
          Result := 0;
          Exit;
        finally
          InfoList.Free
        end;
      end;
      // command info
      Command := FRegistry.FindCommand(Tokens[1].RawText);
      if Command = nil then
      begin
        Result := -1;
        Exit;
      end;
      with Command do
      begin
        InfoText := Name + LineEnding +
                    '  ' + Description + LineEnding +
                    '  Syntax: ' + Syntax + LineEnding;
        case Scope of
          csEverywhere:      InfoText := InfoText + '  Scope:  Everywhere';
          csScriptOnly:      InfoText := InfoText + '  Scope:  Script only';
          csInteractiveOnly: InfoText := InfoText + '  Scope:  Interactive only';
      end;
      end;
      Form1.SysConsole1.WriteMessage(InfoText);
      Result := 0;
      Exit;
    end;
    // find command object in CommandRegistry
    Command := FRegistry.FindCommand(CommandName);
    // unknown command
    if Command = nil then
    begin
      Result := -1;              
      Exit;
    end;    
    // cannot be used in this mode
    if Command.Scope = csScriptOnly then
    begin
      Result := -2;              
      Exit;
    end;
    // argument number error
    if (Tokens.Count - 1) <> Command.RequiredArgs then
    begin
      Result := -3;
      Exit;
    end;
    // arguments and calling
    ActionContext := TActionContext.Create;
    try
      // set caller 
      ActionContext.ActionSource := asSysConsole;
      // arguments
      with ActionContext do
      begin
        SArg1 := '';
        SArg2 := '';
        if Tokens.Count > 1 then SArg1 := Tokens[1].RawText;
        if Tokens.Count > 2 then SArg2 := Tokens[2].RawText;
        if not TryStrToBool(SArg1, BArg1) then BArg1 := False;
        if not TryStrToBool(SArg2, BArg2) then BArg2 := False;
        if not TryStrToInt(SArg1, IArg1) then IArg1 := -1;
        if not TryStrToInt(SArg2, IArg2) then IArg2 := -1;
      end;
      Command.Operation(ActionContext);
      Result := 0;
    finally
      ActionContext.Free;
    end;
  finally
    Tokens.Free;
  end;
  FLastExitCode := Result;
end;

end.
