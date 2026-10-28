{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_8008_microcode.pas                                                   | }
{ | Microcode for Intel 8008 CPU implementation module                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case AOC of  
    // HLT
    $00, $01, $FF:
         begin
           FLastInstruction.Mnemonic := 'HLT';
           FHalted := true;
           EmitEvent(ceHalt);
           FLastInstruction.Cycles := 8;
         end;
    // RLC
    $02: begin
           FLastInstruction.Mnemonic := 'RLC';
           b1 := FRegs.A shr 7; { A 7. bit }
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FFlags.C := (b1 = 1);                                { CY refresh }
           FLastInstruction.Cycles := 10;
         end;
    // RFC
    $03: begin
           FLastInstruction.Mnemonic := 'RFC';
           if not FFlags.C then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // ADI d8
    $04: begin
           FLastInstruction.Mnemonic := 'ADI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           b2 := Fregs.A;
           w1 := b2 + b1;
           Fregs.A := w1 and $00FF;
           UpdateFlags(w1);
           FLastInstruction.Cycles := 16;
         end;
    // RET
    $07, $0F, $17, $1F, $27, $2F, $37, $3F:
         begin
           FLastInstruction.Mnemonic := 'RET';
           with FStack do
           begin
             if Pointer = 0 then Pointer := 6 else Dec(Pointer);
             FRegs.PC := Regs[Pointer];
           end;
           FLastInstruction.Cycles := 7;
         end;
    // RRC
    $0A: begin
           FLastInstruction.Mnemonic := 'RRC';
           b1 := FRegs.A and $01; { A 0. bit }
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FFlags.C := (b1 = 1);
           FLastInstruction.Cycles := 10;
         end;
    // RFZ
    $0B: begin
           FLastInstruction.Mnemonic := 'RFZ';
           if not FFlags.Z then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // ACI d8
    $0C: begin
           FLastInstruction.Mnemonic := 'ACI';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           b1 := FRegs.A;
           b2 := Ord(FFlags.C);
           w2 := b1 + w1 + b2;
           FRegs.A := w2 and $00FF;
           UpdateFlags(w2);
           FLastInstruction.Cycles := 16;
         end;
    // RAL
    $12: begin
           FLastInstruction.Mnemonic := 'RAL';
           if FFlags.C then b1 := 1 else b1 := 0;
           b2 := FRegs.A shr 7;
           FRegs.A := ((FRegs.A shl 1) or b1) and $FF;
           FFlags.C := (b2 = 1);
           FLastInstruction.Cycles := 10;
         end;
    // RFS
    $13: begin
           FLastInstruction.Mnemonic := 'RFS';
           if not FFlags.S then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // SUI d8
    $14: begin
           FLastInstruction.Mnemonic := 'SUI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           w1 := FRegs.A - b1;
           FRegs.A := w1 and $00FF;
           UpdateFlags(w1);
           FLastInstruction.Cycles := 16;
         end;
    // RAR
    $1A: begin
           FLastInstruction.Mnemonic := 'RAR';
           if FFlags.C then b1 := 1 else b1 := 0;
           b2 := FRegs.A and $01;
           FRegs.A := (FRegs.A shr 1) or (b1 shl 7);
           FFlags.C := (b2 = 1);
           FLastInstruction.Cycles := 10;
         end;
    // RFP
    $1B: begin
           FLastInstruction.Mnemonic := 'RFP';
           if not FFlags.P then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // SBI d8
    $1C: begin
           FLastInstruction.Mnemonic := 'SBI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           if FFlags.C then b2 := 1 else b2 := 0;
           w1 := FRegs.A - b1 - b2;
           FRegs.A := w1 and $00FF;
           UpdateFlags(w1);
           FLastInstruction.Cycles := 16;
         end;
    // RTC
    $23: begin
           FLastInstruction.Mnemonic := 'RTC';
           if FFlags.C then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // NDI d8
    $24: begin
           FLastInstruction.Mnemonic := 'NDI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FRegs.A := FRegs.A and b1;
           UpdateFlags(FRegs.A);
           FLastInstruction.Cycles := 16;
         end;
    // RTZ
    $2B: begin
           FLastInstruction.Mnemonic := 'RTZ';
           if FFlags.Z then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // XRI d8
    $2C: begin
           FLastInstruction.Mnemonic := 'XRI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FRegs.A := FRegs.A xor b1;
           UpdateFlags(FRegs.A);
           FLastInstruction.Cycles := 16;
         end;
    // RTS
    $33: begin
           FLastInstruction.Mnemonic := 'RTS';
           if FFlags.S then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // ORI d8
    $34: begin
           FLastInstruction.Mnemonic := 'ORI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           FRegs.A := FRegs.A or b1;
           UpdateFlags(FRegs.A);
           FLastInstruction.Cycles := 16;
         end;
    // RTP
    $3B: begin
           FLastInstruction.Mnemonic := 'RTP';
           if FFlags.P then
           begin
             with FStack do
             begin
               if Pointer = 0 then Pointer := 6 else Dec(Pointer);
               FRegs.PC := Regs[Pointer];
             end;
             FLastInstruction.Cycles := 10;
           end else FLastInstruction.Cycles := 6;
         end;
    // CPI d8
    $3C: begin
           FLastInstruction.Mnemonic := 'CPI';
           FLastInstruction.NumOperand := 1;
           b1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := b1;
           w1 := FRegs.A - b1;
           UpdateFlags(w1);
           FLastInstruction.Cycles := 16;
         end;
    // JFC a16
    $40: begin
           FLastInstruction.Mnemonic := 'JFC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.C then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CFC a16
    $42: begin
           FLastInstruction.Mnemonic := 'CFC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.C then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // JMP a16
    $44, $4C, $54, $5C, $64, $6C, $74, $7C:
         begin
           FLastInstruction.Mnemonic := 'JMP';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           FRegs.PC := w1 and $3FFF;
           FLastInstruction.Cycles := 22;
         end;
    // CAL a16
    $46, $4E, $56, $5E, $66, $6E, $76, $7E:
         begin
           FLastInstruction.Mnemonic := 'CAL';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           with FStack do
           begin
             Regs[Pointer] := FRegs.PC;
             Pointer := (Pointer + 1) mod 7;
           end;  
           FRegs.PC := w1 and $3FFF;
           FLastInstruction.Cycles := 28;
         end;
    // JFZ a16
    $48: begin
           FLastInstruction.Mnemonic := 'JFZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.Z then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CFZ a16
    $4A: begin
           FLastInstruction.Mnemonic := 'CFZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.Z then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // JFS a16
    $50: begin
           FLastInstruction.Mnemonic := 'JFS';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.S then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CFS a16
    $52: begin
           FLastInstruction.Mnemonic := 'CFS';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.S then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // JFP a16
    $58: begin
           FLastInstruction.Mnemonic := 'JFP';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.P then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CFP a16
    $5A: begin
           FLastInstruction.Mnemonic := 'CFP';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if not FFlags.P then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // JTC a16
    $60: begin
           FLastInstruction.Mnemonic := 'JTC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.C then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CTC a16
    $62: begin
           FLastInstruction.Mnemonic := 'CTC';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.C then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // JTZ a16
    $68: begin
           FLastInstruction.Mnemonic := 'JTZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.Z then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CTZ a16
    $6A: begin
           FLastInstruction.Mnemonic := 'CTZ';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.Z then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // JTS a16
    $70: begin
           FLastInstruction.Mnemonic := 'JTS';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.S then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CTS a16
    $72: begin
           FLastInstruction.Mnemonic := 'CTS';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.S then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // JTP a16
    $78: begin
           FLastInstruction.Mnemonic := 'JTP';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.P then
           begin
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // CTP a16
    $7A: begin
           FLastInstruction.Mnemonic := 'CTP';
           FLastInstruction.NumOperand := 1;
           w1 := FBus.ReadMemory(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.ReadMemory(FRegs.PC) * 256;
           Inc(FRegs.PC);
           FLastInstruction.Operands[FLastInstruction.NumOperand] := w1;
           if FFlags.P then
           begin
             with FStack do
             begin
               Regs[Pointer] := FRegs.PC;
               Pointer := (Pointer + 1) mod 7;
             end;  
             FRegs.PC := w1 and $3FFF;
             FLastInstruction.Cycles := 22;
           end else FLastInstruction.Cycles := 18;
         end;
    // NOP
    $C0: begin
           FLastInstruction.Mnemonic := 'NOP';
           FLastInstruction.Cycles := 10;
         end;
  else
    // LAI-LMI 
    // $06, $0E, $16, $1E, $26, $2E, $36, $3E
    if (AOC >= $06) and (AOC <= $3E) and ((AOC and $C7) = $06) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'L' + RegNames[DestRegIndex] + 'I';
      FLastInstruction.NumOperand := 1;
      b1 := FBus.ReadMemory(FRegs.PC);
      Inc(FRegs.PC);
      FLastInstruction.Operands[1] := b1;
      if DestRegIndex = 7 then
      begin
        // LMI d8
        FBus.WriteMemory((FRegs.H shl 8) or FRegs.L, b1);
        FLastInstruction.Cycles := 18;
      end else
      begin
        // LrI d8
        RegPointers[DestRegIndex]^ := b1;
        FLastInstruction.Cycles := 16;
      end;
    end;
    // INB-INL
    // $08, $10, $18, $20, $28, $30
    if (AOC >= $08) and (AOC <= $30) and ((AOC and $07) = $00) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'IN' + RegNames[DestRegIndex];
      bool1 := FFlags.C;                                          { store Carry }
      Inc(RegPointers[DestRegIndex]^);
      UpdateFlags(RegPointers[DestRegIndex]^);
      FLastInstruction.Cycles := 10;
      FFlags.C := bool1;                                        { restore Carry }
    end;
    // DCB-DCL
    // $09, $11, $19, $21, $29, $31
    if (AOC >= $09) and (AOC <= $31) and ((AOC and $07) = $01) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'DC' + RegNames[DestRegIndex];
      bool1 := FFlags.C;                                          { store Carry }
      Dec(RegPointers[DestRegIndex]^);
      UpdateFlags(RegPointers[DestRegIndex]^);
      FLastInstruction.Cycles := 10;
      FFlags.C := bool1;                                        { restore Carry }
    end;
    // RST n
    // $05, $0D, $15, $1D, $25, $2D, $35, $3D
    if (AOC and $C7) = $05 then
    begin
      w1 := (AOC shr 3) and $07;
      FLastInstruction.Mnemonic := 'RST ' + IntToStr(w1);
      with FStack do
      begin
        Regs[Pointer] := FRegs.PC;
        Pointer := (Pointer + 1) mod 7; 
      end;
      FRegs.PC := w1 * 8;
      FLastInstruction.Cycles := 10;
    end;
    // INP n
    // $43, $45, $47, $49, $4B, $4D, $4F
    if (Odd(AOC)) and (AOC >= $41) and (AOC <= $4F) then
    begin
      FRegs.A := FBus.ReadPort((AOC - $41) div 2);
      FLastInstruction.Mnemonic := 'INP' + IntToStr((AOC - $41) div 2);
      FLastInstruction.Cycles := 16;
    end;  
    // OUT n
    // $51, $53, ... $7F
    if (Odd(AOC)) and (AOC >= $51) and (AOC <= $7F) then
    begin
      FBus.WritePort((AOC - $41) div 2, FRegs.A);
      FLastInstruction.Mnemonic := 'OUT' + IntToStr((AOC - $41) div 2);
      FLastInstruction.Cycles := 12;
    end;  
    // ADA-ADM
    // $80-$87
    if (AOC >= $80) and (AOC <= $87) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'AD' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 + w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2);
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // ACA-ACM
    // $88-$8F
    if (AOC >= $88) and (AOC <= $8F) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'AC' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := Ord(FFlags.C);
      w2 := b1 + w1 + b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2);
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // SUA-SUM
    // $90-$97
    if (AOC >= $90) and (AOC <= $97) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'SU' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(b1 + (w1 xor $FF) + 1);
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // SBA-SBM
    // $98-$9F
    if (AOC >= $98) and (AOC <= $9F) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'SB' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := Ord(FFlags.C);
      w2 := b1 - w1 - b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2);
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // NDA-NDM
    // $A0-$A7
    if (AOC >= $A0) and (AOC <= $A7) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'AN' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A and b1;
      UpdateFlags(FRegs.A);
      FFlags.C := False;
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // XRA-XRM
    // $A8-$AF
    if (AOC >= $A8) and (AOC <= $AF) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'XR' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A xor b1;
      UpdateFlags(FRegs.A);
      FFlags.C := False;
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // ORA-ORM
    // $B0-$B7
    if (AOC >= $B0) and (AOC <= $B7) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'OR' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A or b1;
      UpdateFlags(FRegs.A);
      FFlags.C := False;
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // CPA-CPM
    // $B8-$BF
    if (AOC >= $B8) and (AOC <= $BF) then
    begin
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'CP' + RegNames[SourceRegIndex];
      if SourceRegIndex = 7
        then w1 := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L)
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      UpdateFlags(w2);
      if SourceRegIndex = 7
        then FLastInstruction.Cycles := 16
        else FLastInstruction.Cycles := 10;
    end;
    // LAB-LAM, LBA-LBM, ... LMA-LML
    // $C1-$FE
    if (AOC >= $C1) and (AOC <= $FE) then
    begin
      DestRegIndex := (AOC shr 3) and $07;
      SourceRegIndex := AOC and $07;
      FLastInstruction.Mnemonic := 'L' + RegNames[DestRegIndex] + RegNames[SourceRegIndex];

      if DestRegIndex = 7 then
      begin
        { M -> r }
        FBus.WriteMemory((FRegs.H shl 8) or FRegs.L, RegPointers[SourceRegIndex]^);
        FLastInstruction.Cycles := 14;
      end else
        if SourceRegIndex = 7 then
        begin
          { r -> M }
          RegPointers[DestRegIndex]^ := FBus.ReadMemory((FRegs.H shl 8) or FRegs.L);
          FLastInstruction.Cycles := 16;
        end else 
        begin
          { r1 <- r2 }
          RegPointers[DestRegIndex]^ := RegPointers[SourceRegIndex]^;
          FLastInstruction.Cycles := 10;
        end;
    end;
  end;
