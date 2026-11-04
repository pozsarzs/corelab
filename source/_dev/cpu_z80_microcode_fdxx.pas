{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_fdxx.pas                                               | }
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
  // prefix-depends operations
  RegPointers[4] := @FRegs.IYH;                             // redirect HL to IY
  RegPointers[5] := @FRegs.IYL;
  // instructions
  case AOC of  
    // NOP
    $00: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
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
           FLastInstruction.Cycles := 14;
         end;
    // LD (BC), A
    $02: begin
           FLastInstruction.Mnemonic := 'LD (BC), A';
           FBus.WriteMemory(FRegs.BC, FRegs.A);
           FLastInstruction.Cycles := 11;
         end;
    // INC BC
    $03: begin
           FLastInstruction.Mnemonic:='INC BC';
           Inc(FRegs.BC);
           FLastInstruction.Cycles := 10;
         end;
    // INC r; INC (IY+r8)
    $04, $0C, $14, $1C, $24, $2C, $34, $3C:
         begin
           DestRegIndex := (AOC shr 3) and $07;
           FLastInstruction.Mnemonic := 'INC ' + YRegNames[DestRegIndex];
           b1 := FRegs.F and $01;                                { store Carry }
           if DestRegIndex = 6 then
           begin
             // INC (IY+r8)
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'INC (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             b2 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
             w1 := (b2 + 1) and $FF;
             FBus.WriteMemory((FRegs.IY + ShortInt(offset)) and $FFFF, w1);
             UpdateFlags(w1, b2, 1, False, False);
             FLastInstruction.Cycles := 23;
           end else
           begin
             // INC r
             b2 := RegPointers[DestRegIndex]^;
             Inc(RegPointers[DestRegIndex]^);
             UpdateFlags(RegPointers[DestRegIndex]^, b2, 1, False, False);
             FLastInstruction.Cycles := 8;
           end;
           FRegs.F := (FRegs.F and $FE) or b1;                 { restore Carry }
         end;
    // DEC r; DEC (IY+r8)
    $05, $0D, $15, $1D, $25, $2D, $35, $3D:
         begin
           DestRegIndex := (AOC shr 3) and $07;
           FLastInstruction.Mnemonic := 'DEC ' + YRegNames[DestRegIndex];
           b1 := FRegs.F and $01;                                { store Carry }
           if DestRegIndex = 6 then
           begin
             // DEC (IY+r8)
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'DEC (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             b2 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
             w1 := (b2 - 1) and $FF;
             FBus.WriteMemory((FRegs.IY + ShortInt(offset)) and $FFFF, w1);
             UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF, True, False);
             FLastInstruction.Cycles := 23;
           end else
           begin
             // DEC r
             b2 := RegPointers[DestRegIndex]^;
             Dec(RegPointers[DestRegIndex]^);
             UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF, True, False);
             FLastInstruction.Cycles := 8;
           end;
           FRegs.F := (FRegs.F and $FE) or b1;                 { restore Carry }
         end;
    // LD r, d8; LD (IY+r8), d8
    $06, $0E, $16, $1E, $26, $2E, $36, $3E:
         begin
           DestRegIndex := (AOC shr 3) and $07;
           FLastInstruction.Mnemonic := 'LD ' + YRegNames[DestRegIndex];
           FLastInstruction.NumOperand := 1;
           if DestRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC); // offset (r8 = -128..0..+128)
             Inc(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'LD (IY+%.2X), %.2X';
               NumOperand := 1;
               Operands[NumOperand] := offset;
               NumOperand := 2;
             end;
           end;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           if DestRegIndex = 6 then
           begin
             // LD (IY+r8), d8
             FBus.WriteMemory((FRegs.IY + ShortInt(offset)) and $FFFF, b1);
             FLastInstruction.Cycles := 19;
           end else
           begin
             // LD r, d8
             RegPointers[DestRegIndex]^ := b1;
             FLastInstruction.Cycles := 11;
           end;
         end;
    // RLCA
    $07: begin
           FLastInstruction.Mnemonic := 'RLCA';
           b1 := FRegs.A shr 7;
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FRegs.F := (FRegs.F and $FE) or b1;                    { CY refresh }
           FLastInstruction.Cycles := 8;
         end;
    // ADD rp
    $09, $19, $29, $39:
         begin
           SourceRegIndex := (AOC shr 4) and $03;
           case SourceRegIndex of
             0: begin FLastInstruction.Mnemonic := 'ADD IY, BC'; w1 := FRegs.BC; end;
             1: begin FLastInstruction.Mnemonic := 'ADD IY, DE'; w1 := FRegs.DE; end;
             2: begin FLastInstruction.Mnemonic := 'ADD IY, IY'; w1 := FRegs.IY; end;
             3: begin FLastInstruction.Mnemonic := 'ADD IY, SP'; w1 := FRegs.SP; end;
           end;
           dw1 := Cardinal(FRegs.IY) + Cardinal(w1);
           FRegs.IY := dw1 and $FFFF;
           FRegs.F := (FRegs.F and $C4) or 
                      (((FRegs.IY xor w1 xor dw1) shr 8) and $10) or   // H flag
                      ((dw1 shr 8) and $28) or                     // X, Y flags
                      ((dw1 shr 16) and $01);                          // C flag
           FLastInstruction.Cycles := 15;
         end;
    // LD A, (BC)
    $0A: begin
           FLastInstruction.Mnemonic:='LD A, (BC)';
           FRegs.A := FBus.ReadMemory(FRegs.BC);
           FLastInstruction.Cycles := 11;
         end;
    // DEC BC
    $0B: begin
           FLastInstruction.Mnemonic:='DEC BC';
           Dec(FRegs.BC);
           FLastInstruction.Cycles := 10;
         end;
    // RRCA
    $0F: begin
           FLastInstruction.Mnemonic := 'RRCA';
           b1 := FRegs.A and $01;
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FRegs.F := (FRegs.F and $FE) or b1;
           FLastInstruction.Cycles := 8;
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
           FLastInstruction.Cycles := 14;
         end;
    // LD (DE), A
    $12: begin
           FLastInstruction.Mnemonic := 'LD (DE), A';
           FBus.WriteMemory(FRegs.DE, FRegs.A);
           FLastInstruction.Cycles := 11;
         end;
    // INC DE
    $13: begin
           FLastInstruction.Mnemonic:='INC DE';
           Inc(FRegs.DE);
           FLastInstruction.Cycles := 10;
         end;
    // RLA
    $17: begin
           FLastInstruction.Mnemonic := 'RLA';
           b1 := FRegs.F and $01;
           b2 := FRegs.A shr 7;
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FRegs.F := (FRegs.F and $FE) or b2;
           FLastInstruction.Cycles := 8;
         end;         
    // LD A,(DE)
    $1A: begin
           FLastInstruction.Mnemonic:='LD A,(DE)';
           FRegs.A := FBus.ReadMemory(FRegs.DE);
           FLastInstruction.Cycles := 11;
         end;
    // DEC DE
    $1B: begin
           FLastInstruction.Mnemonic:='DEC DE';
           Dec(FRegs.DE);
           FLastInstruction.Cycles := 10;
         end;
    // RRA
    $1F: begin
           FLastInstruction.Mnemonic := 'RRA';
           b1 := FRegs.F and $01;
           b2 := FRegs.A and $01;
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FRegs.F := (FRegs.F and $FE) or b2;
           FLastInstruction.Cycles := 8;
         end;
    // LD IY, d16
    $21: begin
           FLastInstruction.Mnemonic := 'LD IY,';
           FRegs.IYL := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.IYH := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.NumOperand := 1;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := FRegs.IY;
           FLastInstruction.Cycles := 14;
         end;
    // LD (a16), IY
    $22: begin
           FLastInstruction.Mnemonic:='LD (%.4X), IY';
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.NumOperand := 1;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FBus.WriteMemory(w1, FRegs.IYL);
           FBus.WriteMemory(w1 + 1, FRegs.IYH);
           FLastInstruction.Cycles := 20;
         end;
    // INC IY
    $23: begin
           FLastInstruction.Mnemonic:='INC IY';
           Inc(FRegs.IY);
           FLastInstruction.Cycles := 10;
         end;
    // LD IY, (a16)
    $2A: begin
           FLastInstruction.Mnemonic:='LD IY, (%.4X)';
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.NumOperand := 1;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.IYL := FBus.ReadMemory(w1);
           FRegs.IYH := FBus.ReadMemory(w1 + 1);
           FLastInstruction.Cycles := 20;
         end;
    // DEC IY
    $2B: begin
           FLastInstruction.Mnemonic:='DEC IY';
           Dec(FRegs.IY);
           FLastInstruction.Cycles := 10;
         end;
    // CPL
    $2F: begin
           FLastInstruction.Mnemonic := 'CPL';
           FRegs.A := FRegs.A xor $FF;
           FLastInstruction.Cycles := 8;
         end;
    // LD SP, d16
    $31: begin
           FLastInstruction.Mnemonic := 'LD SP';
           FRegs.SPL := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.SPH := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.NumOperand := 1;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := Fregs.SP;
           FLastInstruction.Cycles := 14;
         end;
    // LD (a16), A
    $32: begin
           FLastInstruction.Mnemonic:='LD (%.4X), A';
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.NumOperand := 1;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FBus.WriteMemory(w1, FRegs.A);
           FLastInstruction.Cycles := 17;
         end;
    // INC SP
    $33: begin
           FLastInstruction.Mnemonic:='INC SP';
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // SCF
    $37: begin
           FLastInstruction.Mnemonic := 'SCF';
           FRegs.F := FRegs.F or $01;
           FLastInstruction.Cycles := 8;
         end;
    // LD A, (a16)
    $3A: begin
           FLastInstruction.Mnemonic:='LD A, (%.4X)';
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.NumOperand := 1;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.A := FBus.ReadMemory(w1);
           FLastInstruction.Cycles := 17;
         end;
    // DEC SP
    $3B: begin
           FLastInstruction.Mnemonic:='DEC SP';
           Dec(FRegs.SP);
           FLastInstruction.Cycles := 10;
         end;
    // CCF
    $3F: begin
           FLastInstruction.Mnemonic := 'CCF';
           FRegs.F := FRegs.F xor $01;
           FLastInstruction.Cycles := 8;
         end;
    // LD r1, r2; LD (IY+r8), r1; LD r1, (IY+r8)
    $40..$75, $77..$7F:
         begin
           DestRegIndex := (AOC shr 3) and $07;
           SourceRegIndex := AOC and $07;
           if (DestRegIndex = 6) or (SourceRegIndex = 6) then
           begin
             offset := FBus.ReadMemory(FRegs.PC);      // offset (r8 = -128..0..+128)
             Inc(FRegs.PC);
             with FLastInstruction do
             begin
               if DestRegIndex = 6
                 then Mnemonic := 'LD (IY+%.2X), ' + YRegNames[SourceRegIndex]
                 else Mnemonic := 'LD ' + YRegNames[DestRegIndex] + ', (IY+%.2X)';
               NumOperand := 1;
               Operands[1] := offset;
             end;
           end else
           begin
             FLastInstruction.Mnemonic := 'LD ' + YRegNames[DestRegIndex] + ', ' +
                                                  YRegNames[SourceRegIndex];
           end;
           if DestRegIndex = 6
             then FBus.WriteMemory((FRegs.IY + ShortInt(offset)) and $FFFF, RegPointers[SourceRegIndex]^) {LD (IY), r} else
               if SourceRegIndex = 6
                 then RegPointers[DestRegIndex]^ := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF) {LD r, (IY)}
                 else RegPointers[DestRegIndex]^ := RegPointers[SourceRegIndex]^; {LD r1, r2}
           if (AOC = $46) or (AOC = $4E) or (AOC = $56) or (AOC = $5E) or 
              (AOC = $66) or (AOC = $6E) or (AOC = $77) or (AOC = $7E) or 
              ((AOC >= $70) and (AOC <= $75))
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // HALT
    $76: begin
           FLastInstruction.Mnemonic := 'HALT';
           FHalted := true;
           EmitEvent(ceHalt);
           FLastInstruction.Cycles := 4;
         end;
    // ADD r
    $80..$87:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'ADD ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'ADD (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             w1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else w1 := RegPointers[SourceRegIndex]^;
           b1 := FRegs.A;
           w2 := b1 + w1;
           FRegs.A := w2 and $00FF;
           UpdateFlags(w2, b1, w1, False, False);
           if AOC = $86
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // ADC r
    $88..$8F:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'ADC ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'ADC (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             w1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else w1 := RegPointers[SourceRegIndex]^;
           b1 := FRegs.A;
           b2 := FRegs.F and $01;
           w2 := b1 + w1 + b2;
           FRegs.A := w2 and $00FF;
           UpdateFlags(w2, b1, w1 + b2, False, False);
           if AOC = $8E
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // SUB r
    $90..$97:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'SUB ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'SUB (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             w1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else w1 := RegPointers[SourceRegIndex]^;
           b1 := FRegs.A;
           w2 := b1 - w1;
           FRegs.A := w2 and $00FF;
           UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF, True, False);
           FRegs.F := FRegs.F xor $01;
           if AOC = $96
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // SBC r
    $98..$9F:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'SBC ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'SBC (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             w1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else w1 := RegPointers[SourceRegIndex]^;
           b1 := FRegs.A;
           b2 := FRegs.F and $01;
           w2 := b1 - w1 - b2;
           FRegs.A := w2 and $00FF;
           UpdateFlags(b1 + ((w1 + b2) xor $FF) + 1, b1, (w1 + b2) xor $FF, True, False);
           FRegs.F := FRegs.F xor $01;
           if AOC = $9E
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // AND r
    $A0..$A7:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'AND ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'AND (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             b1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else b1 := RegPointers[SourceRegIndex]^;
           b2 := FRegs.A;
           FRegs.A := FRegs.A and b1;
           UpdateFlags(FRegs.A, b2, b2, False, True);
           FRegs.F := (FRegs.F and $FE) or $10;
           if AOC = $A6
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // XOR r
    $A8..$AF:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'XOR ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'XOR (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             b1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else b1 := RegPointers[SourceRegIndex]^;
           b2 := FRegs.A;
           FRegs.A := FRegs.A xor b1;
           UpdateFlags(FRegs.A, b2, b2, False, True);
           FRegs.F := FRegs.F and $EE;
           if AOC = $AE
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // OR r
    $B0..$B7:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'OR ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'OR (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             b1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else b1 := RegPointers[SourceRegIndex]^;
           b2 := FRegs.A;
           FRegs.A := FRegs.A or b1;
           UpdateFlags(FRegs.A, b2, b2, False, True);
           FRegs.F := FRegs.F and $EE;
           if AOC = $B6
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
         end;
    // CP r
    $B8..$BF:
         begin
           SourceRegIndex := AOC and $07;
           FLastInstruction.Mnemonic := 'CP ' + YRegNames[SourceRegIndex];
           if SourceRegIndex = 6 then
           begin
             offset := FBus.ReadMemory(FRegs.PC);
             with FLastInstruction do
             begin
               Mnemonic := 'CP (IY+%.2X)';
               NumOperand := 1;
               Operands[NumOperand] := offset;
             end;
             Inc(FRegs.PC);
             w1 := FBus.ReadMemory((FRegs.IY + ShortInt(offset)) and $FFFF);
           end else w1 := RegPointers[SourceRegIndex]^;
           b1 := FRegs.A;
           w2 := b1 - w1;
           UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF, True, False);
           FRegs.F := FRegs.F xor $01;
           if AOC = $BE
             then FLastInstruction.Cycles := 19
             else FLastInstruction.Cycles := 8;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // POP BC
    $C1: begin
           FLastInstruction.Mnemonic := 'POP BC';
           FRegs.C := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.B := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 14;
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
         end;
    // PUSH BC
    $C5: begin
           FLastInstruction.Mnemonic := 'PUSH BC';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.B);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.C);
           FLastInstruction.Cycles := 15;
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
           FLastInstruction.Cycles := 11;
         end;
    // RST n
    $C7, $CF, $D7, $DF, $E7, $EF, $F7, $FF:
         begin
           w1 := (AOC shr 3) and $07;
           FLastInstruction.Mnemonic := 'RST ' + IntToStr(w1);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.PCH);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.PCL);
           FRegs.PC := w1 * 8;
           FLastInstruction.Cycles := 15;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // RET
    $C9: begin
           FLastInstruction.Mnemonic := 'RET';
           w1 := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
           Inc(FRegs.SP);
           FRegs.PC := w1;
           FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 14;
         end;
    // PREFIX CB
    $CB: begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Cycles := FLastInstruction.Cycles + 4;
           RunOpCode(b1, prFDCB);
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 21;
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
           FLastInstruction.Cycles := 11;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // POP DE
    $D1: begin
           FLastInstruction.Mnemonic := 'POP DE';
           FRegs.E := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.D := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 14;
         end;
    // OUT (d8), A
    $D3: begin
           FLastInstruction.Mnemonic := 'OUT (%.2X), A';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FBus.WritePort(b1, Fregs.A);
           FLastInstruction.Cycles := 15;
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
         end;
    // PUSH DE
    $D5: begin
           FLastInstruction.Mnemonic := 'PUSH DE';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.D);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.E);
           FLastInstruction.Cycles := 15;
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
           FLastInstruction.Cycles := 11;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // EXX
    $D9: begin
           FLastInstruction.Mnemonic := 'EXX';
           Fregs.PC := Fregs.IY;
           FLastInstruction.Cycles := 8;
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
           FLastInstruction.Cycles := 14;
         end;
    // IN A, (d8)
    $DB: begin
           FLastInstruction.Mnemonic := 'IN A, (%.2X)';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FRegs.A := FBus.ReadPort(b1);
           FLastInstruction.Cycles := 15;
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
         end;
    // PREFIX DD
    $DD: begin
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
           FLastInstruction.Cycles := 11;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // POP IY
    $E1: begin
           FLastInstruction.Mnemonic := 'POP IY';
           FRegs.IYL := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.IYH := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 14;
         end;
    // EX (SP),IY
    $E3: begin
           FLastInstruction.Mnemonic := 'EX (SP),IY';
           // L <-> [SP]
           b1 := FBus.ReadMemory(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.IYL);
           FRegs.IYL := b1;
           // H <-> [SP + 1]
           b2 := FBus.ReadMemory((FRegs.SP + 1) and $FFFF);
           FBus.WriteMemory((FRegs.SP + 1) and $FFFF, FRegs.IYH);
           FRegs.IYH := b2;
           FLastInstruction.Cycles := 23;
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
         end;
    // PUSH IY
    $E5: begin
           FLastInstruction.Mnemonic := 'PUSH IY';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.IYH);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.IYL);
           FLastInstruction.Cycles := 15;
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
           FLastInstruction.Cycles := 11;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // JP (IY)
    $E9: begin
           FLastInstruction.Mnemonic := 'JP (IY)';
           FRegs.PC := FRegs.IY;
           FLastInstruction.Cycles := 8;
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
           FLastInstruction.Cycles := 14;
         end;
    // EX DE, HL
    $EB: begin
           FLastInstruction.Mnemonic := 'EX DE, HL';
           with FRegs do
           begin
             w1 := DE; DE := HL; HL := w1;
           end;
           FLastInstruction.Cycles := 8;
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 11;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // POP AF
    $F1: begin
           FLastInstruction.Mnemonic := 'POP AF';
           FRegs.F := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FRegs.A := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           FLastInstruction.Cycles := 14;
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
           FLastInstruction.Cycles := 14;
         end;
    // DI
    $F3: begin
           FLastInstruction.Mnemonic := 'DI';
           FInterruptEnabled := false;
           FInterruptEnabled2 := false;
           FLastInstruction.Cycles := 8;
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
         end;
    // PUSH AF
    $F5: begin
           FLastInstruction.Mnemonic := 'PUSH AF';
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.A);
           Dec(FRegs.SP);
           FBus.WriteMemory(FRegs.SP, FRegs.F);
           FLastInstruction.Cycles := 15;
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
           FLastInstruction.Cycles := 11;
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
             FLastInstruction.Cycles := 15;
           end else FLastInstruction.Cycles := 9;
         end;
    // LD SP, IY
    $F9: begin
           FLastInstruction.Mnemonic := 'LD SP, IY';
           Fregs.SP := Fregs.IY;
           FLastInstruction.Cycles := 10;
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
           FLastInstruction.Cycles := 14;
         end;
    // EI
    $FB: begin
           FLastInstruction.Mnemonic := 'EI';
           FInterruptEnabled := true;
           FInterruptEnabled2 := true;
           FLastInstruction.Cycles := 8;
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
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 14;
         end;
    // PREFIX FD
    $FD: begin
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
           FLastInstruction.Cycles := 11;
         end;
  end;
  //restore redirection
  RegPointers[4] := @FRegs.H;
  RegPointers[5] := @FRegs.L;
