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
           LogRecord.Mnemonic:='NOP';
         end;
    // HLT
    $76: begin
           LogRecord.Mnemonic:='HLT';
           FHalted := true;
           EmitEvent(ceHalt);
         end;
    // XCHG
    $EB: begin
           LogRecord.Mnemonic:='XCHG';
           with FRegs do
           begin
             w1 := DE; DE := HL; HL := w1;
           end;
         end;
  else  
    // MOV r1, r2; MOV M, r1; MOV r1, M
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
  end;
