{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_8008.pas                                                             | }
{ | Intel 8008 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library cpu_8008;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_cpu;
type
  // Register set
  T8008Registers = record
    A, B, C, D, E, H, L: Byte;
    PC:                  Word;
  end;
  // Flags
  T8008Flags = record
    C, Z, S, P: Boolean;
  end;
  // Internal 7-level hardware stack for PC
  T8008Stack = record
    Regs:    array[0..6] of Word;
    Pointer: Byte; 
  end;
type
  { T8008CPU }
  T8008CPU = class(TCPU)
  private
    RegPointers: array[0..6] of PByte;
  protected
    FRegs:  T8008Registers;
    FFlags: T8008Flags;
    FStack: T8008Stack;
    procedure UpdateFlags(Value16: Word);
    procedure DoInterrupt(AEvent: TCPUEvent); override;
    procedure RunOpCode(AOC: Byte);
  public
    constructor Create; override;
    procedure Reset; override;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    procedure Step; override;
    function GetCurrentInstruction: TLogRec; override;
    function GetCurrentInterrupt: TIntLogRec; override;
    function GetRegister(const RegName: PChar): Word; override;
    procedure SetRegister(const RegName: PChar; Value: Word); override;
    function GetRegisterCount: Byte; override;
    function GetRegisterName(AIndex: Byte): PChar; override;
    function GetRegisterSize(AIndex: Byte): Byte; override;
  end;
const
  RegNames: array[0..7] of char = ('A', 'B', 'C', 'D', 'E', 'H', 'L', 'M');
  PubRegNames: array[0..6] of PChar = ('A', 'B', 'C', 'D', 'E', 'H', 'L');
  PubRegSize:  array[0..6] of Byte  = (2, 2, 2, 2, 2, 2, 2);

{ T8008CPU }

// ---- PROTECTED METHODS ----

// UPDATE FLAGS (CZSP)
procedure T8008CPU.UpdateFlags(Value16: Word);
var
  b:      Byte;
  l:      Boolean;
  Value8: Byte;
begin
  Value8 := Value16 and $FF;
  with FFlags do
  begin
    // Carry:
    C := (Value16 and $0100) <> 0;
    // Zero:
    Z := (Value8 = 0);
    // Sign:
    S := (Value8 and $80) <> 0;
    // Parity:
    l := True;
    for b := 0 to 7 do
      if (Value8 and (1 shl b)) <> 0 then l := not l;
    P := l;
  end;
end;

// INTERRUPT HANDLER
procedure T8008CPU.DoInterrupt(AEvent: TCPUEvent);
begin
  // send event to host
  inherited DoInterrupt(AEvent); 
  if AEvent = ceInterrupt then
  begin
    // detect instruction
    if (FIRQVector and $C7) = $05 then
    begin
      // RST n
      // save return address to stack
      FStack.Regs[FStack.Pointer] := FRegs.PC;
      FStack.Pointer := (FStack.Pointer + 1) mod 7;
      // jump based on vector (RST n = n * 8)
      FRegs.PC := ((FIRQVector shr 3) and $07) * 8;
    end else
    begin
      // other interrupt instructions (e.g. CALL vector)
    end;
  end;
end;end;

// RUN SPECIFIED OPCODE
procedure T8008CPU.RunOpCode(AOC: Byte);
var
  SourceRegIndex, DestRegIndex: Byte;
  w1, w2:                       Word;
  b1, b2:                       Byte;
  bool1:                        Boolean;
begin
  {$I cpu_8008_microcode.pas}
end;

// ---- PUBLIC METHODS ----

// CREATING A CPU INSTANCE 
constructor T8008CPU.Create;
begin
  inherited Create;
  // CPU identity information
  FModname := '8008';
  FDescription := 'Intel 8008 microprocessor';
  // CPU features
  FArchitecture := arNeumann;                            // Type of architecture
  FAddressWidth := 14;                              // Address bus width in bits
  FEndianness := enLittle;                                         // Byte order
  FMaxMemAddress := $3FFF;                  // The highest (data) memory address
  FMaxCodeAddress := $3FFF;                   // The highest code memory address
  FMaxIOPortAddress := $001F;                    // The highest I/O port address
  FHasSeparateIOBus := true;          // Indicates separate memory and I/O buses
  FDefaultClockFreq := 500000; {500 kHz}             // original clock frequency
  // set register pointers
  RegPointers[0] := @FRegs.A;
  RegPointers[1] := @FRegs.B;
  RegPointers[2] := @FRegs.C;
  RegPointers[3] := @FRegs.D;
  RegPointers[4] := @FRegs.E;
  RegPointers[5] := @FRegs.H;
  RegPointers[6] := @FRegs.L;
  Reset;
end;

// RESET CPU
procedure T8008CPU.Reset;
begin
  FRunning := false;
  FHalted := false;
  FIRQPending := false;
  FNMIPending := false;
  FTotalCycles := 0;
  FTotalInstructions := 0;
  FillChar(FRegs, SizeOf(FRegs), 0);
  FillChar(FStack, SizeOf(FStack), 0);
  with FFlags do
  begin
    C := false;
    Z := false;
    S := false;
    P := false;
  end;
  EmitEvent(ceReset);
end;

// LOAD SAVED STATE
function T8008CPU.LoadState(AStream: TStream): Boolean;
begin
  Result := true;
  with AStream do
    try
      ReadBuffer(FEnabled, SizeOf(FEnabled));
      ReadBuffer(FRegs, SizeOf(FRegs));
      ReadBuffer(FFlags, SizeOf(FFlags));
      ReadBuffer(FStack, SizeOf(FStack));
      ReadBuffer(FRunning, SizeOf(FRunning));
      ReadBuffer(FHalted, SizeOf(FHalted));
      ReadBuffer(FIRQPending, SizeOf(FIRQPending));
      ReadBuffer(FNMIPending, SizeOf(FNMIPending));
      ReadBuffer(FTotalCycles, SizeOf(FTotalCycles));
      ReadBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function T8008CPU.SaveState(AStream: TStream): Boolean;
begin
  Result := false;
  with AStream do
  begin
    WriteBuffer(FEnabled, SizeOf(FEnabled));
    WriteBuffer(FRegs, SizeOf(FRegs));
    WriteBuffer(FFlags, SizeOf(FFlags));
    WriteBuffer(FStack, SizeOf(FStack));
    WriteBuffer(FRunning, SizeOf(FRunning));
    WriteBuffer(FHalted, SizeOf(FHalted));
    WriteBuffer(FIRQPending, SizeOf(FIRQPending));
    WriteBuffer(FNMIPending, SizeOf(FNMIPending));
    WriteBuffer(FTotalCycles, SizeOf(FTotalCycles));
    WriteBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    Result := true;
  end;
end;

// EXECUTING AN INSTRUCTION
procedure T8008CPU.Step;
var
  OC: Byte;
begin
  if not FEnabled then Exit;
  if CheckInterrupts then Exit;
  if FHalted then Exit;
  OC := FBus.ReadMemory(FRegs.PC);
  with FLastInstruction do
  begin
    Address := FRegs.PC;
    Cycles := 0;
    Opcode := OC;
    NumOperand := 0;
  end;
  Inc(FRegs.PC);
  FRegs.PC := FRegs.PC and $3FFF;
  RunOpCode(OC);
  FTotalCycles := FTotalCycles + FLastInstruction.Cycles;
  EmitEvent(ceInstructionBoundary);
  Inc(FTotalInstructions);
end;

// QUERY FOR THE LAST STATEMENT
function T8008CPU.GetCurrentInstruction: TLogRec;
var
  RawCode, AsmText: string;
begin
  with FLastInstruction do
  begin
    RawCode := IntToHex(Opcode, 2);
    if NumOperand > 0 then RawCode := RawCode + ' ' + IntToHex(Operands[1], 2);
    if NumOperand > 1 then RawCode := RawCode + ' ' + IntToHex(Operands[2], 2);
    AsmText := Mnemonic;
    if NumOperand > 0 then AsmText := AsmText + ' ' + IntToHex(Operands[1], 2);
    if NumOperand > 1 then AsmText := AsmText + ', ' + IntToHex(Operands[2], 2);
  end;
  with Result do
  begin
    InstCount := FTotalInstructions;
    Address := IntToHex(FLastInstruction.Address, 4);
    Opcode := RawCode;
    Mnemonic := AsmText;
    Cycles := FLastInstruction.Cycles;
    TotalCycles := FTotalCycles;
  end;
end;

// QUERY FOR THE LAST INTERRUPT DATA
function T8008CPU.GetCurrentInterrupt: TIntLogRec;
begin
  with Result do
  begin
    Sender := '';
    Vector := IntToHex(FIRQVector, 2);
    if FIRQPending then Status := 'Pending' else Status := '';
  end;
end;

// QUERYING REGISTERS
function T8008CPU.GetRegister(const RegName: PChar): Word;
begin
  Result := 0;
  case UpperCase(RegName) of
    'A': Result := FRegs.A;
    'B': Result := FRegs.B;
    'C': Result := FRegs.C;
    'D': Result := FRegs.D;
    'E': Result := FRegs.E;
    'H': Result := FRegs.H;
    'L': Result := FRegs.L;
  end;
end;

// SETTING REGISTERS
procedure T8008CPU.SetRegister(const RegName: PChar; Value: Word);
begin
  case UpperCase(RegName) of
    'A': FRegs.A := Value and $FF;
    'B': FRegs.B := Value and $FF;
    'C': FRegs.C := Value and $FF;
    'D': FRegs.D := Value and $FF;
    'E': FRegs.E := Value and $FF;
    'H': FRegs.H := Value and $FF;
    'L': FRegs.L := Value and $FF;
  end;
end;

// QUERYING NUMBER OF THE ALL REGISTERS
function T8008CPU.GetRegisterCount: Byte;
begin
  Result := Length(PubRegNames);
end;

// QUERYING REGISTER NAME
function T8008CPU.GetRegisterName(AIndex: Byte): PChar;
begin
  if AIndex < Length(PubRegNames) then Result := PubRegNames[AIndex] else Result := nil;
end;

// QUERYING REGISTER SIZE IN NIBBLES
function T8008CPU.GetRegisterSize(AIndex: Byte): Byte;
begin
  if AIndex < Length(PubRegSize) then Result := PubRegSize[AIndex] else Result := 0;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateCPU: TCPU; CALLTYPE; export;
begin
  Result := T8008CPU.Create;
end;

procedure DestroyCPU(APort: TCPU); CALLTYPE; export;
begin
  if Assigned(APort) then APort.Free;
end;

function LoadState(APort: TCPU; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort) then Result := APort.LoadState(AStream) else Result := false;
end;

function SaveState(APort: TCPU; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort) then Result := APort.SaveState(AStream) else Result := false;
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreateCPU name 'cpu_create';
exports DestroyCPU name 'cpu_destroy';
exports LoadState name 'cpu_loadstate';
exports SaveState name 'cpu_savestate';

end.
