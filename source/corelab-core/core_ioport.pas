{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_ioport.pas                                                          | }
{ | I/O port (device) abstraction module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_ioport;
{$MODE OBJFPC}{$H+}
{$MODESWITCH TYPEHELPERS}
interface
uses
  SysUtils, TypInfo;
type
  TIOPort = class;
  // Data mode
  TLineMode = (lmDirect, lmBCD);
  TLineModeHelper = type helper for TLineMode
    function ToString: string;
    function FromString(const AValue: string): TLineMode;
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
  // Callback procedure for interrupt
  type TInterruptCallback = procedure(Sender: TIOPort; Vector: Byte) of object;
  // I/O port (device) base class
  TIOPort = class
  protected
    FAddressRangeSize: Byte;                               // Address range size
    FDataInMode:       TLineMode;                   // Decoding input data lines
    FDataInNegation:   Boolean;             // Negation of databit (port -> CPU)
    FDataOutMode:      TLineMode;                  // Decoding output data lines
    FDataOutNegation:  Boolean;             // Negation of databit (CPU -> port)
    FDescription:      PChar;                               // Short description
    FEnabled:          Boolean;           // Enable port without detach from bus
    FHasPanel:         Boolean;           // Does the implementation have a GUI?
    FLatchedOutput:    Boolean;                                // Latched output
    FModname:          PChar;                                     // Module name
    FReadBackOutput:   Boolean;         // Output port with read-back capability
    FSelMode:          TLineMode;              // Decoding matrix selector lines
    FSelNegation:      Boolean;              // Negation of matrix selector bits
    FVersion:          TSemanticVersion;                       // Module version
    FIntVector:        Byte;                                 // Interrupt vector
    FOnInterrupt:      TInterruptCallback;   // Callback procedure for interrupt
    procedure RequestInterrupt; virtual;    
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function ReadPort(Port: Byte): Byte; virtual; abstract;
    procedure Reset; virtual; abstract;
    procedure WritePort(Port: Byte; Value: Byte); virtual; abstract;
    property AddressRangeSize: Byte read FAddressRangeSize;
    property DataInMode: TLineMode read FDataInMode write FDataInMode;
    property DataInNegation: Boolean read FDataInNegation write FDataInNegation;
    property DataOutMode: TLineMode read FDataOutMode write FDataOutMode;
    property DataOutNegation: Boolean read FDataOutNegation write FDataOutNegation;
    property Description: PChar read FDescription;
    property Enabled: Boolean read FEnabled write FEnabled;
    property HasPanel: Boolean read FHasPanel;
    property IntVector: Byte read FIntVector write FIntVector;
    property LatchedOutput: Boolean read FLatchedOutput;
    property ModName: PChar read FModname;
    property OnInterrupt: TInterruptCallback read FOnInterrupt write FOnInterrupt;
    property ReadBackOutput: Boolean read FReadBackOutput;
    property SelMode: TLineMode read FSelMode write FSelMode;
    property SelNegation: Boolean read FSelNegation write FSelNegation;
    property Version: TSemanticVersion read FVersion;
  end;

implementation

// HELPER FOR OWN TYPES
function TLineModeHelper.ToString: string;
begin
  WriteStr(Result, Self);
end;

function TLineModeHelper.FromString(const AValue: string): TLineMode;
begin
  Result := TLineMode(GetEnumValue(TypeInfo(TLineMode), AValue));
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

// REQUEST INTERRUPT
procedure TIOPort.RequestInterrupt;
begin
  if FEnabled and Assigned(FOnInterrupt) then
    FOnInterrupt(Self, FIntVector);
end;

// CREATE TIOPORT INSTANCE
constructor TIOPort.Create;
begin
  inherited Create;
  // Initial state
  FAddressRangeSize := 1;
  FDataInMode := lmBCD;
  FDataInNegation := false;
  FDataOutMode := lmBCD;
  FDataOutNegation := false;
  FEnabled := false;
  FHasPanel := false;
  FLatchedOutput := false;
  FModname := 'MyIO';
  FReadBackOutput := false;
  FSelMode := lmBCD;
  FSelNegation := false;
  with FVersion do
  begin
    Major := 0;
    Minor := 1;
    Patch := 0;
  end; 
end;

// DESTROY TIOPORT INSTANCE
destructor TIOPort.Destroy;
begin
  inherited Destroy;
end;

end.
