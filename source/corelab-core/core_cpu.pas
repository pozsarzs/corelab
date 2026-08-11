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
  CMem, Classes, SysUtils, TypInfo;
type
  // Defines type of architecture
  TArchitecture = (arHarvad,arNeumann);
  TArchitectureHelper = type helper for TArchitecture
    function ToString: string;
    function FromString(const Value: string): TArchitecture;
  end;
  // Defines CPU Byte order
  TEndianness = (enLittle, enBig);
  TEndiannessHelper = type helper for TEndianness
    function ToString: string;
    function FromString(const Value: string): TEndianness;
  end;
  // Generic CPU events used by debugger and trace systems
  TCPUEvent = (ceInstructionBoundary, ceInterrupt, ceHalt, ceReset);
  TCPUEventHelper = type helper for TCPUEvent
    function ToString: string;
    function FromString(const Value: string): TCPUEvent;
  end;
  // Event callback type
  TCPUEventHandler = procedure(Sender: TObject; Event: TCPUEvent) of object;
  // Generic CPU bus interface
  ISysBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    // read/write a Byte from/to (data) memory
    function  MemRead(AAddress: UInt64): Byte;
    procedure MemWrite(AAddress: UInt64; AValue: Byte);
    // read/write a Byte from/to code memory (only Harvard architecture)
    function  CodeRead(AAddress: UInt64): Byte;
    procedure CodeWrite(AAddress: UInt64; AValue: Byte);
    // read/write a Byte from/to I/O port
    function  IORead(APort: UInt64): Byte;
    procedure IOWrite(APort: UInt64; AValue: Byte);
  end;
  // Version info
  TSemanticVersion = record
    Major: Integer;
    Minor: Integer;
    Patch: Integer;
  end;
  TSemanticVersionHelper = type helper for TSemanticVersion
    function ToString: string;
    function Compare(AOther: TSemanticVersion): Integer;
  end;
  // Abstract base CPU class
  TCPU = class
  protected
    FBus:              ICPUBus;                        // Connected external bus
    FOnEvent:          TCPUEventHandler;                       // Event callback
    // CPU identity information
    FModname:          PChar;
    FDescription:      PChar;                               // Short description
    FVersion:          TSemanticVersion;                       // Module version
    // CPU features
    FArchitecture:     TArchitecture;                    // Type of architecture
    FBitWidth:         Byte;                 // Main processor word size in bits
    FAddressWidth:     Byte;                        // Address bus width in bits
    FEndianness:       TEndianness;                                // Byte order
    FMaxMemAddress:    QWord;               // The highest (data) memory address
    FMaxCodeAddress:   QWord;                 // The highest code memory address
    FMaxIOPortAddress: QWord;                    // The highest I/O port address
    FHasSeparateIOBus: Boolean;       // Indicates separate memory and I/O buses
    // Runtime state
    FRunning:          Boolean;                           // CPU execution state
    FHalted:           Boolean;                                // CPU HALT state
    FInterruptEnabled: Boolean;                  // Global interrupt enable flag
    FIRQPending:       Boolean;                    // Pending maskable interrupt
    FNMIPending:       Boolean;                // Pending non-maskable interrupt
    // Execution statistics
    FCycles:           QWord;                                    // Total cycles
    FInstructions:     QWord;                     // Total executed instructions
    var FRegPtr:       array of ^QWord;
    procedure EmitEvent(AEvent: TCPUEvent); virtual;
    procedure DoInterrupt(AEvent: TCPUEvent); virtual;
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; override;
    procedure SetRegister(const RegName: PChar; AValue: QWord); virtual; abstract;
    function  GetRegister(const RegName: PChar): QWord; virtual; abstract;
    procedure Reset; virtual; abstract;
    procedure Run; virtual;
    procedure Step; virtual; abstract;
    procedure Stop; virtual;
    function  GetCurrentInstruction: PChar; virtual; abstract;
    procedure IRQ; virtual;
    procedure NMI; virtual;
    function  CheckInterrupts: Boolean;
    procedure ConnectBus(const Bus: ICPUBus); virtual;
    // SrvBus side methods
//    function LoadState(AStream: TStream): Boolean; virtual;
//    function SaveState(AStream: TStream): Boolean; virtual;
    // Public properties
    property Modname: PChar read FModname;
    property Description: PChar read FDescription;
    property Architecture: TArchitecture read FArchitecture;
    property BitWidth: Byte read FBitWidth;
    property AddressWidth: Byte read FAddressWidth;
    property Endianness: TEndianness read FEndianness;
    property MaxMemAddress: QWord read FMaxMemAddress;
    property MaxCodeAddress: QWord read FMaxCodeAddress;
    property MaxIOPortAddress: QWord read FMaxIOPortAddress;
    property HasSeparateIOBus: Boolean read FHasSeparateIOBus;
    property Running: Boolean read FRunning;
    property Halted: Boolean read FHalted;
    property InterruptEnabled: Boolean read FInterruptEnabled;
    property Cycles: QWord read FCycles;
    property Instructions: QWord read FInstructions;
    property OnEvent: TCPUEventHandler read FOnEvent write FOnEvent;
    property Version: TSemanticVersion read FVersion;
  end;

implementation

// HELPER FOR OWN TYPES
function TArchitectureHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TArchitectureHelper.FromString(const Value: string):  TArchitecture;
begin
  Result :=  TArchitecture(GetEnumValue(TypeInfo(TArchitecture), Value));
end;

function TEndiannessHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TEndiannessHelper.FromString(const Value: string): TEndianness;
begin
  Result := TEndianness(GetEnumValue(TypeInfo(TEndianness), Value));
end;

function TCPUEventHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TCPUEventHelper.FromString(const Value: string): TCPUEvent;
begin
  Result := TCPUEvent(GetEnumValue(TypeInfo(TCPUEvent), Value));
end;

function TSemanticVersionHelper.ToString: string;
begin
  Result := Format('%d.%d.%d', [Major, Minor, Patch]);
end;

function TSemanticVersionHelper.Compare(AOther: TSemanticVersion): Integer;
begin
  Result := 0;
  if AOther.Major > Major then Result := -1 else
    if AOther.Major < Major then Result := 1;
  if Result = 0 then
    if AOther.Minor > Minor then Result := -1 else
      if AOther.Minor < Minor then Result := 1;
  if Result = 0 then
    if AOther.Patch > Patch then Result := -1 else
      if AOther.Patch < Patch then Result := 1;
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
procedure TCPU.EmitEvent(AEvent: TCPUEvent);
begin
  if Assigned(FOnEvent) then FOnEvent(Self, AEvent);
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
procedure TCPU.DoInterrupt(AEvent: TCPUEvent);
begin
  EmitEvent(AEvent); 
end;

// CONNECT CPU TO EXTERNAL SYSTEM BUS
procedure TCPU.ConnectBus(const Bus: ICPUBus);
begin
  FBus := Bus;                                   // Store external bus reference
end;

end.
