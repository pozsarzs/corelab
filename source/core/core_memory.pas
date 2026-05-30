{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_mem.pas                                                             | }
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
uses
  Classes, SysUtils;
type
  // Abstract base memory class
  TMemory = class
  protected
    // Allocated memory block
    FMaxRelAddress: qword;          // Stores the highest valid relative address
    FSize: qword;                                         // Total size in bytes
    FReadOnly: boolean;           //Flag indicating that the memory block is ROM
  public
    // Public methods
    constructor Create(ASize: qword; AReadOnly: boolean); virtual;
    function ReadByte(Address: qword): byte;  virtual; abstract;
    procedure WriteByte(Address: qword; Value: byte);  virtual; abstract;
    procedure Reset; virtual; abstract;
    procedure LoadFromStream(Stream: TStream; TargetAddress: qword); virtual; abstract;
    procedure SaveToStream(Stream: TStream; SourceAddress: qword; Length: qword); virtual; abstract;
    // Public properties
    property MaxRelAddress: qword read FMaxRelAddress;
    property Size: qword read FSize;
    property ReadOnly: boolean read FReadOnly;
  end;

implementation

// Create TMemory instance
constructor TMemory.Create(ASize: qword; AReadOnly: boolean);
begin
  inherited Create;
  // Initial state
  FSize := ASize;
  if ASize > 0 then FMaxRelAddress := ASize - 1 else FMaxRelAddress := 0;
  FReadOnly := false;
end;

end.
