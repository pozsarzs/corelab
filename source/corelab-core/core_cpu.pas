{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_cpu.pas                                                             | }
{ | CPU abstraction module                                                   | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_cpu;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils;
type
  // Defines type of architecture
  TArchitecture = (arHarvad,arNeumann);
  // Defines CPU byte order
  TEndianness = (enLittle, enBig);
  // Generic CPU events used by debugger and trace systems
  TCPUEvent = (ceInstructionBoundary, ceInterrupt, ceHalt, ceReset);
  // Event callback type
  TCPUEventHandler = procedure(Sender: TObject; Event: TCPUEvent) of object;
  // Generic CPU bus interface
  ICPUBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    // read/write a byte from/to (data) memory
    function  MemRead(Address: uint64): byte;
    procedure MemWrite(Address: uint64; Value: byte);
    // read/write a byte from/to code memory (only Harvard architecture)
    function  CodeRead(Address: uint64): byte;
    procedure CodeWrite(Address: uint64; Value: byte);
    // read/write a byte from/to I/O port
    function  IORead(Port: uint64): byte;
    procedure IOWrite(Port: uint64; Value: byte);
  end;
  // Abstract base CPU class
  TCPU = class
  protected
    FBus: ICPUBus;                                     // Connected external bus
    FOnEvent: TCPUEventHandler;                                // Event callback
    // CPU identity information
    FModname: PChar;
    FDescription: PChar;                                    // Short description
    // CPU features
    FArchitecture: TArchitecture;                        // Type of architecture
    FBitWidth: byte;                         // Main processor word size in bits
    FAddressWidth: byte;                            // Address bus width in bits
    FEndianness: TEndianness;                                      // Byte order
    FMaxMemAddress: qword;                  // The highest (data) memory address
    FMaxCodeAddress: qword;                   // The highest code memory address
    FMaxIOPortAddress: qword;                    // The highest I/O port address
    FHasSeparateIOBus: boolean;       // Indicates separate memory and I/O buses
    // Runtime state
    FRunning: boolean;                                    // CPU execution state
    FHalted: boolean;                                          // CPU HALT state
    FInterruptEnabled: boolean;                  // Global interrupt enable flag
    FIRQPending: boolean;                          // Pending maskable interrupt
    FNMIPending: boolean;                      // Pending non-maskable interrupt
    // Execution statistics
    FCycles: qword;                                              // Total cycles
    FInstructions: qword;                         // Total executed instructions
    var FRegPtr: array of ^qword;
    procedure EmitEvent(Event: TCPUEvent); virtual;
    procedure DoInterrupt(Event: TCPUEvent); virtual;
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure SetRegister(const RegName: PChar; Value: qword); virtual; abstract;
    function  GetRegister(const RegName: PChar): qword; virtual; abstract;
    procedure Reset; virtual; abstract;
    procedure Run; virtual;
    procedure Step; virtual; abstract;
    procedure Stop; virtual;
    function  GetCurrentInstruction: PChar; virtual; abstract;
    procedure IRQ; virtual;
    procedure NMI; virtual;
    function  CheckInterrupts: boolean;
    procedure ConnectBus(const Bus: ICPUBus); virtual;
    // Public properties
    property Modname: PChar read FModname;
    property Description: PChar read FDescription;
    property Architecture: TArchitecture read FArchitecture;
    property BitWidth: byte read FBitWidth;
    property AddressWidth: byte read FAddressWidth;
    property Endianness: TEndianness read FEndianness;
    property MaxMemAddress: qword read FMaxMemAddress;
    property MaxCodeAddress: qword read FMaxCodeAddress;
    property MaxIOPortAddress: qword read FMaxIOPortAddress;
    property HasSeparateIOBus: boolean read FHasSeparateIOBus;
    property Running: boolean read FRunning;
    property Halted: boolean read FHalted;
    property InterruptEnabled: boolean read FInterruptEnabled;
    property Cycles: qword read FCycles;
    property Instructions: qword read FInstructions;
    property OnEvent: TCPUEventHandler read FOnEvent write FOnEvent;
  end;

implementation

// Create CPU instance
constructor TCPU.Create;
begin
  inherited Create;
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
end;

// Destroy TCPU instance
destructor TCPU.Destroy;
begin
  inherited Destroy;
end;

// Sends a CPU event to the host application
procedure TCPU.EmitEvent(Event: TCPUEvent);
begin
  if Assigned(FOnEvent) then FOnEvent(Self, Event);
end;

// Start CPU execution
procedure TCPU.Run;
begin
  FRunning := true;
end;

// Stop CPU execution
procedure TCPU.Stop;
begin
  FRunning := false;
end;

// Signal maskable interrupt
procedure TCPU.IRQ;
begin
  FIRQPending := true;                                   // Set pending IRQ flag
  EmitEvent(ceInterrupt);                             // Notify host application
end;

// Signal non-maskable interrupt
procedure TCPU.NMI;
begin
  FNMIPending := true;                                   // Set pending NMI flag
  EmitEvent(ceInterrupt);                             // Notify host application
end;

// Check pending interrupt
function TCPU.CheckInterrupts: boolean;
begin
  Result := false;
  if FNMIPending then
  begin
    FNMIPending := false;                                          // Accept NMI
    FHalted := false;                                             // Wake-up CPU
    DoInterrupt(ceInterrupt);                     // Call the instance's handler
    Result := true;
    Exit;
  end;
  if FIRQPending and FInterruptEnabled then
  begin
    FIRQPending := false;                                          // Accept IRQ
    FHalted := false;                                             // Wake-up CPU
    DoInterrupt(ceInterrupt);                     // Call the instance's handler
    Result := true;
  end;
end;

// Interrupt handler
procedure TCPU.DoInterrupt(Event: TCPUEvent);
begin
  EmitEvent(Event); 
end;

// Connect CPU to external system bus
procedure TCPU.ConnectBus(const Bus: ICPUBus);
begin
  FBus := Bus;                                   // Store external bus reference
end;

end.
