{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80.pas                                                              | }
{ | Zilog Z80 CPU implementation module                                      | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library cpu_z80;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_cpu;
type
  // Register set
  TZ80Registers = record
    I: Byte;
    R: Byte;
    case boolean of
      true: (
        BC, DE, HL, AF:     Word;
        BC_, DE_, HL_, AF_: Word;
        PC, SP:             Word;
        IX, IY:             Word;
      );
      false: (
        C, B, E, D, L, H, F, A:         Byte;
        C_, B_, E_, D_, L_, H_, F_, A_: Byte;
        PCL, PCH, SPL, SPH:             Byte;
        IXL, IXH, IYL, IYH:             Byte;
      );
    end;
  { TZ80CPU }
  TZ80CPU = class(TCPU)
  private
  protected
    RegPointers: array[0..7] of PByte;         // pointers to register variables
    FRegs: TZ80Registers;
    FInterruptMode: Byte;                                      // interrupt mode
    FInterruptEnabled2:  Boolean;           // global interrupt enable flag IFF2
    procedure UpdateFlags(Value16: Word; OldValue, ValueToAdd: Byte; N: Boolean = False; P: Boolean = False);
    procedure DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0); override;
    procedure RunOpCode(AOC: Byte; APrefix: Byte = 0);
  public
    constructor Create; override;
    function CheckInterrupts: Boolean; override;
    procedure Reset; override;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    procedure NMI; override;
    procedure Step; override;
    function GetCurrentInstruction: TLogRec; override;
    function GetCurrentInterrupt(AMode: Byte = 0): TIntLogRec; override;
    function GetRegister(const RegName: PChar): Word; override;
    procedure SetRegister(const RegName: PChar; Value: Word); override;
    function GetRegisterCount: Byte; override;
    function GetRegisterName(AIndex: Byte): PChar; override;
    function GetRegisterSize(AIndex: Byte): Byte; override;
  end;
const
  // registers
  RegNames:    array[0..7] of string[4] = ('B', 'C', 'D', 'E', 'H', 'L', '(HL)', 'A');
  PubRegNames: array[0..13] of PChar = ('A', 'B', 'C', 'D', 'E', 'H', 'L',
                                        'F', 'PC', 'SP', 'IX', 'IY', 'I', 'R');
  PubRegSize: array[0..13] of Byte = (2, 2, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 2, 2);
  // opcode prefixes
  prNone =    0;
  prCB =      1;
  prDD =      2;
  prED =      3;
  prFD =      4;
  prDDCB =    5;
  prFDCB =    6;
  // interrupt modes
  imINT_IM0 = 0;
  imINT_IM1 = 1;
  imINT_IM2 = 2;
  imNMI =     255;

{ TZ80CPU }
                                           
// ---- PROTECTED METHODS ----

// UPDATE REGISTER F (SZ0A 0P1C)
procedure TZ80CPU.UpdateFlags(Value16: Word; OldValue, ValueToAdd: Byte; N: Boolean = False; P: Boolean = False);
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
  // 4. Half-Carry:      xxxH xxxx
  if ((Value8 xor OldValue xor ValueToAdd) and $10) <> 0
    then FRegs.F := FRegs.F or $10
    else FRegs.F := FRegs.F and $EF;
  // 2. Parity/Overflow: xxxx xPxx
  if P then
  begin
    // parity (at logical operations)
    l := true;
    for b := 0 to 7 do
      if (Value8 and (1 shl b)) <> 0 then l := not l;
    if l 
      then FRegs.F := FRegs.F or $04
      else FRegs.F := FRegs.F and $FB;
  end else
  begin
    // overflow (at aritmetical operations)
    if ((OldValue xor ValueToAdd xor $80) and
       (OldValue xor Value8) and $80) <> 0
      then FRegs.F := FRegs.F or $04
      else FRegs.F := FRegs.F and $FB;
  end;
  // 1. Add/Subtract:    xxxx xxNx
  if N
    then FRegs.F := FRegs.F or $02
    else FRegs.F := FRegs.F and $FD;
  // 0. Carry:           xxxx xxxC
  if (Value16 and $0100) <> 0
    then FRegs.F := FRegs.F or $01
    else FRegs.F := FRegs.F and $FE;
  // 5, 3.:              xxYx Xxxx
  FRegs.F := (FRegs.F and $D7) or (Value8 and $28);
end;

// INTERRUPT HANDLER
procedure TZ80CPU.DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0);
var
  IntVectorAddress: Word;
