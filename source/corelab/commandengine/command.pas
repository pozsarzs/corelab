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
  uactcontext, ucommon;
type
  // target type of output call
  TActionOperation = procedure(AActionContext: TActionContext) of object;
  // Command scope type
  TCommandScope = (csCommandLine, csScript);
  TCommandScopes = set of TCommandScope;
  { TCommand }
  TCommand = class
  protected
    FName:               string;
    FDescription:        string;
    FScope:              TCommandScopes;
    FSyntax:             string;
    FRequiredArgs:       Integer;
    FOperation:          TActionOperation;
    FAllowedUnderCPURun: Boolean;
    FAllowedOpModes:     TOpModes;
  public
    constructor Create(const AName: string;
                       const ADescription: string;
                       AScope: TCommandScopes;
                       const ASyntax: string;
                       ARequiredArgs: Byte;
                       AOperation: TActionOperation;
                       AAllowedUnderCPURun: Boolean;
                       AAllowedOpModes: TOpModes); virtual;
    destructor Destroy; override;
    property Name: string read FName;
    property Description: string read FDescription;
    property Scope: TCommandScopes read FScope;
    property Syntax: string read FSyntax;
    property Operation: TActionOperation read FOperation;
    property RequiredArgs: Integer read FRequiredArgs;
    property AllowedUnderCPURun: Boolean read FAllowedUnderCPURun;
    property AllowedOpModes: TOpModes read FAllowedOpModes;
  end;

implementation

{ TCommand }

// CREATE TCOMMAND INSTANCE
constructor TCommand.Create(const AName: string;
                            const ADescription: string;
                            AScope: TCommandScopes;
                            const ASyntax: string;
                            ARequiredArgs: Byte;
                            AOperation: TActionOperation;
                            AAllowedUnderCPURun: Boolean;
                            AAllowedOpModes: TOpModes);
begin
  inherited Create;
  FName := AName;
  FDescription := ADescription;
  FScope := AScope;
  FSyntax := ASyntax;
  FRequiredArgs :=  ARequiredArgs;
  FOperation := AOperation;
  FAllowedUnderCPURun := AAllowedUnderCPURun;
  FAllowedOpModes := AAllowedOpModes;
end;

// DESTROY TCOMMAND INSTANCE
destructor TCommand.Destroy;
begin
  inherited Destroy;
end;

begin
end.
