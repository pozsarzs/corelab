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
  Classes, {$IFDEF UNIX}cthreads,{$ENDIF} core_cpu;
type
  // simulation state type
  TSimulationMode = (smNone, smCPURun, smCPUStep, smCPUStop);
  { TSimulationThread }
  TSimulationThread = class(TThread)
  private
    FCPU:   TCPU;                                                   // processor
    FDelay: Integer;                              // Running delay between steps
    FEvent: PRTLEvent;                                      // event for wake up
    FMode:  TSimulationMode;                                 // simulation state
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CPURun;
    procedure CPUStep;
    procedure CPUStop;
    property CPU: TCPU write FCPU;
    property Mode: TSimulationMode read FMode;
    property Delay: Integer read FDelay write FDelay;
  end;

implementation

{ TSimulationThread }

// CREATE INSTANCE
constructor TSimulationThread.Create;
begin
  inherited Create(True);
  FCPU := nil;
  FDelay := 1000;
  FEvent := RTLEventCreate;
  FMode := smNone;
end;

//DESTROY INSTANCE
destructor TSimulationThread.Destroy;
begin
  Terminate;
  RTLEventSetEvent(FEvent);
  WaitFor;
  RTLEventDestroy(FEvent);
  inherited Destroy;
end;

// RUN SIMULATION
procedure TSimulationThread.CPURun;
begin
  FMode := smCPURun;
  RTLEventSetEvent(FEvent);
end;

// STEP SIMULATION
procedure TSimulationThread.CPUStep;
begin
  FMode := smCPUStep;
  RTLEventSetEvent(FEvent);
end;

// REQUEST STOP SIMULATION
procedure TSimulationThread.CPUStop;
begin
  FMode := smCPUStop;
  RTLEventSetEvent(FEvent);
end;

// EXECUTE THREAD
procedure TSimulationThread.Execute;
begin
  while not Terminated do
  begin
    // wait for event
    RTLEventWaitFor(FEvent);
    // run
    if FMode = smCPURun then
    begin
      while FMode = smCPURun do
      begin
        FCPU.Step;
        Sleep(FDelay);
      end;
    end else
    begin
      // step
      if FMode = smCPUStep then
      begin
        FCPU.Step;
        FMode := smNone;
      end;
      // stop
      if FMode = smCPUStop then
      begin
        FCPU.Stop;
        FMode := smNone;
      end;
      // clear previous event
      RTLEventResetEvent(FEvent);
    end;
  end;
end;

end.

