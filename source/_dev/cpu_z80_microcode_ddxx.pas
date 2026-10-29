{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_ddxx.pas                                               | }
{ | Microcode for Zilog Z80 CPU implementation module                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case AOC of

    $CB: begin
       // read offset byte
       b1 := FBus.ReadMemory(FRegs.PC);
       Inc(FRegs.PC);
       FLastInstruction.Operands[1] := b1;
       FLastInstruction.NumOperand := 1;
       // read opcode
       b2 := FBus.ReadMemory(FRegs.PC);
       Inc(FRegs.PC);
       FLastInstruction.Cycles := FLastInstruction.Cycles + 4;
       RunOpCode(b2, prDDCB);
     end;
  
  end;
