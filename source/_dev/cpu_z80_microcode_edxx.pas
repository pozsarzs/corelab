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
           FLastInstruction.Mnemonic := 'LD I,A';
           FLastInstruction.Cycles := 9;
         end;
    // LD R, A
    $4F: begin
           FLastInstruction.Mnemonic := 'LD R,A';
           FLastInstruction.Cycles := 9;
         end;
    // LD A, I
    $57: begin
           FLastInstruction.Mnemonic := 'LD A,I';
           // |SZY0XP0-|
           FLastInstruction.Cycles := 9;
         end;
    // LD A, R
    $5F: begin
           FLastInstruction.Mnemonic := 'LD A,R';
           // |SZY0XP0-|
           FLastInstruction.Cycles := 9;
         end;
    // RRD
    $67: begin
           FLastInstruction.Mnemonic := 'RRD';
           // |SZY0XP0-|
           FLastInstruction.Cycles := 18;
         end;
    // RLD
    $6F: begin
           FLastInstruction.Mnemonic := 'RLD';
           // |SZY0XP0-|
           FLastInstruction.Cycles := 18;
         end;
    // IN (C)
    $70: begin
           FLastInstruction.Mnemonic := 'IN (C)';
           // |SZY0XP0-|
           FLastInstruction.Cycles := 12;
         end;
    // OUT (C),0
    $71: begin
           FLastInstruction.Mnemonic := 'OUT (C),0';
           FLastInstruction.Cycles := 12;
         end;
    // NOP
    $77: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;

    // IN A,(C)
    $78: begin
           FLastInstruction.Mnemonic := 'IN A,(C)';
           // |SZY0XP0-|
           FLastInstruction.Cycles := 12;
         end;
    // OUT (C),A
    $79: begin
           FLastInstruction.Mnemonic := 'OUT (C),A';
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
           // |--X0XV0-|
           FLastInstruction.Cycles := 16;
         end;
    // CPI
    $A1: begin
           FLastInstruction.Mnemonic := 'CPI';
           // |SZXHXV1-|
           FLastInstruction.Cycles := 16;
         end;
    // INI
    $A2: begin
           FLastInstruction.Mnemonic := 'INI';
           // |SZXHXV1-|
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
