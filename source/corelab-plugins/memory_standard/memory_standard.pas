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
uses
   core_memory;
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
  FModname := 'Standard memory';
  FDescription := 'Up to 16MB RAM/ROM';
  FMemoryMode := mmRAM;
  Reset;
end;

// DESTROY TSTANDARDMEMORY INSTANCE
destructor TStandardMemory.Destroy;
begin
  inherited Destroy;
end;

// EXPORTABLE FUNCTIONS AND PROCEDURES
function CreateMemory: TMemory; cdecl; export;
begin
  Result := TStandardMemory.Create;
end;

procedure DestroyMemory(Memory: TMemory); cdecl; export;
begin
  if Assigned(Memory) then Memory.Free;
end;

// EXPORTED FUNCTIONS AND PROCEDURES
exports CreateMemory name 'memory_create';
exports DestroyMemory name 'memory_destroy';

begin
end.
