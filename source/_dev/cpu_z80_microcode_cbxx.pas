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
                // RLC r, RLC M
              end;
    $08..$0F: begin
                // RRC r, RRC M
              end;
    $10..$17: begin
                // RL r, RL M
              end;
    $18..$1F: begin
                // RR r, RR M
              end;
    $20..$27: begin
                // SLA r, SLA M
              end;
    $28..$2F: begin
                // SRA r, SRA M
              end;
  
  end;
