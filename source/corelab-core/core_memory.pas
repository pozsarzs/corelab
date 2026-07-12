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
    function FromString(const AValue: string): TMemoryMode;
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
  // Abstract base I/O port class
  TMemory = class
  protected
    FAddressRangeSize: dword;                              // Address range size
    FDescription: PChar;                                    // Short description
    FEnabled: Boolean;                  // Enable memory without detach from bus
    FMemoryMode: TMemoryMode;                            //Memory operation mode
    FMemCells: array of Byte;                                    // Memory cells
    FModname: PChar;                                              // Module name
    FVersion: TSemanticVersion;                                // Module version
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; override;
    // system bus side
    function ReadMemory(Address: dword): Byte; virtual;
    procedure Reset; virtual;
    procedure WriteMemory(Address: dword; Value: Byte); virtual;
    // service bus side
    procedure LoadFromStream(Stream: TStream; Address, Count: dword); virtual;
    procedure SaveToStream(Stream: TStream; Address, Count: dword); virtual;
    // Public properties
    property AddressRangeSize: dword read FAddressRangeSize write FAddressRangeSize;
    property Description: PChar read FDescription write FDescription;
    property Enabled: Boolean read FEnabled write FEnabled;
    property MemoryMode: TMemoryMode read FMemoryMode write FMemoryMode;
    property ModName: PChar read FModname write FModname;
    property Version: TSemanticVersion read FVersion;
  end;

implementation

// Helper for own types
function TMemoryModeHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TMemoryModeHelper.FromString(const AValue: string): TMemoryMode;
begin
  Result := TMemoryMode(GetEnumValue(TypeInfo(TMemoryMode), AValue));
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

// Create TMemory instance
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

// Destroy TMemory instance
destructor TMemory.Destroy;
begin
  inherited Destroy;
end;

// Read virtual memory
function TMemory.ReadMemory(Address: dword): Byte;
begin
  Result := 0;
  if FEnabled then
    if Address < FAddressRangeSize
      then Result := FMemCells[Address]
      else Result := 0;
end;

// Write virtual memory
procedure TMemory.WriteMemory(Address: dword; Value: Byte);
begin
  if FEnabled and (FMemoryMode = mmRAM) then
    if Address < FAddressRangeSize then FMemCells[Address] := Value;
end;

// Set size and reset cells
procedure TMemory.Reset;
var
  dw: dword;
begin
  dw := 1 shl 24;
  if FAddressRangeSize > dw then FAddressRangeSize := dw;
  SetLength(FMemCells, FAddressRangeSize);
  if FAddressRangeSize > 0 then FillByte(FMemCells[0], FAddressRangeSize, 0);
end;

// Load memory content from stream
procedure TMemory.LoadFromStream(Stream: TStream; Address, Count: dword);
begin
  if not FEnabled then exit;
  if (Address + Count > FAddressRangeSize) or (Stream.Size - Stream.Position < Count) then exit;
  if Count > 0 then Stream.ReadBuffer(FMemCells[Address], Count);
end;

// Save memory content to stream
procedure TMemory.SaveToStream(Stream: TStream; Address, Count: dword);
begin
  if not FEnabled then exit;
  if Address + Count > FAddressRangeSize then exit;
  if Count > 0 then Stream.WriteBuffer(FMemCells[Address], Count);
end;

end.