begin
  // send event to host
  inherited DoInterrupt(AEvent, AMode); 
  if AEvent = ceInterrupt then
  begin
    // If is not NMI then disable more interrupt requests
    if AMode <> imNMI then
    begin
      FInterruptEnabled := false; 
      FInterruptEnabled2 := false; 
    end;
    // save return address to stack
    Dec(FRegs.SP);
    FBus.WriteMemory(FRegs.SP, (FRegs.PC shr 8) and $FF); // PCH
    Dec(FRegs.SP);
    FBus.WriteMemory(FRegs.SP, FRegs.PC and $FF);         // PCL
    // NMI
    if AMode = imNMI then
    begin
      FRegs.PC := $0066;
      FTotalCycles := FTotalCycles + 11;
      Exit;
    end;
    // maskable INTs
    case FInterruptMode of
      0: begin
           // IM 0
           if (FIRQVector[AMode] >= $C0) and ((FIRQVector[AMode] and $07) = $07) then
           begin
             FRegs.PC := ((FIRQVector[AMode] shr 3) and $07) * 8;
             FTotalCycles := FTotalCycles + 13;
           end;
         end;
      1: begin
           // IM 1: fixed jump to $0038
           FRegs.PC := $0038;
           FTotalCycles := FTotalCycles + 13;
         end;
      2: begin
           // IM 2: address based on the I register and the fetched vector
           IntVectorAddress := (FRegs.I shl 8) or FIRQVector[AMode];
           FRegs.PC := FBus.ReadMemory(IntVectorAddress) or
                       (FBus.ReadMemory(IntVectorAddress + 1) shl 8);
           FTotalCycles := FTotalCycles + 19;
         end;
    end;
  end;
end;

// RUN SPECIFIED OPCODE
procedure TZ80CPU.RunOpCode(AOC: Byte; APrefix: Byte = 0);
var
  SourceRegIndex, DestRegIndex: Byte;
  dw1:                          Cardinal;
  w1, w2:                       Word;
  b1, b2:                       Byte;
begin
  case APrefix of
    prNone: begin {$I cpu_z80_microcode.pas} end;
    prCB:   begin {$I cpu_z80_microcode_cbxx.pas} end;
    prDD:   begin {$I cpu_z80_microcode_ddxx.pas} end;
    prED:   begin {$I cpu_z80_microcode_edxx.pas} end;
    prFD:   begin {$I cpu_z80_microcode_fdxx.pas} end;
    prDDCB: begin {$I cpu_z80_microcode_ddcbxx.pas} end;
    prFDCB: begin {$I cpu_z80_microcode_fdcbxx.pas} end;
  end;
end;
  
// ---- PUBLIC METHODS ----

// CREATING A CPU INSTANCE 
constructor TZ80CPU.Create;
begin
  inherited Create;
  // CPU identity information
  FModname := 'Z80';
  FDescription := 'Zilog Z80 microprocessor';
  // CPU features
  FArchitecture := arNeumann;                            // type of architecture
  FAddressWidth := 16;                              // address bus width in bits
  FEndianness := enLittle;                                         // byte order
  FMaxMemAddress := $FFFF;                  // the highest (data) memory address
  FMaxCodeAddress := $FFFF;                   // the highest code memory address
  FMaxIOPortAddress := $00FF;                    // the highest I/O port address
  FHasSeparateIOBus := true;          // indicates separate memory and I/O buses
  FDefaultClockFreq := 2500000; {2.5 MHz}            // original clock frequency
  // set register pointers
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

// CHECK PENDING INTERRUPT
function TZ80CPU.CheckInterrupts: Boolean;
var
  b: Byte;
begin
  Result := false;
  // Check NMI
  if FNMIPending then
  begin
    FNMIPending := false;                                          // Accept NMI
    FHalted := false;                                             // Wake-up CPU
    DoInterrupt(ceInterrupt, imNMI);              // Call the instance's handler
    Result := true;
    Exit;
  end;
  // Check maskable INTs
  for b := 0 to Length(FIRQPending) - 1 do
  begin
    if FIRQPending[b] and FInterruptEnabled then
    begin
      FIRQPending[b] := false;                                     // Accept IRQ
      FHalted := false;                                           // Wake-up CPU
      DoInterrupt(ceInterrupt, b);                                  // b = AMode
      Result := true;
      Exit;                                 // One check - one interrupt calling
    end;
  end;
end;

// RESET CPU
procedure TZ80CPU.Reset;
var
  b: Byte;
begin
  // Initial execution state
  FRunning := false;
  FHalted := false;
  FInterruptEnabled := false;
  // interrupts
  for b := 0 to Length(FIRQPending) - 1 do FIRQPending[b] := false;
  FNMIPending := false;
  // Clear counters
  FTotalCycles := 0;
  FTotalInstructions := 0;
  // Others
  FillChar(FRegs, SizeOf(FRegs), 0);
  FRegs.PC := 0;
  FRegs.SP := $FFFF;
  EmitEvent(ceReset);
