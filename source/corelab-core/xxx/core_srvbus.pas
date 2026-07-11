{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_srvbus.pas                                                          | }
{ | Service bus abstraction module                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_srvbus;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, core_cpu, core_memory, core_ioport;
type
  // Service bus base class
  TSrvBus = class(TInterfacedObject, ICPUBus)
  protected
    FCodeMemory: TMemory;                        // Connected code memory module
    FDataMemory: TMemory;                      // Connected (data) memory module
    FIOPorts:    TIOPort;                                // Connected I/O module
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
  end;

implementation

// CREATE TSRVBUS INSTANCE
constructor TSrvBus.Create;
begin
  inherited Create;
  FCodeMemory := Nil;
  FDataMemory := Nil;
  FIOPorts := Nil;
end;

// DESTROY TSRVBUS INSTANCE
destructor TSrvBus.Destroy;
begin
  inherited Destroy;
end;
