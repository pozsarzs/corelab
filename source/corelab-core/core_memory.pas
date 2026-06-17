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
interface
type
  // Operation mode
  TMemoryMode = (pmReadOnly, pmReadWrite);
  // Abstract base I/O port class
  TMemory = class
  protected
    FModname: PChar;                                              // Module name
    FDescription: PChar;                                    // Short description
    FAddressRangeSize: qword;                              // Address range size
    FEnabled: boolean;                    // Enable port without detach from bus
    FMemoryMode: TPortMode;                              //Memory operation mode
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; virtual;
    function ReadMemory(Address: qword): byte; virtual; abstract;
    procedure WriteMemory(Address: qword; Value: byte); virtual; abstract;
    procedure Reset; virtual; abstract;
    // Public properties
    property AddressRangeSize: qword read FAddressRangeSize write FAddressRangeSize;
    property Description: PChar read FDescription write FDescription;
    property Enabled: boolean read FEnabled write FEnabled;
    property ModName: PChar read FModname write FModname;
    property MemoryMode: TPortMode read FPortMode write FPortMode;
  end;

implementation

// Create TMemory instance
constructor TMemory.Create;
begin
  inherited Create;
  // Initial state
  FAddressRangeSize := 4095;
  FEnabled := false;
  FMemoryMode := pmReadWrite;
  FModname := 'RAM';
end;

// Destroy TMemory instance
destructor TMemory.Destroy;
begin
  inherited Destroy;
end;

end.
