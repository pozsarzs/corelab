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
{$MODE OBJFPC}{$H+}
{$MODESWITCH TYPEHELPERS}
interface
uses
  Classes, SysUtils, TypInfo;
type
  // Defines type of architecture
  TArchitecture = (arHarvad,arNeumann);
  TArchitectureHelper = type helper for TArchitecture
    function ToString: string;
    function FromString(const AValue: string): TArchitecture;
  end;
  // Defines CPU Byte order
  TEndianness = (enLittle, enBig);
  TEndiannessHelper = type helper for TEndianness
    function ToString: string;
    function FromString(const AValue: string): TEndianness;
  end;
  // Generic CPU events used by debugger and trace systems
  TCPUEvent = (ceInstructionBoundary, ceInterrupt, ceHalt, ceReset);
  TCPUEventHelper = type helper for TCPUEvent
    function ToString: string;
    function FromString(const AValue: string): TCPUEvent;
  end;
  // Event callback type
  TCPUEventHandler = procedure(Sender: TObject; Event: TCPUEvent) of object;
  // Generic CPU bus interface
  ICPUBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    // read/write a Byte from/to (data) memory
    function  MemRead(Address: uint64): Byte;
    procedure MemWrite(Address: uint64; Value: Byte);
    // read/write a Byte from/to code memory (only Harvard architecture)
    function  CodeRead(Address: uint64): Byte;
    procedure CodeWrite(Address: uint64; Value: Byte);
    // read/write a Byte from/to I/O port
    function  IORead(Port: uint64): Byte;
    procedure IOWrite(Port: uint64; Value: Byte);
  end;
  // Version info
  TSemanticVersion = record
    Major: Integer;
    Minor: Integer;
    Patch: Integer;
  end;
  TSemanticVersionHelper = type helper for TSemanticVersion
    function ToString: string;
    function Compare(Other: TSemanticVersion): Integer;
  end;
  // Abstract base CPU class
  TCPU = class
  protected
    FBus: ICPUBus;                                     // Connected external bus
    FOnEvent: TCPUEventHandler;                                // Event callback
    // CPU identity information
    FModname: PChar;
    FDescription: PChar;                                    // Short description
    FVersion: TSemanticVersion;                                // Module version
    // CPU features
    FArchitecture: TArchitecture;                        // Type of architecture
    FBitWidth: Byte;                         // Main processor word size in bits
    FAddressWidth: Byte;                            // Address bus width in bits
    FEndianness: TEndianness;                                      // Byte order
    FMaxMemAddress: qword;                  // The highest (data) memory address
    FMaxCodeAddress: qword;                   // The highest code memory address
    FMaxIOPortAddress: qword;                    // The highest I/O port address
    FHasSeparateIOBus: Boolean;       // Indicates separate memory and I/O buses
    // Runtime state
    FRunning: Boolean;                                    // CPU execution state
    FHalted: Boolean;                                          // CPU HALT state
    FInterruptEnabled: Boolean;                  // Global interrupt enable flag
    FIRQPending: Boolean;                          // Pending maskable interrupt
    FNMIPending: Boolean;                      // Pending non-maskable interrupt
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
    function  CheckInterrupts: Boolean;
    procedure ConnectBus(const Bus: ICPUBus); virtual;
    // Public properties
    property Modname: PChar read FModname;
    property Description: PChar read FDescription;
    property Architecture: TArchitecture read FArchitecture;
    property BitWidth: Byte read FBitWidth;
    property AddressWidth: Byte read FAddressWidth;
    property Endianness: TEndianness read FEndianness;
    property MaxMemAddress: qword read FMaxMemAddress;
    property MaxCodeAddress: qword read FMaxCodeAddress;
    property MaxIOPortAddress: qword read FMaxIOPortAddress;
    property HasSeparateIOBus: Boolean read FHasSeparateIOBus;
    property Running: Boolean read FRunning;
    property Halted: Boolean read FHalted;
    property InterruptEnabled: Boolean read FInterruptEnabled;
    property Cycles: qword read FCycles;
    property Instructions: qword read FInstructions;
    property OnEvent: TCPUEventHandler read FOnEvent write FOnEvent;
    property Version: TSemanticVersion read FVersion;
  end;

implementation

// HELPER FOR OWN TYPES
function TArchitectureHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TArchitectureHelper.FromString(const AValue: string):  TArchitecture;
begin
  Result :=  TArchitecture(GetEnumValue(TypeInfo( TArchitecture), AValue));
end;

function TEndiannessHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TEndiannessHelper.FromString(const AValue: string): TEndianness;
begin
  Result := TEndianness(GetEnumValue(TypeInfo(TEndianness), AValue));
end;

function TCPUEventHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TCPUEventHelper.FromString(const AValue: string): TCPUEvent;
begin
  Result := TCPUEvent(GetEnumValue(TypeInfo(TCPUEvent), AValue));
end;

function TSemanticVersionHelper.ToString: string;
begin
  Result := Format('%d.%d.%d', [Major, Minor, Patch]);
end;

function TSemanticVersionHelper.Compare(Other: TSemanticVersion): Integer;
begin
  Result := 0;
  if Other.Major > Major then Result := -1 else
    if Other.Major < Major then Result := 1;
  if Result = 0 then
    if Other.Minor > Minor then Result := -1 else
      if Other.Minor < Minor then Result := 1;
  if Result = 0 then
    if Other.Patch > Patch then Result := -1 else
      if Other.Patch < Patch then Result := 1;
end;

// CREATE CPU INSTANCE
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
  with FVersion do
  begin
    Major := 0;
    Minor := 1;
    Patch := 0;
  end; 
end;

// DESTROY TCPU INSTANCE
destructor TCPU.Destroy;
begin
  inherited Destroy;
end;

// SENDS A CPU EVENT TO THE HOST APPLICATION
procedure TCPU.EmitEvent(Event: TCPUEvent);
begin
  if Assigned(FOnEvent) then FOnEvent(Self, Event);
end;

// START CPU EXECUTION
procedure TCPU.Run;
begin
  FRunning := true;
end;

// STOP CPU EXECUTION
procedure TCPU.Stop;
begin
  FRunning := false;
end;

// SIGNAL MASKABLE INTERRUPT
procedure TCPU.IRQ;
begin
  FIRQPending := true;                                   // Set pending IRQ flag
  EmitEvent(ceInterrupt);                             // Notify host application
end;

// SIGNAL NON-MASKABLE INTERRUPT
procedure TCPU.NMI;
begin
  FNMIPending := true;                                   // Set pending NMI flag
  EmitEvent(ceInterrupt);                             // Notify host application
end;

// CHECK PENDING INTERRUPT
function TCPU.CheckInterrupts: Boolean;
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

// INTERRUPT HANDLER
procedure TCPU.DoInterrupt(Event: TCPUEvent);
begin
  EmitEvent(Event); 
end;

// CONNECT CPU TO EXTERNAL SYSTEM BUS
procedure TCPU.ConnectBus(const Bus: ICPUBus);
begin
  FBus := Bus;                                   // Store external bus reference
end;

end.
