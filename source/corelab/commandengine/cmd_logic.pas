{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_logic.pas                                                            | }
{ | Logic operation commands                                                 | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ Logic operation commands:

  The success of the operations in the ExitCode.

  name: 	AND
  description:	Bitwise/logical AND in-place.
  scope:	csEveryWhere
  syntax:	AND $target value|$variable
  note:		The operation modifies the $FZ flag.

  name: 	NOT
  description:	Bitwise/logical NOT in-place.
  scope:	csEveryWhere
  syntax:	NOT $target
  note:		The operation modifies the $FZ flag.

  name: 	OR
  description:	Bitwise/logical OR in-place.
  scope:	csEveryWhere
  syntax:	OR $target value|$variable
  note:		The operation modifies the $FZ flag.

  name: 	XOR
  description:	Bitwise/logical XOR in-place.
  scope:	csEveryWhere
  syntax:	XOR $target value|$variable
  note:		The operation modifies the $FZ flag.

  name: 	SHL
  description:	Shift target bits left by count in-place.
  scope:	csEveryWhere
  syntax:	SHL $target [count|$variable]
  note:		The operation modifies the $FZ and $FC flags.
  
  name: 	SHR
  description:	Shift target bits right by count in-place.
  scope:	csEveryWhere
  syntax:	SHR $target [count|$variable]
  note:		The operation modifies the $FZ and $FC flags.

  name: 	BIT
  description:	Check the specified bit.
  scope:	csEveryWhere
  syntax:	BIT $variable value|$variable
  note:		The operation modifies the $FZ flag.
}

unit cmd_logic;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  TCmd_AND = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_NOT = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_OR = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_XOR = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SHL = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SHR = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_BIT = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation

// CREATE INSTANCES
constructor TCmd_AND.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_NOT.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_OR.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_XOR.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_SHL.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_SHR.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_BIT.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

// DESTROY INSTANCES
destructor TCmd_AND.Destroy; begin inherited Destroy; end;
destructor TCmd_NOT.Destroy; begin inherited Destroy; end;
destructor TCmd_OR.Destroy; begin inherited Destroy; end;
destructor TCmd_XOR.Destroy; begin inherited Destroy; end;
destructor TCmd_SHL.Destroy; begin inherited Destroy; end;
destructor TCmd_SHR.Destroy; begin inherited Destroy; end;
destructor TCmd_BIT.Destroy; begin inherited Destroy; end;

// EXECUTE OPERATION
function TCmd_AND.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_NOT.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_OR.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_XOR.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SHL.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SHR.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_BIT.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

begin
end.
