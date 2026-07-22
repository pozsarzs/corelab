{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_math.pas                                                             | }
{ | Arithmetical commands                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ Arithmetical operation commands:

  The success of the operations in the ExitCode.

  name: 	ABS
  description:	Replace target value with its absolute value in-place.
  scope:	csEveryWhere
  syntax:	ABS $target
  note:		The operation modifies the $FZ and $FC flags.

  name: 	ADD
  description:	Add value to target in-place.
  scope:	csEveryWhere
  syntax:	ADD $target value|$variable
  note:		The operation modifies the $FZ and $FC flags.

  name: 	DEC
  description:	Decrement integer target by 1 or by count in-place.
  scope:	csEveryWhere
  syntax:	DEC $target [count|$variable]
  note:		The operation modifies the $FZ and $FC flags.

  name: 	IDV
  description:	Perform integer division on target in-place.
  scope:	csEveryWhere
  syntax:	IDV $target value|$variable
  note:		The operation modifies the $FZ and $FC flags.

  name: 	IMD
  description:	Perform integer division remainder on target in-place.
  scope:	csEveryWhere
  syntax:	IMD $target value|$variable
  note:		The operation modifies the $FZ and $FC flags.

  name: 	INC
  description:	Increment integer target by 1 or by count in-place.
  scope:	csEveryWhere
  syntax:	INC $target [count|$variable]
  note:		The operation modifies the $FZ and $FC flags.

  name: 	RDV
  description:	Perform floating-point division on target in-place.
  scope:	csEveryWhere
  syntax:	RDV $target value|$variable
  note:		The operation modifies the $FZ and $FC flags.

  name: 	MUL
  description:	Multiply target by value in-place in-place.
  scope:	csEveryWhere
  syntax:	MUL $target value|$variable
  note:		The operation modifies the $FZ and $FC flags.

  name: 	SUB
  description:	Subtract value from target in-place.
  scope:	csEveryWhere
  syntax:	SUB $target value|$variable
  note:		The operation modifies the $FZ and $FC flags.
}

unit cmd_math;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  TCmd_ABS = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_ADD = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_DEC = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_IDV = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_IMD = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_INC = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_RDV = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_MUL = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SUB = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation

// CREATE INSTANCES
constructor TCmd_ABS.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_ADD.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_DEC.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_IDV.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_IMD.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_INC.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_RDV.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_MUL.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_SUB.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

// DESTROY INSTANCES
destructor TCmd_ABS.Destroy; begin inherited Destroy; end;
destructor TCmd_ADD.Destroy; begin inherited Destroy; end;
destructor TCmd_DEC.Destroy; begin inherited Destroy; end;
destructor TCmd_IDV.Destroy; begin inherited Destroy; end;
destructor TCmd_IMD.Destroy; begin inherited Destroy; end;
destructor TCmd_INC.Destroy; begin inherited Destroy; end;
destructor TCmd_RDV.Destroy; begin inherited Destroy; end;
destructor TCmd_MUL.Destroy; begin inherited Destroy; end;
destructor TCmd_SUB.Destroy; begin inherited Destroy; end;

// EXECUTE OPERATION
function TCmd_ABS.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_ADD.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_DEC.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_IDV.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_IMD.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_INC.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_RDV.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_MUL.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SUB.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

begin
end.
