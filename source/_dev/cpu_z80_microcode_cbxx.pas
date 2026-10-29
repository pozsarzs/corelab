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
    $00..$07: begin
                // RLC r; RLC M
              end;
    $08..$0F: begin
                // RRC r; RRC M
              end;
    $10..$17: begin
                // RL r; RL M
              end;
    $18..$1F: begin
                // RR r; RR M
              end;
    $20..$27: begin
                // SLA r; SLA M
              end;
    $28..$2F: begin
                // SRA r; SRA M
              end;
    $30..$37: begin
                // SLL r; SLL M
              end;
    $38..$3F: begin
                // SRL r; SRL M
              end;
    $40..$7F: begin
                // BIT n, r; BIT n, M
              end;
    $80..$BF: begin
                // RES n, r; RES n, M
              end;
    $C0..$FF: begin
                // SET n, r; SET n, M
              end;
  end;
