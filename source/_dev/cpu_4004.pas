{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_4004.pas                                                             | }
{ | Intel 4004 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library cpu_4004;
{$MODE OBJFPC}{$H+}{$Q-}{$R-}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_cpu, core_bus;
type
  // Register set
  T4004Registers = record
    R:  array[0..15] of Byte; // 4 bit general registers
    A:  Byte;                 // 4 bit Accumulator
    PC: Word;                 // 12 bit Program Counter
  end;
  // Flags
  T4004Flags = record
    C: Boolean;
  end;
  // Internal 7-level hardware stack for PC
  T4004Stack = record
    Regs:    array[0..2] of Word;
    Pointer: Byte; 
  end;
type
  { T4004CPU }
  T4004CPU = class(TCPU)
  private
    RegPointers: array[0..16] of PByte;
  protected
    FBus:   IMCS4Bus;                                  // Connected external bus
    FRegs:  T4004Registers;
    FFlags: T4004Flags;
    FStack: T4004Stack;
    procedure UpdateFlags(Value16: Word);
    procedure RunOpCode(AOC: Byte);
  public
    constructor Create; override;
    procedure Reset; override;
    function ConnectBus(const ABus: IInterface): Boolean; override;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    procedure Step; override;
    function GetCurrentInstruction: TLogRec; override;
    function GetRegister(const RegName: PChar): Word; override;
    procedure SetRegister(const RegName: PChar; Value: Word); override;
    function GetRegisterCount: Byte; override;
    function GetRegisterName(AIndex: Byte): PChar; override;
    function GetRegisterSize(AIndex: Byte): Byte; override;
  end;
const
  PubRegNames: array[0..17] of PChar = ('R0',  'R1',  'R2',  'R3',
                                       'R4',  'R5',  'R6',  'R7',
                                       'R8',  'R9',  'R10', 'R11',
                                       'R12', 'R13', 'R14', 'R15',
                                       'A',   'PC');
  PubRegSize:  array[0..17] of Byte  = (1, 1, 1, 1, 1, 1, 1, 1,
                                        1, 1, 1, 1, 1, 1, 1, 1,
                                        1, 3);

{ T4004CPU }

// ---- PROTECTED METHODS ----

// UPDATE FLAGS (C)
procedure T4004CPU.UpdateFlags(Value16: Word);
var
  Value8: Byte;
begin
  Value8 := Value16 and $FF;
  FFlags.C := (Value16 and $0100) <> 0;
end;

// RUN SPECIFIED OPCODE
procedure T4004CPU.RunOpCode(AOC: Byte);
var
  SourceRegIndex, DestRegIndex: Byte;
  w1, w2:                       Word;
  b1, b2:                       Byte;
  bool1:                        Boolean;
begin
  {$I cpu_4004_microcode.pas}
end;

// ---- PUBLIC METHODS ----

// CREATING A CPU INSTANCE 
constructor T4004CPU.Create;
var
  b: Byte;
begin
  inherited Create;
  // CPU identity information
  FModname := '4004';
  FBusType := btMCS4;
  FDescription := 'Intel 4004 microprocessor';
  // CPU features
  FArchitecture := arHarvard;                            // Type of architecture
  FAddressWidth := 12;                              // Address bus width in bits
  FEndianness := enLittle;                                         // Byte order
  FMaxMemAddress := $FF;                    // The highest (data) memory address
  FMaxCodeAddress := $FFF;                    // The highest code memory address
  FMaxIOPortAddress := $000F;                    // The highest I/O port address
  FHasSeparateIOBus := true;          // Indicates separate memory and I/O buses
  FDefaultClockFreq := 500000; {500 kHz}             // original clock frequency
  // set register pointers
  for b := 0 to 16 do RegPointers[b] := @FRegs.R[b];
  RegPointers[16] := @FRegs.A;
  Reset;
end;

// RESET CPU
procedure T4004CPU.Reset;
var
  b: Byte;
begin
  FRunning := false;
  FHalted := false;
  FTotalCycles := 0;
  FTotalInstructions := 0;
  FillChar(FRegs, SizeOf(FRegs), 0);
  FillChar(FStack, SizeOf(FStack), 0);
  FFlags.C := false;
  EmitEvent(ceReset);
end;

// CONNECT CPU TO EXTERNAL SYSTEM BUS
function T4004CPU.ConnectBus(const ABus: IInterface): Boolean;
begin
  Result := Supports(ABus, IMCS4Bus, FBus);
end;

// LOAD SAVED STATE
function T4004CPU.LoadState(AStream: TStream): Boolean;
begin
  Result := true;
  with AStream do
    try
      ReadBuffer(FEnabled, SizeOf(FEnabled));
      ReadBuffer(FRegs, SizeOf(FRegs));
      ReadBuffer(FFlags, SizeOf(FFlags));
      ReadBuffer(FStack, SizeOf(FStack));
      ReadBuffer(FLastInstruction, SizeOf(FLastInstruction));
      ReadBuffer(FRunning, SizeOf(FRunning));
      ReadBuffer(FHalted, SizeOf(FHalted));
      ReadBuffer(FTotalCycles, SizeOf(FTotalCycles));
      ReadBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function T4004CPU.SaveState(AStream: TStream): Boolean;
begin
  Result := false;
  with AStream do
  begin
    WriteBuffer(FEnabled, SizeOf(FEnabled));
    WriteBuffer(FRegs, SizeOf(FRegs));
    WriteBuffer(FFlags, SizeOf(FFlags));
    WriteBuffer(FStack, SizeOf(FStack));
    WriteBuffer(FLastInstruction, SizeOf(FLastInstruction));
    WriteBuffer(FRunning, SizeOf(FRunning));
    WriteBuffer(FHalted, SizeOf(FHalted));
    WriteBuffer(FTotalCycles, SizeOf(FTotalCycles));
    WriteBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    Result := true;
  end;
end;

// EXECUTING AN INSTRUCTION
procedure T4004CPU.Step;
var
  OC: Byte;
begin
  if not FEnabled then Exit;
  if FHalted then Exit;
  OC := 0;
  OC := FBus.ReadROM(FRegs.PC);
  with FLastInstruction do
  begin
    Address := FRegs.PC;
    Cycles := 0;
    Opcode := OC;
    NumOperand := 0;
  end;
  Inc(FRegs.PC);
  FRegs.PC := FRegs.PC and $FFF;
  RunOpCode(OC);
  FTotalCycles := FTotalCycles + FLastInstruction.Cycles;
  EmitEvent(ceInstructionBoundary);
  Inc(FTotalInstructions);
end;

// QUERY FOR THE LAST STATEMENT
function T4004CPU.GetCurrentInstruction: TLogRec;
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

// QUERYING REGISTERS
function T4004CPU.GetRegister(const RegName: PChar): Word;
var
  b: Byte;
  s: string[3];
begin
  Result := 0;
  s := UpperCase(StrPas(RegName));
  if s = 'A' then Result := FRegs.A else
  begin
    if s[1] = 'R' then
    begin
      delete(s, 1, 1);
      for b := 0 to 15 do
        if StrToInt(s) = b then Result := FRegs.R[b];
    end;
  end;
end;

// SETTING REGISTERS
procedure T4004CPU.SetRegister(const RegName: PChar; Value: Word);
var
  b: Byte;
  s: string[3];
begin
  s := UpperCase(StrPas(RegName));
  if s = 'A' then FRegs.A := Byte(Value) and $0F else
  begin
    if s[1] = 'R' then
    begin
      delete(s, 1, 1);
      for b := 0 to 15 do
        if StrToInt(s) = b then FRegs.R[b] := Byte(Value) and $0F;
    end;
  end;
end;

// QUERYING NUMBER OF THE ALL REGISTERS
function T4004CPU.GetRegisterCount: Byte;
begin
  Result := Length(PubRegNames);
end;

// QUERYING REGISTER NAME
function T4004CPU.GetRegisterName(AIndex: Byte): PChar;
begin
  if AIndex < Length(PubRegNames) then Result := PubRegNames[AIndex] else Result := nil;
end;

// QUERYING REGISTER SIZE IN NIBBLES
function T4004CPU.GetRegisterSize(AIndex: Byte): Byte;
begin
  if AIndex < Length(PubRegSize) then Result := PubRegSize[AIndex] else Result := 0;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateCPU: TCPU; CALLTYPE; export;
begin
  Result := T4004CPU.Create;
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
