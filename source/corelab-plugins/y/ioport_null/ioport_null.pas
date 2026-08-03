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
  CMem, Classes, core_ioport;
type
  // NULL device class
  TNULLPort = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Reset; override;
    function ReadPort(APort: Word): Byte; override;
    procedure WritePort(APort: Word; AValue: Byte); override;
  end;

// ---- PUBLIC METHODS ----
  
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

// RESET VIRTUAL PORT
procedure TNULLPort.Reset;
begin
end;

// READ VIRTUAL PORT
function TNULLPort.ReadPort(APort: Word): Byte;
begin
  if FEnabled and (APort = 0)
    then Result := $00
    else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TNULLPort.WritePort(APort: Word; AValue: Byte);
begin
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TNULLPort.Create;
end;

procedure DestroyPort(APort: TIOPort); CALLTYPE; export;
begin
  if Assigned(APort) then APort.Free;
end;

procedure SetIntHandler(APort: TIOPort; AIntProc: TInterruptCallback; AIntVect: Byte); CALLTYPE; export;
begin
  if Assigned(APort) then
  begin
    APort.OnInterrupt := AIntProc;
    APort.IntVector := AIntVect;
  end;
end;

function LoadState(APort: TIOPort; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.LoadState(AStream)
    else Result := false;
end;

function SaveState(APort: TIOPort; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.SaveState(AStream)
    else Result := false;
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';
exports SetIntHandler name 'ioport_setinthandler';
exports LoadState name 'ioport_loadstate';
exports SaveState name 'ioport_savestate';

begin
end.
