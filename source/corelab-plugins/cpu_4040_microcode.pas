{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_4040_microcode.pas                                                   | }
{ | Microcode for Intel 4040 CPU implementation module                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

    // instructions
    // HLT
    $01: begin
           FLastInstruction.Mnemonic := 'HLT';
           FHalted := true;
           EmitEvent(ceHalt);
           FLastInstruction.Cycles := 8;
         end;
    // BBS
    $02: begin
           FLastInstruction.Mnemonic := 'BBS';
           with FStack do
           begin
             if Pointer = 0 then Pointer := FStackSize - 1 else Dec(Pointer);
             FRegs.PC := Regs[Pointer];
           end;
           FInterruptEnabled := True; 
           FLastInstruction.Cycles := 8;
         end;
    // LCR
    $03: begin
           FLastInstruction.Mnemonic := 'LCR';
           FRegs.A := FRegs.CCR;
           FLastInstruction.Cycles := 8;
         end;
    // OR4
    $04: begin
           FLastInstruction.Mnemonic := 'OR4';
           FRegs.A := FRegs.A or RegPointers[4]^;
           FLastInstruction.Cycles := 8;
         end;
    // OR5
    $05: begin
           FLastInstruction.Mnemonic := 'OR5';
           FRegs.A := FRegs.A or RegPointers[5]^;
           FLastInstruction.Cycles := 8;
         end;
    // AN6
    $06: begin
           FLastInstruction.Mnemonic := 'AN6';
           FRegs.A := FRegs.A and RegPointers[6]^;
           FLastInstruction.Cycles := 8;
         end;
    // AN7
    $07: begin
           FLastInstruction.Mnemonic := 'AN7';
           FRegs.A := FRegs.A and RegPointers[7]^;
           FLastInstruction.Cycles := 8;
         end;
    // DB0
    $08: begin
           FLastInstruction.Mnemonic := 'DB0';
           FROMBank := 0;
           FRegs.PC := FRegs.PC and $0FFF;
           FLastInstruction.Cycles := 8;
         end;
    // DB1
    $09: begin
           FLastInstruction.Mnemonic := 'DB1';
           FROMBank := 1;
           FRegs.PC := FRegs.PC or $1000;
           FLastInstruction.Cycles := 8;
         end;
    // SB0
    $0A: begin
           FLastInstruction.Mnemonic := 'SB0';
           for b1 := 0 to 7 do RegPointers[b1] := @FRegs.R[b1];
           FLastInstruction.Cycles := 8;
         end;
    // SB1
    $0B: begin
           FLastInstruction.Mnemonic := 'SB1';
           for b1 := 17 to 24 do RegPointers[b1 - 17] := @FRegs.R[b1 -1];
           FLastInstruction.Cycles := 8;
         end;
     // DIN
    $0C: begin
           FLastInstruction.Mnemonic := 'DIN';
           FInterruptEnabled := False;
           FLastInstruction.Cycles := 8;
         end;
    // EIN
    $0D: begin
           FLastInstruction.Mnemonic := 'EIN';
           FInterruptEnabled := True;
           FLastInstruction.Cycles := 8;
         end;
    // RPM
    $0E: begin
           FLastInstruction.Mnemonic := 'RPM';
           // not implemented
           // Read Program Memory function for 4008/4009/4289 chips
           FLastInstruction.Cycles := 8;
         end;
