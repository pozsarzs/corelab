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
  // Abstract memory class
  TMemory = class
  private
    DataMask:          QWord;               // Data mask dependent on data width
  protected
    FAddressRangeSize: DWord;                              // Address range size
    FDataWidth:        Byte;                           // Data width (4-64 bits)
    FDescription:      PChar;                               // Short description
    FEnabled:          Boolean;         // Enable memory without detach from bus
    FInstanceID:       Integer;                            // Module instance ID
    FMemoryMode:       TMemoryMode;                      //Memory operation mode
    FMemCells:         array of QWord;                           // Memory cells
    FModname:          PChar;                                     // Module name
    FVersion:          TSemanticVersion;                       // Module version
    procedure SetFAddressRangeSize(AAddressRangeSize: DWord);
    procedure SetFDataWidth(ADataWidth: Byte);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    // SysBus side
    procedure Reset; virtual;
    function ReadMemory(AAddress: DWord): QWord; virtual;
    procedure WriteMemory(AAddress: DWord; AValue: QWord); virtual;
    // SrvBus side methods
    function LoadState(AStream: TStream): Boolean; virtual;
    function SaveState(AStream: TStream): Boolean; virtual;
    procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord); virtual;
    procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord); virtual;
    // Properties
    property AddressRangeSize: DWord read FAddressRangeSize write SetFAddressRangeSize;
    property DataWidth: Byte read FDataWidth write SetFDataWidth;
    property Description: PChar read FDescription;
    property Enabled: Boolean read FEnabled write FEnabled;
    property InstanceID: Integer read FInstanceID write FInstanceID;
    property MemoryMode: TMemoryMode read FMemoryMode write FMemoryMode;
    property ModName: PChar read FModname;
    property Version: TSemanticVersion read FVersion;
  end;

implementation

// ---- HELPER FOR OWN TYPES ----

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

// ---- PROTECTED METHODS ----

// SET MEMORY SIZE
procedure TMemory.SetFAddressRangeSize(AAddressRangeSize: DWord);
var
  dw: DWord;
begin
  if AAddressRangeSize >= 16 then
  begin
    FAddressRangeSize := AAddressRangeSize;
    dw := 1 shl 24;
    if FAddressRangeSize > dw then FAddressRangeSize := dw;
    SetLength(FMemCells, FAddressRangeSize);
  end;
end;

// SET DATA WIDTH
procedure TMemory.SetFDataWidth(ADataWidth: Byte);
begin
  if (ADataWidth >= 4) and (ADataWidth <= 64) then
  begin
    if ADataWidth = 64
      then DataMask := High(QWord)
      else DataMask := (QWord(1) shl ADataWidth) - 1;
    FDataWidth := ADataWidth;
  end;
end;

// ---- PUBLIC METHODS ----

// CREATE TMEMORY INSTANCE
constructor TMemory.Create;
begin
  inherited Create;
  // Initial state
  SetFAddressRangeSize(1024);
  FEnabled := false;
  FMemoryMode := mmRAM;
  FModname := PChar('RAM/ROM');
  FDescription := PChar('Standard memory with 4-64 bit data width.');
  SetFDataWidth(8);
  with FVersion do
  begin
    Major := 0;
    Minor := 1;
    Patch := 0;
  end; 
  Reset;
end;

// DESTROY TMEMORY INSTANCE
destructor TMemory.Destroy;
begin
  inherited Destroy;
end;

// FILL MEMORY WITH ZERO
procedure TMemory.Reset;
var
  dw: DWord;
begin
  if FAddressRangeSize > 0 then
    for dw := 0 to FAddressRangeSize - 1 do FMemCells[dw] := 0;
end;

// READ VIRTUAL MEMORY
function TMemory.ReadMemory(AAddress: DWord): QWord;
begin
  Result := 0;
  if FEnabled then
    if AAddress < FAddressRangeSize
      then Result := DataMask and FMemCells[AAddress]
      else Result := 0;
end;

// WRITE VIRTUAL MEMORY
procedure TMemory.WriteMemory(AAddress: DWord; AValue: QWord);
begin
  if FEnabled and (FMemoryMode = mmRAM) then
    if AAddress < FAddressRangeSize then FMemCells[AAddress] := DataMask and AValue;
end;

// LOAD SAVED STATE
function TMemory.LoadState(AStream: TStream): Boolean;
begin
  Result := true;
  with AStream do
    try
      // common fields
      ReadBuffer(FEnabled, SizeOf(FEnabled));
      // common fields related to IOPort
      ReadBuffer(FMemoryMode, SizeOf(FMemoryMode));
      ReadBuffer(FAddressRangeSize, SizeOf(FAddressRangeSize));
      SetFAddressRangeSize(FAddressRangeSize);
      ReadBuffer(FDataWidth, SizeOf(FDataWidth));
      SetFDataWidth(FDataWidth);
      Reset;
      if FAddressRangeSize > 0 then
        ReadBuffer(FMemCells[0], FAddressRangeSize);
    except
      Result := false;
    end;
end;

// SAVE ACTUAL STATE
function TMemory.SaveState(AStream: TStream): Boolean;
begin
  Result := false;
  if FInstanceID > -1 then
    with AStream do
    begin
      // common fields
      WriteBuffer(FEnabled, SizeOf(FEnabled));
      // common fields related to IOPort
      WriteBuffer(FMemoryMode, SizeOf(FMemoryMode));
      WriteBuffer(FAddressRangeSize, SizeOf(FAddressRangeSize));
      WriteBuffer(FDataWidth, SizeOf(FDataWidth));
      if FAddressRangeSize > 0 then
        WriteBuffer(FMemCells[0], FAddressRangeSize);
      Result := true;
    end;
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
