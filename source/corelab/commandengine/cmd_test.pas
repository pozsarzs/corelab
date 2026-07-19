{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_test.pas                                                             | }
{ | Dummy command classes for ChkCommandEngine program                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ Commands:
    teststart, teststop, teststatus. }
 
unit cmd_test;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  // Abstract command class
  TCmd_teststart = class(TCommand)
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_teststop = class(TCommand)
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_teststatus = class(TCommand)
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_bye = class(TCommand)
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation

// CREATE INSTANCES
constructor TCmd_teststart.Create;
begin
  inherited Create;
end;

constructor TCmd_teststop.Create;
begin
  inherited Create;
end;

constructor TCmd_teststatus.Create;
begin
  inherited Create;
end;

constructor TCmd_bye.Create;
begin
  inherited Create;
end;

// DESTROY INSTANCES
destructor TCmd_teststart.Destroy;
begin
  inherited Destroy;
end;

destructor TCmd_teststop.Destroy;
begin
  inherited Destroy;
end;

destructor TCmd_teststatus.Destroy;
begin
  inherited Destroy;
end;

destructor TCmd_bye.Destroy;
begin
  inherited Destroy;
end;

// EXECUTE OPERATION
function TCmd_teststart.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    FCommandScope := csEverywhere;
    FActionName := 'actStart';
    AContext.WriteOutput('Execute command "teststart."');
  except
    Result := -1;
  end;
end;

function TCmd_teststop.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    FActionName := 'actStop';
    AContext.WriteOutput('Execute command "teststop."');
  except
    Result := -1;
  end;
end;

function TCmd_teststatus.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    FActionName := 'actStatus';
    AContext.WriteOutput('Execute command "teststatus."');
  except
    Result := -1;
  end;
end;

function TCmd_bye.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  FExitRequested := True;
  AContext.WriteOutput('Execute command "bye".');
  Result := 0;
end;

begin
end.
