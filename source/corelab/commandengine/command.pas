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
   Math, token, commandcontext;
type
  // Command scope type
  TCommandScope = (csEverywhere, csScriptOnly, csInteractiveOnly);
  // Abstract command class
  TCommand = class
  protected
    FActionName:    string;
    FMinParamCount: Byte;
    FMaxParamCount: Byte;
    FParamCount:    Byte;
    FCommandScope:  TCommandScope;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(Tokens: TTokenList; AContext: TCommandContext): Integer; virtual; abstract;
    procedure SetParamCount(ACount: Byte);
    property ActionName: string read FActionName;
    property MinParamCount: Byte read FMinParamCount;
    property MaxParamCount: Byte read FMaxParamCount;
    property ParamCount: Byte read FParamCount write SetParamCount;
    property CommandScope: TCommandScope read FCommandScope;
  end;

implementation

// CREATE TCOMMAND INSTANCE
constructor TCommand.Create;
begin
  inherited Create;
  FActionName := '';
  FCommandScope := csEverywhere;
  FMinParamCount := 0;
  FMaxParamCount := 0;
  FParamCount := 0;
end;

// DESTROY TCOMMAND INSTANCE
destructor TCommand.Destroy;
begin
  inherited Destroy;
end;

// SET PARAMCOUNT PROPERTY
procedure TCommand.SetParamCount(ACount: byte);
begin
  FParamCount := EnsureRange(ACount, 0, 255);
end;

begin
end.
