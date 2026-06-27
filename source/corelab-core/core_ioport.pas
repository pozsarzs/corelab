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
  TLineMode = (lmDirect, lmBCD); // Operation mode
  TPortMode = (pmReadOnly, pmWriteOnly, pmReadWrite);  // Operation mode
  TResponse = (rp00, rpFF, rpAd); // Operation mode
  // Abstract base memory class
  TIOPort = class
  protected
    FAddressRangeSize: byte;                               // Address range size
    FDataInMode: TLineMode;                         // Decoding input data lines
    FDataInNegation: boolean;               // Negation of databit (port -> CPU)
    FDataOutMode: TLineMode;                       // Decoding output data lines
    FDataOutNegation: boolean;              // Negation of databit (CPU -> port)
    FDescription: PChar;                                    // Short description
    FEnabled: boolean;                    // Enable port without detach from bus
    FHasGUI: boolean;                     // Does the implementation have a GUI?
    FLatchedOutput: boolean;                                   // Latched output
    FModname: PChar;                                              // Module name
    FPortMode: TPortMode;                                 // Port operation mode
    FReadBackOutput: boolean;           // Output port with read-back capability
    FResponse: TResponse;                    // Response type of the null device
    FSelMode: TLineMode;                       // Decoding matrix selector lines
    FSelNegation: boolean;                   // Negation of matrix selector bits
    FTitle: PChar;                                                 // Form title
  public
    // Public methods
    constructor Create; virtual;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; virtual; abstract;
    procedure Reset; virtual; abstract;
    procedure WritePort(Port: byte; Value: byte); virtual; abstract;
    // Public properties
    property AddressRangeSize: byte read FAddressRangeSize;
    property DataInMode: TLineMode read FDataInMode write FDataInMode;
    property DataInNegation: boolean read FDataInNegation write FDataInNegation;
    property DataOutMode: TLineMode read FDataOutMode write FDataOutMode;
    property DataOutNegation: boolean read FDataOutNegation write FDataOutNegation;
    property Description: PChar read FDescription;
    property Enabled: boolean read FEnabled write FEnabled;
    property HasGUI: boolean read FHasGUI;
    property LatchedOutput: boolean read FLatchedOutput;
    property ModName: PChar read FModname;
    property PortMode: TPortMode read FPortMode;
    property ReadBackOutput: boolean read FReadBackOutput;
    property Response: TResponse read FResponse write FResponse;
    property SelMode: TLineMode read FSelMode write FSelMode;
    property SelNegation: boolean read FSelNegation write FSelNegation;
    property Title: PChar read FTitle write FTitle;
  end;

implementation

// Create TIOPort instance
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
  FHasGUI := false;
  FLatchedOutput := false;
  FPortMode := pmReadWrite;
  FReadBackOutput := false;
  FResponse := rp00;
  FSelMode := lmBCD;
  FSelNegation := false;
  FTitle := FModname;
end;

// Destroy TIOPort instance
destructor TIOPort.Destroy;
begin
  inherited Destroy;
end;

end.
