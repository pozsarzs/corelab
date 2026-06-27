{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_bus.pas                                                             | }
{ | System bus abstraction module                                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_bus;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, core_cpu, core_memory, core_ioport;
type
  // Abstract base system bus class
  TBus = class(TInterfacedObject, ICPUBus)
  protected
    FCodeMemory: TMemory;                        // Connected code memory module
    FDataMemory: TMemory;                      // Connected (data) memory module
    FIOPorts: TIOPort;                                   // Connected I/O module
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    // Simulator side methods
    function  CodeRead(Address: uint64): byte; virtual;
    function  IORead(Port: uint64): byte; virtual;
    function  MemRead(Address: uint64): byte; virtual;
    procedure CodeWrite(Address: uint64; Value: byte); virtual;
    procedure IOWrite(Port: uint64; Value: byte); virtual;
    procedure MemWrite(Address: uint64; Value: byte); virtual;
    // Host side methods
    procedure AttachCodeMemory(AMemory: TMemory); virtual;
    procedure AttachDataMemory(AMemory: TMemory); virtual;
    procedure AttachIOPorts(APorts: TIOPort); virtual;
    procedure AttachMemory(AMemory: TMemory); virtual;
    procedure Reset; virtual;
    // Public properties
    property CodeMemory: TMemory read FCodeMemory;
    property DataMemory: TMemory read FDataMemory;
    property IOPorts: TIOPort read FIOPorts;
  end;

implementation

// Create TBus instance
constructor TBus.Create;
begin
  inherited Create;
  FCodeMemory := nil;
  FDataMemory := nil;
  FIOPorts := nil;
end;

// Destroy TBus instance
destructor TBus.Destroy;
begin
  inherited Destroy;
end;

// Reading (data) memory based on absolute address
function TBus.MemRead(Address: uint64): byte;
begin
  if Assigned(FDataMemory)
    then Result := FDataMemory.ReadMemory(Address)
    else Result := $FF;
end;

// Writing (data) memory based on absolute address
procedure TBus.MemWrite(Address: uint64; Value: byte);
begin
  if Assigned(FDataMemory) then FDataMemory.WriteMemory(Address, Value);
end;

// Reading code memory based on absolute address
function TBus.CodeRead(Address: uint64): byte;
begin
  if Assigned(FCodeMemory)
    then Result := FCodeMemory.ReadMemory(Address)
    else Result := $FF;
end;

// Writing code memory based on absolute address
procedure TBus.CodeWrite(Address: uint64; Value: byte);
begin
  if Assigned(FCodeMemory) then FCodeMemory.WriteMemory(Address, Value);
end;

// Reading I/O port based on absolute address
function TBus.IORead(Port: uint64): byte;
begin
  if Assigned(FIOPorts)
    then Result := FIOPorts.ReadPort(Port)
    else Result := $FF;
end;

// Writing I/O port based on absolute address
procedure TBus.IOWrite(Port: uint64; Value: byte);
begin
  if Assigned(FIOPorts) then FIOPorts.WritePort(Port, Value);
end;

// Connecting memory (Neumann)
procedure TBus.AttachMemory(AMemory: TMemory);
begin
  FCodeMemory := AMemory;
  FDataMemory := AMemory;
end;

// Connecting data memory (Harvard)
procedure TBus.AttachDataMemory(AMemory: TMemory);
begin
  FDataMemory := AMemory;
end;

// Connecting code memory (Harvard)
procedure TBus.AttachCodeMemory(AMemory: TMemory);
begin
  FCodeMemory := AMemory;
end;

// Connecting I/O ports
procedure TBus.AttachIOPorts(APorts: TIOPort);
begin
  FIOPorts := APorts;
end;

// Reset all hardware components connected to the bus   
procedure TBus.Reset;
begin
  if Assigned(FCodeMemory) then FCodeMemory.Reset;
  if Assigned(FDataMemory) and (FDataMemory <> FCodeMemory)
    then FDataMemory.Reset;
  if Assigned(FIOPorts) then FIOPorts.Reset;
end;

end.
