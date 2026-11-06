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
    procedure RunOpCode(AOC: Byte); override;
  public
    constructor Create; override;
    function GetRegister(const RegName: PChar): Word; override;
    procedure SetRegister(const RegName: PChar; Value: Word); override;
    function GetRegisterCount: Byte; override;
    function GetRegisterName(AIndex: Byte): PChar; override;
    function GetRegisterSize(AIndex: Byte): Byte; override;
  end;
const
  PubRegNames4040: array[0..25] of PChar = ('R0',  'R1',  'R2',  'R3',
                                            'R4',  'R5',  'R6',  'R7',
                                            'R8',  'R9',  'R10', 'R11',
                                            'R12', 'R13', 'R14', 'R15',
                                            'R16', 'R17', 'R18', 'R19',
                                            'R20', 'R21', 'R22', 'R23',
                                            'A',   'PC');
  PubRegSize4040:  array[0..25] of Byte  = (1, 1, 1, 1, 1, 1, 1, 1,
                                            1, 1, 1, 1, 1, 1, 1, 1,
                                            1, 1, 1, 1, 1, 1, 1, 1,
                                            1, 3);

{ T4040CPU }
                                           
// ---- PROTECTED METHODS ----

// RUN SPECIFIED OPCODE
procedure T4040CPU.RunOpCode(AOC: Byte);
var
  b1: Byte;
begin
  case AOC of
    {$I cpu_4040_microcode.pas}
  else
    inherited RunOpCode(AOC);
  end;  
end;

// ---- PUBLIC METHODS ----

// CREATING A CPU INSTANCE 
constructor T4040CPU.Create;
begin
  inherited Create;
  // base sets
  SetLength(FStack.Regs, 7);
  SetLength(FRegs.R, 24);
  FPCMask := $1FFF;
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
  Reset;
end;

// QUERYING REGISTERS
function T4040CPU.GetRegister(const RegName: PChar): Word;
var
  b: Byte;
  s: string[3];
begin
  Result := 0;
  s := UpperCase(StrPas(RegName));
  if s = 'A' then Result := FRegs.A else
  begin
    if s[1] = 'R' then
    begin
      Delete(s, 1, 1);
      for b := 0 to 23 do
        if StrToInt(s) = b then Result := FRegs.R[b];
    end;
  end;
end;

// SETTING REGISTERS
procedure T4040CPU.SetRegister(const RegName: PChar; Value: Word);
var
  b: Byte;
  s: string[3];
begin
  s := UpperCase(StrPas(RegName));
  if s = 'A' then FRegs.A := Byte(Value) and $0F else
  begin
    if s[1] = 'R' then
    begin
      Delete(s, 1, 1);
      for b := 0 to 23 do
        if StrToInt(s) = b then FRegs.R[b] := Byte(Value) and $0F;
    end;
  end;
end;

// QUERYING NUMBER OF THE ALL REGISTERS
function T4040CPU.GetRegisterCount: Byte;
begin
  Result := Length(PubRegNames4040);
end;

// QUERYING REGISTER NAME
function T4040CPU.GetRegisterName(AIndex: Byte): PChar;
begin
  if AIndex < Length(PubRegNames4040) then Result := PubRegNames4040[AIndex] else Result := nil;
end;

// QUERYING REGISTER SIZE IN NIBBLES
function T4040CPU.GetRegisterSize(AIndex: Byte): Byte;
begin
  if AIndex < Length(PubRegSize4040) then Result := PubRegSize4040[AIndex] else Result := 0;
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
