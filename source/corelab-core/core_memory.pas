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
{$mode objfpc}{$H+}
{$modeswitch typehelpers}
interface
uses
  Classes;
type
  // Operation mode
  TMemoryMode = (mmRAM, mmROM);
  TMemoryModeHelper = type helper for TMemoryMode
    function ToString: string;
    function FromString(const AValue: string): TMemoryMode;
  end;
  // Abstract base I/O port class
  TMemory = class
  protected
    FAddressRangeSize: dword;                              // Address range size
    FDescription: PChar;                                    // Short description
    FEnabled: boolean;                  // Enable memory without detach from bus
    FMemoryMode: TMemoryMode;                            //Memory operation mode
    FModname: PChar;                                              // Module name
    FMemCells: array of byte;                                    // Memory cells
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; override;
    function ReadMemory(Address: dword): byte; virtual;
    procedure LoadFromStream(Stream: TStream; Address, Count: dword); virtual;
    procedure Reset; virtual;
    procedure SaveToStream(Stream: TStream; Address, Count: dword); virtual;
    procedure WriteMemory(Address: dword; Value: byte); virtual;
    // Public properties
    property AddressRangeSize: dword read FAddressRangeSize write FAddressRangeSize;
    property Description: PChar read FDescription write FDescription;
    property Enabled: boolean read FEnabled write FEnabled;
    property MemoryMode: TMemoryMode read FMemoryMode write FMemoryMode;
    property ModName: PChar read FModname write FModname;
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

// Create TMemory instance
constructor TMemory.Create;
begin
  inherited Create;
  // Initial state
  FAddressRangeSize := 1024;
  FEnabled := false;
  FMemoryMode := mmRAM;
  FModname := 'RAM';
end;

// Destroy TMemory instance
destructor TMemory.Destroy;
begin
  inherited Destroy;
end;

// Read virtual memory
function TMemory.ReadMemory(Address: dword): byte;
begin
  Result := 0;
  if FEnabled then
    if Address < FAddressRangeSize
      then Result := FMemCells[Address]
      else Result := 0;
end;

// Write virtual memory
procedure TMemory.WriteMemory(Address: dword; Value: byte);
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
