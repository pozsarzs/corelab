{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | microcode.pas                                                            | }
{ | Microcode for Intel 8085 CPU implementation module                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

    // RIM
    $20: begin
           FLastInstruction.Mnemonic := 'RIM';
           FLastInstruction.Cycles := 4;
         end;
    // SIM
    $30: begin
           FLastInstruction.Mnemonic := 'SIM';
           FLastInstruction.Cycles := 4;
         end;
