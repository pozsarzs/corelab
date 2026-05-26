{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_cpu.pas                                                             | }
{ | Core CPU abstraction module                                              | }
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
    function MemRead(Address: uint64): byte;       { Read one byte from memory }
    procedure MemWrite(Address: uint64; Value: byte); { Write one byte to mem. }
    function IORead(Port: uint64): byte;         { Read one byte from I/O port }
    procedure IOWrite(Port: uint64; Value: byte); { Write one byte to I/O port }
  end;
  // Abstract base CPU class
  TCPU = class
  protected
    FBus: ICPUBus;                                    { Connected external bus }
    FOnEvent: TCPUEventHandler;                               { Event callback }
    // CPU identity information
    FName: string;
    FFamily: string;
    FArchitecture: TArchitecture;                       { Type of architecture }
    FBitWidth: byte;                        { Main processor word size in bits }
    FAddressWidth: byte;                           { Address bus width in bits }
    FEndianness: TEndianness;                                     { Byte order }
    FHasSeparateIOBus: boolean;      { Indicates separate memory and I/O buses }
    // Runtime state
    FRunning: boolean;                                   { CPU execution state }
    FHalted: boolean;                                         { CPU HALT state }
    FIRQPending: boolean;                         { Pending maskable interrupt }
    FNMIPending: boolean;                     { Pending non-maskable interrupt }
    // Execution statistics
    FCycles: qword;                                    { Total executed cycles }
    FInstructions: qword;                        { Total executed instructions }
  protected
    procedure EmitEvent(Event: TCPUEvent); virtual;
  public
    constructor Create; virtual;
    function GetRegister(const RegName: string): qword; virtual; abstract;
    procedure Reset; virtual; abstract;
    procedure Step; virtual; abstract;
    procedure SetRegister(const RegName: string; Value: qword); virtual; abstract;
    procedure Run; virtual;
    procedure Stop; virtual;
    procedure IRQ; virtual;
    procedure NMI; virtual;
    procedure ConnectBus(const Bus: ICPUBus); virtual;

    // Public properties
    property Name: string
      read FName;

    property Family: string
      read FFamily;

    property BitWidth: byte
      read FBitWidth;

    property AddressWidth: byte
      read FAddressWidth;

    property Endianness: TEndianness
      read FEndianness;

    property HasSeparateIOBus: boolean
      read FHasSeparateIOBus;

    property Running: boolean
      read FRunning;

    property Halted: boolean
      read FHalted;

    property Cycles: qword
      read FCycles;

    property Instructions: qword
      read FInstructions;

    property OnEvent: TCPUEventHandler
      read FOnEvent
      write FOnEvent;
  end;

implementation

// Create CPU instance
constructor TCPU.Create;
begin
  inherited Create;
  // Initial execution state
  FRunning := false;
  FHalted := false;
  // No pending interrupts
  FIRQPending := false;
  FNMIPending := false;
  // Clear counters
  FCycles := 0;
  FInstructions := 0;
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
  FIRQPending := true;                                  { Set pending IRQ flag }
  EmitEvent(ceInterrupt);                            { Notify host application }
end;

// Signal non-maskable interrupt
procedure TCPU.NMI;
begin
  FNMIPending := true;                                 { Set pending NMI  flag }
  EmitEvent(ceInterrupt);                            { Notify host application }
end;

// Connect CPU to external system bus
procedure TCPU.ConnectBus(const Bus: ICPUBus);
begin
  FBus := Bus;                                  { Store external bus reference }
end;

end.
