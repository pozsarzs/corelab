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
{$mode objfpc}{$H+}
uses
  //Interfaces, Forms, StdCtrls, SysUtils,
   core_memory;
type
  // Standard port implementation
  TStandardMemory = class(TMemory)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
  end;
  
// Create TMemory instance
constructor TStandardMemory.Create;
begin
  inherited Create;
  FModname := 'Standard memory';
  FDescription := 'Up to 16MB RAM/ROM';
  FMemoryMode := pmReadWrite;
  Reset;
end;

// Destroy TMemory instance
destructor TStandardMemory.Destroy;
begin
  inherited Destroy;
end;

// Exportable function for create TMemory instance
function CreateMemory: TMemory; cdecl; export;
begin
  Result := TStandardMemory.Create;
end;

// Exportable function for destroy TMemory instance
procedure DestroyMemory(Memory: TMemory); cdecl; export;
begin
  if Assigned(Memory) then Memory.Free;
end;

// Exported functions and procedures
exports CreateMemory name 'memory_create';
exports DestroyMemory name 'memory_destroy';

begin
end.
