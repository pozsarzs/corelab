{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_bus.pas                                                             | }
{ | System and service bus module                                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_bus;
{$MODE OBJFPC}{$H+}
interface
uses
  CMem, Classes, SysUtils, core_cpu, core_memory, core_ioport;
type
  // Device description record
  TBusDevice = record
    InstanceID: Integer;
    BaseAddress: DWord;
    AddressRange: DWord;
    CPUDevice: TCPU;
    MemoryDevice: TMemory;
    IODevice: TIOPort;
  end;
  // SysBus (TCPU -> device classes)
  ISysBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    // 16 B - 16M Bytes memory size, 4 - 64 bits datawidth
    function MemRead(AAddress: DWord): QWord;
    procedure MemWrite(AAddress: DWord; AValue: QWord);
    function CodeRead(AAddress: DWord): QWord;
    procedure CodeWrite(AAddress: DWord; AValue: QWord);
    // 1 - 65535 Bytes port size, 8 bits datawidth
    function IORead(APort: DWord): Byte;
    procedure IOWrite(APort: DWord; AValue: Byte);
  end;
  // SrvBus (TSupervisor -> TCPU and device classes)
  ISrvBus = interface
    ['{B6F7E1C4-5B9C-5D7B-9062-9E48C2D92345}']
    function AttachCPU(ACPU: TCPU): Integer;
    function AttachCodeMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer;
    function AttachDataMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer;
    function AttachIOPorts(APorts: TIOPort; ABaseAddress: DWord; AAddressRange: DWord): Integer;
    function DetachCPU(InstanceID: Integer): Boolean;
    function DetachCodeMemory(InstanceID: Integer): Boolean;
    function DetachDataMemory(InstanceID: Integer): Boolean;
    function DetachIOPorts(InstanceID: Integer): Boolean;
    procedure Reset;
  end;
  TBus = class(TInterfacedObject, ISysBus, ISrvBus)
  private
    FDevices: array of TBusDevice;                       // Attached device list
    FNextID: Integer;              // Internal counter for distribute InstanceID
  public
    constructor Create; virtual;
    destructor Destroy; override;
    // ISysBus implementation
    function MemRead(AAddress: DWord): QWord; virtual;
    procedure MemWrite(AAddress: DWord; AValue: QWord); virtual;
    function CodeRead(AAddress: DWord): QWord; virtual;
    procedure CodeWrite(AAddress: DWord; AValue: QWord); virtual;
    function IORead(APort: DWord): Byte; virtual;
    procedure IOWrite(APort: DWord; AValue: Byte); virtual;
    // ISrvBus implementation
    function AttachCPU(ACPU: TCPU): Integer; virtual;
    function AttachCodeMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer; virtual;
    function AttachDataMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer; virtual;
    function AttachIOPorts(APorts: TIOPort; ABaseAddress: DWord; AAddressRange: DWord): Integer; virtual;
    function DetachCPU(InstanceID: Integer): Boolean; virtual;
    function DetachCodeMemory(InstanceID: Integer): Boolean; virtual;
    function DetachDataMemory(InstanceID: Integer): Boolean; virtual;
    function DetachIOPorts(InstanceID: Integer): Boolean; virtual;
    procedure Reset; virtual;
  end;

implementation

// ---- PUBLIC METHODS ----

// CREATE TBUS INSTANCE
constructor TBus.Create;
begin
  inherited Create;
end;

// DESTROY TBUS INSTANCE
destructor TBus.Destroy;
begin
  inherited Destroy;
end;

// ---- ISYSBUS IMPLEMENTATION ----

function TBus.MemRead(AAddress: DWord): QWord;
begin
end;

procedure TBus.MemWrite(AAddress: DWord; AValue: QWord);
begin
end;

function TBus.CodeRead(AAddress: DWord): QWord;
begin
end;

procedure TBus.CodeWrite(AAddress: DWord; AValue: QWord);
begin
end;

function TBus.IORead(APort: DWord): Byte;
begin
end;

procedure TBus.IOWrite(APort: DWord; AValue: Byte);
begin
end;

// ---- ISRVBUS IMPLEMENTATION ----

function TBus.AttachCPU(ACPU: TCPU): Integer;
begin
end;

function TBus.AttachCodeMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer;
begin
end;

function TBus.AttachDataMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer;
begin
end;

function TBus.AttachIOPorts(APorts: TIOPort; ABaseAddress: DWord; AAddressRange: DWord): Integer;
begin
end;

function TBus.DetachCPU(InstanceID: Integer): Boolean;
begin
end;

function TBus.DetachCodeMemory(InstanceID: Integer): Boolean;
begin
end;

function TBus.DetachDataMemory(InstanceID: Integer): Boolean;
begin
end;

function TBus.DetachIOPorts(InstanceID: Integer): Boolean;
begin
end;

procedure TBus.Reset;
begin
end;

end.
