{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_sysbus.pas                                                          | }
{ | System bus abstraction module                                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_sysbus;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, core_cpu, core_memory, core_ioport;
type
  // System bus base class
  TSysBus = class(TInterfacedObject, ICPUBus)
  protected
    FCodeMemory: TMemory;                        // Connected code memory module
    FDataMemory: TMemory;                      // Connected (data) memory module
    FIOPorts:    TIOPort;                                // Connected I/O module
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    // Simulator side methods
    function CodeRead(AAddress: UInt64): Byte; virtual;
    function IORead(APort: UInt64): Byte; virtual;
    function MemRead(AAddress: UInt64): Byte; virtual;
    procedure CodeWrite(AAddress: UInt64; AValue: Byte); virtual;
    procedure IOWrite(APort: UInt64; AValue: Byte); virtual;
    procedure MemWrite(AAddress: UInt64; AValue: Byte); virtual;
    // Host side methods
    procedure AttachCodeMemory(AMemory: TMemory); virtual;
    procedure AttachDataMemory(AMemory: TMemory); virtual;
    procedure AttachIOPorts(APorts: TIOPort); virtual;
    procedure AttachMemory(AMemory: TMemory); virtual;
    procedure Reset; virtual;
    // Properties
    property CodeMemory: TMemory read FCodeMemory;
    property DataMemory: TMemory read FDataMemory;
    property IOPorts: TIOPort read FIOPorts;
  end;

implementation

// CREATE TSYSBUS INSTANCE
constructor TSysBus.Create;
begin
  inherited Create;
  FCodeMemory := Nil;
  FDataMemory := Nil;
  FIOPorts := Nil;
end;

// DESTROY TSYSBUS INSTANCE
destructor TSysBus.Destroy;
begin
  inherited Destroy;
end;

// READING (DATA) MEMORY BASED ON ABSOLUTE ADDRESS
function TSysBus.MemRead(AAddress: UInt64): Byte;
begin
  if Assigned(FDataMemory)
    then Result := FDataMemory.ReadMemory(AAddress)
    else Result := $FF;
end;

// WRITING (DATA) MEMORY BASED ON ABSOLUTE ADDRESS
procedure TSysBus.MemWrite(AAddress: UInt64; AValue: Byte);
begin
  if Assigned(FDataMemory) then FDataMemory.WriteMemory(AAddress, AValue);
end;

// READING CODE MEMORY BASED ON ABSOLUTE ADDRESS
function TSysBus.CodeRead(AAddress: UInt64): Byte;
begin
  if Assigned(FCodeMemory)
    then Result := FCodeMemory.ReadMemory(AAddress)
    else Result := $FF;
end;

// WRITING CODE MEMORY BASED ON ABSOLUTE ADDRESS
procedure TSysBus.CodeWrite(AAddress: UInt64; AValue: Byte);
begin
  if Assigned(FCodeMemory) then FCodeMemory.WriteMemory(AAddress, AValue);
end;

// READING I/O PORT BASED ON ABSOLUTE ADDRESS
function TSysBus.IORead(APort: UInt64): Byte;
begin
  if Assigned(FIOPorts)
    then Result := FIOPorts.ReadPort(APort)
    else Result := $FF;
end;

// WRITING I/O PORT BASED ON ABSOLUTE ADDRESS
procedure TSysBus.IOWrite(APort: UInt64; AValue: Byte);
begin
  if Assigned(FIOPorts) then FIOPorts.WritePort(APort, AValue);
end;

// CONNECTING MEMORY (NEUMANN)
procedure TSysBus.AttachMemory(AMemory: TMemory);
begin
  FCodeMemory := AMemory;
  FDataMemory := AMemory;
end;

// CONNECTING DATA MEMORY (HARVARD)
procedure TSysBus.AttachDataMemory(AMemory: TMemory);
begin
  FDataMemory := AMemory;
end;

// CONNECTING CODE MEMORY (HARVARD)
procedure TSysBus.AttachCodeMemory(AMemory: TMemory);
begin
  FCodeMemory := AMemory;
end;

// CONNECTING I/O PORTS
procedure TSysBus.AttachIOPorts(APorts: TIOPort);
begin
  FIOPorts := APorts;
end;

// RESET ALL HARDWARE COMPONENTS CONNECTED TO THE BUS   
procedure TSysBus.Reset;
begin
  if Assigned(FCodeMemory) then FCodeMemory.Reset;
  if Assigned(FDataMemory) and (FDataMemory <> FCodeMemory)
    then FDataMemory.Reset;
  if Assigned(FIOPorts) then FIOPorts.Reset;
end;

end.
