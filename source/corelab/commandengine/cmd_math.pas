{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_math.pas                                                             | }
{ | Arithmetical command classes                                             | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ Commands:
    abs, add, conv, dec, div idiv, imod, inc, mul, sub. }
 
unit cmd_math;
{$MODE OBJFPC}{$H+}
interface
uses
   command, commandcontext, token;
type
  // Abstract command class
  TCmd_abs = class(TCommand)
  protected
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(ATokens: TTokenList; AContext: TCommandContext): integer; override;
  end;

implementation
uses
  Math, SysUtils;

// CREATE TCMD_ABS INSTANCE
constructor TCmd_abs.Create;
begin
  inherited Create;
end;

// DESTROY TCMD_ABS INSTANCE
destructor TCmd_abs.Destroy;
begin
  inherited Destroy;
end;

// EXECUTE OPERATION
function TCmd_abs.Execute(ATokens: TTokenList; AContext: TCommandContext): integer;
begin
  Result := 0;
  try

  except
    Result := -1;
  end;
end;

begin
end.
