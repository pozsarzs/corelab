{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | memory_4001rom.pas                                                       | }
{ | Intel 4001 ROM and I/O chip implementation                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library memory_4001rom;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_memory, core_bus, core_ioport;
type
  { T4001ROM }
  T4001ROM = class(TMemory, IMCS4Bus)
  private
    FChipID:        Byte;
    FSelected:      Boolean;
    FTargetAddress: Word;
    FTargetPort:    TIOPort;
  protected
    procedure SetFAddressRangeSize(AAddressRangeSize: DWord); override;
    procedure SetFBaseAddress(ABaseAddress: DWord); override;
    procedure SetFMemoryMode(AMemoryMode: TMemoryMode); override;
    function QueryInterface(constref iid: TGuid; out obj): LongInt; CALLTYPE;
    function _AddRef: LongInt; CALLTYPE;
    function _Release: LongInt; CALLTYPE;
  public
    constructor Create; override;
    procedure SendSRC(AAddress: Byte);
    function ReadRAM: Byte;
    procedure WriteRAM(AData: Byte);
    function ReadRAMStatus(AIndex: Byte): Byte;
    procedure WriteRAMStatus(AIndex: Byte; AData: Byte);
    procedure WriteRAMIOPort(AData: Byte);
    function ReadROM(AAddress: Word): Byte;
    function ReadROMIOPort: Byte;
    procedure WriteROMIOPort(AData: Byte);
    property ChipID: Byte read FChipID;
    property TargetAddress: Word read FTargetAddress write FTargetAddress;
    property TargetPort: TIOPort read FTargetPort write FTargetPort;
  end;

{ T4001ROM }

// ---- PROTECTED METHODS ----

// SET MEMORY SIZE
procedure T4001ROM.SetFAddressRangeSize(AAddressRangeSize: DWord);
begin
  FAddressRangeSize := 256;
  SetLength(FMemCells, FAddressRangeSize);
end;

// SET BASE ADDRESS
procedure T4001ROM.SetFBaseAddress(ABaseAddress: DWord);
begin
  if ABaseAddress <= $0F00 then
  begin
    FChipID := ABaseAddress div 256;
    FBaseAddress := FChipID * 256;
  end;
end;

// SET MEMORY MODE
procedure T4001ROM.SetFMemoryMode(AMemoryMode: TMemoryMode);
begin
  FMemoryMode := mmROM;
end;

// INTERFACE DUMMY METHODS
function T4001ROM.QueryInterface(constref iid: TGuid; out obj): LongInt; CALLTYPE;
begin
  if IsEqualGUID(iid, IMCS4Bus) then
  begin
    GetInterface(iid, obj);
    Result := 0;
  end
  else Result := LongInt($80004002);
end;

function T4001ROM._AddRef: LongInt; CALLTYPE;
begin
  Result := -1;
end;

function T4001ROM._Release: LongInt; CALLTYPE;
begin
  Result := -1;
end;

// ---- PUBLIC METHODS ----

// CREATE T4001ROM INSTANCE
constructor T4001ROM.Create;
begin
  inherited Create;
  SetFAddressRangeSize(256);
  FBusType := btMCS4;
  FModname := 'Intel 4001';
  FDescription := '256-byte ROM with 4-bit I/O port';
  FMemoryMode := mmROM;
  FSelected := false;
  FTargetPort := nil;
  FTargetAddress := 0;
  FChipID := 0;
end;

// RECEIVE CONTROL DATA (8 bits)
procedure T4001ROM.SendSRC(AAddress: Byte);
begin
  // SRC bits:
  // [7:6] chip ID
  // [5:4] register
  // [3:0] character
  FSelected := ((AAddress shr 4) = FChipID);
end;

// READ A ROM CELL (8 bits)
function T4001ROM.ReadROM(AAddress: Word): Byte;
begin
  Result := ReadMemory(AAddress);
end;

// READ I/O PORT (4 bits)
function T4001ROM.ReadROMIOPort: Byte;
begin
  Result := 0;
  if FSelected and Assigned(FTargetPort)
    then Result := FTargetPort.ReadPort(FTargetAddress) and $0F;
end;

// WRITE I/O PORT (4 bits)
procedure T4001ROM.WriteROMIOPort(AData: Byte);
begin
  if FSelected and Assigned(FTargetPort) then
    FTargetPort.WritePort(FTargetAddress, AData and $0F);
end;

// NOT SUPPORTED RAM FUNCTIONS
function T4001ROM.ReadRAM: Byte; begin Result := 0; end;
procedure T4001ROM.WriteRAM(AData: Byte); begin end;
function T4001ROM.ReadRAMStatus(AIndex: Byte): Byte; begin Result := 0; end;
procedure T4001ROM.WriteRAMStatus(AIndex: Byte; AData: Byte); begin end;
procedure T4001ROM.WriteRAMIOPort(AData: Byte); begin end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateMemory: TMemory; CALLTYPE; export;
begin
  Result := T4001ROM.Create;
end;

procedure DestroyMemory(AMemory: TMemory); CALLTYPE; export;
begin
  if Assigned(AMemory) then AMemory.Free;
end;

function LoadState(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(AMemory)
    then Result := AMemory.LoadState(AStream)
    else Result := false;
end;

function SaveState(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(AMemory)
    then Result := AMemory.SaveState(AStream)
    else Result := false;
end;

procedure SetTargetPort(AMemory: TMemory; APort: TIOPort; AAddress: Word); CALLTYPE; export;
begin
  if Assigned(AMemory) and (AMemory is T4001ROM) then
  begin
    T4001ROM(AMemory).TargetPort := APort;
    T4001ROM(AMemory).TargetAddress := AAddress;
  end;
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreateMemory name 'memory_create';
exports DestroyMemory name 'memory_destroy';
exports LoadState name 'memory_loadstate';
exports SaveState name 'memory_savestate';
exports SetTargetPort name 'memory_set_target_port';

begin
end.
