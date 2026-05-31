{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | i8080_cpu.pas                                                            | }
{ | Intel 8080 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library i8080_cpu;
{$mode objfpc}{$H+}
uses
  Classes, SysUtils, core_cpu;
type
  // Intruction table
  // - type of operand
  TOperandType = (opNone, opFixed, opI8, opI16);
  // - an operand
  TOperandDef = record
    OpType: TOperandType;
    FixedName: string[6];
  end;
  // - an record
  TInstructionDef = record
    NumOperand: byte;
    Op1: TOperandDef;
    Op2: TOperandDef;
    AffectedFlags: byte;
    Mnemonic: string[12];
  end;
  // Last executed instruction
  TLastInstruction = record
    Address: word;
    Opcode: byte;
    NumOperand: byte;
    Operands: array[1..2] of byte;
  end;
  // Register set
  T8080Registers = record
    case boolean of
      true: (
        BC, DE, HL, AF: word;
        PC, SP: word;
      );
      false: (
        C, B, E, D, L, H, F, A: byte;
        PCL, PCH, SPL, SPH: byte;
      );
  end;
  // 8080 CPU implementation
  T8080CPU = class(TCPU)
  protected
    FRegs: T8080Registers;
  public
    constructor Create; override;
    procedure Reset; override;
    procedure Step; override;
    function  GetCurrentInstruction: string; override;
    function GetRegister(const RegName: string): qword; override;
    procedure SetRegister(const RegName: string; Value: qword); override;
  end;
const
  // 8080 instruction table
  {$I insttable.pas}
  // Bit mask of flags (F: S Z X A X P X C)
  FLAG_C  = $01; // Bit 0: Carry
  FLAG_P  = $04; // Bit 2: Parity
  FLAG_AC = $10; // Bit 4: Auxiliary Carry
  FLAG_Z  = $40; // Bit 6: Zero
  FLAG_S  = $80; // Bit 7: Sign
var
  LogRecord: TLastInstruction;

// Creating a CPU instance 
constructor T8080CPU.Create;
begin
  inherited Create;
  // CPU identity information
  FName := 'Intel 8080';
  FFamily := '80xx';
  // CPU features
  FArchitecture := arNeumann;                           { Type of architecture }
  FBitWidth := 8;                           { Main processor word size in bits }
  FAddressWidth := 16;                             { Address bus width in bits }
  FEndianness := enLittle;                                        { Byte order }
  FMaxMemAddress := $FFFF;                 { The highest (data) memory address }
  FMaxCodeAddress := $FFFF;                  { The highest code memory address }
  FMaxIOPortAddress := $00FF;                   { The highest I/O port address }
  FHasSeparateIOBus := true;         { Indicates separate memory and I/O buses }
  Reset;
end;

// Reset CPU
procedure T8080CPU.Reset;
begin
  FillChar(FRegs, SizeOf(FRegs), 0);
  FRegs.PC := 0;
  FRegs.SP := $FFFF;
  FHalted := false;
  FRunning := false;
  EmitEvent(ceReset);
end;

// Executing an instruction
procedure T8080CPU.Step;
var
  OC: byte;
begin
  if CheckInterrupts then Exit;
  if FHalted then Exit;
  OC := FBus.MemRead(FRegs.PC);                       { Fetch opcode from (PC) }
  with LogRecord do
  begin
    Address := FRegs.PC;
    Opcode := OC;
    NumOperand := 0;
  end;
  Inc(FRegs.PC);                                    { Increment Program Counter}
  EmitEvent(ceInstructionBoundary);             { Notify debugger/trace system }
  case OC of
    $00: { NOP }
      begin
      end;
    $76: { HLT }
      begin
        FHalted := true;
        EmitEvent(ceHalt);
      end;
    {$I microcode.pas}
  end;
  Inc(FInstructions);                           { Increment Instruction Counter}
end;

// Formatted query for the last statement
function T8080CPU.GetCurrentInstruction: string;

function Opcode2Mnemonic(Line: TLastInstruction): string;
begin
  Result := 'UNKNOWN';
  // ide jön a mnemonik mátrix feldolgozása
  // külön van, mert processzoronként eltér
end;

begin
  Result := '';
  with LogRecord do
  begin
    Result := InttoHex(Address, 4) + #9;
    Result := Result + InttoHex(Opcode, 2) + #9;
    if NumOperand > 0
      then Result := Result + InttoHex(Operands[1], 2) + ' '
      else Result := Result + '   ';
    if NumOperand > 1
      then Result := Result + InttoHex(Operands[2], 2) + #9
      else Result := Result + '  ' + #9;
  end;
  Result := Result + Opcode2Mnemonic(LogRecord);
end;

// Querying registers
function T8080CPU.GetRegister(const RegName: string): qword;
begin
  Result := 0;
  case UpperCase(RegName) of
    'A':  Result := FRegs.A;
    'F':  Result := FRegs.F;
    'BC': Result := FRegs.BC;
    'DE': Result := FRegs.DE;
    'HL': Result := FRegs.HL;
    'PC': Result := FRegs.PC;
    'SP': Result := FRegs.SP;
  end;
end;

// Setting registers
procedure T8080CPU.SetRegister(const RegName: string; Value: qword);
begin
  case UpperCase(RegName) of
    'A':  FRegs.A := Value and $FF;
    'F':  FRegs.F := Value and $FF;
    'BC': FRegs.BC := Value and $FFFF;
    'DE': FRegs.DE := Value and $FFFF;
    'HL': FRegs.HL := Value and $FFFF;
    'PC': FRegs.PC := Value and $FFFF;
    'SP': FRegs.SP := Value and $FFFF;
  end;
end;

// Creating a CPU instance 
function CreateCPU: TCPU; {$IFDEF UNIX} cdecl; {$ELSE} stdcall; {$ENDIF} export;
begin
  Result := T8080CPU.Create;
end;

exports CreateCPU {$IFDEF WIN32} name 'createcpu' {$ENDIF};

begin
end.





