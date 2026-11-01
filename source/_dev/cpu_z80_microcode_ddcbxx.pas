{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_ddcbxx.pas                                             | }
{ | Microcode for Zilog Z80 CPU implementation module                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  // store prefix for log
  with FLastInstruction do
  begin
    NumPrefix := 1;
    Prefixes[NumPrefix] := OpCode
  end;
  // instructions
  case AOC of
    // RLC r; RLC (IX+r8)
    $00..$07: begin
              // |SZY0XP0C|12, 23
              end;
    // RRC r; RRC (IX+r8)
    $08..$0F: begin
              // |SZY0XP0C|12, 23
              end;
    // RL r; RL (IX+r8)
    $10..$17: begin
              // |SZY0XP0C|12, 23
              end;
    // RR r; RR (IX+r8)
    $18..$1F: begin
              // |SZY0XP0C|12, 23
              end;
    // SLA r; SLA (IX+r8)
    $20..$27: begin
              // |SZY0XP0C|12, 23
              end;
    // SRA r; SRA (IX+r8)
    $28..$2F: begin
              // |SZY0XP0C|12, 23
              end;
    // SLL r; SLL (IX+r8)
    $30..$37: begin
              // |SZY0XP0C|12, 23
              end;
    // SRL r; SRL (IX+r8)
    $38..$3F: begin
              // |SZY0XP0C|12, 23
              end;
    // BIT n, r; BIT n, (IX+r8)
    $40..$7F: begin
              // |SZY1XU0-|12, 20
              end;
    // RES n, r; RES n, (IX+r8)
    $80..$BF: begin
              // 12, 20
              end;
    // SET n, r; SET n, (IX+r8)
    $C0..$FF: begin
              // 12, 23
              end;
  end;
