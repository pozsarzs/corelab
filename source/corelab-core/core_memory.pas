{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_memory.pas                                                          | }
{ | Memory abstraction module                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_memory;
{$MODE OBJFPC}{$H+}
{$MODESWITCH TYPEHELPERS}
interface
uses
  Classes, SysUtils, TypInfo;
type
  // Operation mode
  TMemoryMode = (mmRAM, mmROM);
  TMemoryModeHelper = type helper for TMemoryMode
    function ToString: string;
    function FromString(const Value: string): TMemoryMode;
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
  // Abstract base I/O port class
  TMemory = class
  protected
    FAddressRangeSize: DWord;                              // Address range size
    FDescription:      PChar;                               // Short description
    FEnabled:          Boolean;         // Enable memory without detach from bus
    FMemoryMode:       TMemoryMode;                      //Memory operation mode
    FMemCells:         array of Byte;                            // Memory cells
    FModname:          PChar;                                     // Module name
    FVersion:          TSemanticVersion;                       // Module version
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; override;
    // system bus side
    function ReadMemory(AAddress: DWord): Byte; virtual;
    procedure Reset; virtual;
    procedure WriteMemory(AAddress: DWord; AValue: Byte); virtual;
    // service bus side
    procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord); virtual;
    procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord); virtual;
    // Public properties
    property AddressRangeSize: DWord read FAddressRangeSize write FAddressRangeSize;
    property Description: PChar read FDescription write FDescription;
    property Enabled: Boolean read FEnabled write FEnabled;
    property MemoryMode: TMemoryMode read FMemoryMode write FMemoryMode;
    property ModName: PChar read FModname write FModname;
    property Version: TSemanticVersion read FVersion;
  end;

implementation

// HELPER FOR OWN TYPES
function TMemoryModeHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TMemoryModeHelper.FromString(const Value: string): TMemoryMode;
begin
  Result := TMemoryMode(GetEnumValue(TypeInfo(TMemoryMode), Value));
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

// CREATE TMEMORY INSTANCE
constructor TMemory.Create;
begin
  inherited Create;
  // Initial state
  FAddressRangeSize := 1024;
  FEnabled := false;
  FMemoryMode := mmRAM;
  FModname := 'RAM';
  with FVersion do
  begin
    Major := 0;
    Minor := 1;
    Patch := 0;
  end; 
end;

// DESTROY TMEMORY INSTANCE
destructor TMemory.Destroy;
begin
  inherited Destroy;
end;

// READ VIRTUAL MEMORY
function TMemory.ReadMemory(AAddress: DWord): Byte;
begin
  Result := 0;
  if FEnabled then
    if AAddress < FAddressRangeSize
      then Result := FMemCells[AAddress]
      else Result := 0;
end;

// WRITE VIRTUAL MEMORY
procedure TMemory.WriteMemory(AAddress: DWord; AValue: Byte);
begin
  if FEnabled and (FMemoryMode = mmRAM) then
    if AAddress < FAddressRangeSize then FMemCells[AAddress] := AValue;
end;

// SET SIZE AND RESET CELLS
procedure TMemory.Reset;
var
  dw: DWord;
begin
  dw := 1 shl 24;
  if FAddressRangeSize > dw then FAddressRangeSize := dw;
  SetLength(FMemCells, FAddressRangeSize);
  if FAddressRangeSize > 0 then FillByte(FMemCells[0], FAddressRangeSize, 0);
end;

// LOAD MEMORY CONTENT FROM STREAM
procedure TMemory.LoadFromStream(AStream: TStream; AAddress, ACount: DWord);
begin
  if not FEnabled then exit;
  if (AAddress + ACount > FAddressRangeSize) or (AStream.Size - AStream.Position < ACount) then exit;
  if ACount > 0 then AStream.ReadBuffer(FMemCells[AAddress], ACount);
end;

// SAVE MEMORY CONTENT TO STREAM
procedure TMemory.SaveToStream(AStream: TStream; AAddress, ACount: DWord);
begin
  if not FEnabled then exit;
  if AAddress + ACount > FAddressRangeSize then exit;
  if ACount > 0 then AStream.WriteBuffer(FMemCells[AAddress], ACount);
end;

end.
