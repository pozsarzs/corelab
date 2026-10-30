{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_fdxx.pas                                               | }
{ | Microcode for Zilog Z80 CPU implementation module                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case AOC of
{ 
|FD 00  |NOP          |2   |8     |--------|
|FD 01  |LD BC,d16    |4   |14    |--------|
|FD 02  |LD (BC),A    |2   |11    |--------|
|FD 03  |INC BC       |2   |10    |--------|
|FD 04  |INC B        |2   |8     |-----V0-|
|FD 05  |DEC B        |2   |8     |-----V1-|
|FD 06  |LD B,d8      |3   |11    |--------|
|FD 07  |RLCA         |2   |8     |--Y0X-0C|
|FD 08  |EX AF,AF'    |2   |8     |--------|
|FD 09  |ADD IY,BC    |2   |15    |--YHX-0C|
|FD 0A  |LD A,(BC)    |2   |11    |--------|
|FD 0B  |DEC BC       |2   |10    |--------|
|FD 0C  |INC C        |2   |8     |-----V0-|
|FD 0D  |DEC C        |2   |8     |-----V1-|
|FD 0E  |LD C,d8      |3   |11    |--------|
|FD 0F  |RRCA         |2   |8     |--Y0X-0C|
|FD 10  |DJNZ r8      |3   |17/12 |--------|
|FD 11  |LD DE,d16    |4   |14    |--------|
|FD 12  |LD (DE),A    |2   |11    |--------|
|FD 13  |INC DE       |2   |10    |--------|
|FD 14  |INC D        |2   |8     |-----V0-|
|FD 15  |DEC D        |2   |8     |-----V1-|
|FD 16  |LD D,d8      |3   |11    |--------|
|FD 17  |RLA          |2   |8     |--Y0X-0C|
|FD 18  |JR r8        |3   |16    |--------|
|FD 19  |ADD IY,DE    |2   |15    |--YHX-0C|
|FD 1A  |LD A,(DE)    |2   |11    |--------|
|FD 1B  |DEC DE       |2   |10    |--------|
|FD 1C  |INC E        |2   |8     |-----V0-|
|FD 1D  |DEC E        |2   |8     |-----V1-|
|FD 1E  |LD E,d8      |3   |11    |--------|
|FD 1F  |RRA          |2   |8     |--Y0X-0C|
|FD 20  |JR NZ,r8     |3   |16/11 |--------|
|FD 21  |LD IY,d16    |4   |14    |--------|
|FD 22  |LD (a16),IY  |4   |20    |--------|
|FD 23  |INC IY       |2   |10    |--------|
|FD 24  |INC IYh      |2   |8     |-----V0-|
|FD 25  |DEC IYh      |2   |8     |-----V1-|
|FD 26  |LD IYh,d8    |3   |11    |--------|
|FD 27  |DAA          |2   |8     |SZYHXP-C|
|FD 28  |JR Z,r8      |3   |16/11 |--------|
|FD 29  |ADD IY,IY    |2   |15    |--YHX-0C|
|FD 2A  |LD IY,(a16)  |4   |20    |--------|
|FD 2B  |DEC IY       |2   |10    |--------|
|FD 2C  |INC IYl      |2   |8     |-----V0-|
|FD 2D  |DEC IYl      |2   |8     |-----V1-|
|FD 2E  |LD IYl,d8    |3   |11    |--------|
|FD 2F  |CPL          |2   |8     |--Y1X-1-|
|FD 30  |JR NC,r8     |3   |16/11 |--------|
|FD 31  |LD SP,d16    |4   |14    |--------|
|FD 32  |LD (a16),A   |4   |17    |--------|
|FD 33  |INC SP       |2   |10    |--------|
|FD 34  |INC (IY+r8)  |3   |23    |-----V0-|
|FD 35  |DEC (IY+r8)  |3   |23    |-----V1-|
|FD 36  |LD (IY+r8),d8|4   |19    |--------|
|FD 37  |SCF          |2   |8     |--Y0X-01|
|FD 38  |JR C,r8      |3   |16/11 |--------|
|FD 39  |ADD IY,SP    |2   |15    |--YHX-0C|
|FD 3A  |LD A,(a16)   |4   |17    |--------|
|FD 3B  |DEC SP       |2   |10    |--------|
|FD 3C  |INC A        |2   |8     |-----V0-|
|FD 3D  |DEC A        |2   |8     |-----V1-|
|FD 3E  |LD A,d8      |3   |11    |--------|
|FD 3F  |CCF          |2   |8     |--YHX-0C|
|FD 40  |LD B,B       |2   |8     |--------|
|FD 41  |LD B,C       |2   |8     |--------|
|FD 42  |LD B,D       |2   |8     |--------|
|FD 43  |LD B,E       |2   |8     |--------|
|FD 44  |LD B,IYh     |2   |8     |--------|
|FD 45  |LD B,IYl     |2   |8     |--------|
|FD 46  |LD B,(IY+r8) |3   |19    |--------|
|FD 47  |LD B,A       |2   |8     |--------|
|FD 48  |LD C,B       |2   |8     |--------|
|FD 49  |LD C,C       |2   |8     |--------|
|FD 4A  |LD C,D       |2   |8     |--------|
|FD 4B  |LD C,E       |2   |8     |--------|
|FD 4C  |LD C,IYh     |2   |8     |--------|
|FD 4D  |LD C,IYl     |2   |8     |--------|
|FD 4E  |LD C,(IY+r8) |3   |19    |--------|
|FD 4F  |LD C,A       |2   |8     |--------|
|FD 50  |LD D,B       |2   |8     |--------|
|FD 51  |LD D,C       |2   |8     |--------|
|FD 52  |LD D,D       |2   |8     |--------|
|FD 53  |LD D,E       |2   |8     |--------|
|FD 54  |LD D,IYh     |2   |8     |--------|
|FD 55  |LD D,IYl     |2   |8     |--------|
|FD 56  |LD D,(IY+r8) |3   |19    |--------|
|FD 57  |LD D,A       |2   |8     |--------|
|FD 58  |LD E,B       |2   |8     |--------|
|FD 59  |LD E,C       |2   |8     |--------|
|FD 5A  |LD E,D       |2   |8     |--------|
|FD 5B  |LD E,E       |2   |8     |--------|
|FD 5C  |LD E,IYh     |2   |8     |--------|
|FD 5D  |LD E,IYl     |2   |8     |--------|
|FD 5E  |LD E,(IY+r8) |3   |19    |--------|
|FD 5F  |LD E,A       |2   |8     |--------|
|FD 60  |LD IYh,B     |2   |8     |--------|
|FD 61  |LD IYh,C     |2   |8     |--------|
|FD 62  |LD IYh,D     |2   |8     |--------|
|FD 63  |LD IYh,E     |2   |8     |--------|
|FD 64  |LD IYh,IYh   |2   |8     |--------|
|FD 65  |LD IYh,IYl   |2   |8     |--------|
|FD 66  |LD H,(IY+r8) |3   |19    |--------|
|FD 67  |LD IYh,A     |2   |8     |--------|
|FD 68  |LD IYl,B     |2   |8     |--------|
|FD 69  |LD IYl,C     |2   |8     |--------|
|FD 6A  |LD IYl,D     |2   |8     |--------|
|FD 6B  |LD IYl,E     |2   |8     |--------|
|FD 6C  |LD IYl,IYh   |2   |8     |--------|
|FD 6D  |LD IYl,IYl   |2   |8     |--------|
|FD 6E  |LD L,(IY+r8) |3   |19    |--------|
|FD 6F  |LD IYl,A     |2   |8     |--------|
|FD 70  |LD (IY+r8),B |3   |19    |--------|
|FD 71  |LD (IY+r8),C |3   |19    |--------|
|FD 72  |LD (IY+r8),D |3   |19    |--------|
|FD 73  |LD (IY+r8),E |3   |19    |--------|
|FD 74  |LD (IY+r8),H |3   |19    |--------|
|FD 75  |LD (IY+r8),L |3   |19    |--------|
|FD 76  |HALT         |2   |8     |--------|
|FD 77  |LD (IY+r8),A |3   |19    |--------|
|FD 78  |LD A,B       |2   |8     |--------|
|FD 79  |LD A,C       |2   |8     |--------|
|FD 7A  |LD A,D       |2   |8     |--------|
|FD 7B  |LD A,E       |2   |8     |--------|
|FD 7C  |LD A,IYh     |2   |8     |--------|
|FD 7D  |LD A,IYl     |2   |8     |--------|
|FD 7E  |LD A,(IY+r8) |3   |19    |--------|
|FD 7F  |LD A,A       |2   |8     |--------|
|FD 80  |ADD A,B      |2   |8     |SZYHXV0C|
|FD 81  |ADD A,C      |2   |8     |SZYHXV0C|
|FD 82  |ADD A,D      |2   |8     |SZYHXV0C|
|FD 83  |ADD A,E      |2   |8     |SZYHXV0C|
|FD 84  |ADD A,IYh    |2   |8     |SZYHXV0C|
|FD 85  |ADD A,IYl    |2   |8     |SZYHXV0C|
|FD 86  |ADD A,(IY+r8)|3   |19    |SZYHXV0C|
|FD 87  |ADD A,A      |2   |8     |SZYHXV0C|
|FD 88  |ADC A,B      |2   |8     |SZYHXV0C|
|FD 89  |ADC A,C      |2   |8     |SZYHXV0C|
|FD 8A  |ADC A,D      |2   |8     |SZYHXV0C|
|FD 8B  |ADC A,E      |2   |8     |SZYHXV0C|
|FD 8C  |ADC A,IYh    |2   |8     |SZYHXV0C|
|FD 8D  |ADC A,IYl    |2   |8     |SZYHXV0C|
|FD 8E  |ADC A,(IY+r8)|3   |19    |SZYHXV0C|
|FD 8F  |ADC A,A      |2   |8     |SZYHXV0C|
|FD 90  |SUB B        |2   |8     |SZYHXV1C|
|FD 91  |SUB C        |2   |8     |SZYHXV1C|
|FD 92  |SUB D        |2   |8     |SZYHXV1C|
|FD 93  |SUB E        |2   |8     |SZYHXV1C|
|FD 94  |SUB IYh      |2   |8     |SZYHXV1C|
|FD 95  |SUB IYl      |2   |8     |SZYHXV1C|
|FD 96  |SUB (IY+r8)  |3   |19    |SZYHXV1C|
|FD 97  |SUB A        |2   |8     |SZYHXV1C|
|FD 98  |SBC A,B      |2   |8     |SZYHXV1C|
|FD 99  |SBC A,C      |2   |8     |SZYHXV1C|
|FD 9A  |SBC A,D      |2   |8     |SZYHXV1C|
|FD 9B  |SBC A,E      |2   |8     |SZYHXV1C|
|FD 9C  |SBC A,IYh    |2   |8     |SZYHXV1C|
|FD 9D  |SBC A,IYl    |2   |8     |SZYHXV1C|
|FD 9E  |SBC A,(IY+r8)|3   |19    |SZYHXV1C|
|FD 9F  |SBC A,A      |2   |8     |SZYHXV1C|
|FD A0  |AND B        |2   |8     |SZY1XP00|
|FD A1  |AND C        |2   |8     |SZY1XP00|
|FD A2  |AND D        |2   |8     |SZY1XP00|
|FD A3  |AND E        |2   |8     |SZY1XP00|
|FD A4  |AND IYh      |2   |8     |SZY1XP00|
|FD A5  |AND IYl      |2   |8     |SZY1XP00|
|FD A6  |AND (IY+r8)  |3   |19    |SZY1XP00|
|FD A7  |AND A        |2   |8     |SZY1XP00|
|FD A8  |XOR B        |2   |8     |SZY1XP00|
|FD A9  |XOR C        |2   |8     |SZY1XP00|
|FD AA  |XOR D        |2   |8     |SZY1XP00|
|FD AB  |XOR E        |2   |8     |SZY1XP00|
|FD AC  |XOR IYh      |2   |8     |SZY1XP00|
|FD AD  |XOR IYl      |2   |8     |SZY1XP00|
|FD AE  |XOR (IY+r8)  |3   |19    |SZY1XP00|
|FD AF  |XOR A        |2   |8     |SZY1XP00|
|FD B0  |OR B         |2   |8     |SZY1XP00|
|FD B1  |OR C         |2   |8     |SZY1XP00|
|FD B2  |OR D         |2   |8     |SZY1XP00|
|FD B3  |OR E         |2   |8     |SZY1XP00|
|FD B4  |OR IYh       |2   |8     |SZY1XP00|
|FD B5  |OR IYl       |2   |8     |SZY1XP00|
|FD B6  |OR (IY+r8)   |3   |19    |SZY1XP00|
|FD B7  |OR A         |2   |8     |SZY1XP00|
|FD B8  |CP B         |2   |8     |SZYHXV1C|
|FD B9  |CP C         |2   |8     |SZYHXV1C|
|FD BA  |CP D         |2   |8     |SZYHXV1C|
|FD BB  |CP E         |2   |8     |SZYHXV1C|
|FD BC  |CP IYh       |2   |8     |SZYHXV1C|
|FD BD  |CP IYl       |2   |8     |SZYHXV1C|
|FD BE  |CP (IY+r8)   |3   |19    |SZYHXV1C|
|FD BF  |CP A         |2   |8     |SZYHXV1C|
|FD C0  |RET NZ       |2   |15/9  |--------|
|FD C1  |POP BC       |2   |14    |--------|
|FD C2  |JP NZ,a16    |4   |14    |--------|
|FD C3  |JP a16       |4   |14    |--------|
|FD C4  |CALL NZ,a16  |4   |21/14 |--------|
|FD C5  |PUSH BC      |2   |15    |--------|
|FD C6  |ADD A,d8     |3   |11    |SZYHXV0C|
|FD C7  |RST 00H      |2   |15    |--------|
|FD C8  |RET Z        |2   |15/9  |--------|
|FD C9  |RET          |2   |14    |--------|
|FD CA  |JP Z,a16     |4   |14    |--------|
}
    $CB: begin
       // read offset byte
       b1 := FBus.ReadMemory(FRegs.PC);
       Inc(FRegs.PC);
       FLastInstruction.Operands[1] := b1;
       FLastInstruction.NumOperand := 1;
       // read opcode
       b2 := FBus.ReadMemory(FRegs.PC);
       Inc(FRegs.PC);
       FLastInstruction.Cycles := FLastInstruction.Cycles + 4;
       RunOpCode(b2, prFDCB);
     end;
{ 
|FD CC  |CALL Z,a16   |4   |21/14 |--------|
|FD CD  |CALL a16     |4   |21    |--------|
|FD CE  |ADC A,d8     |3   |11    |SZYHXV0C|
|FD CF  |RST 08H      |2   |15    |--------|
|FD D0  |RET NC       |2   |15/9  |--------|
|FD D1  |POP DE       |2   |14    |--------|
|FD D2  |JP NC,a16    |4   |14    |--------|
|FD D3  |OUT (d8),A   |3   |15    |--------|
|FD D4  |CALL NC,a16  |4   |21/14 |--------|
|FD D5  |PUSH DE      |2   |15    |--------|
|FD D6  |SUB d8       |3   |11    |SZYHXV1C|
|FD D7  |RST 10H      |2   |15    |--------|
|FD D8  |RET C        |2   |15/9  |--------|
|FD D9  |EXX          |2   |8     |--------|
|FD DA  |JP C,a16     |4   |14    |--------|
|FD DB  |IN A,(d8)    |3   |15    |--------|
|FD DC  |CALL C,a16   |4   |21/14 |--------|
|FD DD  |PREFIX DD    |    |      |        |
|FD DE  |SBC A,d8     |3   |11    |SZYHXV1C|
|FD DF  |RST 18H      |2   |15    |--------|
|FD E0  |RET PO       |2   |15/9  |--------|
|FD E1  |POP IY       |2   |14    |--------|
|FD E2  |JP PO,a16    |4   |14    |--------|
|FD E3  |EX (SP),IY   |2   |23    |--------|
|FD E4  |CALL PO,a16  |4   |21/14 |--------|
|FD E5  |PUSH IY      |2   |15    |--------|
|FD E6  |AND d8       |3   |11    |SZY1XP00|
|FD E7  |RST 20H      |2   |15    |--------|
|FD E8  |RET PE       |2   |15/9  |--------|
|FD E9  |JP (IY)      |2   |8     |--------|
|FD EA  |JP PE,a16    |4   |14    |--------|
|FD EB  |EX DE,HL     |2   |8     |--------|
|FD EC  |CALL PE,a16  |4   |21/14 |--------|
|FD ED  |PREFIX ED    |    |      |        |
|FD EE  |XOR d8       |3   |11    |SZY1XP00|
|FD EF  |RST 28H      |2   |15    |--------|
|FD F0  |RET P        |2   |15/9  |--------|
|FD F1  |POP AF       |2   |14    |SZYHXPNC|
|FD F2  |JP P,a16     |4   |14    |--------|
|FD F3  |DI           |2   |8     |--------|
|FD F4  |CALL P,a16   |4   |21/14 |--------|
|FD F5  |PUSH AF      |2   |15    |--------|
|FD F6  |OR d8        |3   |11    |SZY1XP00|
|FD F7  |RST 30H      |2   |15    |--------|
|FD F8  |RET M        |2   |15/9  |--------|
|FD F9  |LD SP,IY     |2   |10    |--------|
|FD FA  |JP M,a16     |4   |14    |--------|
|FD FB  |EI           |2   |8     |--------|
|FD FC  |CALL M,a16   |4   |21/14 |--------|
|FD FD  |PREFIX FD    |    |      |        |
|FD FE  |CP d8        |3   |11    |SZYHXV1C|
|FD FF  |RST 38H      |2   |15    |--------|
}
  end;
