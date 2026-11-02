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
    // IN r, (C) és OUT (C), r
    // IN:  $40, $48, $50, $58, $60, $68, $70, $78
    // OUT: $41, $49, $51, $59, $61, $69, $71, $79
    $40, $48, $50, $58, $60, $68, $70, $78,
    $41, $49, $51, $59, $61, $69, $71, $79:
         begin
           SourceRegIndex := (AOC shr 3) and $07; // 0..7: B, C, D, E, H, L, (HL/0), A
           if (AOC and $01) = 0 then
           begin
             // IN r, (C)
             if SourceRegIndex = 6
               then FLastInstruction.Mnemonic := 'IN (C)'
               else FLastInstruction.Mnemonic := 'IN ' + RegNames[SourceRegIndex] + ', (C)';
             b1 := FBus.ReadPort(FRegs.BC);
             if SourceRegIndex <> 6 then RegPointers[SourceRegIndex]^ := b1;
             if (b1 and $80) <> 0                                       // set S
               then FRegs.F := FRegs.F or $80
               else FRegs.F := FRegs.F and $7F;
             if b1 = 0                                                  // set Z
               then FRegs.F := FRegs.F or $40
               else FRegs.F := FRegs.F and $BF;
             b3 := b1 xor (b1 shr 4);                                 // set P/V
             b3 := b3 xor (b3 shr 2);
             b3 := b3 xor (b3 shr 1);
             if (b3 and 1) = 0
               then FRegs.F := FRegs.F or $04
               else FRegs.F := FRegs.F and $FB;
             FRegs.F := FRegs.F and $ED;                            // H = N = 0
             FRegs.F := (FRegs.F and $D7) or (b1 and $28);        // set X and Y
           end else
           begin
             // OUT (C), r
             if SourceRegIndex = 6 then
             begin
               FLastInstruction.Mnemonic := 'OUT (C), 0';
               b1 := 0;
             end else
             begin
               FLastInstruction.Mnemonic := 'OUT (C), ' + RegNames[SourceRegIndex];
               b1 := RegPointers[SourceRegIndex]^;
             end;
             FBus.WritePort(FRegs.BC, b1);
           end;
           FLastInstruction.Cycles := 12;
         end;
    // NEG
    $44, $4C, $54, $5C, $64, $6C, $74, $7C:
         begin
           FLastInstruction.Mnemonic := 'NEG';
           b1 := FRegs.A;
           i1 := Word(0) - b1;
           FRegs.A := i1 and $FF;
           UpdateFlags(i1, 0, b1, True, False);
           FLastInstruction.Cycles := 8;
         end;
    // RETN
    $45, $55, $5D, $65, $6D, $75, $7D:
         begin
           FLastInstruction.Mnemonic := 'RETN';
           w1 := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
           Inc(FRegs.SP);
           FRegs.PC := w1;
           FInterruptEnabled := FInterruptEnabled2;
           FLastInstruction.Cycles := 14;
         end;
    // IM 0
    $46, $4E, $66, $6E:
         begin
           FLastInstruction.Mnemonic := 'IM 0';
           FInterruptMode := 0;
           FLastInstruction.Cycles := 8;
         end;
    // IM 1
    $56, $76:
         begin
           FLastInstruction.Mnemonic := 'IM 1';
           FInterruptMode := 1;
           FLastInstruction.Cycles := 8;
         end;
    // IM 2
    $5E, $7E:
         begin
           FLastInstruction.Mnemonic := 'IM 2';
           FInterruptMode := 2;
           FLastInstruction.Cycles := 8;
         end;
    // LD I, A
    $47: begin
           FLastInstruction.Mnemonic := 'LD I, A';
           FRegs.I := FRegs.A;
           FLastInstruction.Cycles := 9;
         end;
    // RETI
    $4D: begin
           FLastInstruction.Mnemonic := 'RETI';
           w1 := FBus.ReadMemory(FRegs.SP);
           Inc(FRegs.SP);
           w1 := w1 + FBus.ReadMemory(FRegs.SP) * 256;
           Inc(FRegs.SP);
           FRegs.PC := w1;
           FInterruptEnabled := FInterruptEnabled2;
           FLastInstruction.Cycles := 14;
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
    // NOP
    $77: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
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
           b1 := FBus.ReadPort(FRegs.BC);
           FBus.WriteMemory(FRegs.HL, b1);
           Inc(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + ((FRegs.C + 1) and $FF);                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := Byte(i1) xor FRegs.B;                                  // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FLastInstruction.Cycles := 16;
         end;
    // OUTI
    $A3: begin
           FLastInstruction.Mnemonic := 'OUTI';
           b1 := FBus.ReadMemory(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           FBus.WritePort(FRegs.BC, b1);
           Inc(Fregs.HL);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + FRegs.L;                                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := (Byte(i1) and 7) xor FRegs.B;                          // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
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
           b1 := FBus.ReadMemory(FRegs.HL);
           FBus.WriteMemory(FRegs.DE, b1);
           if FRegs.DE = 0 then Fregs.DE := $FFFF else Dec(FRegs.DE);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
           if FRegs.BC = 0 then FRegs.BC := $FFFF else Dec(FRegs.BC);
           if FRegs.BC > 0                                            // set P/V
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or ((FRegs.A + b1)and $28);  // set X, Y
           FLastInstruction.Cycles := 16;
         end;
    // CPD
    $A9: begin
           FLastInstruction.Mnemonic := 'CPD';
           b1 := FBus.ReadMemory(FRegs.HL);
           i1 := FRegs.A - b1;
           Dec(Fregs.BC);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
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
    // IND
    $AA: begin
           FLastInstruction.Mnemonic := 'IND';
           b1 := FBus.ReadPort(FRegs.BC);
           FBus.WriteMemory(FRegs.HL, b1);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + ((FRegs.C - 1) and $FF);                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := Byte(i1) xor FRegs.B;                                  // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FLastInstruction.Cycles := 16;
         end;
    // OUTD
    $AB: begin
           FLastInstruction.Mnemonic := 'OUTD';
           b1 := FBus.ReadMemory(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           FBus.WritePort(FRegs.BC, b1);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + FRegs.L;                                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := (Byte(i1) and 7) xor FRegs.B;                          // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
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
           if FRegs.BC <> 0 then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
         end;
    // CPIR
    $B1: begin
           FLastInstruction.Mnemonic := 'CPIR';
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
           if (FRegs.BC <> 0) and (i1 <> 0) then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
         end;
    // INIR
    $B2: begin
           FLastInstruction.Mnemonic := 'INIR';
           b1 := FBus.ReadPort(FRegs.BC);
           FBus.WriteMemory(FRegs.HL, b1);
           Inc(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + ((FRegs.C + 1) and $FF);                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := Byte(i1) xor FRegs.B;                                  // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           if FRegs.B <> 0 then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
         end;
    // OTIR
    $B3: begin
           FLastInstruction.Mnemonic := 'OTIR';
           b1 := FBus.ReadMemory(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           FBus.WritePort(FRegs.BC, b1);
           Inc(Fregs.HL);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + FRegs.L;                                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := (Byte(i1) and 7) xor FRegs.B;                          // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           if FRegs.B <> 0 then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
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
           b1 := FBus.ReadMemory(FRegs.HL);
           FBus.WriteMemory(FRegs.DE, b1);
           if FRegs.DE = 0 then Fregs.DE := $FFFF else Dec(FRegs.DE);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
           if FRegs.BC = 0 then FRegs.BC := $FFFF else Dec(FRegs.BC);
           if FRegs.BC > 0                                            // set P/V
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           FRegs.F := FRegs.F and $ED;                              // H = N = 0
           FRegs.F := (FRegs.F and $D7) or ((FRegs.A + b1)and $28);  // set X, Y
           if FRegs.BC <> 0 then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
         end;
    // CPDR
    $B9: begin
           FLastInstruction.Mnemonic := 'CPDR';
           b1 := FBus.ReadMemory(FRegs.HL);
           i1 := FRegs.A - b1;
           Dec(Fregs.BC);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
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
           if (FRegs.BC <> 0) and (i1 <> 0) then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
         end;
    // INDR
    $BA: begin
           FLastInstruction.Mnemonic := 'INDR';
           b1 := FBus.ReadPort(FRegs.BC);
           FBus.WriteMemory(FRegs.HL, b1);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + ((FRegs.C - 1) and $FF);                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := Byte(i1) xor FRegs.B;                                  // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           if FRegs.B <> 0 then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
         end;
    // OTDR
    $BB: begin
           FLastInstruction.Mnemonic := 'OTDR';
           b1 := FBus.ReadMemory(FRegs.HL);
           if Fregs.B = 0 then Fregs.B := $FF else Dec(Fregs.B);
           FBus.WritePort(FRegs.BC, b1);
           if FRegs.HL = 0 then Fregs.HL := $FFFF else Dec(FRegs.HL);
           if FRegs.B > 0                                               // set Z
             then FRegs.F := FRegs.F and $BF
             else FRegs.F := FRegs.F or $40;
           FRegs.F := FRegs.F or $02;                                   // set N
           if (FRegs.B and $80) <> 0                                    // set S
             then FRegs.F := FRegs.F or $80
             else FRegs.F := FRegs.F and $7F;
           FRegs.F := (FRegs.F and $D7) or (FRegs.B and $28);     // set X and Y
           i1 := b1 + FRegs.L;                                          // set H
           if i1 > 255
             then FRegs.F := FRegs.F or $10
             else FRegs.F := FRegs.F and $EF;
           b2 := (Byte(i1) and 7) xor FRegs.B;                          // set P
           b3 := b2 xor (b2 shr 4);
           b3 := b3 xor (b3 shr 2);
           b3 := b3 xor (b3 shr 1);
           if (b3 and 1) = 0
             then FRegs.F := FRegs.F or $04
             else FRegs.F := FRegs.F and $FB;
           if FRegs.B <> 0 then
           begin
             FRegs.PC := FRegs.PC - 2;
             FLastInstruction.Cycles := 21;
           end else FLastInstruction.Cycles := 16;
         end;
    // NOP
    $BC..$FF:
         begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 8;
         end;
  else


{ 
|ED 42  |SBC HL,BC    |2   |15    |SZXHXV1C|
|ED 52  |SBC HL,DE    |2   |15    |SZXHXV1C|
|ED 62  |SBC HL,HL    |2   |15    |SZXHXV1C|
|ED 72  |SBC HL,SP    |2   |15    |SZXHXV1C|

|ED 43  |LD (a16),BC  |4   |20    |--------|
|ED 53  |LD (a16),DE  |4   |20    |--------|
|ED 63  |LD (a16),HL  |4   |20    |--------|
|ED 73  |LD (a16),SP  |4   |20    |--------|

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