end;

// LOAD SAVED STATE
function TZ80CPU.LoadState(AStream: TStream): Boolean;
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
      ReadBuffer(FTotalCycles, SizeOf(FTotalCycles));
      ReadBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    except
      Result := false;
    end;
end;
  
// SAVE ACTUAL STATE
function TZ80CPU.SaveState(AStream: TStream): Boolean;
begin
  Result := false;
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
    WriteBuffer(FTotalCycles, SizeOf(FTotalCycles));
    WriteBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    Result := true;
  end;
end;

// SIGNAL NON-MASKABLE INTERRUPT
procedure TZ80CPU.NMI;
begin
  if not FEnabled then Exit;
  FNMIPending := true;                                   // set pending NMI flag
  FInterruptEnabled2 := FInterruptEnabled;     // save maskable interrupt status
  FInterruptEnabled := false;                      // disable maskable interrupt
  EmitEvent(ceInterrupt);                             // notify host application
end;

// EXECUTING AN INSTRUCTION
procedure TZ80CPU.Step;
var
  OC: Byte;
begin
  if not FEnabled then Exit;
  if CheckInterrupts then Exit;
  if FHalted then Exit;
  OC := FBus.ReadMemory(FRegs.PC);                     // Fetch opcode from (PC)
  with FLastInstruction do
  begin
    Address := FRegs.PC;
    Cycles := 0;
    Opcode := OC;
    NumOperand := 0;
  end;
  Inc(FRegs.PC);                                    // increment program counter
  RunOpcode(OC);
  FTotalCycles := FTotalCycles + FLastInstruction.Cycles;
  EmitEvent(ceInstructionBoundary);              // notify debugger/trace system
  Inc(FTotalInstructions);                      // increment instruction counter
end;

// QUERY FOR THE LAST STATEMENT
function TZ80CPU.GetCurrentInstruction: TLogRec;
var
  RawCode, AsmText: string;
begin
  with FLastInstruction do
  begin
    RawCode := IntToHex(Opcode, 2);
    if NumOperand > 0 then RawCode := RawCode + ' ' + IntToHex(Operands[1], 2);
    if NumOperand > 1 then RawCode := RawCode + ' ' + IntToHex(Operands[2], 2);
    AsmText := Mnemonic;
    if Pos('%', Mnemonic) > 0 then
    begin
      if NumOperand = 1 then AsmText := Format(Mnemonic, [Operands[1]]) else
        if NumOperand = 2
          then AsmText := Format(Mnemonic, [Operands[1], Operands[2]])
          else AsmText := Mnemonic;
    end else
    begin
      AsmText := Mnemonic;
      if NumOperand > 0 then AsmText := AsmText + ' ' + IntToHex(Operands[1], 2);
      if NumOperand > 1 then AsmText := AsmText + ', ' + IntToHex(Operands[2], 2);
    end;
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
function TZ80CPU.GetCurrentInterrupt(AMode: Byte = 0): TIntLogRec;
begin
  with Result do
  begin
    Sender := '';
    Vector := IntToHex(FIRQVector[AMode], 2);
    if FInterruptEnabled then Flag := 'EI' else Flag := 'DI';
    if FIRQPending[AMode] then Status := 'Pending' else Status := '';
  end;
end;

// QUERYING REGISTERS
function TZ80CPU.GetRegister(const RegName: PChar): Word;
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
    'IX': Result := FRegs.IX;
    'IY': Result := FRegs.IY;
    'I': Result := FRegs.I;
    'R': Result := FRegs.R;
  end;
end;

// SETTING REGISTERS
procedure TZ80CPU.SetRegister(const RegName: PChar; Value: Word);
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
    'IX': FRegs.IX := Value and $FFFF;
    'IY': FRegs.IX := Value and $FFFF;
    'I': FRegs.I := Value and $FF;
    'R': FRegs.R := Value and $FF;
  end;
end;

// QUERYING NUMBER OF THE ALL REGISTERS
function TZ80CPU.GetRegisterCount: Byte;
begin
  Result := Length(PubRegNames);
end;

// QUERYING REGISTER NAME
function TZ80CPU.GetRegisterName(AIndex: Byte): PChar;
begin
  if AIndex < Length(PubRegNames)
    then Result := PubRegNames[AIndex]
    else Result := nil;
end;

// QUERYING REGISTER SIZE IN NIBBLES
function TZ80CPU.GetRegisterSize(AIndex: Byte): Byte;
begin
  if AIndex < Length(PubRegSize)
    then Result := PubRegSize[AIndex]
    else Result := 0;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateCPU: TCPU; CALLTYPE; export;
begin
  Result := TZ80CPU.Create;
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
