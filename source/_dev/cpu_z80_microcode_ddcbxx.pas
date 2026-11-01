{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_ddcbxx.pas                                             | }
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
    // RLC r; RLC (IX+r8)
    $00..$07:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'RLC (IX+%.2X)'
               else Mnemonic := 'RLC ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b2 := b1 shr 7;
           b1 := ((b1 shl 1) or b2) and $FF;
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // RRC r; RRC (IX+r8)
    $08..$0F:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'RRC (IX+%.2X)'
               else Mnemonic := 'RRC ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b2 := b1 and $01;
           b1 := (b1 shr 1) or (b2 shl 7);
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // RL r; RL (IX+r8)
    $10..$17:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'RL (IX+%.2X)'
               else Mnemonic := 'RL ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b3 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b1 := FRegs.F and $01;                                   // Old Carry
           b2 := b3 shr 7;                                          // New Carry
           b3 := ((b3 shl 1) or b1) and $FF;
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b3);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b3;
           w1 := (Word(b2) shl 8) or b3;
           UpdateFlags(w1, b3, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // RR r; RR (IX+r8)
    $18..$1F:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'RR (IX+%.2X)'
               else Mnemonic := 'RR ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b3 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b1 := FRegs.F and $01;                                   // Old Carry
           b2 := b3 and $01;                                        // New Carry
           b3 := (b3 shr 1) or (b1 shl 7);
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b3);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b3;
           w1 := (Word(b2) shl 8) or b3;
           UpdateFlags(w1, b3, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // SLA r; SLA (IX+r8)
    $20..$27:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'SLA (IX+%.2X)'
               else Mnemonic := 'SLA ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b2 := b1 shr 7;                                          // New Carry
           b1 := b1 shl 1;
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // SRA r; SRA (IX+r8)
    $28..$2F:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'SRA (IX+%.2X)'
               else Mnemonic := 'SRA ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b2 := b1 and 1;                                          // New Carry
           b1 := b1 shr 1;
           b1 := b1 or ((b1 and $40) shl 1);
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // SLL r; SLL (IX+r8)
    $30..$37:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'SLL (IX+%.2X)'
               else Mnemonic := 'SLL ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b2 := b1 shr 7;                                          // New Carry
           b1 := (b1 shl 1) or 1;
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // SRL r; SRL (IX+r8)
    $38..$3F:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'SRL (IX+%.2X)'
               else Mnemonic := 'SRL ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b2 := b1 and 1;                                          // New Carry
           b1 := b1 shr 1;
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
           FLastInstruction.Cycles := 23;
         end;
    // BIT n, r; BIT n, (IX+r8)
    $40..$7F:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           b2 := (AOC shr 3) and 7;                                 // bit index
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             Mnemonic := 'BIT ' + IntToStr(b2) + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           if (b1 and (1 shl b2)) > 0                                   // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $10;                                   // H = 1
           FRegs.F := FRegs.F and $FD;                                  // N = 0
           FLastInstruction.Cycles := 20;
         end;
    // RES n, r; RES n, (IX+r8)
    $80..$BF:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           b2 := (AOC shr 3) and 7;                                 // bit index
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'RES ' + IntToStr(b2) + ', (IX+%.2X)'
               else Mnemonic := 'RES ' + IntToStr(b2) + ', ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b1 := b1 and (not(1 shl b2));
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           FLastInstruction.Cycles := 23;
         end;
    // SET n, r; SET n, (IX+r8)
    $C0..$FF:
         begin
           offset := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           SourceRegIndex := AOC and $07;
           b2 := (AOC shr 3) and 7;                                 // bit index
           with FLastInstruction do
           begin
             NumOperand := 1;
             Operands[NumOperand] := offset;
             if SourceRegIndex = 6
               then Mnemonic := 'SET ' + IntToStr(b2) + ', (IX+%.2X)'
               else Mnemonic := 'SET ' + IntToStr(b2) + ', ' + RegNames[SourceRegIndex] + ', (IX+%.2X)';
           end;
           b1 := FBus.ReadMemory(FRegs.IX + ShortInt(offset));
           b1 := b1 or (1 shl b2);
           FBus.WriteMemory(FRegs.IX + ShortInt(offset), b1);
           if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
           FLastInstruction.Cycles := 23;
         end;
  end;
