{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_string.pas                                                           | }
{ | String operation commands                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ String operation commands:

  The success of the operations in the ExitCode.

  name: 	SAPP
  description:	Append value or variable to the end of target string in-place.
  scope:	csScriptOnly
  syntax:	SAPP $target value|$variable

  name: 	SDEL
  description:	Delete characters from target starting at index in-place.
  scope:	csScriptOnly
  syntax:	SDEL $target index count

  name: 	SFND
  description:	Find index of substring in target and store 0-based result (-1 if not found).
  scope:	csScriptOnly
  syntax:	SFND $target substring|$variable $result

  name: 	SINS
  description:	Insert substring into target at specified index in-place.
  scope:	csScriptOnly
  syntax:	SINS $target index substring|$variable

  name: 	SLEN
  description:	Store the character count of target string into a variable.
  scope:	csScriptOnly
  syntax:	SLEN $target $result

  name: 	SLOW
  description:	Convert target string to lowercase in-place.
  scope:	csScriptOnly
  syntax:	SLOW $target

  name: 	SREP
  description:	Replace occurrences of old substring with new substring in target in-place.
  scope:	csScriptOnly
  syntax:	SREP $target old_str|$var new_str|$var

  name: 	SSUB
  description:	Extract a substring from target starting at index into result variable.
  scope:	csScriptOnly
  syntax:	SSUB $target index count $result

  name: 	SUPP
  description:	Convert target string to uppercase in-place.
  scope:	csScriptOnly
  syntax:	SUPP $target
}

unit cmd_string;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  TCmd_SAPP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SDEL = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SFND = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SINS = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SLEN = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SLOW = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SREP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SSUB = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SUPP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation

// CREATE INSTANCES
constructor TCmd_SAPP.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SDEL.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SFND.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SINS.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SLEN.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SLOW.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SREP.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SSUB.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_SUPP.Create; begin inherited Create; FCommandScope := csScriptOnly; end;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

// DESTROY INSTANCES
destructor TCmd_SAPP.Destroy; begin inherited Destroy; end;
destructor TCmd_SDEL.Destroy; begin inherited Destroy; end;
destructor TCmd_SFND.Destroy; begin inherited Destroy; end;
destructor TCmd_SINS.Destroy; begin inherited Destroy; end;
destructor TCmd_SLEN.Destroy; begin inherited Destroy; end;
destructor TCmd_SLOW.Destroy; begin inherited Destroy; end;
destructor TCmd_SREP.Destroy; begin inherited Destroy; end;
destructor TCmd_SSUB.Destroy; begin inherited Destroy; end;
destructor TCmd_SUPP.Destroy; begin inherited Destroy; end;

// EXECUTE OPERATION
function TCmd_SAPP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SDEL.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SFND.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SINS.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SLEN.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SLOW.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SREP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SSUB.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SUPP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

begin
end.
