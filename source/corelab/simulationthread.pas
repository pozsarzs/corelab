{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | simulationthread.pas                                                     | }
{ | Thread for simulation                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit simulationthread;
interface
{$MODE OBJFPC}{$H+}
uses
  Classes, {$IFDEF UNIX}cthreads;{$ENDIF}
type
  // simulation state type
  TSimulationMode = (smNone, smCPURun, smCPUStep, smCPUStop);
  { TSimulationThread }
  TSimulationThread = class(TThread)
  private
    FMode: TSimulationMode;
  protected
    procedure Execute; override;
  public
    procedure CPURun;
    procedure CPUStep;
    procedure CPUStop;
  end;

implementation

{ TSimulationThread }

// RUN SIMULATION
procedure TSimulationThread.CPURun;
begin
end;

// STEP SIMULATION
procedure TSimulationThread.CPUStep;
begin
end;

// REQUEST STOP SIMULATION
procedure TSimulationThread.CPUStop;
begin
end;

procedure TSimulationThread.Execute;
begin
end;

end.
