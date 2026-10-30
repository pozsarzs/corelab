{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_cbxx.pas                                               | }
{ | Microcode for Zilog Z80 CPU implementation module                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case AOC of
    // RLC r; RLC M
    $00..$07: begin
              end;
    // RRC r; RRC M
    $08..$0F: begin
              end;
    // RL r; RL M
    $10..$17: begin
              end;
    // RR r; RR M
    $18..$1F: begin
              end;
    // SLA r; SLA M
    $20..$27: begin
              end;
    // SRA r; SRA M
    $28..$2F: begin
              end;
    // SLL r; SLL M
    $30..$37: begin
              end;
    // SRL r; SRL M
    $38..$3F: begin
              end;
    // BIT n, r; BIT n, M
    $40..$7F: begin
              end;
    // RES n, r; RES n, M
    $80..$BF: begin
              end;
    // SET n, r; SET n, M
    $C0..$FF: begin
              end;
  end;
