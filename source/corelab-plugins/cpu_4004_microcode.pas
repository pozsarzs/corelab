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
    // JCN 0-15
    $10..$1F:
         begin
           b1 := FBus.ReadROM(FRegs.PC);
           FRegs.PC := (FRegs.PC + 1) and FPCMask;
           b2 := AOC and $0F;
           FLastInstruction.Mnemonic := 'JCN ' + IntToStr(b2);
           bool1 := False;
           // Bit 2: Jump if the Accumulator is 0 (JZ).
           if ((b2 and $04) = $04) and (FRegs.A = 0) then bool1 := True;
           // Bit 1: Jump if the Carry flag is 1 (JC).
           if ((b2 and $02) = $02) and FFlags.C then bool1 := True;
           // Bit 0: Jump if the TEST pin is 0 (active low).
           if ((b2 and $01) = $01) and (FTestPin = False) then bool1 := True;
           // Bit 3: inversion
           if (b2 and $08) = $08 then bool1 := not bool1;
           if bool1 then FRegs.PC := (FRegs.PC and FPCMask and $FF00) or b1;
           FLastInstruction.Cycles := 16;
         end;
    // FIM 0-7 d8; SRC 0-7
    $20..$2F:
         if Odd(AOC) then
         begin
           // SRC 0-7
           SourceRegIndex := ((AOC shr 1) and $07);
           FLastInstruction.Mnemonic := 'SRC ' + IntToHex(SourceRegIndex, 1);
           SourceRegIndex := SourceRegIndex * 2;
           FBus.SendSRC((RegPointers[SourceRegIndex]^ shl 4) or
                        (RegPointers[SourceRegIndex + 1]^));
           FLastInstruction.Cycles := 8;
         end else
         begin
           // FIM 0-7 d8
           DestRegIndex := ((AOC shr 1) and $07);
           FLastInstruction.Mnemonic := 'FIM ' + IntToHex(SourceRegIndex, 1);
           FLastInstruction.NumOperand := 1;
           DestRegIndex := DestRegIndex * 2;
           b1 := FBus.ReadROM(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.PC := FRegs.PC and FPCMask;
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
           FLastInstruction.Mnemonic := 'JIN ' + IntToHex(SourceRegIndex, 1);
           SourceRegIndex := SourceRegIndex * 2;
           b1 := FRegs.PC and FPCMask and $FF00;
           b1 := b1 or (RegPointers[SourceRegIndex]^ shl 4) or
                       (RegPointers[SourceRegIndex + 1]^);
           FRegs.PC := b1 and FPCMask;
           FLastInstruction.Cycles := 8;
         end else
         begin
           // FIN 0-7
           SourceRegIndex := (AOC shr 1) and $07;
           DestRegIndex := SourceRegIndex * 2;
           FLastInstruction.Mnemonic := 'FIN ' + IntToHex(SourceRegIndex, 1);
           b1 := FBus.ReadROM((FRegs.PC and FPCMask and $FF00) or (Fregs.R[0] shl 4) or (Fregs.R[1] and $0F));
           RegPointers[DestRegIndex]^ := b1 shr 4;
           RegPointers[DestRegIndex + 1]^ := b1 and $0F;
           FLastInstruction.Cycles := 16;
         end;
    // JUN 0-15 a8
    $40..$4F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'JUN ' + IntToHex(SourceRegIndex, 1);
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadROM(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.PC := FRegs.PC and FPCMask;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FRegs.PC := (((Word(SourceRegIndex) shl 8) or b1) or (FROMBank shl 12)) and FPCMask;
           FLastInstruction.Cycles := 16;
         end;
    // JMS 0-15 a8
    $50..$5F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'JMS ' + IntToHex(SourceRegIndex, 1);
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadROM(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.PC := FRegs.PC and FPCMask;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           with FStack do
           begin
             Regs[Pointer] := FRegs.PC;
             Pointer := (Pointer + 1) mod FStackSize; 
           end;
           FRegs.PC := (((Word(SourceRegIndex) shl 8) or b1) or (FROMBank shl 12)) and FPCMask;
           FLastInstruction.Cycles := 16;
         end;
    // INC 0-15
    $60..$6F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'INC ' + IntToHex(SourceRegIndex, 1);
           Inc(RegPointers[SourceRegIndex]^);
           RegPointers[SourceRegIndex]^ := RegPointers[SourceRegIndex]^ and $0F;
           FLastInstruction.Cycles := 8;
         end;
    // ISZ 0-15 a8
    $70..$7F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'ISZ ' + IntToHex(SourceRegIndex, 1);
           FLastInstruction.NumOperand := 1;
           Inc(RegPointers[SourceRegIndex]^);
           RegPointers[SourceRegIndex]^ := RegPointers[SourceRegIndex]^ and $0F;
           b1 := FBus.ReadROM(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.PC := FRegs.PC and FPCMask;
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           if RegPointers[SourceRegIndex]^ <> 0
             then Fregs.PC := (Fregs.PC and FPCMask and $FF00) or b1;
           FLastInstruction.Cycles := 16;
         end;
    // ADD 0-15
    $80..$8F:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'ADD ' + IntToHex(SourceRegIndex, 1);
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
           FLastInstruction.Mnemonic := 'SUB ' + IntToHex(SourceRegIndex, 1);
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
           FLastInstruction.Mnemonic := 'LD ' + IntToHex(SourceRegIndex, 1);
           FRegs.A := RegPointers[SourceRegIndex]^;
           FLastInstruction.Cycles := 8;
         end;
    // XCH 0-15
    $B0..$BF:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'XCH ' + IntToHex(SourceRegIndex, 1);
           b1 := FRegs.A;
           FRegs.A := RegPointers[SourceRegIndex]^;
           RegPointers[SourceRegIndex]^ := b1;
           FLastInstruction.Cycles := 8;
         end;
    // BBL 0-15
    $C0..$CF:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'BBL ' + IntToHex(SourceRegIndex, 1);
           with FStack do
           begin
             if Pointer = 0 then Pointer := FStackSize -1 else Dec(Pointer);
             FRegs.PC := Regs[Pointer];
           end;
           Fregs.A := SourceRegIndex;
           FLastInstruction.Cycles := 8;
         end;
    // LDM 0-15
    $D0..$DF:
         begin
           SourceRegIndex := AOC and $0F;
           FLastInstruction.Mnemonic := 'LDM ' + IntToHex(SourceRegIndex, 1);
           Fregs.A := SourceRegIndex;
           FLastInstruction.Cycles := 8;
         end;
    // WRM
    $E0: begin
           FLastInstruction.Mnemonic := 'WRM';
           FBus.WriteRAM(FRegs.A);
           FLastInstruction.Cycles := 8;
         end;
    // WMP
    $E1: begin
           FLastInstruction.Mnemonic := 'WMP';
           FBus.WriteRAMIOPort(FRegs.A);
           FLastInstruction.Cycles := 8;
         end;
    // WRR
    $E2: begin
           FLastInstruction.Mnemonic := 'WRR';
           FBus.WriteROMIOPort(FRegs.A);
           FLastInstruction.Cycles := 8;
         end;
    // WPM
    $E3: begin
           FLastInstruction.Mnemonic := 'WPM';
           // not implemented
           // Write Program Memory function for 4008/4009/4289 chips
           FLastInstruction.Cycles := 8;
         end;
    // WR 0-3
    $E4..$E7:
         begin
           b1 := AOC and $03;
           FLastInstruction.Mnemonic := 'WR ' + IntToStr(b1);
           FBus.WriteRAMStatus(b1, FRegs.A);
           FLastInstruction.Cycles := 8;
         end;
    // SBM
    $E8: begin
           FLastInstruction.Mnemonic := 'SBM';
           b1 := FRegs.A + ((not FBus.ReadRAM) and $0F);
           if FFlags.C then Inc(b1);
           FRegs.A := b1 and $0F;
           FFlags.C := b1 > $0F;
           FLastInstruction.Cycles := 8;
         end;
    // RDM
    $E9: begin
           FLastInstruction.Mnemonic := 'RDM';
           b1 := FBus.ReadRAM;
           FRegs.A := b1 and $0F;
           FLastInstruction.Cycles := 8;
         end;
    // RDR
    $EA: begin
           FLastInstruction.Mnemonic := 'RDR';
           b1 := FBus.ReadROMIOPort;
           FRegs.A := b1 and $0F;
           FLastInstruction.Cycles := 8;
         end;
    // ADM
    $EB: begin
           FLastInstruction.Mnemonic := 'ADM';
           b1 := FRegs.A + FBus.ReadRAM;
           if FFlags.C then Inc(b1);
           FRegs.A := b1 and $0F;
           FFlags.C := b1 > $0F;
           FLastInstruction.Cycles := 8;
         end;
    // RD 0-3
    $EC..$EF:
         begin
           b1 := AOC and $03;
           FLastInstruction.Mnemonic := 'RD ' + IntToStr(b1);
           FRegs.A := FBus.ReadRAMStatus(b1) and $0F;
           FLastInstruction.Cycles := 8;
         end;
    // CLB
    $F0: begin
           FLastInstruction.Mnemonic := 'CLB';
           FRegs.A := 0;
           FFlags.C := False;
           FLastInstruction.Cycles := 8;
         end;
    // CLC
    $F1: begin
           FLastInstruction.Mnemonic := 'CLC';
           FFlags.C := False;
           FLastInstruction.Cycles := 8;
         end;
    // IAC
    $F2: begin
           FLastInstruction.Mnemonic := 'IAC';
           b1 := FRegs.A;
           Inc(b1);
           FRegs.A := b1 and $0F;
           FFlags.C := b1 > $0F;
           FLastInstruction.Cycles := 8;
         end;
    // CMC
    $F3: begin
           FLastInstruction.Mnemonic := 'CMC';
           FFlags.C := not FFlags.C;
           FLastInstruction.Cycles := 8;
         end;           
    // CMA
    $F4: begin
           FLastInstruction.Mnemonic := 'CMA';
           FRegs.A := (not FRegs.A) and $0F;
           FLastInstruction.Cycles := 8;
         end;           
    // RAR
    $F6: begin
           FLastInstruction.Mnemonic := 'RAR';
           bool1 := FFlags.C;
           b1 := FRegs.A and $0F;
           FFlags.C := ((b1 and $01) = 1);
           b1 := b1 shr 1;
           if bool1 then FRegs.A := b1 or $08 else FRegs.A := b1;
           FLastInstruction.Cycles := 8;
         end;           
    // TCC
    $F7: begin
           FLastInstruction.Mnemonic := 'TCC';
           if FFlags.C then FRegs.A := 1 else FRegs.A := 0;
           FFlags.C := False;
           FLastInstruction.Cycles := 8;
         end;
    // DAC
    $F8: begin
           FLastInstruction.Mnemonic := 'DAC';
           b1 := FRegs.A + $0F;
           FRegs.A := b1 and $0F;
           FFlags.C := b1 > $0F;
           FLastInstruction.Cycles := 8;
         end;
    // TCS
    $F9: begin
           FLastInstruction.Mnemonic := 'TCS';
           FRegs.A := 9;
           if FFlags.C then Inc(FRegs.A);
           FFlags.C := False;
           FLastInstruction.Cycles := 8;
         end;
    // STC
    $FA: begin
           FLastInstruction.Mnemonic := 'STC';
           FFLags.C := True;
           FLastInstruction.Cycles := 8;
         end;
    // DAA
    $FB: begin
           FLastInstruction.Mnemonic := 'DAA';
           if (FRegs.A > 9) or FFlags.C then
           begin
             w1 := FRegs.A + 6;
             FRegs.A := w1 and $0F;
             FFlags.C := (w1 > 15);
           end;
           FLastInstruction.Cycles := 8;
         end;
    // KBP
    $FC: begin
           FLastInstruction.Mnemonic := 'KBP';
           b1 := FRegs.A;
           FRegs.A := $F;
           if b1 = 0 then FRegs.A := $0 else
             for b2 := 0 to 3 do
               if b1 = 1 shl b2 then FRegs.A := b2 + 1;
           FLastInstruction.Cycles := 8;
         end;
    // DCL
    $FD: begin
           FLastInstruction.Mnemonic := 'DCL';
           FRegs.CCR := FRegs.A and $7;
           FLastInstruction.Cycles := 8;
         end;
  end;
