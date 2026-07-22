{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_data.pas                                                             | }
{ | Data management commands                                                 | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ Data management commands:

  The success of the operations in the ExitCode.

  name: 	ASCI
  description:	Convert ASCII character to its byte value.
  scope:	csEveryWhere
  syntax:	ASCI $target value|$source

  name: 	CHAR
  description:	Convert byte size value to its ASCII character representation.
  scope:	csEveryWhere
  syntax:	CHAR $target value|$source

  name: 	COMP
  description:	Compare target with value by subtraction.
  scope:	csEveryWhere
  syntax:	COMP value1|$variable1 value2|$variable2
  note:		The operation modifies the $FZ and $FC flags.

  name: 	CONV
  description:	Convert number in different numeral systems in-place.
  scope:	csEveryWhere
  syntax:	CONV $target nsBin|nsDec|nsHex|nsOct

  name: 	INRG
  description:	Check if value is between min and max.
  scope:	csEveryWhere
  syntax:	INRG $target value|$variable
  note:		The operation modifies the $FZ and $FC flags.

  name: 	FILL
  description:	Fill an array with a specific byte value.
  scope:	csEveryWhere
  syntax:	FILL $array value|$source

  name: 	POPA
  description:	Retrieve an result from argument stack.
  scope:	csEveryWhere
  syntax:	POPA $target

  name: 	PSHA
  description:	Store an argument to the argument stack.
  scope:	csEveryWhere
  syntax:	PSHA value|$source

  name: 	SETV
  description:	Create variable and/or assign value to variable or array element.
  scope:	csEveryWhere
  syntax:	SETV $target [value|$source]

  name: 	SWAP
  description:	Swap the values of two variables.
  scope:	csEveryWhere
  syntax:	SWAP $variable1 $variable2

  name:		INDX
  description:	Search for a value in an array and then return it with its index in the exit code.
  scope:	csEveryWhere
  syntax:	INDX $array value|$source
}

unit cmd_data;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  TCmd_ASCI = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_CHAR = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_COMP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_CONV = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_INRG = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_FILL = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_POPA = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_PSHA = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SETV = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SWAP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_INDX = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation

// CREATE INSTANCES
constructor TCmd_ASCI.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_CHAR.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_COMP.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_CONV.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_INRG.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_FILL.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_POPA.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_PSHA.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_SETV.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_SWAP.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_INDX.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

// DESTROY INSTANCES
destructor TCmd_ASCI.Destroy; begin inherited Destroy; end;
destructor TCmd_CHAR.Destroy; begin inherited Destroy; end;
destructor TCmd_COMP.Destroy; begin inherited Destroy; end;
destructor TCmd_CONV.Destroy; begin inherited Destroy; end;
destructor TCmd_INRG.Destroy; begin inherited Destroy; end;
destructor TCmd_FILL.Destroy; begin inherited Destroy; end;
destructor TCmd_POPA.Destroy; begin inherited Destroy; end;
destructor TCmd_PSHA.Destroy; begin inherited Destroy; end;
destructor TCmd_SWAP.Destroy; begin inherited Destroy; end;
destructor TCmd_INDX.Destroy; begin inherited Destroy; end;

// EXECUTE OPERATION
function TCmd_ASCI.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_CHAR.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_COMP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_CONV.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_INRG.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_FILL.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_POPA.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_PSHA.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_SETV.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_SWAP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

function TCmd_INDX.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
    // Implementáció helye
  except
    Result := -1;
  end;
end;

begin
end.
