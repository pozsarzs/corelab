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
{ 
|ED 40  |IN B,(C)     |2   |12    |SZX0XP0-|
|ED 41  |OUT (C),B    |2   |12    |--------|
|ED 42  |SBC HL,BC    |2   |15    |SZXHXV1C|
|ED 43  |LD (a16),BC  |4   |20    |--------|
|ED 44  |NEG          |2   |8     |SZXHXV1C|
|ED 45  |RETN         |2   |14    |--------|
|ED 46  |IM 0         |2   |8     |--------|
|ED 47  |LD I,A       |2   |9     |--------|
|ED 48  |IN C,(C)     |2   |12    |SZX0XP0-|
|ED 49  |OUT (C),C    |2   |12    |--------|
|ED 4A  |ADC HL,BC    |2   |15    |SZXHXV0C|
|ED 4B  |LD BC,(a16)  |4   |20    |--------|
|ED 4C  |NEG          |2   |8     |SZXHXV1C|
|ED 4D  |RETI         |2   |14    |--------|
|ED 4E  |IM 0         |2   |8     |--------|
|ED 4F  |LD R,A       |2   |9     |--------|
|ED 50  |IN D,(C)     |2   |12    |SZX0XP0-|
|ED 51  |OUT (C),D    |2   |12    |--------|
|ED 52  |SBC HL,DE    |2   |15    |SZXHXV1C|
|ED 53  |LD (a16),DE  |4   |20    |--------|
|ED 54  |NEG          |2   |8     |SZXHXV1C|
|ED 55  |RETN         |2   |14    |--------|
|ED 56  |IM 1         |2   |8     |--------|
|ED 57  |LD A,I       |2   |9     |SZY0XP0-|
|ED 58  |IN E,(C)     |2   |12    |SZX0XP0-|
|ED 59  |OUT (C),E    |2   |12    |--------|
|ED 5A  |ADC HL,DE    |2   |15    |SZXHXV0C|
|ED 5B  |LD DE,(a16)  |4   |20    |--------|
|ED 5C  |NEG          |2   |8     |SZXHXV1C|
|ED 5D  |RETN         |2   |14    |--------|
|ED 5E  |IM 2         |2   |8     |--------|
|ED 5F  |LD A,R       |2   |9     |SZY0XP0-|
|ED 60  |IN H,(C)     |2   |12    |SZX0XP0-|
|ED 61  |OUT (C),H    |2   |12    |--------|
|ED 62  |SBC HL,HL    |2   |15    |SZXHXV1C|
|ED 63  |LD (a16),HL  |4   |20    |--------|
|ED 64  |NEG          |2   |8     |SZXHXV1C|
|ED 65  |RETN         |2   |14    |--------|
|ED 66  |IM 0         |2   |8     |--------|
|ED 67  |RRD          |2   |18    |SZX0XP0-|
|ED 68  |IN L,(C)     |2   |12    |SZX0XP0-|
|ED 69  |OUT (C),L    |2   |12    |--------|
|ED 6A  |ADC HL,HL    |2   |15    |SZXHXV0C|
|ED 6B  |LD HL,(a16)  |4   |20    |--------|
|ED 6C  |NEG          |2   |8     |SZXHXV1C|
|ED 6D  |RETN         |2   |14    |--------|
|ED 6E  |IM 0         |2   |8     |--------|
|ED 6F  |RLD          |2   |18    |SZX0XP0-|
|ED 70  |IN (C)       |2   |12    |SZX0XP0-|
|ED 71  |OUT (C),0    |2   |12    |--------|
|ED 72  |SBC HL,SP    |2   |15    |SZXHXV1C|
|ED 73  |LD (a16),SP  |4   |20    |--------|
|ED 74  |NEG          |2   |8     |SZXHXV1C|
|ED 75  |RETN         |2   |14    |--------|
|ED 76  |IM 1         |2   |8     |--------|
}
    $77: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
{ 
|ED 78  |IN A,(C)     |2   |12    |SZX0XP0-|
|ED 79  |OUT (C),A    |2   |12    |--------|
|ED 7A  |ADC HL,SP    |2   |15    |SZXHXV0C|
|ED 7B  |LD SP,(a16)  |4   |20    |--------|
|ED 7C  |NEG          |2   |8     |SZXHXV1C|
|ED 7D  |RETN         |2   |14    |--------|
|ED 7E  |IM 2         |2   |8     |--------|
}
    // NOP
    $7F..$9F:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
{ 
|ED A0  |LDI          |2   |16    |--X0XV0-|
|ED A1  |CPI          |2   |16    |SZXHXV1-|
|ED A2  |INI          |2   |16    |SZXHXV1-|
|ED A3  |OUTI         |2   |16    |SZXHXV1-|
}
    $A4..$A7:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
{-
|ED A8  |LDD          |2   |16    |--X0XV0-|
|ED A9  |CPD          |2   |16    |SZXHXV1-|
|ED AA  |IND          |2   |16    |SZXHXV1-|
|ED AB  |OUTD         |2   |16    |SZXHXV1-|
}
    $AC..$AF:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
{-
|ED B0  |LDIR         |2   |21/16 |--X0XV0-|
|ED B1  |CPIR         |2   |21/16 |SZXHXV1-|
|ED B2  |INIR         |2   |21/16 |SZXHXV1-|
|ED B3  |OTIR         |2   |21/16 |SZXHXV1-|
}
    $B4..$B7:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
{-
|ED B8  |LDDR         |2   |21/16 |--X0XV0-|
|ED B9  |CPDR         |2   |21/16 |SZXHXV1-|
|ED BA  |INDR         |2   |21/16 |SZXHXV1-|
|ED BB  |OTDR         |2   |21/16 |SZXHXV1-|
}
    // NOP
    $BC..$FF:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
  end;
