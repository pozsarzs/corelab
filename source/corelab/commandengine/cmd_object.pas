{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_objets.pas                                                           | }
{ | Object management commands                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ Object management commands:

  The success of the operations in the ExitCode.

  name: 	CALM
  description:	Call object's method.
  scope:	csEveryWhere
  syntax:	PSHA $parameter
  		CALM [$target] $object.method

  name: 	CRTE
  description:	Instantiate a hardware module or debug form.
  scope:	csEveryWhere
  syntax:	CRTE $object class|$variable
  
  name: 	DEST
  description:	Delete an object and free its memory.
  scope:	csEveryWhere
  syntax:	DEST $object

  name: 	GETP
  description:	Get object's property.
  scope:	csEveryWhere
  syntax:	GETP $target $object.property
  note:		The operation modifies the $FZ flag.

  name: 	SETP
  description:	Set object's property.
  scope:	csEveryWhere
  syntax:	SETP $object.property value|$variable
 }

unit cmd_object;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  TCmd_CALM = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_CRTE = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_DEST = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_GETP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_SETP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation

// CREATE INSTANCES
constructor TCmd_CALM.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_CRTE.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_DEST.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_GETP.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_SETP.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

// DESTROY INSTANCES
destructor TCmd_CALM.Destroy; begin inherited Destroy; end;
destructor TCmd_CRTE.Destroy; begin inherited Destroy; end;
destructor TCmd_DEST.Destroy; begin inherited Destroy; end;
destructor TCmd_GETP.Destroy; begin inherited Destroy; end;
destructor TCmd_SETP.Destroy; begin inherited Destroy; end;

// EXECUTE OPERATION
function TCmd_CALM.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_CRTE.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_DEST.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_GETP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_SETP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

begin
end.
