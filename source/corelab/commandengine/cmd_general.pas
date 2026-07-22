{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_general.pas                                                          | }
{ | General commands                                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ General commands:

  The success of the operations in the ExitCode.

  name: 	APPX
  description:	Terminate simulation environment.
  scope:	csInteractiveOnly
  syntax:	APPX value|$variable

  name: 	CALL
  description:	Call subroutine.
  scope:	csScriptOnly
  syntax:	PSHA $parameter
  		CALL $object.method

  name: 	RTRN
  description:	Return from subroutine.
  scope:	csScriptOnly
  syntax:	RTRN
   		POPA $parameter

  name: 	END
  description:	End of script.
  scope:	csScriptOnly
  syntax:	END

  name: 	EXIT
  description:	Terminate the script.
  scope:	csScriptOnly
  syntax:	EXIT value|$variable

  name: 	HELP
  description:	Display general help overview or detailed usage for a specific command.
  scope:	csInteractiveOnly
  syntax:	HELP [command]

  name: 	INPW
  description:	Show prompt window and read user input into a variable.
  scope:	csEveryWhere
  syntax:	PSHA "title"
  		PSHA "label"
  		INPW $target [default|$variable]

  name: 	JPEQ, JPNE, JPLT, JPGT, JPLE, JPGE, JPZR, JPNZ
  description:	Jump to the specified label, based on the result of the previous CMP.
  scope:	csScriptOnly
  syntax:	JPxx label|$variable
  note:		The operation clears the $FZ and $FC flags.

  name: 	MSGW
  description:	Show modal message window.
  scope:	csEveryWhere
  syntax:	PSHA "title"
  		PSHA "label"
		PSHA $variable
  		MSGW "bla bla %v bla"

  name: 	PRNT
  description:	Write text to console.
  scope:	csEveryWhere
  syntax:	PSHA $variable
    		PRNT "bla bla %v bla"

  name: 	WAIT
  description:	Wait specified ms.
  scope:	csEveryWhere
  syntax:	WAIT value|$variable
}

unit cmd_general;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  TCmd_APPX = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_CALL = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_RTRN = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_END = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_EXIT = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_HELP = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_INPW = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPEQ = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPNE = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPLT = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPGT = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPLE = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPGE = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPZR = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_JPNZ = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_MSGW = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_PRNT = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;
  TCmd_WAIT = class(TCommand)
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation

// CREATE INSTANCES
constructor TCmd_APPX.Create;
begin
  inherited Create;
  FCommandScope := csInteractiveOnly;
end;

constructor TCmd_CALL.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_RTRN.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_END.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_EXIT.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_HELP.Create;
begin
  inherited Create;
  FCommandScope := csInteractiveOnly;
end;

constructor TCmd_INPW.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_JPEQ.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_JPNE.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_JPLT.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_JPGT.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_JPLE.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_JPGE.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_JPZR.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_JPNZ.Create;
begin
  inherited Create;
  FCommandScope := csScriptOnly;
end;

constructor TCmd_MSGW.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_PRNT.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

constructor TCmd_WAIT.Create;
begin
  inherited Create;
  FCommandScope := csEveryWhere;
end;

// DESTROY INSTANCES
destructor TCmd_APPX.Destroy; begin inherited Destroy; end;
destructor TCmd_CALL.Destroy; begin inherited Destroy; end;
destructor TCmd_RTRN.Destroy; begin inherited Destroy; end;
destructor TCmd_END.Destroy; begin inherited Destroy; end;
destructor TCmd_EXIT.Destroy; begin inherited Destroy; end;
destructor TCmd_HELP.Destroy; begin inherited Destroy; end;
destructor TCmd_INPW.Destroy; begin inherited Destroy; end;
destructor TCmd_JPEQ.Destroy; begin inherited Destroy; end;
destructor TCmd_JPNE.Destroy; begin inherited Destroy; end;
destructor TCmd_JPLT.Destroy; begin inherited Destroy; end;
destructor TCmd_JPGT.Destroy; begin inherited Destroy; end;
destructor TCmd_JPLE.Destroy; begin inherited Destroy; end;
destructor TCmd_JPGE.Destroy; begin inherited Destroy; end;
destructor TCmd_JPZR.Destroy; begin inherited Destroy; end;
destructor TCmd_JPNZ.Destroy; begin inherited Destroy; end;
destructor TCmd_MSGW.Destroy; begin inherited Destroy; end;
destructor TCmd_PRNT.Destroy; begin inherited Destroy; end;
destructor TCmd_WAIT.Destroy; begin inherited Destroy; end;

// EXECUTE OPERATION
function TCmd_APPX.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_CALL.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_RTRN.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_END.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_EXIT.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_HELP.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_INPW.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPEQ.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPNE.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPLT.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPGT.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPLE.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPGE.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPZR.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_JPNZ.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_MSGW.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_PRNT.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

function TCmd_WAIT.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try
  except
    Result := -1;
  end;
end;

begin
end.
