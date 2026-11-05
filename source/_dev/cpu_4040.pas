{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_4040.pas                                                             | }
{ | Intel 4040 CPU implementation module                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library cpu_4040;
{$MODE OBJFPC}{$H+}{$Q-}{$R-}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, core_cpu, cpu_4004;
type
  { T4040CPU }
  T4040CPU = class(T4004CPU)
  private
  protected
  public
    constructor Create; override;
  end;

{ T4040CPU }
                                           
// ---- PROTECTED METHODS ----

// ---- PUBLIC METHODS ----

// CREATING A CPU INSTANCE 
constructor T4040CPU.Create;
begin
  inherited Create;
  // CPU identity information
  FModname := '4040';
  FDescription := 'Intel 4040 microprocessor';
  // CPU features
  FArchitecture := arHarvard;                            // Type of architecture
  FAddressWidth := 13;                              // Address bus width in bits
  FEndianness := enLittle;                                         // Byte order
  FMaxMemAddress := $FF;                    // The highest (data) memory address
  FMaxCodeAddress := $1FFF;                   // The highest code memory address
  FMaxIOPortAddress := $000F;                    // The highest I/O port address
  FHasSeparateIOBus := true;          // Indicates separate memory and I/O buses
  FDefaultClockFreq := 500000; {500 kHz}             // original clock frequency
  FTestPin := True;                                      // active low input pin
  // Reset CPU
  // Reset;
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreateCPU: TCPU; CALLTYPE; export;
begin
  Result := T4040CPU.Create;
end;

procedure DestroyCPU(APort: TCPU); CALLTYPE; export;
begin
  if Assigned(APort) then APort.Free;
end;

function LoadState(APort: TCPU; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.LoadState(AStream)
    else Result := false;
end;

function SaveState(APort: TCPU; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.SaveState(AStream)
    else Result := false;
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreateCPU name 'cpu_create';
exports DestroyCPU name 'cpu_destroy';
exports LoadState name 'cpu_loadstate';
exports SaveState name 'cpu_savestate';

end.
