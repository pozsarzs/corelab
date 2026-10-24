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
    procedure DoInterrupt(AEvent: TCPUEvent); override;
  public
    constructor Create; override;
    procedure Reset; override;
    function LoadState(AStream: TStream): Boolean; override;
    function SaveState(AStream: TStream): Boolean; override;
    procedure Step; override;
  end;

{ T8085CPU }
                                           
// ---- PROTECTED METHODS ----

// INTERRUPT HANDLER
procedure T8085CPU.DoInterrupt(AEvent: TCPUEvent);
begin
  // send event to host
  inherited DoInterrupt(AEvent); 
  if AEvent = ceInterrupt then
  begin
    // prohibit further interruption
    FInterruptEnabled := false; 
    if (FIRQVector >= $C0) and ((FIRQVector and $07) = $07) then
    begin
      // RST interrupt instructions
      // save return address to stack
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, (FRegs.PC shr 8) and $FF); // PCH
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, FRegs.PC and $FF);         // PCL
      // jump based on vector (RST n = n * 8)
      FRegs.PC := ((FIRQVector shr 3) and $07) * 8;
    end
    else
    begin
      // other interrupt instructions (e.g. CALL vector)
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
begin
  // Initial execution state
  FRunning := false;
  FHalted := false;
  FInterruptEnabled := false;
  // No pending interrupts
  FIRQPending := false;
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
  with FLastInstruction do
  begin
    Address := FRegs.PC;
    Cycles := 0;
    Opcode := OC;
    NumOperand := 0;
  end;
  Inc(FRegs.PC);                                    // Increment Program Counter
  {$I cpu_8080_microcode.pas}
  {$I cpu_8085_microcode.pas}
  FTotalCycles := FTotalCycles + FLastInstruction.Cycles;
  EmitEvent(ceInstructionBoundary);              // Notify debugger/trace system
  Inc(FTotalInstructions);                           // Increment Instruction Counter
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
