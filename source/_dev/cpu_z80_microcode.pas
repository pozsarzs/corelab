{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode.pas                                                    | }
{ | Microcode for Zilog Z80 CPU implementation module                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case AOC of  
    // NOP
    $00: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 4;
         end;
    // LD BC, d16
    $01: begin
           FLastInstruction.Mnemonic := 'LD BC';
           FLastInstruction.NumOperand := 1;
           FRegs.C := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.B := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := Fregs.BC;
           FLastInstruction.Cycles := 10;
         end;
    // LD (BC), A
    $02: begin
           FLastInstruction.Mnemonic := 'LD (BC), A';
           FBus.WriteMemory(FRegs.BC, FRegs.A);
           FLastInstruction.Cycles := 7;
         end;
    // INC BC
    $03: begin
           FLastInstruction.Mnemonic:='INC BC';
           Inc(FRegs.BC);
           FLastInstruction.Cycles := 6;
         end;
    // RLCA
    $07: begin
           FLastInstruction.Mnemonic := 'RLCA';
           b1 := FRegs.A shr 7; { A 7. bit }
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FRegs.F := (FRegs.F and $FE) or b1;                    { CY refresh }
           FLastInstruction.Cycles := 4;
         end;
    // LD A, (BC)
    $0A: begin
           FLastInstruction.Mnemonic:='LD A, (BC)';
           FRegs.A := FBus.ReadMemory(FRegs.BC);
           FLastInstruction.Cycles := 7;
         end;
    // DEC BC
    $0B: begin
           FLastInstruction.Mnemonic:='DEC BC';
           Dec(FRegs.BC);
           FLastInstruction.Cycles := 6;
         end;
    // RRCA
    $0F: begin
           FLastInstruction.Mnemonic := 'RRCA';
           b1 := FRegs.A and $01; { A 0. bit }
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FRegs.F := (FRegs.F and $FE) or b1;
           FLastInstruction.Cycles := 4;
         end;
    // LD DE, d16
    $11: begin
           FLastInstruction.Mnemonic := 'LD DE';
           FLastInstruction.NumOperand := 1;
           FRegs.E := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.D := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := Fregs.DE;
           FLastInstruction.Cycles := 10;
         end;
    // LD (DE), A
    $12: begin
           FLastInstruction.Mnemonic := 'LD (DE), A';
           FBus.WriteMemory(FRegs.DE, FRegs.A);
           FLastInstruction.Cycles := 7;
         end;
    // INC DE
    $13: begin
           FLastInstruction.Mnemonic:='INC DE';
           Inc(FRegs.DE);
           FLastInstruction.Cycles := 6;
         end;
    // RLA
    $17: begin
           FLastInstruction.Mnemonic := 'RLA';
           b1 := FRegs.F and $01;
           b2 := FRegs.A shr 7;
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FRegs.F := (FRegs.F and $FE) or b2;
           FLastInstruction.Cycles := 4;
         end;         
    // LD A,(DE)
    $1A: begin
           FLastInstruction.Mnemonic:='LD A,(DE)';
           FRegs.A := FBus.ReadMemory(FRegs.DE);
           FLastInstruction.Cycles := 7;
         end;
    // DEC DE
    $1B: begin
           FLastInstruction.Mnemonic:='DEC DE';
           Dec(FRegs.DE);
           FLastInstruction.Cycles := 6;
         end;
    // RRA
    $1F: begin
           FLastInstruction.Mnemonic := 'RRA';
           b1 := FRegs.F and $01;
           b2 := FRegs.A and $01;
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FRegs.F := (FRegs.F and $FE) or b2;
           FLastInstruction.Cycles := 4;
         end;
    // LD HL, d16
    $21: begin
           FLastInstruction.Mnemonic := 'LD HL';
           FLastInstruction.NumOperand := 1;
           FRegs.L := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.H := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := FRegs.HL;
           FLastInstruction.Cycles := 10;
         end;
    // LD (a16), HL
    $22: begin
           FLastInstruction.Mnemonic:='LD (%.4X), HL';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FBus.WriteMemory(w1, FRegs.L);
           FBus.WriteMemory(w1 + 1, FRegs.H);
           FLastInstruction.Cycles := 16;
         end;
    // INC HL
    $23: begin
           FLastInstruction.Mnemonic:='INC HL';
           Inc(FRegs.HL);
           FLastInstruction.Cycles := 6;
         end;
    // LD HL,(a16)
    $2A: begin
           FLastInstruction.Mnemonic:='LD HL, (%.4X)';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.L := FBus.ReadMemory(w1);
           FRegs.H := FBus.ReadMemory(w1 + 1);
           FLastInstruction.Cycles := 16;
         end;
    // DEC HL
    $2B: begin
           FLastInstruction.Mnemonic:='DEC HL';
           Dec(FRegs.HL);
           FLastInstruction.Cycles := 6;
         end;
    // CPL
    $2F: begin
           FLastInstruction.Mnemonic := 'CPL';
           FRegs.A := FRegs.A xor $FF;
           FLastInstruction.Cycles := 4;
         end;
    // LD SP, d16
    $31: begin
           FLastInstruction.Mnemonic := 'LD SP';
           FLastInstruction.NumOperand := 1;
           FRegs.SPL := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.SPH := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := Fregs.SP;
           FLastInstruction.Cycles := 10;
         end;
    // LD (a16), A
    $32: begin
           FLastInstruction.Mnemonic:='LD (%.4X), A';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FBus.WriteMemory(w1, FRegs.A);
           FLastInstruction.Cycles := 13;
         end;
    // INC SP
    $33: begin
           FLastInstruction.Mnemonic:='INC SP';
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 6;
         end;
    // SCF
    $37: begin
           FLastInstruction.Mnemonic := 'SCF';
           FRegs.F := FRegs.F or $01;
           FLastInstruction.Cycles := 4;
         end;
    // LD A, (a16)
    $3A: begin
           FLastInstruction.Mnemonic:='LD A, (%.4X)';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.A := FBus.ReadMemory(w1);
           FLastInstruction.Cycles := 13;
         end;
    // DEC SP
    $3B: begin
           FLastInstruction.Mnemonic:='DEC SP';
           Dec(FRegs.SP);
           FLastInstruction.Cycles := 6;
         end;
    // CCF
    $3F: begin
           FLastInstruction.Mnemonic := 'CCF';
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 4;
         end;
    // HALT
    $76: begin
           FLastInstruction.Mnemonic := 'HALT';
           FHalted := true;
           EmitEvent(ceHalt);
           FLastInstruction.Cycles := 4;
         end;
    // RET NZ
    $C0: begin
           FLastInstruction.Mnemonic := 'RET NZ';
           if (FRegs.F and $40) = 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 11;
           end else FLastInstruction.Cycles := 5;
         end;
    // POP BC
    $C1: begin
           FLastInstruction.Mnemonic := 'POP BC';
           FRegs.C := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.B := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JP NZ, a16
    $C2: begin
           FLastInstruction.Mnemonic := 'JP NZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $40) = 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // JP a16
    $C3: begin
           FLastInstruction.Mnemonic := 'JP';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // CALL NZ, a16
    $C4: begin
           FLastInstruction.Mnemonic := 'CALL NZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $40) = 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 10;
         end;
    // PUSH BC
    $C5: begin
           FLastInstruction.Mnemonic := 'PUSH BC';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.B);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.C);
           FLastInstruction.Cycles := 11;
         end;
    // ADD A, d8
    $C6: begin
           FLastInstruction.Mnemonic := 'ADD A';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := Fregs.A;
           w1 := b2 + b1;
           Fregs.A := w1 and $00FF;
           UpdateFlags(w1, b2, b1, False, False);
           FLastInstruction.Cycles := 7;
         end;
    // RET Z
    $C8: begin
           FLastInstruction.Mnemonic := 'RET Z';
           if (FRegs.F and $40) > 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 11;
           end else FLastInstruction.Cycles := 5;
         end;
    // RET
    $C9: begin
           FLastInstruction.Mnemonic := 'RET';
           w1 := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
           Inc(FRegs.SP);
           FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // JP Z, a16
    $CA: begin
           FLastInstruction.Mnemonic := 'JP Z';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $40) > 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // PREFIX CB
    $CB: begin
           // read next byte (opcode)
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Cycles := FLastInstruction.Cycles + 4;
           RunOpCode(b1, prCB);
         end;
    // CALL Z, a16
    $CC: begin
           FLastInstruction.Mnemonic := 'CALL Z';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $40) > 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 11;
         end;
    // CALL a16
    $CD: begin
           FLastInstruction.Mnemonic := 'CALL';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.PCH);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.PCL);
           FRegs.PC := w1;
           FLastInstruction.Cycles := 17;
         end;
    // ADC A, d8
    $CE: begin
           FLastInstruction.Mnemonic := 'ADC A';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           b1 := FRegs.A;
           b2 := FRegs.F and $01;
           w2 := b1 + w1 + b2;
           FRegs.A := w2 and $00FF;
           UpdateFlags(w2, b1, w1 + b2, False, False);
           FLastInstruction.Cycles := 7;
         end;
    // RET NC
    $D0: begin
           FLastInstruction.Mnemonic := 'RET NC';
           if (FRegs.F and $01) = 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 11;
           end else FLastInstruction.Cycles := 5;
         end;
    // POP DE
    $D1: begin
           FLastInstruction.Mnemonic := 'POP DE';
           FRegs.E := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.D := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JP NC, a16
    $D2: begin
           FLastInstruction.Mnemonic := 'JP NC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $01) = 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // OUT (d8), A
    $D3: begin
           FLastInstruction.Mnemonic := 'OUT (%.2X), A';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FBus.WritePort(b1, Fregs.A);
           FLastInstruction.Cycles := 11;
         end;
    // CALL NC, a16
    $D4: begin
           FLastInstruction.Mnemonic := 'CALL NC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $01) = 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 10;
         end;
    // PUSH DE
    $D5: begin
           FLastInstruction.Mnemonic := 'PUSH DE';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.D);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.E);
           FLastInstruction.Cycles := 11;
         end;
    // SUB d8
    $D6: begin
           FLastInstruction.Mnemonic := 'SUB';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           w1 := b2 - b1;
           Fregs.A := w1 and $00FF;
           UpdateFlags(b2 + (b1 xor $FF) + 1, b2, b1 xor $FF, True, False);
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 7;
         end;
    // RET C
    $D8: begin
           FLastInstruction.Mnemonic := 'RET C';
           if (FRegs.F and $01) > 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 11;
           end else FLastInstruction.Cycles := 5;
         end;
    // EXX
    $D9: begin
           FLastInstruction.Mnemonic := 'EXX';
           Fregs.PC := Fregs.HL;
           FLastInstruction.Cycles := 4;
         end;
    // JP C, a16
    $DA: begin
           FLastInstruction.Mnemonic := 'JP C';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $01) > 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // IN A, (d8)
    $DB: begin
           FLastInstruction.Mnemonic := 'IN A, (%.2X)';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FRegs.A := FBus.ReadPort(b1);
           FLastInstruction.Cycles := 10;
         end;
    // CALL C, a16
    $DC: begin
           FLastInstruction.Mnemonic := 'CALL C';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $01) > 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 10;
         end;
    // PREFIX DD
    $DD: begin
           // read next byte (opcode)
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Cycles := FLastInstruction.Cycles + 4;
           RunOpCode(b1, prDD);
         end;
    // SBC A, d8
    $DE: begin
           FLastInstruction.Mnemonic := 'SBC A';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           b1 := FRegs.A;
           b2 := FRegs.F and $01;
           w2 := b1 - w1 - b2;
           FRegs.A := w2 and $00FF;
           UpdateFlags(b1 + ((w1 + b2) xor $FF) + 1, b1, (w1 + b2) xor $FF, True, False);
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 7;
         end;
    // RET PO
    $E0: begin
           FLastInstruction.Mnemonic := 'RET PO';
           if (FRegs.F and $04) = 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 11;
           end else FLastInstruction.Cycles := 5;
         end;
    // POP HL
    $E1: begin
           FLastInstruction.Mnemonic := 'POP HL';
           FRegs.L := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.H := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JP PO, a16
    $E2: begin
           FLastInstruction.Mnemonic := 'JP PO';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $04) = 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // EX (SP),HL
    $E3: begin
           FLastInstruction.Mnemonic := 'EX (SP),HL';
           // L <-> [SP]
           b1 := FBus.ReadMemory(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.L);
           FRegs.L := b1;
           
           // H <-> [SP + 1]
           b2 := FBus.ReadMemory(FRegs.SP + 1);
           FBus.WriteMemory(FRegs.SP + 1, FRegs.H);
           FRegs.H := b2;
           FLastInstruction.Cycles := 18;
         end;
    // CALL PO, a16
    $E4: begin
           FLastInstruction.Mnemonic := 'CALL PO';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $04) = 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 10;
         end;
    // PUSH HL
    $E5: begin
           FLastInstruction.Mnemonic := 'PUSH HL';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.H);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.L);
           FLastInstruction.Cycles := 11;
         end;
    // AND d8
    $E6: begin
           FLastInstruction.Mnemonic := 'AND';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           Fregs.A := Fregs.A and b1;
           UpdateFlags(FRegs.A, b2, b2, False, True);
           FRegs.F := (FRegs.F and $FE) or $10;
           FLastInstruction.Cycles := 7;
         end;
    // RET PE
    $E8: begin
           FLastInstruction.Mnemonic := 'RET PE';
           if (FRegs.F and $04) > 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 11;
           end else FLastInstruction.Cycles := 5;
         end;
    // JP PE, a16
    $EA: begin
           FLastInstruction.Mnemonic := 'JP PE';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $04) > 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // EX DE, HL
    $EB: begin
           FLastInstruction.Mnemonic := 'EX DE, HL';
           with FRegs do
           begin
             w1 := DE; DE := HL; HL := w1;
           end;
           FLastInstruction.Cycles := 4;
         end;
    // CALL PE, a16
    $EC: begin
           FLastInstruction.Mnemonic := 'CALL PE';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $04) > 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 10;
         end;
    // PREFIX ED
    $ED: begin
           // read next byte (opcode)
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Cycles := FLastInstruction.Cycles + 4;
           RunOpCode(b1, prED);
         end;
    // XOR d8
    $EE: begin
           FLastInstruction.Mnemonic := 'XOR';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           Fregs.A := Fregs.A xor b1;
           UpdateFlags(FRegs.A, b2, b2, False, True);
           FRegs.F := FRegs.F and $EE;
           FLastInstruction.Cycles := 7;
         end;
    // RET P
    $F0: begin
           FLastInstruction.Mnemonic := 'RET P';
           if (FRegs.F and $80) = 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 5;
         end;
    // POP AF
    $F1: begin
           FLastInstruction.Mnemonic := 'POP AF';
           FRegs.F := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.A := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JP P, a16
    $F2: begin
           FLastInstruction.Mnemonic := 'JP P';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $10) = 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // DI
    $F3: begin
           FLastInstruction.Mnemonic := 'DI';
           FInterruptEnabled := false;
           FInterruptEnabled2 := false;
           FLastInstruction.Cycles := 4;
         end;
    // CALL P, a16
    $F4: begin
           FLastInstruction.Mnemonic := 'CALL P';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $80) = 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 11;
         end;
    // PUSH AF
    $F5: begin
           FLastInstruction.Mnemonic := 'PUSH AF';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.A);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.F);
           FLastInstruction.Cycles := 11;
         end;
    // OR d8
    $F6: begin
           FLastInstruction.Mnemonic := 'OR';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           Fregs.A := Fregs.A or b1;
           UpdateFlags(FRegs.A, b2, b2, False, True);
           FRegs.F := FRegs.F and $EE;
           FLastInstruction.Cycles := 7;
         end;
    // RET M
    $F8: begin
           FLastInstruction.Mnemonic := 'RET M';
           if (FRegs.F and $80) = 0 then
           begin
             w1 := FBus.ReadMemory(FRegs.SP);
             Inc(FRegs.SP);
             w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
             Inc(FRegs.SP);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 11;
           end else FLastInstruction.Cycles := 5;
         end;
    // LD SP, HL
    $F9: begin
           FLastInstruction.Mnemonic := 'LD SP, HL';
           Fregs.SP := Fregs.HL;
           FLastInstruction.Cycles := 6;
         end;
    // JP M, a16
    $FA: begin
           FLastInstruction.Mnemonic := 'JP M';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $10) > 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // EI
    $FB: begin
           FLastInstruction.Mnemonic := 'EI';
           FInterruptEnabled := true;
           FInterruptEnabled2 := true;
           FLastInstruction.Cycles := 4;
         end;
    // CALL M, a16
    $FC: begin
           FLastInstruction.Mnemonic := 'CALL M';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $80) > 0 then
           begin
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCH);
             Dec(FRegs.SP);
             FBus.WriteMemory(FRegs.SP, FRegs.PCL);
             FRegs.PC := w1;
             FLastInstruction.Cycles := 17;
           end else FLastInstruction.Cycles := 10;
         end;
    // PREFIX FD
    $FD: begin
           // read next byte (opcode)
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Cycles := FLastInstruction.Cycles + 4;
           RunOpCode(b1, prFD);
         end;
    // CP d8
    $FE: begin
           FLastInstruction.Mnemonic := 'CP';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           UpdateFlags(b2 + (b1 xor $FF) + 1, b2, b1 xor $FF, True, False);
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 7;
         end;
   else  
    // INC r; INC (HL)
    // $04, $14, $24, $34, $0C, $1C, $2C, $3C
    if (AOC <= $3F) and ((AOC and $07) = $04) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'INC ' + RegNames[DestRegIndex];
      b1 := FRegs.F and $01;                                     { store Carry }
      if DestRegIndex = 6 then
      begin
        // INC (HL)
        b2 := FBus.ReadMemory(FRegs.HL);
        w1 := (b2 + 1) and $FF;
        FBus.WriteMemory(FRegs.HL, w1);
        UpdateFlags(w1, b2, 1, False, False);
        FLastInstruction.Cycles := 10;
      end else
      begin
        // INC r
        b2 := RegPointers[DestRegIndex]^;
        Inc(RegPointers[DestRegIndex]^);
        UpdateFlags(RegPointers[DestRegIndex]^, b2, 1, False, False);
        FLastInstruction.Cycles := 5;
      end;
      FRegs.F := (FRegs.F and $FE) or b1;                      { restore Carry }
    end;
    // DEC r; DEC (HL)
    // $05, $15, $25, $35, $0D, $1D, $2D, $3D
    if (AOC <= $3F) and ((AOC and $07) = $05) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'DEC ' + RegNames[DestRegIndex];
      b1 := FRegs.F and $01;                                     { store Carry }
      if DestRegIndex = 6 then
      begin
        // DEC (HL)
        b2 := FBus.ReadMemory(FRegs.HL);
        w1 := (b2 - 1) and $FF;
        FBus.WriteMemory(FRegs.HL, w1);
        UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF, True, False);
        FLastInstruction.Cycles := 10;
      end else
      begin
        // DEC r
        b2 := RegPointers[DestRegIndex]^;
        Dec(RegPointers[DestRegIndex]^);
        UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF, True, False);
        FLastInstruction.Cycles := 5;
      end;
      FRegs.F := (FRegs.F and $FE) or b1;                      { restore Carry }
    end;
    // LD r, d8; LD (HL), d8
    // $06, $16, $26, $36, $0E, $1E, $2E, $3E
    if (AOC <= $3F) and ((AOC and $07) = $06) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'LD ' + RegNames[DestRegIndex];
      FLastInstruction.NumOperand := 1;
      b1 := FBus.ReadMemory(FRegs.PC);
      Inc(FRegs.PC);
      FLastInstruction.Operands[1] := b1;
      if DestRegIndex = 6 then
      begin
        FBus.WriteMemory(FRegs.HL, b1);                          { LD (HL), d8 }
        FLastInstruction.Cycles := 10;
      end else
      begin
        RegPointers[DestRegIndex]^ := b1;                           { LD r, d8 }
        FLastInstruction.Cycles := 7;
      end;
    end;
    // ADD rp
    // $09, $19, $29, $39)
    if (AOC <= $3F) and ((AOC and $0F) = $09) then
    begin
      SourceRegIndex := (AOC shr 4) and $03;
      case SourceRegIndex of
        0: begin FLastInstruction.Mnemonic := 'ADD HL, BC'; w1 := FRegs.BC; end;
        1: begin FLastInstruction.Mnemonic := 'ADD HL, DE'; w1 := FRegs.DE; end;
        2: begin FLastInstruction.Mnemonic := 'ADD HL, HL'; w1 := FRegs.HL; end;
        3: begin FLastInstruction.Mnemonic := 'ADD HL, SP'; w1 := FRegs.SP; end;
      end;
      dw1 := Cardinal(FRegs.HL) + Cardinal(w1);
      FRegs.HL := dw1 and $FFFF;
      if (dw1 and $10000) <> 0 
        then FRegs.F := FRegs.F or $01
        else FRegs.F := FRegs.F and $FE;
      FLastInstruction.Cycles := 10;
    end;
    // LD r1, r2; LD (HL), r1; LD r1, (HL)
    // $40-$7F
    if (AOC >= $40) and (AOC <= $7F) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'LD ' +
                            RegNames[DestRegIndex] + ', ' +
                            RegNames[SourceRegIndex];
      if (DestRegIndex = 6) and (SourceRegIndex = 6) then {HLT} else
        if DestRegIndex = 6
          then FBus.WriteMemory(FRegs.HL, RegPointers[SourceRegIndex]^) {LD (HL), r} else
	  if SourceRegIndex = 6
            then RegPointers[DestRegIndex]^ := FBus.ReadMemory(FRegs.HL) {LD r, (HL)}
            else RegPointers[DestRegIndex]^ := RegPointers[SourceRegIndex]^; {LD r1, r2}
      if (AOC = $46) or (AOC = $4E) or 
         (AOC = $56) or (AOC = $5E) or 
         (AOC = $66) or (AOC = $6E) or 
         (AOC = $77) or (AOC = $7E) or 
         ((AOC >= $70) and (AOC <= $75))
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 5;
    end;
    // ADD r
    // $80-$87
    if (AOC >= $80) and (AOC <= $87) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'ADD ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 + w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2, b1, w1, False, False);
      if AOC = $86
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // ADC r
    // $88-$8F
    if (AOC >= $88) and (AOC <= $8F) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'ADC ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := FRegs.F and $01;
      w2 := b1 + w1 + b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2, b1, w1 + b2, False, False);
      if AOC = $8E
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // SUB r
    // $90-$97
    if (AOC >= $90) and (AOC <= $97) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'SUB ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF, True, False);
      FRegs.F := FRegs.F xor $01;
      if AOC = $96
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // SBC r
    // $98-$9F
    if (AOC >= $98) and (AOC <= $9F) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'SBC ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := FRegs.F and $01;
      w2 := b1 - w1 - b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(b1 + ((w1 + b2) xor $FF) + 1, b1, (w1 + b2) xor $FF, True, False);
      FRegs.F := FRegs.F xor $01;
      if AOC = $9E
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // AND r
    // $A0-$A7
    if (AOC >= $A0) and (AOC <= $A7) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'AND ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.ReadMemory(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A and b1;
      UpdateFlags(FRegs.A, b2, b2, False, True);
      FRegs.F := (FRegs.F and $FE) or $10;
      if AOC = $A6
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // XOR r
    // $A8-$AF
    if (AOC >= $A8) and (AOC <= $AF) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'XOR ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.ReadMemory(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A xor b1;
      UpdateFlags(FRegs.A, b2, b2, False, True);
      FRegs.F := FRegs.F and $EE;
      if AOC = $AE
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // OR r
    // $B0-$B7
    if (AOC >= $B0) and (AOC <= $B7) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'OR ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.ReadMemory(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A or b1;
      UpdateFlags(FRegs.A, b2, b2, False, True);
      FRegs.F := FRegs.F and $EE;
      if AOC = $B6
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // CP r
    // $B8-$BF
    if (AOC >= $B8) and (AOC <= $BF) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'CP ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF, True, False);
      FRegs.F := FRegs.F xor $01;
      if AOC = $BE
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // RST n
    // $C7, $D7, $E7, $F7, $CF, $DF, $EF, $FF
    if (AOC >= $C0) and ((AOC and $07) = $07) then
    begin
      w1 := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'RST ' + IntToStr(w1);
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, FRegs.PCH);
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, FRegs.PCL);
      FRegs.PC := w1 * 8;
      FLastInstruction.Cycles := 11;
    end;
  end;
