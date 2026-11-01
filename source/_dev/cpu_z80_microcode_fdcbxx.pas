{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_fdcbxx.pas                                             | }
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
    // RLC r; RLC (IY+r8)
    $00..$07: begin
              // |SZY0XP0C|12, 23
              end;
    // RRC r; RRC (IY+r8)
    $08..$0F: begin
              // |SZY0XP0C|12, 23
              end;
    // RL r; RL (IY+r8)
    $10..$17: begin
              // |SZY0XP0C|12, 23
              end;
    // RR r; RR (IY+r8)
    $18..$1F: begin
              // |SZY0XP0C|12, 23
              end;
    // SLA r; SLA (IY+r8)
    $20..$27: begin
              // |SZY0XP0C|12, 23
              end;
    // SRA r; SRA (IY+r8)
    $28..$2F: begin
              // |SZY0XP0C|12, 23
              end;
    // SLL r; SLL (IY+r8)
    $30..$37: begin
              // |SZY0XP0C|12, 23
              end;
    // SRL r; SRL (IY+r8)
    $38..$3F: begin
              // |SZY0XP0C|12, 23
              end;
    // BIT n, r; BIT n, (IY+r8)
    $40..$7F: begin
              // |SZY1XU0-|12, 20
              end;
    // RES n, r; RES n, (IY+r8)
    $80..$BF: begin
              // 12, 20
              end;
    // SET n, r; SET n, (IY+r8)
    $C0..$FF: begin
              // 12, 23
              end;
  end;
