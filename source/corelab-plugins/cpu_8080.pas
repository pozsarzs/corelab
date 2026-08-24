{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_8080.pas                                                             | }
{ | Intel 8080 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library cpu_8080;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_cpu;
type
  // Last executed instruction
  TLastInstruction = record
    Address:    Word;
    Opcode:     Byte;
    NumOperand: Byte;
    Operands:   array[1..2] of Word;
    Mnemonic:   string[12];
  end;
  // Register set
  T8080Registers = record
    case boolean of
      true: (
        BC, DE, HL, AF: Word;
        PC, SP:         Word;
      );
      false: (
        C, B, E, D, L, H, F, A: Byte;
        PCL, PCH, SPL, SPH:     Byte;
      );
  end;
  // 8080 CPU implementation
  T8080CPU = class(TCPU)
  private
    LogRecord:   TLastInstruction;                       // Raw running log data
    RegPointers: array[0..7] of PByte;         // Pointers to register variables
  protected
    FRegs: T8080Registers;
    procedure UpdateFlags(Value16: word; OldValue, ValueToAdd: byte);
  public
    constructor Create; override;
    // Used via the ISvcAPI by TSupervisor class
    procedure Reset; override;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    // Used via the ICtlAPI by TSupervisor class
    procedure Step; override;
    function GetCurrentInstruction: TLogRec; override;
    function GetRegister(const RegName: PChar): Word; override;
    procedure SetRegister(const RegName: PChar; Value: Word); override;
    function GetRegisterCount: Byte; override;
    function GetRegisterName(AIndex: Byte): PChar; override;
    function GetRegisterSize(AIndex: Byte): Byte; override;
  end;
const
  RegNames:    array[0..7] of char = ('B', 'C', 'D', 'E', 'H', 'L', 'M', 'A');
  PubRegNames: array[0..9] of PChar = ('A', 'B', 'C', 'D', 'E', 'H', 'L',
                                        'F', 'PC','SP');
  PubRegSize: array[0..9] of Byte = (2, 2, 2, 2, 2, 2, 2, 2, 4, 4);
                                           
// ---- PROTECTED METHODS ----

// UPDATE REGISTER F (SZ0A 0P1C)
procedure T8080CPU.UpdateFlags(Value16: Word; OldValue, ValueToAdd: Byte);
var
  b:      Byte;
  l:      Boolean;
  Value8: Byte;
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

// ---- PUBLIC METHODS ----

// CREATING A CPU INSTANCE 
constructor T8080CPU.Create;
begin
  inherited Create;
  // CPU identity information
  FModname := '8080';
  FDescription := 'Intel 8080 microprocessor';
  // CPU features
  FArchitecture := arNeumann;                            // Type of architecture
  FAddressWidth := 16;                              // Address bus width in bits
  FEndianness := enLittle;                                         // Byte order
  FMaxMemAddress := $FFFF;                  // The highest (data) memory address
  FMaxCodeAddress := $FFFF;                   // The highest code memory address
  FMaxIOPortAddress := $00FF;                    // The highest I/O port address
  FHasSeparateIOBus := true;          // Indicates separate memory and I/O buses
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

// -- ISvcAPI --

// RESET CPU
procedure T8080CPU.Reset;
begin
  // Initial execution state
  FRunning := false;
  FHalted := false;
  FInterruptEnabled := false;
  // No pending interrupts
  FIRQPending := false;
  FNMIPending := false;
  // Clear counters
  FCycles := 0;
  FInstructions := 0;
  // Others
  FillChar(FRegs, SizeOf(FRegs), 0);
  FRegs.PC := 0;
  FRegs.SP := $FFFF;
  EmitEvent(ceReset);
end;

// LOAD SAVED STATE
function T8080CPU.LoadState(AStream: TStream): Boolean;
begin
  Result := true;
  with AStream do
    try
      // common fields
      ReadBuffer(FEnabled, SizeOf(FEnabled));
      // common fields related to CPU
      ReadBuffer(FRegs, SizeOf(FRegs));
      ReadBuffer(FRunning, SizeOf(FRunning));
      ReadBuffer(FHalted, SizeOf(FHalted));
      ReadBuffer(FInterruptEnabled, SizeOf(FInterruptEnabled));
      ReadBuffer(FIRQPending, SizeOf(FIRQPending));
      ReadBuffer(FNMIPending, SizeOf(FNMIPending));
      ReadBuffer(FCycles, SizeOf(FCycles));
      ReadBuffer(FInstructions, SizeOf(FInstructions));
    except
      Result := false;
    end;
end;
  
// SAVE ACTUAL STATE
function T8080CPU.SaveState(AStream: TStream): Boolean;
begin
  Result := false;
  if FInstanceID > -1 then
    with AStream do
    begin
      // common fields
      WriteBuffer(FEnabled, SizeOf(FEnabled));
      // common fields related to CPU
      WriteBuffer(FRegs, SizeOf(FRegs));
      WriteBuffer(FRunning, SizeOf(FRunning));
      WriteBuffer(FHalted, SizeOf(FHalted));
      WriteBuffer(FInterruptEnabled, SizeOf(FInterruptEnabled));
      WriteBuffer(FIRQPending, SizeOf(FIRQPending));
      WriteBuffer(FNMIPending, SizeOf(FNMIPending));
      WriteBuffer(FCycles, SizeOf(FCycles));
      WriteBuffer(FInstructions, SizeOf(FInstructions));
      Result := true;
    end;
end;

// -- ICtlAPI --

// EXECUTING AN INSTRUCTION
procedure T8080CPU.Step;
var
  OC:                           Byte;
  SourceRegIndex, DestRegIndex: Byte;
  dw1:                          Cardinal;
  w1, w2:                       Word;
  b1, b2:                       Byte;
begin
  if not FEnabled then Exit;
  if CheckInterrupts then Exit;
  if FHalted then Exit;
  OC := FBus.ReadMemory(FRegs.PC);                     // Fetch opcode from (PC)
  with LogRecord do
  begin
    Address := FRegs.PC;
    Opcode := OC;
    NumOperand := 0;
  end;
  Inc(FRegs.PC);                                    // Increment Program Counter
  EmitEvent(ceInstructionBoundary);              // Notify debugger/trace system
  {$I cpu_8080_microcode.pas}
  Inc(FInstructions);                           // Increment Instruction Counter
end;

// QUERY FOR THE LAST STATEMENT
function T8080CPU.GetCurrentInstruction: TLogRec;
var
  RawCode, AsmText: string;
begin
  with LogRecord do
  begin
    RawCode := IntToHex(Opcode, 2);
    if NumOperand > 0 then RawCode := RawCode + IntToHex(Operands[1], 2);
    if NumOperand > 1 then RawCode := RawCode + IntToHex(Operands[2], 2);
    AsmText := Mnemonic;
    if NumOperand > 0 then AsmText := AsmText + ' ' + IntToHex(Operands[1], 2);
    if NumOperand > 1 then AsmText := AsmText + ', ' + IntToHex(Operands[2], 2);
  end;
  with Result do
  begin
    InstCount := FInstructions;
    Address := IntToHex(LogRecord.Address, 4);
    Opcode := RawCode;
    Mnemonic := AsmText;
  end;
end;

// QUERYING REGISTERS
function T8080CPU.GetRegister(const RegName: PChar): Word;
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
    'F':  Result := FRegs.F;
    'PC': Result := FRegs.PC;
    'SP': Result := FRegs.SP;
  end;
end;

// SETTING REGISTERS
procedure T8080CPU.SetRegister(const RegName: PChar; Value: Word);
begin
  case UpperCase(RegName) of
    'A': FRegs.A := Value and $FF;
    'B': FRegs.B := Value and $FF;
    'C': FRegs.C := Value and $FF;
    'D': FRegs.D := Value and $FF;
    'E': FRegs.E := Value and $FF;
    'H': FRegs.H := Value and $FF;
    'L': FRegs.L := Value and $FF;
    'F': FRegs.F := Value and $FF;
    'PC': FRegs.PC := Value and $FFFF;
    'SP': FRegs.SP := Value and $FFFF;
  end;
end;

// QUERYING NUMBER OF THE ALL REGISTERS
function T8080CPU.GetRegisterCount: Byte;
begin
  Result := Length(PubRegNames);
end;

// QUERYING REGISTER NAME
function T8080CPU.GetRegisterName(AIndex: Byte): PChar;
begin
  if AIndex < Length(PubRegNames)
    then Result := PubRegNames[AIndex]
    else Result := nil;
end;

// QUERYING REGISTER SIZE IN NIBBLES
function T8080CPU.GetRegisterSize(AIndex: Byte): Byte;
begin
  if AIndex < Length(PubRegSize)
    then Result := PubRegSize[AIndex]
    else Result := 0;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateCPU: TCPU; CALLTYPE; export;
begin
  Result := T8080CPU.Create;
end;

procedure DestroyCPU(APort: TCPU); CALLTYPE; export;
begin
  if Assigned(APort) then APort.Free;
end;

function LoadState(APort: TCPU; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.LoadState(AStream)
    else Result := false;
end;

function SaveState(APort: TCPU; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.SaveState(AStream)
    else Result := false;
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreateCPU name 'cpu_create';
exports DestroyCPU name 'cpu_destroy';
exports LoadState name 'cpu_loadstate';
exports SaveState name 'cpu_savestate';

end.
