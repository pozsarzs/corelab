{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_4004_microcode.pas                                                   | }
{ | Microcode for Intel 4004 CPU implementation module                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  // instructions
  case AOC of  
    // NOP
    $00: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
    // FIM 0-7 d8; SRC 0-7
    $20..$2F:
         if Odd(AOC) then
         begin
           // SRC 0-7
           SourceRegIndex := ((AOC shr 1) and $07);
           FLastInstruction.Mnemonic := 'SRC ' + IntToStr(SourceRegIndex);
           SourceRegIndex := SourceRegIndex * 2;
           FBus.SendSRC((RegPointers[SourceRegIndex]^ shl 4) or
                        (RegPointers[SourceRegIndex + 1]^));
           FLastInstruction.Cycles := 8;
         end else
         begin
           // FIM 0-7 d8
           DestRegIndex := ((AOC shr 1) and $07);
           FLastInstruction.Mnemonic := 'FIM ' + IntToStr(DestRegIndex);
           FLastInstruction.NumOperand := 1;
           DestRegIndex := DestRegIndex * 2;
           b1 := FBus.ReadROM(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.PC := FRegs.PC and $0FFF;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           RegPointers[DestRegIndex]^ := b1 shr 4;
           RegPointers[DestRegIndex + 1]^ := b1 and $0F;
           FLastInstruction.Cycles := 16;
         end;
    // FIN 0-7; JIN 0-7
    $30..$3F:
         if Odd(AOC) then
         begin
           // JIN 0-7
           SourceRegIndex := ((AOC shr 1) and $07);
           FLastInstruction.Mnemonic := 'JIN ' + IntToStr(SourceRegIndex);
           SourceRegIndex := SourceRegIndex * 2;
           b1 := FRegs.PC and $0F00;
           b1 := b1 or (RegPointers[SourceRegIndex]^ shl 4) or
                       (RegPointers[SourceRegIndex + 1]^);
           FRegs.PC := b1 and $0FFF;
           FLastInstruction.Cycles := 8;
         end else
         begin
           // FIN 0-7
           SourceRegIndex := (AOC shr 1) and $07;
           DestRegIndex := SourceRegIndex * 2;
           FLastInstruction.Mnemonic := 'FIN ' + IntToStr(SourceRegIndex);
           b1 := FBus.ReadROM((FRegs.PC and $0F00) or (Fregs.R[0] shl 4) or (Fregs.R[1] and $0F));
           RegPointers[DestRegIndex]^ := b1 shr 4;
           RegPointers[DestRegIndex + 1]^ := b1 and $0F;
           FLastInstruction.Cycles := 16;
         end;
    // INC 0-15
    $60..$6F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'INC ' + IntToStr(SourceRegIndex);
           Inc(RegPointers[SourceRegIndex]^);
           RegPointers[SourceRegIndex]^ := RegPointers[SourceRegIndex]^ and $0F;
           FLastInstruction.Cycles := 8;
         end;
    // ADD 0-15
    $80..$8F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'ADD ' + IntToStr(SourceRegIndex);
           b1 := FRegs.A + RegPointers[SourceRegIndex]^;
           if FFlags.C then Inc(b1);
           FRegs.A := b1 and $0F;
           FFlags.C := b1 > $0F;
           FLastInstruction.Cycles := 8;
         end;
    // SUB 0-15
    $90..$9F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'SUB ' + IntToStr(SourceRegIndex);
           b1 := FRegs.A + ((not RegPointers[SourceRegIndex]^) and $0F);
           if FFlags.C then Inc(b1);
           FRegs.A := b1 and $0F;
           FFlags.C := b1 > $0F;
           FLastInstruction.Cycles := 8;
         end;
    // LD 0-15
    $A0..$AF:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'LD ' + IntToStr(SourceRegIndex);
           FRegs.A := RegPointers[SourceRegIndex]^;
           FLastInstruction.Cycles := 8;
         end;
    // XCH 0-15
    $B0..$BF:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'XCH ' + IntToStr(SourceRegIndex);
           b1 := FRegs.A;
           FRegs.A := RegPointers[SourceRegIndex]^;
           RegPointers[SourceRegIndex]^ := b1;
           FLastInstruction.Cycles := 8;
         end;
    // BBL 0-15
    $C0..$CF:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'BBL ' + IntToStr(SourceRegIndex);
           with FStack do
           begin
             if Pointer = 0 then Pointer := 2 else Dec(Pointer);
             FRegs.PC := Regs[Pointer];
           end;
           Fregs.A := SourceRegIndex;
           FLastInstruction.Cycles := 8;
         end;
    // LDM 0-15
    $D0..$DF:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'LDM ' + IntToStr(SourceRegIndex);
           Fregs.A := SourceRegIndex;
           FLastInstruction.Cycles := 8;
         end;
  end;

{ 
    // common addressing
    procedure SendSRC(AAddress: Byte);
    // RAM functions (r/w memory and w I/O)
    function ReadRAM: Byte;
    procedure WriteRAM(AData: Byte);
    function ReadRAMStatus(AIndex: Byte): Byte;
    procedure WriteRAMStatus(AIndex: Byte; AData: Byte);
    procedure WriteRAMIOPort(AData: Byte);
    // ROM functions (r memory and r/w I/O)
    function ReadROM(AAddress: Word): Byte;
    function ReadROMIOPort: Byte;
    procedure WriteROMIOPort(AData: Byte);

|10    |JCN 0 a8 |2   |16    |---- |
|11    |JNT a8   |2   |16    |---- |
|12    |JC a8    |2   |16    |---- |
|13    |JCN 3 a8 |2   |16    |---- |
|14    |JZ a8    |2   |16    |---- |
|15    |JCN 5 a8 |2   |16    |---- |
|16    |JCN 6 a8 |2   |16    |---- |
|17    |JCN 7 a8 |2   |16    |---- |
|18    |JCN 8 a8 |2   |16    |---- |
|19    |JT a8    |2   |16    |---- |
|1A    |JNC a8   |2   |16    |---- |
|1B    |JCN 11 a8|2   |16    |---- |
|1C    |JNZ a8   |2   |16    |---- |
|1D    |JCN 13 a8|2   |16    |---- |
|1E    |JCN 14 a8|2   |16    |---- |
|1F    |JCN 15 a8|2   |16    |---- |
|40    |JUN 0 a8 |2   |16    |---- |
|41    |JUN 1 a8 |2   |16    |---- |
|42    |JUN 2 a8 |2   |16    |---- |
|43    |JUN 3 a8 |2   |16    |---- |
|44    |JUN 4 a8 |2   |16    |---- |
|45    |JUN 5 a8 |2   |16    |---- |
|46    |JUN 6 a8 |2   |16    |---- |
|47    |JUN 7 a8 |2   |16    |---- |
|48    |JUN 8 a8 |2   |16    |---- |
|49    |JUN 9 a8 |2   |16    |---- |
|4A    |JUN 10 a8|2   |16    |---- |
|4B    |JUN 11 a8|2   |16    |---- |
|4C    |JUN 12 a8|2   |16    |---- |
|4D    |JUN 13 a8|2   |16    |---- |
|4E    |JUN 14 a8|2   |16    |---- |
|4F    |JUN 15 a8|2   |16    |---- |
|50    |JMS 0 a8 |2   |16    |---- |
|51    |JMS 1 a8 |2   |16    |---- |
|52    |JMS 2 a8 |2   |16    |---- |
|53    |JMS 3 a8 |2   |16    |---- |
|54    |JMS 4 a8 |2   |16    |---- |
|55    |JMS 5 a8 |2   |16    |---- |
|56    |JMS 6 a8 |2   |16    |---- |
|57    |JMS 7 a8 |2   |16    |---- |
|58    |JMS 8 a8 |2   |16    |---- |
|59    |JMS 9 a8 |2   |16    |---- |
|5A    |JMS 10 a8|2   |16    |---- |
|5B    |JMS 11 a8|2   |16    |---- |
|5C    |JMS 12 a8|2   |16    |---- |
|5D    |JMS 13 a8|2   |16    |---- |
|5E    |JMS 14 a8|2   |16    |---- |
|5F    |JMS 15 a8|2   |16    |---- |
|70    |ISZ 0 a8 |2   |16    |---- |
|71    |ISZ 1 a8 |2   |16    |---- |
|72    |ISZ 2 a8 |2   |16    |---- |
|73    |ISZ 3 a8 |2   |16    |---- |
|74    |ISZ 4 a8 |2   |16    |---- |
|75    |ISZ 5 a8 |2   |16    |---- |
|76    |ISZ 6 a8 |2   |16    |---- |
|77    |ISZ 7 a8 |2   |16    |---- |
|78    |ISZ 8 a8 |2   |16    |---- |
|79    |ISZ 9 a8 |2   |16    |---- |
|7A    |ISZ 10 a8|2   |16    |---- |
|7B    |ISZ 11 a8|2   |16    |---- |
|7C    |ISZ 12 a8|2   |16    |---- |
|7D    |ISZ 13 a8|2   |16    |---- |
|7E    |ISZ 14 a8|2   |16    |---- |
|7F    |ISZ 15 a8|2   |16    |---- |
|E0    |WRM      |1   |8     |---- |
|E1    |WMP      |1   |8     |---- |
|E2    |WRR      |1   |8     |---- |
|E3    |WPM      |1   |8     |---- |
|E4    |WR0      |1   |8     |---- |
|E5    |WR1      |1   |8     |---- |
|E6    |WR2      |1   |8     |---- |
|E7    |WR3      |1   |8     |---- |
|E8    |SBM      |1   |8     |C    |
|E9    |RDM      |1   |8     |---- |
|EA    |RDR      |1   |8     |---- |
|EB    |ADM      |1   |8     |C    |
|EC    |RD0      |1   |8     |---- |
|ED    |RD1      |1   |8     |---- |
|EE    |RD2      |1   |8     |---- |
|EF    |RD3      |1   |8     |---- |
|F0    |CLB      |1   |8     |C    |
|F1    |CLC      |1   |8     |C    |
|F2    |IAC      |1   |8     |C    |
|F3    |CMC      |1   |8     |C    |
|F4    |CMA      |1   |8     |---- |
|F5    |RAL      |1   |8     |C    |
|F6    |RAR      |1   |8     |C    |
|F7    |TCC      |1   |8     |C    |
|F8    |DAC      |1   |8     |C    |
|F9    |TCS      |1   |8     |C    |
|FA    |STC      |1   |8     |C    |
|FB    |DAA      |1   |8     |C    |
|FC    |KBP      |1   |8     |---- |
|FD    |DCL      |1   |8     |---- |
}
