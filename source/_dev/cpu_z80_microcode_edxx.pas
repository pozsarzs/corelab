{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_edxx.pas                                               | }
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
    // NOP
    $00..$3F:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
    // LD I, A
    $47: begin
           FLastInstruction.Mnemonic := 'LD I, A';
           FRegs.I := FRegs.A;
           FLastInstruction.Cycles := 9;
         end;
    // LD R, A
    $4F: begin
           FLastInstruction.Mnemonic := 'LD R, A';
           FRegs.R := FRegs.A;
           FLastInstruction.Cycles := 9;
         end;
    // LD A, I
    $57: begin
           FLastInstruction.Mnemonic := 'LD A, I';
           FRegs.A := FRegs.I;
           if (FRegs.A and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           if FRegs.A > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           if FInterruptEnabled2                                        // set P
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or (FRegs.A and $28);     // set X and Y
           FLastInstruction.Cycles := 9;
         end;
    // LD A, R
    $5F: begin
           FLastInstruction.Mnemonic := 'LD A, R';
           FRegs.A := FRegs.R;
           if (FRegs.A and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           if FRegs.A > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           if FInterruptEnabled2                                        // set P
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or (FRegs.A and $28);     // set X and Y
           FLastInstruction.Cycles := 9;
         end;
    // RRD
    $67: begin
           FLastInstruction.Mnemonic := 'RRD';
           b1 := FRegs.A;
           b2 := FBus.ReadMemory(FRegs.HL);
           b3 := b1 and $0F;                   // Al
           b1 := b1 and $F0;
           b1 := b1 or (b2 and $0F);           // (HL)l -> Al
           b2 := b2 shr 4;                     // (HL)h -> (HL)l
           b2 := b2 or (b3 shl 4);             // Al -> (HL)h
           FRegs.A := b1;
           FBus.WriteMemory(FRegs.HL, b2);
           if (FRegs.A and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           if FRegs.A > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           b3 := b1 xor (b1 shr 4);                                     // set P
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or (FRegs.A and $28);     // set X and Y
           FLastInstruction.Cycles := 18;
         end;
    // RLD
    $6F: begin
           FLastInstruction.Mnemonic := 'RLD';
           b1 := FRegs.A;
           b2 := FBus.ReadMemory(FRegs.HL);
           b3 := b1 and $0F;                   // Al
           b1 := b1 and $F0;
           b1 := b1 or (b2 shr 4);             // (HL)h -> Al
           b2 := b2 shl 4;                     // (HL)l -> (HL)h
           b2 := b2 or b3;                     // Al -> (HL)l
           FRegs.A := b1;
           FBus.WriteMemory(FRegs.HL, b2);
           if (FRegs.A and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           if FRegs.A > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           b3 := b1 xor (b1 shr 4);                                     // set P
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or (FRegs.A and $28);     // set X and Y
           FLastInstruction.Cycles := 18;
         end;
    // IN (C)
    $70: begin
           FLastInstruction.Mnemonic := 'IN (C)';
           b1 := FBus.ReadPort(FRegs.BC);
           if (b1 and $80) <> 0                                         // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           if b1 > 0                                                    // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           b3 := b1 xor (b1 shr 4);                                     // set P
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or (b1 and $28);     // set X and Y
           FLastInstruction.Cycles := 12;
         end;
    // OUT (C),0
    $71: begin
           FLastInstruction.Mnemonic := 'OUT (C), 0';
           FBus.WritePort(FRegs.BC, 0); 
           FLastInstruction.Cycles := 12;
         end;
    // NOP
    $77: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
    // IN A,(C)
    $78: begin
           FLastInstruction.Mnemonic := 'IN A, (C)';
           FRegs.A := FBus.ReadPort(FRegs.BC);
           if (FRegs.A and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           if FRegs.A > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           b3 := FRegs.A xor (FRegs.A shr 4);                           // set P
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or (FRegs.A and $28);     // set X and Y
           FLastInstruction.Cycles := 12;
         end;
    // OUT (C),A
    $79: begin
           FLastInstruction.Mnemonic := 'OUT (C), A';
           FBus.WritePort(FRegs.BC, FRegs.A); 
           FLastInstruction.Cycles := 12;
         end;
    // NOP
    $7F..$9F:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
    // LDI
    $A0: begin
           FLastInstruction.Mnemonic := 'LDI';
           b1 := FBus.ReadMemory(FRegs.HL);
           FBus.WriteMemory(FRegs.DE, b1);
           Inc(FRegs.DE);
           Inc(FRegs.HL);
           if FRegs.BC = 0 then FRegs.BC := $FFFF else Dec(FRegs.BC);
           if FRegs.BC > 0                                            // set P/V
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or ((FRegs.A + b1)and $28);  // set X, Y
           FLastInstruction.Cycles := 16;
         end;
    // CPI
    $A1: begin
           FLastInstruction.Mnemonic := 'CPI';
           b1 := FBus.ReadMemory(FRegs.HL);
           i1 := FRegs.A - b1;
           Dec(Fregs.BC);
           Inc(Fregs.HL);
           if (i1 and $80) <> 0                                         // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           if i1 <> 0                                                   // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           if FRegs.BC > 0                                              // set P
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           if ((FRegs.A and $0F) - (b1 and $0F)) < 0 then
           begin
             FRegs.F := FRegs.F or $10;                                 // set H
             FRegs.F := (FRegs.F and $D7) or (Byte(i1 - 1) and $28); // set X, Y
           end else
           begin
             FRegs.F := FRegs.F and $EF;
             FRegs.F := (FRegs.F and $D7) or (Byte(i1) and $28);
           end;
           FRegs.F := FRegs.F or $02;                                   // set N
           FLastInstruction.Cycles := 16;
         end;
    // INI
    $A2: begin
           FLastInstruction.Mnemonic := 'INI';
           // |SZXH XV1-|
           FLastInstruction.Cycles := 16;
         end;
    // OUTI
    $A3: begin
           FLastInstruction.Mnemonic := 'OUTI';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16;
         end;
    // NOP
    $A4..$A7:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
    // LDD
    $A8: begin
           FLastInstruction.Mnemonic := 'LDD';
           // |--X0XV0-|
           FLastInstruction.Cycles := 16;
         end;
    // CPD
    $A9: begin
           FLastInstruction.Mnemonic := 'CPD';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16;
         end;
    // IND
    $AA: begin
           FLastInstruction.Mnemonic := 'IND';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16;
         end;
    // OUTD
    $AB: begin
           FLastInstruction.Mnemonic := 'OUTD';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16;
         end;
    // NOP
    $AC..$AF:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
    // LDIR
    $B0: begin
           FLastInstruction.Mnemonic := 'LDIR';
           // |--X0XV0-|
           FLastInstruction.Cycles := 16; //21
         end;
    // CPIR
    $B1: begin
           FLastInstruction.Mnemonic := 'CPIR';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16; //21
         end;
    // INIR
    $B2: begin
           FLastInstruction.Mnemonic := 'INIR';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16; //21
         end;
    // OUTIR
    $B3: begin
           FLastInstruction.Mnemonic := 'OUTIR';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16; //21
         end;
    // NOP
    $B4..$B7:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
    // LDDR
    $B8: begin
           FLastInstruction.Mnemonic := 'LDDR';
           // |--X0XV0-|
           FLastInstruction.Cycles := 16; //21
         end;
    // CPDR
    $B9: begin
           FLastInstruction.Mnemonic := 'CPDR';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16; //21
         end;
    // INDR
    $BA: begin
           FLastInstruction.Mnemonic := 'INDR';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16; //21
         end;
    // OUTDR
    $BB: begin
           FLastInstruction.Mnemonic := 'OUTDR';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16; //21
         end;
    // NOP
    $BC..$FF:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
  else
{ 
|ED 40  |IN B,(C)     |2   |12    |SZX0XP0-|
|ED 48  |IN C,(C)     |2   |12    |SZX0XP0-|
|ED 50  |IN D,(C)     |2   |12    |SZX0XP0-|
|ED 58  |IN E,(C)     |2   |12    |SZX0XP0-|
|ED 60  |IN H,(C)     |2   |12    |SZX0XP0-|
|ED 68  |IN L,(C)     |2   |12    |SZX0XP0-|

|ED 41  |OUT (C),B    |2   |12    |--------|
|ED 49  |OUT (C),C    |2   |12    |--------|
|ED 51  |OUT (C),D    |2   |12    |--------|
|ED 59  |OUT (C),E    |2   |12    |--------|
|ED 61  |OUT (C),H    |2   |12    |--------|
|ED 69  |OUT (C),L    |2   |12    |--------|

|ED 42  |SBC HL,BC    |2   |15    |SZXHXV1C|
|ED 52  |SBC HL,DE    |2   |15    |SZXHXV1C|
|ED 62  |SBC HL,HL    |2   |15    |SZXHXV1C|
|ED 72  |SBC HL,SP    |2   |15    |SZXHXV1C|

|ED 43  |LD (a16),BC  |4   |20    |--------|
|ED 53  |LD (a16),DE  |4   |20    |--------|
|ED 63  |LD (a16),HL  |4   |20    |--------|
|ED 73  |LD (a16),SP  |4   |20    |--------|

|ED 44  |NEG          |2   |8     |SZXHXV1C|
|ED 4C  |NEG          |2   |8     |SZXHXV1C|
|ED 54  |NEG          |2   |8     |SZXHXV1C|
|ED 5C  |NEG          |2   |8     |SZXHXV1C|
|ED 64  |NEG          |2   |8     |SZXHXV1C|
|ED 6C  |NEG          |2   |8     |SZXHXV1C|
|ED 74  |NEG          |2   |8     |SZXHXV1C|
|ED 7C  |NEG          |2   |8     |SZXHXV1C|

|ED 45  |RETN         |2   |14    |--------|
|ED 4D  |RETI         |2   |14    |--------|
|ED 55  |RETN         |2   |14    |--------|
|ED 5D  |RETN         |2   |14    |--------|
|ED 75  |RETN         |2   |14    |--------|
|ED 65  |RETN         |2   |14    |--------|
|ED 6D  |RETN         |2   |14    |--------|
|ED 7D  |RETN         |2   |14    |--------|

|ED 46  |IM 0         |2   |8     |--------|
|ED 4E  |IM 0         |2   |8     |--------|
|ED 56  |IM 1         |2   |8     |--------|
|ED 5E  |IM 2         |2   |8     |--------|
|ED 66  |IM 0         |2   |8     |--------|
|ED 6E  |IM 0         |2   |8     |--------|
|ED 76  |IM 1         |2   |8     |--------|
|ED 7E  |IM 2         |2   |8     |--------|

|ED 4A  |ADC HL,BC    |2   |15    |SZXHXV0C|
|ED 5A  |ADC HL,DE    |2   |15    |SZXHXV0C|
|ED 6A  |ADC HL,HL    |2   |15    |SZXHXV0C|
|ED 7A  |ADC HL,SP    |2   |15    |SZXHXV0C|

|ED 4B  |LD BC,(a16)  |4   |20    |--------|
|ED 5B  |LD DE,(a16)  |4   |20    |--------|
|ED 6B  |LD HL,(a16)  |4   |20    |--------|
|ED 7B  |LD SP,(a16)  |4   |20    |--------|
}
  end;
