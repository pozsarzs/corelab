{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_ioport.pas                                                          | }
{ | I/O port abstraction module                                              | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_ioport;
{$mode objfpc}{$H+}
interface
type
  // Operation mode
  TPortMode = (pmReadOnly, pmWriteOnly, pmReadWrite);
  // Abstract base I/O port class
  TIOPort = class
  protected
    FModname: string;                                             // Module name
    FDescription: string;                                   // Short description
    FAddressRangeSize: byte;                               // Address range size
    FEnabled: boolean;                    // Enable port without detach from bus
    FHasGUI: boolean;                     // Does the implementation have a GUI?
    FLatchedOutput: boolean;                                   // Latched output
    FPortMode: TPortMode;                                 // Port operation mode
    FReadBackOutput: boolean;           // Output port with read-back capability
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; virtual;
    function ReadPort(Port: byte): byte; virtual; abstract;
    procedure WritePort(Port: byte; Value: byte); virtual; abstract;
    procedure Reset; virtual; abstract;
    // Public properties
    property AddressRangeSize: byte read FAddressRangeSize;
    property Enabled: boolean read FEnabled write FEnabled;
    property HasGUI: boolean read FHasGUI;
    property LatchedOutput: boolean read FLatchedOutput;
    property Description: string read FDescription;
    property ModName: string read FModname;
    property PortMode: TPortMode read FPortMode;
    property ReadBackOutput: boolean read FReadBackOutput;
  end;

implementation

// Create TIOPort instance
constructor TIOPort.Create;
begin
  inherited Create;
  // Initial state
  FAddressRangeSize := 1;
  FEnabled := false;
  FHasGUI := false;
  FLatchedOutput := false;
  FPortMode := pmReadWrite;
  FReadBackOutput := false;
end;

// Destroy TIOPort instance
destructor TIOPort.Destroy;
begin
  inherited Destroy;
end;

end.
