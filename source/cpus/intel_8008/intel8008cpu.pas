{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | intel8008cpu.pas                                                         | }
{ | Intel 8008 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library intel8008cpu;
{$mode objfpc}{$H+}
uses
  Classes, SysUtils, core_cpu;
type
  T8008Registers = record                                  { 8008 register set }
    A, B, C, D, E, H, L: byte;
  end;
  T8008Flags = record                                             { 8008 flags }
    C, Z, S, P: boolean;
  end;
  T8008Stack = record                                    { 8008 internal stack }
    Regs: array[0..7] of word;
    Pointer: byte; 
  end;
type
  { 8008 CPU implementation }
  T8008CPU = class(TCPU)
  protected
    FRegs: T8008Registers;
    FFlags: T8008Flags;
    FStack: T8008Stack;
  public
    constructor Create; override;
    procedure Reset; override;
    procedure Step; override;
    function GetRegister(const RegName: string): qword; override;
    procedure SetRegister(const RegName: string; Value: qword); override;
  end;

// T8008CPU
constructor T8008CPU.Create;
begin
  inherited Create;
  FName := 'Intel 8008';
  FFamily := '80xx';
  FArchitecture := arNeumann;
  FBitWidth := 8;
  FAddressWidth := 14;
  FEndianness := enLittle;
  FHasSeparateIOBus := true;
  Reset;
end;

procedure T8008CPU.Reset;
begin
  FillChar(FRegs, SizeOf(FRegs), 0);
  FillWord(FStack.Regs, SizeOf(FStack.Regs), 0);
  FStack.Pointer := 0;
  with FFlags do
  begin
    C := false;
    Z := false;
    S := false;
    P := false;
  end;
  FHalted := false;
  EmitEvent(ceReset);
end;

procedure T8008CPU.Step;
var
  Opcode: byte;
begin
  Opcode := FBus.MemRead(FStack.Regs[FStack.Pointer]);     { Fetch next opcode }
  with FStack do
    Regs[Pointer] := (Regs[Pointer] + 1 ) and $3FFF;
  EmitEvent(ceInstructionBoundary);             { Notify debugger/trace system }
  case Opcode of
    $01: { HLT }
      begin
        FHalted := true;
        EmitEvent(ceHalt);
      end;
    {$I microcode/alu.inc}
    {$I microcode/bit.inc}
    {$I microcode/block.inc}
    {$I microcode/jump.inc}
    {$I microcode/load.inc}
    {$I microcode/misc.inc}
  end;
  Inc(FInstructions);                           { Increment Instruction Counter}
end;

function T8008CPU.GetRegister(const RegName: string): qword;
var
  Idx: integer;
  UName: string;
begin
  Result := 0;
  UName := UpperCase(RegName);
  // get real registers and virtual F register
  case UName of
    'A': exit(FRegs.A);
    'B': exit(FRegs.B);
    'C': exit(FRegs.C);
    'D': exit(FRegs.D);
    'E': exit(FRegs.E);
    'H': exit(FRegs.H);
    'L': exit(FRegs.L);
    'F': begin
           Result := 0;
           if FFlags.C then Result := Result or $01;
           if FFlags.Z then Result := Result or $02;
           if FFlags.S then Result := Result or $04;
           if FFlags.P then Result := Result or $08;
           exit;
         end;
  end;
  // get stack content
  if (Length(UName) = 6) and (Copy(UName, 1, 5) = 'STACK') then
  begin
    Idx := StrToInt(UName[6]);
    if Idx > 7 then Idx := 7;
    Result := FStack.Regs[StrToInt(UName[6])];
    exit;
  end;
end;

procedure T8008CPU.SetRegister(const RegName: string; Value: qword);
var
  Idx: integer;
  UName: string;
begin
  UName := UpperCase(RegName);
  // set registers
  case UName of
    'A':  FRegs.A := Value and $FF;
    'B':  FRegs.B := Value and $FF;
    'C':  FRegs.C := Value and $FF;
    'D':  FRegs.D := Value and $FF;
    'E':  FRegs.E := Value and $FF;
    'H':  FRegs.H := Value and $FF;
    'L':  FRegs.L := Value and $FF;
  end;
  // set flags
  if UName = 'F' then
  begin
    FFlags.C := (Value and $01) <> 0;
    FFlags.Z := (Value and $02) <> 0;
    FFlags.S := (Value and $04) <> 0;
    FFlags.P := (Value and $08) <> 0;
  end;
  // set stack content
  if (Length(UName) = 6) and (Copy(UName, 1, 5) = 'STACK') then
  begin
    Idx := StrToInt(UName[6]);
    if Idx > 7 then Idx := 7;
    FStack.Regs[StrToInt(UName[6])] := Value and $3FFF;
  end;
end;

function CreateCPU: TCPU; {$IFDEF UNIX} cdecl; {$ELSE} stdcall; {$ENDIF} export;
begin
  Result := T8008CPU.Create;
end;

exports CreateCPU {$IFDEF WIN32} name 'createcpu' {$ENDIF};

begin
end.
