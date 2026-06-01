{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | microcode.pas                                                            | }
{ | Microcode for Intel 8080 CPU implementation module                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case OC of  
    // NOP
    $00: begin
           LogRecord.Mnemonic := 'NOP';
         end;
    // LXI B, d16
    $01: begin
           LogRecord.Mnemonic := 'LXI B';
           LogRecord.NumOperand := 1;
           FRegs.C := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.B := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           LogRecord.Operands[LogRecord.NumOperand] := Fregs.BC;
         end;
    // STAX B
    $02: begin
           LogRecord.Mnemonic := 'STAX B';
           FBus.MemWrite(FRegs.BC, FRegs.A);
         end;
    // INX B
    $03: begin
           LogRecord.Mnemonic:='INX B';
           Inc(FRegs.BC);
         end;
    // LXI D, d16
    $11: begin
           LogRecord.Mnemonic := 'LXI D';
           LogRecord.NumOperand := 1;
           FRegs.E := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.D := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           LogRecord.Operands[LogRecord.NumOperand] := Fregs.DE;
         end;
    // STAX D
    $12: begin
           LogRecord.Mnemonic := 'STAX D';
           FBus.MemWrite(FRegs.DE, FRegs.A);
         end;
    // INX D
    $13: begin
           LogRecord.Mnemonic:='INX D';
           Inc(FRegs.DE);
         end;
    // LXI H, d16
    $21: begin
           LogRecord.Mnemonic := 'LXI H';
           LogRecord.NumOperand := 1;
           FRegs.L := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.H := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           LogRecord.Operands[LogRecord.NumOperand] := FRegs.HL;
         end;
    // SHLD a16
    $22: begin
           LogRecord.Mnemonic:='SHLD';
           LogRecord.NumOperand := 1;
           w1 := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.MemRead(FRegs.PC) * 256;
           Inc(FRegs.PC);
           LogRecord.Operands[LogRecord.NumOperand] := w1;
           FBus.MemWrite(w1, FRegs.L);
           FBus.MemWrite(w1 + 1, FRegs.H);
         end;
    // INX H
    $23: begin
           LogRecord.Mnemonic:='INX H';
           Inc(FRegs.HL);
         end;
    // LXI SP, d16
    $31: begin
           LogRecord.Mnemonic := 'LXI SP';
           LogRecord.NumOperand := 1;
           FRegs.SPL := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           FRegs.SPH := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           LogRecord.Operands[LogRecord.NumOperand] := Fregs.SP;
         end;
    // STA a16
    $32: begin
           LogRecord.Mnemonic:='STA';
           LogRecord.NumOperand := 1;
           w1 := FBus.MemRead(FRegs.PC);
           Inc(FRegs.PC);
           w1 := w1 + FBus.MemRead(FRegs.PC) * 256;
           Inc(FRegs.PC);
           LogRecord.Operands[LogRecord.NumOperand] := w1;
           FBus.MemWrite(w1, FRegs.A);
         end;
    // INX SP
    $33: begin
           LogRecord.Mnemonic:='INX SP';
           Inc(FRegs.SP);
         end;
    // HLT
    $76: begin
           LogRecord.Mnemonic := 'HLT';
           FHalted := true;
           EmitEvent(ceHalt);
         end;
    // XTHL
    $E3: begin
           LogRecord.Mnemonic := 'XTHL';
           // L <-> [SP]
           b1 := FBus.MemRead(FRegs.SP);
           FBus.MemWrite(FRegs.SP, FRegs.L);
           FRegs.L := b1;
           
           // H <-> [SP + 1]
           b2 := FBus.MemRead(FRegs.SP + 1);
           FBus.MemWrite(FRegs.SP + 1, FRegs.H);
           FRegs.H := b2;
         end;
    // XCHG
    $EB: begin
           LogRecord.Mnemonic := 'XCHG';
           with FRegs do
           begin
             w1 := DE; DE := HL; HL := w1;
           end;
         end;
    // DI
    $F3: begin
           LogRecord.Mnemonic := 'DI';
           FInterruptEnabled := false;
         end;
    // SPHL
    $F9: begin
           LogRecord.Mnemonic := 'SPHL';
           Fregs.SP := Fregs.HL;
         end;
    // EI
    $FB: begin
           LogRecord.Mnemonic := 'EI';
           FInterruptEnabled := true;
         end;
  else  
    // INR r; INR M
    // $04-$34, $0C-$3C
    if (OC <= $3F) and ((OC and $07) = $04) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      LogRecord.Mnemonic := 'INR ' + RegNames[DestRegIndex];
      b1 := FRegs.F and $01;                                     { store Carry }
      if DestRegIndex = 6 then
      begin
        // INR M
        b2 := FBus.MemRead(FRegs.HL);
        w1 := (b2 + 1) and $FF;
        FBus.MemWrite(FRegs.HL, w1);
        UpdateFlags(w1, b2, 1);
      end
      else
      begin
        // INR r
        b2 := RegPointers[DestRegIndex]^;
        Inc(RegPointers[DestRegIndex]^);
        UpdateFlags(RegPointers[DestRegIndex]^, b2, 1);
      end;
      FRegs.F := (FRegs.F and $FE) or b1;                      { restore Carry }
    end;
    // DCR r; DCR M
    // $05-$35, $0D-$3D
    if (OC <= $3F) and ((OC and $07) = $05) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      LogRecord.Mnemonic := 'DCR ' + RegNames[DestRegIndex];
      b1 := FRegs.F and $01;                                     { store Carry }
      if DestRegIndex = 6 then
      begin
        // DCR M
        b2 := FBus.MemRead(FRegs.HL);
        w1 := (b2 - 1) and $FF;
        FBus.MemWrite(FRegs.HL, w1);
        UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF);
      end
      else
      begin
        // DCR r
        b2 := RegPointers[DestRegIndex]^;
        Dec(RegPointers[DestRegIndex]^);
        UpdateFlags(b2 + ($01 xor $FF) + 1, b2, $01 xor $FF);
      end;
      FRegs.F := (FRegs.F and $FE) or b1;                      { restore Carry }
    end;
    // MVI r, d8; MVI M, d8
    // $06-$36, $0E-$3E
    if (OC <= $3F) and ((OC and $07) = $06) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      LogRecord.Mnemonic := 'MVI ' + RegNames[DestRegIndex];
      LogRecord.NumOperand := 1;
      b1 := FBus.MemRead(FRegs.PC);
      Inc(FRegs.PC);
      LogRecord.Operands[1] := b1;
      if DestRegIndex = 6 
        then FBus.MemWrite(FRegs.HL, b1)                           { MVI M, d8 }
        else RegPointers[DestRegIndex]^ := b1;                     { MVI r, d8 }
    end;
    // MOV r1, r2; MOV M, r1; MOV r1, M
    // $40-$7F
    if (OC >= $40) and (OC <= $7F) then
    begin
      DestRegIndex := (OC shr 3) and $07;
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'MOV ' +
                            RegNames[DestRegIndex] + ', ' +
                            RegNames[SourceRegIndex];
      if (DestRegIndex = 6) and (SourceRegIndex = 6) then {HLT} else
        if DestRegIndex = 6
          then FBus.MemWrite(FRegs.HL, RegPointers[SourceRegIndex]^) {MOV M, r} else
	  if SourceRegIndex = 6
            then RegPointers[DestRegIndex]^ := FBus.MemRead(FRegs.HL) {MOV r, M}
            else RegPointers[DestRegIndex]^ := RegPointers[SourceRegIndex]^; {MOV r1, r2}
    end;
    // ADD r
    // $80-$87
    if (OC >= $80) and (OC <= $87) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'ADD ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.MemRead(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 + w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2, b1, w1);
    end;
    // ADC r
    // $88-$8F
    if (OC >= $88) and (OC <= $8F) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'ADC ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.MemRead(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := FRegs.F and $01;
      w2 := b1 + w1 + b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(w2, b1, w1 + b2);
    end;
    // SUB r
    // $90-$97
    if (OC >= $90) and (OC <= $97) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'SUB ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.MemRead(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      FRegs.A := w2 and $00FF;
      UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF);
      FRegs.F := FRegs.F xor $01;
    end;
    // SBB r
    // $98-$9F
    if (OC >= $98) and (OC <= $9F) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'SBB ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.MemRead(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      b2 := FRegs.F and $01;
      w2 := b1 - w1 - b2;
      FRegs.A := w2 and $00FF;
      UpdateFlags(b1 + ((w1 + b2) xor $FF) + 1, b1, (w1 + b2) xor $FF);
      FRegs.F := FRegs.F xor $01;
    end;
    // ANA r
    // $A0-$A7
    if (OC >= $A0) and (OC <= $A7) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'ANA ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.MemRead(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A and b1;
      UpdateFlags(FRegs.A, b2, b2);
      FRegs.F := (FRegs.F and $FE) or $10;
    end;
    // XRA r
    // $A8-$AF
    if (OC >= $A8) and (OC <= $AF) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'XRA ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.MemRead(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A xor b1;
      UpdateFlags(FRegs.A, b2, b2);
      FRegs.F := FRegs.F and $EE;
    end;
    // ORA r
    // $B0-$B7
    if (OC >= $A8) and (OC <= $AF) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'ORA ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then b1 := FBus.MemRead(FRegs.HL) 
        else b1 := RegPointers[SourceRegIndex]^;
      b2 := FRegs.A;
      FRegs.A := FRegs.A or b1;
      UpdateFlags(FRegs.A, b2, b2);
      FRegs.F := FRegs.F and $EE;
    end;
    // CMP r
    // $B8-$BF
    if (OC >= $90) and (OC <= $97) then
    begin
      SourceRegIndex := OC and $07;
      LogRecord.Mnemonic := 'SUB ' + RegNames[SourceRegIndex];
      if SourceRegIndex = 6
        then w1 := FBus.MemRead(FRegs.HL) 
        else w1 := RegPointers[SourceRegIndex]^;
      b1 := FRegs.A;
      w2 := b1 - w1;
      UpdateFlags(b1 + (w1 xor $FF) + 1, b1, w1 xor $FF);
      FRegs.F := FRegs.F xor $01;
    end;

  end;
