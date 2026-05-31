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
  // Last executed instruction
  TLastInstruction = record
    Address: word;
    Opcode: byte;
    NumOperand: byte;
    Operands: array[1..2] of byte;
    Mnemonic: string[12];
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
    procedure UpdateFlags(Value16: word; OldValue, ValueToAdd: byte);
  public
    constructor Create; override;
    procedure Reset; override;
    procedure Step; override;
    function GetCurrentInstruction: string; override;
    function GetRegister(const RegName: string): qword; override;
    procedure SetRegister(const RegName: string; Value: qword); override;
  end;
var
  LogRecord: TLastInstruction;                          { Raw running log data }
  RegPointers: array[0..7] of PByte;          { Pointers to register variables }
const
  RegNames: array[0..7] of string = ('B', 'C', 'D', 'E', 'H', 'L', 'M', 'A');

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
  // Set register pointers
  RegPointers[0] := @FRegs.B;
  RegPointers[1] := @FRegs.C;
  RegPointers[2] := @FRegs.D;
  RegPointers[3] := @FRegs.E;
  RegPointers[4] := @FRegs.H;
  RegPointers[5] := @FRegs.L;
  RegPointers[6] := nil;
  RegPointers[7] := @FRegs.A;
  // Reset CPU
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
  SourceRegIndex, DestRegIndex: byte;
  w1, w2: word;
  b1, b2: byte;
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
  {$I microcode.pas}
  Inc(FInstructions);                           { Increment Instruction Counter}
end;

// Formatted query for the last statement
function T8080CPU.GetCurrentInstruction: string;
begin
  Result := '';
  with LogRecord do
  begin
    // Address
    Result := InttoHex(Address, 4) + #9;
    // Opcode
    Result := Result + InttoHex(Opcode, 2) + #9;
    // 1st operand
    if NumOperand > 0
      then Result := Result + InttoHex(Operands[1], 2) + ' '
      else Result := Result + '   ';
    // 2st operand
    if NumOperand > 1
      then Result := Result + InttoHex(Operands[2], 2) + #9
      else Result := Result + '  ' + #9;
    // Mnemonic
    Result := Result + Mnemonic;
    // 1st operand
    if NumOperand > 0
      then Result := Result + #9 + InttoHex(Operands[1], 2);
    if NumOperand > 1
      then Result := Result + ', ' + InttoHex(Operands[2], 2);
  end;
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

// Update register F (SZ0A 0P1C)
procedure T8080CPU.UpdateFlags(Value16: word; OldValue, ValueToAdd: byte);
var
  b: byte;
  l: boolean;
  Value8: byte;
begin
  Value8 := Value16 and $FF;
  // 7. Sign:            Sxxx xxxx
  if (Value8 and $80) <> 0
    then FRegs.F := FRegs.F or $80
    else FRegs.F := FRegs.F and $7F;
  // 6. Zero:            xZxx xxxx
  if Value8 = 0
    then FRegs.F := FRegs.F or $40
    else FRegs.F := FRegs.F and $BF;
  // 5. Constant:        xx0x xxxx
  // 4. Auxiliary Carry: xxxA xxxx
  if ((Value8 xor OldValue xor ValueToAdd) and $10) <> 0
    then FRegs.F := FRegs.F or $10
    else FRegs.F := FRegs.F and $EF;
  // 3. Constant:        xxxx 0xxx
  // 2. Parity:          xxxx xPxx
  l := true;
  for b := 0 to 7 do
    if (Value8 and (1 shl b)) <> 0 then l := not l;
  if l 
    then FRegs.F := FRegs.F or $04
    else FRegs.F := FRegs.F and $FB;
  // 1. Constant:        xxxx xx1x
  // 0. Carry:           xxxx xxxC
  if (Value16 and $0100) <> 0
    then FRegs.F := FRegs.F or $01
    else FRegs.F := FRegs.F and $FE;
  // Constants:          xx0x 0x1x
  FRegs.F := (FRegs.F and $D5) or $02;
end;

exports CreateCPU {$IFDEF WIN32} name 'createcpu' {$ENDIF};

begin
end.
