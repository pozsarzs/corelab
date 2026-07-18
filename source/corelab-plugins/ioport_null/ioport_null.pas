{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_null.pas                                                          | }
{ | NULL device implementation module                                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_null;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, core_ioport;
type
  // NULL device class
  TNULLPort = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: byte): byte; override;
    procedure WritePort(Port: byte; Value: byte); override;
    procedure Reset; override;
  end;
  
// CREATE TNULLPORT INSTANCE
constructor TNULLPort.Create;
begin
  inherited Create;
  FModname := 'NULL device';
  FDescription := 'It absorbs everything and returns 00h.';
  FHasPanel := false;
  Reset;
end;

// DESTROY TNULLPORT INSTANCE
destructor TNULLPort.Destroy;
begin
  inherited Destroy;
end;

// READ VIRTUAL PORT
function TNULLPort.ReadPort(Port: byte): byte;
begin
  if FEnabled and (Port = 0) then Result := $00 else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TNULLPort.WritePort(Port: byte; Value: byte);
begin
end;

// RESET VIRTUAL PORT
procedure TNULLPort.Reset;
begin
end;

// EXPORTABLE FUNCTIONS AND PROCEDURES
function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TNULLPort.Create;
end;

procedure DestroyPort(Port: TIOPort); CALLTYPE; export;
begin
  if Assigned(Port) then Port.Free;
end;

// EXPORTED FUNCTIONS AND PROCEDURES
exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';

begin
end.
