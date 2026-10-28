{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_8085.pas                                                             | }
{ | Intel 8085 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library cpu_8085;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_cpu, cpu_8080;
type
  { T8085CPU }
  T8085CPU = class(T8080CPU)
  private
  protected
    FIRQMask: Byte;                                // interrupt mask (0000 0765)
    procedure DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0); override;
    procedure RunOpCode(AOC: Byte); override;
  public
    constructor Create; override;
    function CheckInterrupts: Boolean; override;
    procedure Reset; override;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    procedure Step; override;
  end;
const
  imINTR   = 0;
  imRST5_5 = 1;
  imRST6_5 = 2;
  imRST7_5 = 3;
  imNMI    = 255;

{ T8085CPU }
                                           
// ---- PROTECTED METHODS ----

// INTERRUPT HANDLER
procedure T8085CPU.DoInterrupt(AEvent: TCPUEvent; AMode: Byte = 0);
begin
  // send event to host
  inherited DoInterrupt(AEvent, AMode);                  // T8080CPU.DoInterrupt
  if AEvent = ceInterrupt then
  begin
    FInterruptEnabled := false; 
    // NMI (TRAP)
    if AMode = imNMI then
    begin
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, (FRegs.PC shr 8) and $FF);
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, FRegs.PC and $FF);
      FRegs.PC := $0024;
      Exit;
    end;
    // RST 5.5, 6.5, 7.5
    if AMode in [imRST5_5, imRST6_5, imRST7_5] then
    begin
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, (FRegs.PC shr 8) and $FF);
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, FRegs.PC and $FF);
      case AMode of
        imRST5_5: FRegs.PC := $002C;
        imRST6_5: FRegs.PC := $0034;
        imRST7_5: FRegs.PC := $003C;
      end;
      Exit;
    end;
    // INTR
    if AMode = imINTR then RunOpCode(FIRQVector[AMode]);
  end;
end;

// RUN SPECIFIED OPCODE
procedure T8085CPU.RunOpCode(AOC: Byte);
var
  b1: Byte;
begin
  case AOC of
    {$I cpu_8085_microcode.pas}
  else
    inherited RunOpCode(AOC);
    with FLastInstruction do
      case AOC of
        // Jcc
        $C2, $CA, $D2, $DA, $E2, $EA, $F2, $FA: if FRegs.PC = (Address + 3) then
                                                  Cycles := 7
                                                else
                                                  Cycles := 10;
        // Ccc
        $C4, $CC, $D4, $DC, $E4, $EC, $F4, $FC: case Cycles of
                                                  11: Cycles := 9;
                                                  17: Cycles := 18;
                                                else
                                                  Cycles := 12;
                                                end;
        // Rcc
        $C0, $C8, $D0, $D8, $E0, $E8, $F0, $F8: case Cycles of
                                                  5: Cycles := 6;
                                                  11: Cycles := 12;
                                                else
                                                  Cycles := 12;
                                                end;
        // CALL a16
        $CD:                                    Cycles := 18;
        // INR r
        $04, $0C, $14, $1C, $24, $2C, $3C:      Cycles := 4;
        // DCR r
        $05, $0D, $15, $1D, $25, $2D, $3D:      Cycles := 4;
        // INX r
        $03, $13, $23, $33:                     Cycles := 6;
        // DCX r
        $0B, $1B, $2B, $3B:                     Cycles := 6;
      end;
  end;  
end;

// ---- PUBLIC METHODS ----

// CREATING A CPU INSTANCE 
constructor T8085CPU.Create;
begin
  inherited Create;
  // CPU identity information
  FModname := '8085';
  FDescription := 'Intel 8085 microprocessor';
  // CPU features
  FArchitecture := arNeumann;                            // type of architecture
  FAddressWidth := 16;                              // address bus width in bits
  FEndianness := enLittle;                                         // byte order
  FMaxMemAddress := $FFFF;                  // the highest (data) memory address
  FMaxCodeAddress := $FFFF;                   // the highest code memory address
  FMaxIOPortAddress := $00FF;                    // the highest I/O port address
  FHasSeparateIOBus := true;          // indicates separate memory and I/O buses
  FDefaultClockFreq := 3000000; {3 MHz}              // original clock frequency
  // Reset CPU
  Reset;
