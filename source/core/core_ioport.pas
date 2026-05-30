{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
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
uses
  Classes, SysUtils;
type
  TIOPort = class
  protected
    FMaxRelAddress: qword;
    FSize: qword;
    FReadOnly: boolean;
  public
    // Public methods
    constructor Create(ASize: qword; AReadOnly: boolean); virtual;
    function ReadPort(Port: qword): byte; virtual; abstract;
    procedure WritePort(Port: qword; Value: byte); virtual; abstract;
    procedure Reset; virtual; abstract;
    // Public properties
    property MaxRelAddress: qword read FMaxRelAddress;
    property Size: qword read FSize;
    property ReadOnly: boolean read FReadOnly;
  end;

implementation

// Create TIOPort instance
constructor TIOPort.Create(ASize: qword; AReadOnly: boolean);
begin
  inherited Create;
  // Initial state
  FSize := ASize;
  if ASize > 0 then FMaxRelAddress := ASize - 1 else FMaxRelAddress := 0;
  FReadOnly := false;
end;

end.
