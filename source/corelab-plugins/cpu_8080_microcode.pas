{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | microcode.pas                                                            | }
{ | Microcode for Intel 8080 CPU implementation module                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case OC of  
    // NOP
    $00: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 4;
         end;
    // LXI B, d16
    $01: begin
           FLastInstruction.Mnemonic := 'LXI B';
           FLastInstruction.NumOperand := 1;
           FRegs.C := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.B := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := Fregs.BC;
           FLastInstruction.Cycles := 10;
         end;
    // STAX B
    $02: begin
           FLastInstruction.Mnemonic := 'STAX B';
           FBus.WriteMemory(FRegs.BC, FRegs.A);
           FLastInstruction.Cycles := 7;
         end;
    // INX B
    $03: begin
           FLastInstruction.Mnemonic:='INX B';
           Inc(FRegs.BC);
           FLastInstruction.Cycles := 5;
         end;
    // RLC
    $07: begin
           FLastInstruction.Mnemonic := 'RLC';
           b1 := FRegs.A shr 7; { A 7. bit }
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FRegs.F := (FRegs.F and $FE) or b1;                    { CY refresh }
           FLastInstruction.Cycles := 4;
         end;
    // LDAX B
    $0A: begin
           FLastInstruction.Mnemonic:='LDAX B';
           FRegs.A := FBus.ReadMemory(FRegs.BC);
           FLastInstruction.Cycles := 7;
         end;
    // DCX B
    $0B: begin
           FLastInstruction.Mnemonic:='DCX B';
           Dec(FRegs.BC);
           FLastInstruction.Cycles := 5;
         end;
    // RRC
    $0F: begin
           FLastInstruction.Mnemonic := 'RRC';
           b1 := FRegs.A and $01; { A 0. bit }
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FRegs.F := (FRegs.F and $FE) or b1;
           FLastInstruction.Cycles := 4;
         end;
    // LXI D, d16
    $11: begin
           FLastInstruction.Mnemonic := 'LXI D';
           FLastInstruction.NumOperand := 1;
           FRegs.E := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.D := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := Fregs.DE;
           FLastInstruction.Cycles := 10;
         end;
    // STAX D
    $12: begin
           FLastInstruction.Mnemonic := 'STAX D';
           FBus.WriteMemory(FRegs.DE, FRegs.A);
           FLastInstruction.Cycles := 7;
         end;
    // INX D
    $13: begin
           FLastInstruction.Mnemonic:='INX D';
           Inc(FRegs.DE);
           FLastInstruction.Cycles := 5;
         end;
    // RAL
    $17: begin
           FLastInstruction.Mnemonic := 'RAL';
           b1 := FRegs.F and $01;
           b2 := FRegs.A shr 7;
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FRegs.F := (FRegs.F and $FE) or b2;
           FLastInstruction.Cycles := 4;
         end;         
    // LDAX D
    $1A: begin
           FLastInstruction.Mnemonic:='LDAX D';
           FRegs.A := FBus.ReadMemory(FRegs.DE);
           FLastInstruction.Cycles := 7;
         end;
    // DCX D
    $1B: begin
           FLastInstruction.Mnemonic:='DCX D';
           Dec(FRegs.DE);
           FLastInstruction.Cycles := 5;
         end;
    // RAR
    $1F: begin
           FLastInstruction.Mnemonic := 'RAR';
           b1 := FRegs.F and $01;
           b2 := FRegs.A and $01;
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FRegs.F := (FRegs.F and $FE) or b2;
           FLastInstruction.Cycles := 4;
         end;
    // LXI H, d16
    $21: begin
           FLastInstruction.Mnemonic := 'LXI H';
           FLastInstruction.NumOperand := 1;
           FRegs.L := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.H := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := FRegs.HL;
           FLastInstruction.Cycles := 10;
         end;
    // SHLD a16
    $22: begin
           FLastInstruction.Mnemonic:='SHLD';
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
    // INX H
    $23: begin
           FLastInstruction.Mnemonic:='INX H';
           Inc(FRegs.HL);
           FLastInstruction.Cycles := 5;
         end;
    // LHLD a16
    $2A: begin
           FLastInstruction.Mnemonic:='LHLD';
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
    // DCX H
    $2B: begin
           FLastInstruction.Mnemonic:='DCX H';
           Dec(FRegs.HL);
           FLastInstruction.Cycles := 5;
         end;
    // CMA
    $2F: begin
           FLastInstruction.Mnemonic := 'CMA';
           FRegs.A := FRegs.A xor $FF;
           FLastInstruction.Cycles := 4;
         end;
    // LXI SP, d16
    $31: begin
           FLastInstruction.Mnemonic := 'LXI SP';
           FLastInstruction.NumOperand := 1;
           FRegs.SPL := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.SPH := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := Fregs.SP;
           FLastInstruction.Cycles := 10;
         end;
    // STA a16
    $32: begin
           FLastInstruction.Mnemonic:='STA';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FBus.WriteMemory(w1, FRegs.A);
           FLastInstruction.Cycles := 13;
         end;
    // INX SP
    $33: begin
           FLastInstruction.Mnemonic:='INX SP';
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 5;
         end;
    // STC
    $37: begin
           FLastInstruction.Mnemonic := 'STC';
           FRegs.F := FRegs.F or $01;
           FLastInstruction.Cycles := 4;
         end;
    // LDA a16
    $3A: begin
           FLastInstruction.Mnemonic:='LDA';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.A := FBus.ReadMemory(w1);
           FLastInstruction.Cycles := 13;
         end;
    // DCX SP
    $3B: begin
           FLastInstruction.Mnemonic:='DCX SP';
           Dec(FRegs.SP);
           FLastInstruction.Cycles := 5;
         end;
    // CMC
    $3F: begin
           FLastInstruction.Mnemonic := 'CMC';
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 4;
         end;
    // HLT
    $76: begin
           FLastInstruction.Mnemonic := 'HLT';
           FHalted := true;
           EmitEvent(ceHalt);
           FLastInstruction.Cycles := 7;
         end;
    // XTHL
    $E3: begin
           FLastInstruction.Mnemonic := 'XTHL';
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
    // XCHG
    $EB: begin
           FLastInstruction.Mnemonic := 'XCHG';
           with FRegs do
           begin
             w1 := DE; DE := HL; HL := w1;
           end;
           FLastInstruction.Cycles := 4;
         end;
    // RNZ
    $C0: begin
           FLastInstruction.Mnemonic := 'RNZ';
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
    // POP B
    $C1: begin
           FLastInstruction.Mnemonic := 'POP B';
           FRegs.C := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.B := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JNZ a16
    $C2: begin
           FLastInstruction.Mnemonic := 'JNZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $40) = 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // JMP a16
    $C3: begin
           FLastInstruction.Mnemonic := 'JMP';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // CNZ a16
    $C4: begin
           FLastInstruction.Mnemonic := 'CNZ';
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
           end else FLastInstruction.Cycles := 11;
         end;
    // PUSH B
    $C5: begin
           FLastInstruction.Mnemonic := 'PUSH B';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.B);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.C);
           FLastInstruction.Cycles := 11;
         end;
    // ADI d8
    $C6: begin
           FLastInstruction.Mnemonic := 'ADI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := Fregs.A;
           w1 := b2 + b1;
           Fregs.A := w1 and $00FF;
           UpdateFlags(w1, b2, b1);
           FLastInstruction.Cycles := 8;
         end;
    // RZ
    $C8: begin
           FLastInstruction.Mnemonic := 'RZ';
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
    // JZ a16
    $CA: begin
           FLastInstruction.Mnemonic := 'JZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $40) > 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // CZ a16
    $CC: begin
           FLastInstruction.Mnemonic := 'CZ';
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
    // ACI d8
    $CE: begin
           FLastInstruction.Mnemonic := 'ACI';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           b1 := FRegs.A;
           b2 := FRegs.F and $01;
           w2 := b1 + w1 + b2;
           FRegs.A := w2 and $00FF;
           UpdateFlags(w2, b1, w1 + b2);
           FLastInstruction.Cycles := 7;
         end;
    // RNC
    $D0: begin
           FLastInstruction.Mnemonic := 'RNC';
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
    // POP D
    $D1: begin
           FLastInstruction.Mnemonic := 'POP D';
           FRegs.E := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.D := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JNC a16
    $D2: begin
           FLastInstruction.Mnemonic := 'JNC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $01) = 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // OUT d8
    $D3: begin
           FLastInstruction.Mnemonic := 'OUT';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FBus.WritePort(b1, Fregs.A);
           FLastInstruction.Cycles := 10;
         end;
    // CNC a16
    $D4: begin
           FLastInstruction.Mnemonic := 'CNC';
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
           end else FLastInstruction.Cycles := 11;
         end;
    // PUSH D
    $D5: begin
           FLastInstruction.Mnemonic := 'PUSH D';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.D);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.E);
           FLastInstruction.Cycles := 11;
         end;
    // SUI d8
    $D6: begin
           FLastInstruction.Mnemonic := 'SUI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           w1 := b2 - b1;
           Fregs.A := w1 and $00FF;
           UpdateFlags(b2 + (b1 xor $FF) + 1, b2, b1 xor $FF);
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 7;
         end;
    // RC
    $D8: begin
           FLastInstruction.Mnemonic := 'RC';
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
    // PCHL
    $D9: begin
           FLastInstruction.Mnemonic := 'PCHL';
           Fregs.PC := Fregs.HL;
           FLastInstruction.Cycles := 10;
         end;
    // JC a16
    $DA: begin
           FLastInstruction.Mnemonic := 'JC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $01) > 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // IN d8
    $DB: begin
           FLastInstruction.Mnemonic := 'IN';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FRegs.A := FBus.ReadPort(b1);
           FLastInstruction.Cycles := 10;
         end;
    // CC a16
    $DC: begin
           FLastInstruction.Mnemonic := 'CC';
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
           end else FLastInstruction.Cycles := 11;
         end;
    // SBI d8
    $DE: begin
           FLastInstruction.Mnemonic := 'SBI';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           b1 := FRegs.A;
           b2 := FRegs.F and $01;
           w2 := b1 - w1 - b2;
           FRegs.A := w2 and $00FF;
           UpdateFlags(b1 + ((w1 + b2) xor $FF) + 1, b1, (w1 + b2) xor $FF);
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 7;
         end;
    // RPO
    $E0: begin
           FLastInstruction.Mnemonic := 'RPO';
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
    // POP H
    $E1: begin
           FLastInstruction.Mnemonic := 'POP H';
           FRegs.L := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.H := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JPO a16
    $E2: begin
           FLastInstruction.Mnemonic := 'JPO';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $04) = 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // CPO a16
    $E4: begin
           FLastInstruction.Mnemonic := 'CPO';
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
           end else FLastInstruction.Cycles := 11;
         end;
    // PUSH H
    $E5: begin
           FLastInstruction.Mnemonic := 'PUSH H';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.H);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.L);
           FLastInstruction.Cycles := 11;
         end;
    // ANI d8
    $E6: begin
           FLastInstruction.Mnemonic := 'ANI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           Fregs.A := Fregs.A and b1;
           UpdateFlags(FRegs.A, b2, b2);
           FRegs.F := (FRegs.F and $FE) or $10;
           FLastInstruction.Cycles := 7;
         end;
    // RPE
    $E8: begin
           FLastInstruction.Mnemonic := 'RPE';
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
    // JPE a16
    $EA: begin
           FLastInstruction.Mnemonic := 'JPE';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if (FRegs.F and $04) > 0 then FRegs.PC := w1;
           FLastInstruction.Cycles := 10;
         end;
    // CPE a16
    $EC: begin
           FLastInstruction.Mnemonic := 'CPE';
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
           end else FLastInstruction.Cycles := 11;
         end;
    // XRI d8
    $EE: begin
           FLastInstruction.Mnemonic := 'XRI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           Fregs.A := Fregs.A xor b1;
           UpdateFlags(FRegs.A, b2, b2);
           FRegs.F := FRegs.F and $EE;
           FLastInstruction.Cycles := 7;
         end;
    // RP
    $F0: begin
           FLastInstruction.Mnemonic := 'RP';
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
    // POP PSW
    $F1: begin
           FLastInstruction.Mnemonic := 'POP PSW';
           FRegs.F := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.A := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // JP a16
    $F2: begin
           FLastInstruction.Mnemonic := 'JP';
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
           FLastInstruction.Cycles := 4;
         end;
    // CP a16
    $F4: begin
           FLastInstruction.Mnemonic := 'CP';
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
    // PUSH PSW
    $F5: begin
           FLastInstruction.Mnemonic := 'PUSH PSW';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.A);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.F);
           FLastInstruction.Cycles := 11;
         end;
    // ORI d8
    $F6: begin
           FLastInstruction.Mnemonic := 'ORI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           Fregs.A := Fregs.A or b1;
           UpdateFlags(FRegs.A, b2, b2);
           FRegs.F := FRegs.F and $EE;
           FLastInstruction.Cycles := 7;
         end;
    // RM
    $F8: begin
           FLastInstruction.Mnemonic := 'RM';
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
    // SPHL
    $F9: begin
           FLastInstruction.Mnemonic := 'SPHL';
           Fregs.SP := Fregs.HL;
           FLastInstruction.Cycles := 5;
         end;
    // JM a16
    $FA: begin
           FLastInstruction.Mnemonic := 'JM';
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
           FLastInstruction.Cycles := 4;
         end;
    // CM a16
    $FC: begin
           FLastInstruction.Mnemonic := 'CM';
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
           end else FLastInstruction.Cycles := 11;
         end;
    // CPI d8
    $FE: begin
           FLastInstruction.Mnemonic := 'CPI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := FRegs.A;
           UpdateFlags(b2 + (b1 xor $FF) + 1, b2, b1 xor $FF);
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 7;
         end;
   else  
    // INR r; INR M
    // $04, $14, $24, $34, $0C, $1C, $2C, $3C
    if (OC <= $3F) and ((OC and $07) = $04) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      FLastInstruction.Mnemonic := 'INR ' + RegNames[DestRegIndex];
      b1 := FRegs.F and $01;                                     { store Carry }
      if DestRegIndex = 6 then
      begin
        // INR M
        b2 := FBus.ReadMemory(FRegs.HL);
        w1 := (b2 + 1) and $FF;
        FBus.WriteMemory(FRegs.HL, w1);
        UpdateFlags(w1, b2, 1);
        FLastInstruction.Cycles := 10;
      end else
      begin
        // INR r
        b2 := RegPointers[DestRegIndex]^;
        Inc(RegPointers[DestRegIndex]^);
        UpdateFlags(RegPointers[DestRegIndex]^, b2, 1);
        FLastInstruction.Cycles := 5;
      end;
      FRegs.F := (FRegs.F and $FE) or b1;                      { restore Carry }
    end;
    // DCR r; DCR M
    // $05, $15, $25, $35, $0D, $1D, $2D, $3D
    if (OC <= $3F) and ((OC and $07) = $05) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      FLastInstruction.Mnemonic := 'DCR ' + RegNames[DestRegIndex];
      b1 := FRegs.F and $01;                                     { store Carry }
      if DestRegIndex = 6 then
      begin
        // DCR M
        b2 := FBus.ReadMemory(FRegs.HL);
        w1 := (b2 - 1) and $FF;
        FBus.WriteMemory(FRegs.HL, w1);
        UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF);
        FLastInstruction.Cycles := 10;
      end else
      begin
        // DCR r
        b2 := RegPointers[DestRegIndex]^;
        Dec(RegPointers[DestRegIndex]^);
        UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF);
        FLastInstruction.Cycles := 5;
      end;
      FRegs.F := (FRegs.F and $FE) or b1;                      { restore Carry }
    end;
    // MVI r, d8; MVI M, d8
    // $06, $16, $26, $36, $0E, $1E, $2E, $3E
    if (OC <= $3F) and ((OC and $07) = $06) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      FLastInstruction.Mnemonic := 'MVI ' + RegNames[DestRegIndex];
      FLastInstruction.NumOperand := 1;
      b1 := FBus.ReadMemory(FRegs.PC);
      Inc(FRegs.PC);
      FLastInstruction.Operands[1] := b1;
      if DestRegIndex = 6 then
      begin
        FBus.WriteMemory(FRegs.HL, b1);                            { MVI M, d8 }
        FLastInstruction.Cycles := 10;
      end else
      begin
        RegPointers[DestRegIndex]^ := b1;                          { MVI r, d8 }
        FLastInstruction.Cycles := 7;
      end;
    end;
    // DAD rp
    // $09, $19, $29, $39)
    if (OC <= $3F) and ((OC and $0F) = $09) then
    begin
      SourceRegIndex := (OC shr 4) and $03;
      case SourceRegIndex of
        0: begin FLastInstruction.Mnemonic := 'DAD B'; w1 := FRegs.BC; end;
        1: begin FLastInstruction.Mnemonic := 'DAD D'; w1 := FRegs.DE; end;
        2: begin FLastInstruction.Mnemonic := 'DAD H'; w1 := FRegs.HL; end;
        3: begin FLastInstruction.Mnemonic := 'DAD SP'; w1 := FRegs.SP; end;
      end;
      dw1 := Cardinal(FRegs.HL) + Cardinal(w1);
      FRegs.HL := dw1 and $FFFF;
      if (dw1 and $10000) <> 0 
        then FRegs.F := FRegs.F or $01
        else FRegs.F := FRegs.F and $FE;
      FLastInstruction.Cycles := 10;
    end;
    // MOV r1, r2; MOV M, r1; MOV r1, M
    // $40-$7F
    if (OC >= $40) and (OC <= $7F) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'MOV ' +
                            RegNames[DestRegIndex] + ', ' +
                            RegNames[SourceRegIndex];
      if (DestRegIndex = 6) and (SourceRegIndex = 6) then {HLT} else
        if DestRegIndex = 6
          then FBus.WriteMemory(FRegs.HL, RegPointers[SourceRegIndex]^) {MOV M, r} else
	  if SourceRegIndex = 6
            then RegPointers[DestRegIndex]^ := FBus.ReadMemory(FRegs.HL) {MOV r, M}
            else RegPointers[DestRegIndex]^ := RegPointers[SourceRegIndex]^; {MOV r1, r2}
      if (OC = $46) or (OC = $4E) or 
         (OC = $56) or (OC = $5E) or 
         (OC = $66) or (OC = $6E) or 
         (OC = $77) or (OC = $7E) or 
         ((OC >= $70) and (OC >= $75))
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 5;
    end;
    // ADD r
    // $80-$87
    if (OC >= $80) and (OC <= $87) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'ADD ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 + w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2, b1, w1);
      if OC = $86
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // ADC r
    // $88-$8F
    if (OC >= $88) and (OC <= $8F) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'ADC ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := FRegs.F and $01;
      w2 := b1 + w1 + b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2, b1, w1 + b2);
      if OC = $8E
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // SUB r
    // $90-$97
    if (OC >= $90) and (OC <= $97) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'SUB ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF);
      FRegs.F := FRegs.F xor $01;
      if OC = $96
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // SBB r
    // $98-$9F
    if (OC >= $98) and (OC <= $9F) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'SBB ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := FRegs.F and $01;
      w2 := b1 - w1 - b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(b1 + ((w1 + b2) xor $FF) + 1, b1, (w1 + b2) xor $FF);
      FRegs.F := FRegs.F xor $01;
      if OC = $9E
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // ANA r
    // $A0-$A7
    if (OC >= $A0) and (OC <= $A7) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'ANA ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.ReadMemory(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A and b1;
      UpdateFlags(FRegs.A, b2, b2);
      FRegs.F := (FRegs.F and $FE) or $10;
      if OC = $A6
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // XRA r
    // $A8-$AF
    if (OC >= $A8) and (OC <= $AF) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'XRA ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.ReadMemory(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A xor b1;
      UpdateFlags(FRegs.A, b2, b2);
      FRegs.F := FRegs.F and $EE;
      if OC = $AE
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // ORA r
    // $B0-$B7
    if (OC >= $B0) and (OC <= $B7) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'ORA ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.ReadMemory(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A or b1;
      UpdateFlags(FRegs.A, b2, b2);
      FRegs.F := FRegs.F and $EE;
      if OC = $B6
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // CMP r
    // $B8-$BF
    if (OC >= $B8) and (OC <= $BF) then
    begin
      SourceRegIndex := OC and $07;
      FLastInstruction.Mnemonic := 'CMP ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.ReadMemory(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF);
      FRegs.F := FRegs.F xor $01;
      if OC = $BE
        then FLastInstruction.Cycles := 7
        else FLastInstruction.Cycles := 4;
    end;
    // RST n
    // $C7, $D7, $E7, $F7, $CF, $DF, $EF, $FF
    if (OC >= $C0) and ((OC and $07) = $07) then
    begin
      w1 := (OC shr 3) and $07;
      FLastInstruction.Mnemonic := 'RST ' + IntToStr(w1);
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, FRegs.PCH);
      Dec(FRegs.SP);
      FBus.WriteMemory(FRegs.SP, FRegs.PCL);
      FRegs.PC := w1 * 8;
      FLastInstruction.Cycles := 11;
    end;
  end;
