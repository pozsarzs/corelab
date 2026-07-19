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

**Arithmetic**
abs
everywhere
abs  - Replace target value with its absolute value in-place (e.g., abs rA).

add
everywhere
add   - Add value to target in-place (e.g., add rA 0x10).

conv
interactive
conv  [to <BIN|DEC|HEX|OCT>] - Convert and print number in different base formats (useful for debugging).

dec
everywhere
dec  [count] - Decrement integer target by 1 or by count in-place (e.g., dec rB).

div
everywhere
div   - Perform floating-point division on target in-place (e.g., div var1 2.5).

idiv
everywhere
idiv   - Perform integer division on target in-place (e.g., idiv rA 4).

imod
everywhere
imod   - Calculate integer division remainder and store in target (e.g., imod rA 10).

inc
everywhere
inc  [count] - Increment integer target by 1 or by count in-place (e.g., inc rB).

mul
everywhere
mul   - Multiply target by value in-place (e.g., mul rA 2).

sub
everywhere
sub   - Subtract value from target in-place (e.g., sub rA 0x05).



 
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
