{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | memory_4002ram.pas                                                       | }
{ | Intel 4002 RAM and I/O chip implementation                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library memory_4002ram;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_memory, core_bus, core_ioport;
type
  { T4002RAM }
  T4002RAM = class(TMemory, IMCS4Bus)
  private
    FChipID:        Byte;
    FActiveReg:     Byte;
    FActiveChar:    Byte;
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

{ T4002RAM }

// ---- PROTECTED METHODS ----

// SET MEMORY SIZE
procedure T4002RAM.SetFAddressRangeSize(AAddressRangeSize: DWord);
begin
  FAddressRangeSize := 80;
  SetLength(FMemCells, FAddressRangeSize);
end;

// SET BASE ADDRESS
procedure T4002RAM.SetFBaseAddress(ABaseAddress: DWord);
begin
  if ABaseAddress <= $0F00 then
  begin
    FChipID := ABaseAddress div 80;
    FBaseAddress := FChipID * 80;  
  end;
end;

// SET MEMORY MODE
procedure T4002RAM.SetFMemoryMode(AMemoryMode: TMemoryMode);
begin
  FMemoryMode := mmRAM;
end;

// INTERFACE DUMMY METHODS
function T4002RAM.QueryInterface(constref iid: TGuid; out obj): LongInt; CALLTYPE;
begin
  if IsEqualGUID(iid, IMCS4Bus) then
  begin
    GetInterface(iid, obj);
    Result := 0;
  end
  else Result := LongInt($80004002);
end;

function T4002RAM._AddRef: LongInt; CALLTYPE;
begin
  Result := -1;
end;

function T4002RAM._Release: LongInt; CALLTYPE;
begin
  Result := -1;
end;

// ---- PUBLIC METHODS ----

// CREATE T4002RAM INSTANCE
constructor T4002RAM.Create;
begin
  inherited Create;
  // 4 register * 16 char + 4 register * 4 status char = 80 Bytes
  SetFAddressRangeSize(80); 
  FBusType := btMCS4;
  FModname := 'Intel 4002';
  FDescription := 'RAM (4 registers x 20 nibbles) with 4-bit output port';
  FMemoryMode := mmRAM;
  FSelected := false;
  FTargetPort := nil;
  FTargetAddress := 0;
  FChipID := 0;
  FActiveReg := 0;
  FActiveChar := 0;
end;

// RECEIVE CONTROL DATA (8 bits)
procedure T4002RAM.SendSRC(AAddress: Byte);
begin
  // SRC bits:
  // [7:6] chip ID
  // [5:4] register
  // [3:0] character
  FSelected := ((AAddress shr 6) and $03) = FChipID;
  FActiveReg := (AAddress shr 4) and $03;
  FActiveChar := AAddress and $0F;
end;

// READ A ROM CELL (4 bits)
function T4002RAM.ReadRAM: Byte;
begin
  Result := 0;
  if FSelected
    then Result := ReadMemory((FActiveReg shl 4) + FActiveChar) and $0F;
end;

// WRITE A RAM CELL (4 bits)
procedure T4002RAM.WriteRAM(AData: Byte);
begin
  if FSelected
    then WriteMemory((FActiveReg shl 4) + FActiveChar, AData and $0F);
end;

// READ RAM STATUS (4 bits)
function T4002RAM.ReadRAMStatus(AIndex: Byte): Byte;
begin
  Result := 0;
  if FSelected and (AIndex < 4)
    then Result := ReadMemory(64 + (FActiveReg shl 2) + AIndex) and $0F;
end;

// WRITE RAM STATUS (4 bits)
procedure T4002RAM.WriteRAMStatus(AIndex: Byte; AData: Byte);
begin
  if FSelected and (AIndex < 4)
    then WriteMemory(64 + (FActiveReg shl 2) + AIndex, AData and $0F);
end;

// WRITE I/O PORT (4 bits)
procedure T4002RAM.WriteRAMIOPort(AData: Byte);
begin
  if FSelected and Assigned(FTargetPort)
    then FTargetPort.WritePort(FTargetAddress, AData and $0F);
end;

// NOT SUPPORTED ROM FUNCTIONS
function T4002RAM.ReadROM(AAddress: Word): Byte; begin Result := 0; end;
function T4002RAM.ReadROMIOPort: Byte; begin Result := 0; end;
procedure T4002RAM.WriteROMIOPort(AData: Byte); begin end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateMemory: TMemory; CALLTYPE; export;
begin
  Result := T4002RAM.Create;
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
  if Assigned(AMemory) and (AMemory is T4002RAM) then
  begin
    T4002RAM(AMemory).TargetPort := APort;
    T4002RAM(AMemory).TargetAddress := AAddress;
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
