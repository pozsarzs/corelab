{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_null.pas                                                          | }
{ | NULL implementation module                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_null;
{$mode objfpc}{$H+}
uses
  core_ioport;
type
  TResponse = (rp00, rpFF, rpAd);
  // NULL port implementation
  TNULLPort = class(TIOPort)
  protected
    FResponse: TResponse;
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset;  override;
    property Response: TResponse read FResponse write FResponse;
  end;

// Create TIOPort instance
constructor TNULLPort.Create;
begin
  inherited Create;
  FModname := 'NULL device';
  FDescription := 'It absorbs everything, returns 0, 255, or the port address.';
  Reset;
end;

// Destroy TIOPort instance
destructor TNULLPort.Destroy;
begin
  inherited Destroy;
end;

// Read virtual port
function TNULLPort.ReadPort(Port: byte): byte;
begin
  Result := 0;
  if FEnabled then
    case FResponse of
      rp00: result := $00;
      rpFF: result := $FF;
      rpAd: result := byte(Port);
    end;   
end;

// Write virtual port
procedure TNULLPort.WritePort(Port: byte; Value: byte);
begin
end;

// Reset virtual port
procedure TNULLPort.Reset;
begin
  FResponse := rpFF;
end;

// Exported functions and procedures
function CreatePort: TIOPort; cdecl; export;
begin
  result := TNULLPort.Create;
end;

procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Destroy;
end;

exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';

begin
end.
