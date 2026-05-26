{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | zilogz80cpu.pas                                                          | }
{ | ZILOG Z80 CPU implementation module                                      | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library zilogz80cpu;
{$mode objfpc}{$H+}
uses
  Classes, SysUtils, core_cpu;
type
  TZ80Registers = record                                    { Z80 register set }
    case boolean of
      true: (
        BC, DE, HL, AF: word;
        BC2, DE2, HL2, AF2: word;
        IX, IY: word;
        PC, SP: word;
        IR: word
      );
      false: (
        C, B, E, D, L, H, F, A: byte;
        C2, B2, E2, D2, L2, H2, F2, A2: byte;
        IXL, IXH, IYL, IYH: byte;
        PCL, PCH, SPL, SPH: byte;
        R, I: byte
      );
  end;
type
  { Z80 CPU implementation }
  TZ80CPU = class(TCPU)
  protected
    FRegs: TZ80Registers;
  public
    constructor Create; override;
    procedure Reset; override;
    procedure Step; override;
    function GetRegister(const RegName: string): qword; override;
    procedure SetRegister(const RegName: string; Value: qword); override;
  end;

// TZ80CPU
constructor TZ80CPU.Create;
begin
  inherited Create;
  FName := 'Zilog Z80';
  FFamily := 'Z80';
  FBitWidth := 8;
  FAddressWidth := 16;
  FEndianness := enLittle;
  FHasSeparateIOBus := true;
  Reset;
end;

procedure TZ80CPU.Reset;
begin
  FillChar(FRegs, SizeOf(FRegs), 0);
  FRegs.PC := 0;
  FRegs.SP := $FFFF;
  FHalted := false;
  EmitEvent(ceReset);
end;

procedure TZ80CPU.Step;
var
  Opcode: byte;
  w: word;
begin
  Opcode := FBus.MemRead(FRegs.PC);                   { Fetch opcode from (PC) }
  Inc(FRegs.PC);                                    { Increment Program Counter}
  EmitEvent(ceInstructionBoundary);             { Notify debugger/trace system }
  with Fregs do
  begin
    case Opcode of
      $00: { NOP }
        begin
        end;
      $76: { HALT }
        begin
          FHalted := true;
          EmitEvent(ceHalt);
        end;

      $D9: {EXX}
        begin
          w := BC; BC := BC2; BC2 := w;
          w := DE; DE := DE2; DE2 := w;
          w := HL; HL := HL2; HL2 := w;
        end;
      $C6: {ADD A, n}
        begin
           Inc(FRegs.PC);                           { Increment Program Counter}
           w := FBus.MemRead(FRegs.PC);              { Fetch operand from (PC) }
           A := A + w;
           {ide jön a flag-ek kezelése}
           A := A And $00FF;
        end;

      {$I microcode/alu.inc}
      {$I microcode/bit.inc}
      {$I microcode/block.inc}
      {$I microcode/jump.inc}
      {$I microcode/load.inc}
      {$I microcode/misc.inc}
    end;
  end;
  Inc(FInstructions);                           { Increment Instruction Counter}
end;

function TZ80CPU.GetRegister(const RegName: string): qword;
begin
  Result := 0;
  case UpperCase(RegName) of
    'A':  Result := FRegs.A;
    'F':  Result := FRegs.F;
    'BC': Result := FRegs.BC;
    'DE': Result := FRegs.DE;
    'HL': Result := FRegs.HL;
    'IX': Result := FRegs.IX;
    'IY': Result := FRegs.IY;
    'PC': Result := FRegs.PC;
    'SP': Result := FRegs.SP;
  end;
end;

procedure TZ80CPU.SetRegister(const RegName: string; Value: qword);
begin
  case UpperCase(RegName) of
    'A':  FRegs.A := Value and $FF;
    'F':  FRegs.F := Value and $FF;
    'BC': FRegs.BC := Value and $FFFF;
    'DE': FRegs.DE := Value and $FFFF;
    'HL': FRegs.HL := Value and $FFFF;
    'IX': FRegs.IX := Value and $FFFF;
    'IY': FRegs.IY := Value and $FFFF;
    'PC': FRegs.PC := Value and $FFFF;
    'SP': FRegs.SP := Value and $FFFF;
  end;
end;

function CreateCPU: TCPU; {$IFDEF UNIX} cdecl; {$ELSE} stdcall; {$ENDIF} export;
begin
  Result := TZ80CPU.Create;
end;

exports CreateCPU {$IFDEF WIN32} name 'createcpu' {$ENDIF};

begin
end.
