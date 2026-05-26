{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | intel8080cpu.pas                                                         | }
{ | Intel 8080 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library intel8080cpu;
{$mode objfpc}{$H+}
uses
  Classes, SysUtils, core_cpu;
type
  T8080Registers = record                                  { 8080 register set }
    case boolean of
      true: (
        BC, DE, HL, AF: word;
        IX, IY: word;
        PC, SP: word;
        IR: word
      );
      false: (
        C, B, E, D, L, H, F, A: byte;
        IXL, IXH, IYL, IYH: byte;
        PCL, PCH, SPL, SPH: byte;
        R, I: byte
      );
  end;
type
  { 8080 CPU implementation }
  T8080CPU = class(TCPU)
  protected
    FRegs: T8080Registers;
  public
    constructor Create; override;
    procedure Reset; override;
    procedure Step; override;
    function GetRegister(const RegName: string): qword; override;
    procedure SetRegister(const RegName: string; Value: qword); override;
  end;

// T8080CPU
constructor T8080CPU.Create;
begin
  inherited Create;
  FName := 'Intel 8080';
  FFamily := '80xx';
  FBitWidth := 8;
  FAddressWidth := 16;
  FEndianness := enLittle;
  FHasSeparateIOBus := true;
  Reset;
end;

procedure T8080CPU.Reset;
begin
  FillChar(FRegs, SizeOf(FRegs), 0);
  FRegs.PC := 0;
  FRegs.SP := $FFFF;
  FHalted := false;
  EmitEvent(ceReset);
end;

procedure T8080CPU.Step;
var
  Opcode: byte;
begin
  Opcode := FBus.MemRead(FRegs.PC);                   { Fetch opcode from (PC) }
  Inc(FRegs.PC);                                    { Increment Program Counter}
  EmitEvent(ceInstructionBoundary);             { Notify debugger/trace system }
  case Opcode of
    $00: { NOP }
      begin
      end;
    $76: { HLT }
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

function T8080CPU.GetRegister(const RegName: string): qword;
begin
  Result := 0;
  case UpperCase(RegName) of
    'A':  Result := FRegs.A;
    'F':  Result := FRegs.F;
    'BC': Result := FRegs.BC;
    'DE': Result := FRegs.DE;
    'HL': Result := FRegs.HL;
    'IX': Result := FRegs.IX;
    'IY': Result := FRegs.IY;
    'PC': Result := FRegs.PC;
    'SP': Result := FRegs.SP;
  end;
end;

procedure T8080CPU.SetRegister(const RegName: string; Value: qword);
begin
  case UpperCase(RegName) of
    'A':  FRegs.A := Value and $FF;
    'F':  FRegs.F := Value and $FF;
    'BC': FRegs.BC := Value and $FFFF;
    'DE': FRegs.DE := Value and $FFFF;
    'HL': FRegs.HL := Value and $FFFF;
    'IX': FRegs.IX := Value and $FFFF;
    'IY': FRegs.IY := Value and $FFFF;
    'PC': FRegs.PC := Value and $FFFF;
    'SP': FRegs.SP := Value and $FFFF;
  end;
end;

function CreateCPU: TCPU; {$IFDEF UNIX} cdecl; {$ELSE} stdcall; {$ENDIF} export;
begin
  Result := T8080CPU.Create;
end;

exports CreateCPU {$IFDEF WIN32} name 'createcpu' {$ENDIF};

begin
end.
