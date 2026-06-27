{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_bell.pas                                                          | }
{ | Bell device implementation module                                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_bell;
{$mode objfpc}{$H+}
uses
  SysUtils, core_ioport;
type
  // BELL device implementation
  TBELLPort = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
  end;
  
// Create TIOPort instance
constructor TBELLPort.Create;
begin
  inherited Create;
  FModname := 'BELL device';
  FDescription := 'It rings at a value greater than zero.';
  FHasGUI := false;
  FPortMode := pmWriteOnly;
  Reset;
end;

// Destroy TIOPort instance
destructor TBELLPort.Destroy;
begin
  inherited Destroy;
end;

// Read virtual port
function TBELLPort.ReadPort(Port: byte): byte;
begin
  Result := 0;
end;

// Write virtual port
procedure TBELLPort.WritePort(Port: byte; Value: byte);
begin
  if Value > 0 then Beep;
end;

// Reset virtual port
procedure TBELLPort.Reset;
begin
end;

// Exportable function for create TIOPort instance
function CreatePort: TIOPort; cdecl; export;
begin
  result := TBELLPort.Create;
end;

// Exportable procedure for destroy TIOPort instance
procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Free;
end;

// Exported functions and procedures
exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';

begin
end.
