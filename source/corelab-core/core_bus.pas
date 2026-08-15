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
  CMem, Classes, SysUtils, sysbus, svcapi, ctlapi, core_cpu, core_ioport,
  core_memory;
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
  // Bus and API class
  TBus = class(TInterfacedObject, ISysBus, ISvcAPI, ICtlAPI)
  private
    FDevices: array of TBusDevice;                       // Attached device list
    FNextID: Integer;              // Internal counter for distribute InstanceID
  public
    constructor Create; virtual;
    destructor Destroy; override;
    // Administration
    function AttachCPU(ACPU: TCPU): Integer; virtual;
    function AttachMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer; virtual;
    function AttachIOPorts(APorts: TIOPort; ABaseAddress: DWord; AAddressRange: DWord): Integer; virtual;
    function DetachCPU(InstanceID: Integer): Boolean; virtual;
    function DetachMemory(InstanceID: Integer): Boolean; virtual;
    function DetachIOPorts(InstanceID: Integer): Boolean; virtual;
    // Used via the ISysBus by TCPU class
    function ReadMemory(AAddress: DWord): QWord; virtual;
    procedure WriteMemory(AAddress: DWord; AValue: QWord); virtual;
    function ReadPort(APort: Word): Byte; virtual;
    procedure WritePort(APort: Word; AValue: Byte); virtual;
    // Used via the ISvcAPI by TSupervisor class
    procedure Reset; virtual;
    function LoadState(AStream: TStream): Boolean; virtual;
    function SaveState(AStream: TStream): Boolean; virtual;
    procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord); virtual;
    procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord); virtual;
    procedure CreatePanel; virtual;
    procedure FreePanel; virtual;
    procedure ShowPanel; virtual;
    procedure HidePanel; virtual;
    procedure RenamePanel(ACaption: PChar); virtual;
    function ResizePanel(AWidth, AHeight: Integer): Boolean; virtual;
    function MovePanel(ALeft, ATop: Integer): Boolean; virtual;
    // Used via the ICtlAPI by TSupervisor class
    procedure SetRegister(const RegName: PChar; AValue: QWord); virtual;
    function  GetRegister(const RegName: PChar): QWord; virtual;
    procedure Run; virtual;
    procedure Step; virtual;
    procedure Stop; virtual;
    function  GetCurrentInstruction: PChar; virtual;
    procedure IRQ; virtual;
    procedure NMI; virtual;
    function  CheckInterrupts: Boolean; virtual;
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

// -- Administration --

function TBus.AttachCPU(ACPU: TCPU): Integer;
begin
  Result := 0;
end;

function TBus.AttachMemory(AMemory: TMemory; ABaseAddress: DWord; AAddressRange: DWord): Integer;
begin
  Result := 0;
end;

function TBus.AttachIOPorts(APorts: TIOPort; ABaseAddress: DWord; AAddressRange: DWord): Integer;
begin
  Result := 0;
end;

function TBus.DetachCPU(InstanceID: Integer): Boolean;
begin
  Result := false;
end;

function TBus.DetachIOPorts(InstanceID: Integer): Boolean;
begin
  Result := false;
end;

function TBus.DetachMemory(InstanceID: Integer): Boolean;
begin
  Result := false;
end;

// -- ISysBus --

function TBus.ReadMemory(AAddress: DWord): QWord;
begin
  Result := 0;
end;

procedure TBus.WriteMemory(AAddress: DWord; AValue: QWord);
begin
end;

function TBus.ReadPort(APort: Word): Byte;
begin
end;

procedure TBus.WritePort(APort: Word; AValue: Byte);
begin
end;

// -- ISvcAPI --

procedure TBus.Reset;
begin
end;

function TBus.LoadState(AStream: TStream): Boolean;
begin
  Result := false;
end;

function TBus.SaveState(AStream: TStream): Boolean;
begin
  Result := false;
end;

procedure TBus.LoadFromStream(AStream: TStream; AAddress, ACount: DWord);
begin
end;

procedure TBus.SaveToStream(AStream: TStream; AAddress, ACount: DWord);
begin
end;

procedure TBus.CreatePanel;
begin
end;

procedure TBus.FreePanel;
begin
end;

procedure TBus.ShowPanel;
begin
end;

procedure TBus.HidePanel;
begin
end;

procedure TBus.RenamePanel(ACaption: PChar);
begin
end;

function TBus.ResizePanel(AWidth, AHeight: Integer): Boolean;
begin
  Result := false;
end;

function TBus.MovePanel(ALeft, ATop: Integer): Boolean;
begin
  Result := false;
end;

// -- ICtlAPI --

procedure TBus.SetRegister(const RegName: PChar; AValue: QWord);
begin
end;

function TBus.GetRegister(const RegName: PChar): QWord;
begin
  Result := 0;
end;

procedure TBus.Run;
begin
end;

procedure TBus.Step;
begin
end;

procedure TBus.Stop;
begin
end;

function TBus.GetCurrentInstruction: PChar;
begin
  Result := nil;
end;

procedure TBus.IRQ;
begin
end;


procedure TBus.NMI;
begin
end;

function TBus.CheckInterrupts: Boolean;
begin
  Result := false;
end;

end.
