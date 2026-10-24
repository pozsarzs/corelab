{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | microcode.pas                                                            | }
{ | Microcode for Intel 8085 CPU implementation module                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

    // RIM
    $20: begin
           FLastInstruction.Mnemonic := 'RIM';
           { Bit 0 (M5.5): Current state of the RST 5.5 mask.
             Bit 1 (M6.5): Current state of the RST 6.5 mask.
             Bit 2 (M7.5): Current state of the RST 7.5 mask.
             Bit 3 (IE):   State of the global Interrupt Enable flag (1 = enabled).
             Bit 4 (I5.5): Pending RST 5.5 interrupt (1 = pending).
             Bit 5 (I6.5): Pending RST 6.5 interrupt (1 = pending).
             Bit 6 (I7.5): Pending RST 7.5 interrupt (1 = pending).
             Bit 7 (SID):  Serial Input Data. (NOT IMPLEMENTED!)
           }
           b1 := (FIRQMask and $07);
           if FInterruptEnabled then b1 := b1 or $08;
           if FIRQPending[imRST5_5] then b1 := b1 or $10;
           if FIRQPending[imRST6_5] then b1 := b1 or $20;
           if FIRQPending[imRST7_5] then b1 := b1 or $40;
           Fregs.A := b1;
           FLastInstruction.Cycles := 4;
         end;
    // SIM
    $30: begin
           FLastInstruction.Mnemonic := 'SIM';
           { Bit 0 (M5.5): RST 5.5 mask (1 = disabled, 0 = enabled).
             Bit 1 (M6.5): RST 6.5 mask (1 = disabled, 0 = enabled).
             Bit 2 (M7.5): RST 7.5 mask (1 = disabled, 0 = enabled).
             Bit 3 (MSE):  Mask Set Enable. (1 = enabled)
             Bit 4 (R7.5): Reset pending RST 7.5 (1 = reset).
             Bit 5:        Unused (0).
             Bit 6 (SOE):  Serial Output Enable. (NOT IMPLEMENTED!)
             Bit 7 (SOD):  Serial Output Data. (NOT IMPLEMENTED!)
           }
           b1 := Fregs.A;
           if (b1 and $08) = $08 then FIRQMask := b1 and $07;
           if (b1 and $10) = $10 then FIRQPending[imRST7_5] := false;
           FLastInstruction.Cycles := 4;
         end;
