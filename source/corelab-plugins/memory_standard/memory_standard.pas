{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | memory_standard.pas                                                      | }
{ | Standard memory implementation module                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library memory_standard;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
   CMem, Classes, core_memory;
type
  // Standard memory class
  TStandardMemory = class(TMemory)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
// CREATE TSTANDARDMEMORY INSTANCE
constructor TStandardMemory.Create;
begin
  inherited Create;
  FModname := PChar('Standard memory');
  FDescription := PChar('Up to 16MB RAM/ROM');
  FMemoryMode := mmRAM;
end;

// DESTROY TSTANDARDMEMORY INSTANCE
destructor TStandardMemory.Destroy;
begin
  inherited Destroy;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateMemory: TMemory; CALLTYPE; export;
begin
  Result := TStandardMemory.Create;
end;

procedure DestroyMemory(AMemory: TMemory); CALLTYPE; export;
begin
  if Assigned(AMemory) then AMemory.Free;
end;

function LoadState(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(AMemory)
    then Result := AMemory.LoadState(AStream)
    else Result := false;
end;

function SaveState(AMemory: TMemory; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(AMemory)
    then Result := AMemory.SaveState(AStream)
    else Result := false;
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreateMemory name 'memory_create';
exports DestroyMemory name 'memory_destroy';
exports LoadState name 'memory_loadstate';
exports SaveState name 'memory_savestate';

begin
end.