end;

// RESET CPU
procedure T8085CPU.Reset;
var
  b: Byte;
begin
  // initial execution state
  FRunning := false;
  FHalted := false;
  FInterruptEnabled := false;
  // interrupts
  for b := 0 to Length(FIRQPending) - 1 do FIRQPending[b] := false;
  FIRQMask := $07;
  FNMIPending := false;
  // clear counters
  FTotalCycles := 0;
  FTotalInstructions := 0;
  // others
  FillChar(FRegs, SizeOf(FRegs), 0);
  FRegs.PC := 0;
  FRegs.SP := $FFFF;
  EmitEvent(ceReset);
end;

// LOAD SAVED STATE
function T8085CPU.LoadState(AStream: TStream): Boolean;
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
      ReadBuffer(FIRQMask, SizeOf(FIRQMask));
      ReadBuffer(FIRQPending, SizeOf(FIRQPending));
      ReadBuffer(FNMIPending, SizeOf(FNMIPending));
      ReadBuffer(FTotalCycles, SizeOf(FTotalCycles));
      ReadBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    except
      Result := false;
    end;
end;
  
// SAVE ACTUAL STATE
function T8085CPU.SaveState(AStream: TStream): Boolean;
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
    WriteBuffer(FIRQMask, SizeOf(FIRQMask));
    WriteBuffer(FIRQPending, SizeOf(FIRQPending));
    WriteBuffer(FNMIPending, SizeOf(FNMIPending));
    WriteBuffer(FTotalCycles, SizeOf(FTotalCycles));
    WriteBuffer(FTotalInstructions, SizeOf(FTotalInstructions));
    Result := true;
  end;
end;

// EXECUTING AN INSTRUCTION
procedure T8085CPU.Step;
var
  OC: Byte;
begin
  if not FEnabled then Exit;
  if CheckInterrupts then Exit;
  if FHalted then Exit;
  OC := FBus.ReadMemory(FRegs.PC);                     // fetch opcode from (PC)
  with FLastInstruction do
  begin
    Address := FRegs.PC;
    Cycles := 0;
    Opcode := OC;
    NumOperand := 0;
  end;
  Inc(FRegs.PC);                                    // increment Program Counter
  RunOpcode(OC);  
  FTotalCycles := FTotalCycles + FLastInstruction.Cycles;
  EmitEvent(ceInstructionBoundary);              // notify debugger/trace system
  Inc(FTotalInstructions);                      // increment Instruction Counter
end;

// CHECK PENDING INTERRUPT
function T8085CPU.CheckInterrupts: Boolean;
var
  b: Byte;
begin
  Result := false;
  if FNMIPending then
  begin
    FNMIPending := false;                                          // Accept NMI
    FHalted := false;                                             // Wake-up CPU
    DoInterrupt(ceInterrupt, imNMI);              // Call the instance's handler
    Result := true;
    Exit;
  end;
  // priority: RST 7.5 -> RST 6.5 -> RST 5.5 -> INTR
  for b := 3 downto 0 do 
  begin
    if FIRQPending[b] and FInterruptEnabled then
    begin
      // check mask
      if b > 0 then
      begin
        if ((FIRQMask shr (b - 1)) and $01) = 1 then
        Continue;
      end;
      FIRQPending[b] := false;                                     // accept IRQ
      FHalted := false;                                           // wake-up CPU
      DoInterrupt(ceInterrupt, b);                                  // b = AMode
      Result := true;
      Exit;                                 // One check - one interrupt calling
    end;
  end;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateCPU: TCPU; CALLTYPE; export;
begin
  Result := T8085CPU.Create;
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
