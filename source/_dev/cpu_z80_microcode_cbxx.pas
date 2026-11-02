{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_cbxx.pas                                               | }
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
    Prefixes[NumPrefix] := AOC;
  end;
  // instructions
  case AOC of
    // RLC r; RLC (HL)
    $00..$07:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'RLC (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'RLC ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b2 := b1 shr 7;
           b1 := ((b1 shl 1) or b2) and $FF;
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
         end;
    // RRC r; RRC (HL)
    $08..$0F:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'RRC (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'RRC ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b2 := b1 and $01;
           b1 := (b1 shr 1) or (b2 shl 7);
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
         end;
    // RL r; RL (HL)
    $10..$17:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'RL (HL)';
             b3 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'RL ' + RegNames[SourceRegIndex];
             b3 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b1 := FRegs.F and $01;                                   // Old Carry
           b2 := b3 shr 7;                                          // New Carry
           b3 := ((b3 shl 1) or b1) and $FF;
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b3)
             else RegPointers[SourceRegIndex]^ := b3;
           w1 := (Word(b2) shl 8) or b3;
           UpdateFlags(w1, b3, 0, False, True);
         end;
    // RR r; RR (HL)
    $18..$1F:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'RR (HL)';
             b3 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'RR ' + RegNames[SourceRegIndex];
             b3 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b1 := FRegs.F and $01;                                   // Old Carry
           b2 := b3 and $01;                                        // New Carry
           b3 := (b3 shr 1) or (b1 shl 7);
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b3)
             else RegPointers[SourceRegIndex]^ := b3;
           w1 := (Word(b2) shl 8) or b3;
           UpdateFlags(w1, b3, 0, False, True);
         end;
    // SLA r; SLA (HL)
    $20..$27:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'SLA (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'SLA ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b2 := b1 shr 7;                                          // New Carry
           b1 := b1 shl 1;
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
         end;
    // SRA r; SRA (HL)
    $28..$2F:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'SRA (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'SRA ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b2 := b1 and 1;                                          // New Carry
           b1 := b1 shr 1;
           b1 := b1 or ((b1 and $40) shl 1);
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
         end;
    // SLL r; SLL (HL)
    $30..$37:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'SLL (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'SLL ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b2 := b1 shr 7;                                          // New Carry
           b1 := (b1 shl 1) or 1;
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
         end;
    // SRL r; SRL (HL)
    $38..$3F:
         begin
           SourceRegIndex := AOC and $07;
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'SRL (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'SRL ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b2 := b1 and 1;                                          // New Carry
           b1 := b1 shr 1;
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
           w1 := (Word(b2) shl 8) or b1;
           UpdateFlags(w1, b1, 0, False, True);
         end;
    // BIT n, r; BIT n, (HL)
    $40..$7F:
         begin
           SourceRegIndex := AOC and $07;
           b2 := (AOC shr 3) and 7;                                 // bit index
           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'BIT ' + IntToStr(b2) + ', (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 12;
           end else
           begin
             FLastInstruction.Mnemonic := 'BIT ' + IntToStr(b2) + ', ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           if (b1 and (1 shl b2)) > 0                                   // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $10;                                   // H = 1
           FRegs.F := FRegs.F and $FD;                                  // N = 0
         end;
    // RES n, r; RES n, (HL)
    $80..$BF:
         begin
           SourceRegIndex := AOC and $07;
           b2 := (AOC shr 3) and 7;                                 // bit index

           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'RES ' + IntToStr(b2) + ', (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'RES ' + IntToStr(b2) + ', ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b1 := b1 and (not(1 shl b2));
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
         end;
    // SET n, r; SET n, (HL)
    $C0..$FF:
         begin
           SourceRegIndex := AOC and $07;
           b2 := (AOC shr 3) and 7;                                 // bit index

           if SourceRegIndex = 6 then
           begin
             FLastInstruction.Mnemonic := 'SET ' + IntToStr(b2) + ', (HL)';
             b1 := FBus.ReadMemory(FRegs.HL);
             FLastInstruction.Cycles := 15;
           end else
           begin
             FLastInstruction.Mnemonic := 'SET ' + IntToStr(b2) + ', ' + RegNames[SourceRegIndex];
             b1 := RegPointers[SourceRegIndex]^;
             FLastInstruction.Cycles := 8;
           end;
           b1 := b1 or (1 shl b2);
           if SourceRegIndex = 6
             then FBus.WriteMemory(FRegs.HL, b1)
             else RegPointers[SourceRegIndex]^ := b1;
         end;
  end;
