{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_ddxx.pas                                               | }
{ | Microcode for Zilog Z80 CPU implementation module                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  case AOC of
{ 
|DD 00  |NOP          |2   |8     |--------|
|DD 01  |LD BC,d16    |4   |14    |--------|
|DD 02  |LD (BC),A    |2   |11    |--------|
|DD 03  |INC BC       |2   |10    |--------|
|DD 04  |INC B        |2   |8     |-----V0-|
|DD 05  |DEC B        |2   |8     |-----V1-|
|DD 06  |LD B,d8      |3   |11    |--------|
|DD 07  |RLCA         |2   |8     |--Y0X-0C|
|DD 08  |EX AF,AF'    |2   |8     |--------|
|DD 09  |ADD IX,BC    |2   |15    |--YHX-0C|
|DD 0A  |LD A,(BC)    |2   |11    |--------|
|DD 0B  |DEC BC       |2   |10    |--------|
|DD 0C  |INC C        |2   |8     |-----V0-|
|DD 0D  |DEC C        |2   |8     |-----V1-|
|DD 0E  |LD C,d8      |3   |11    |--------|
|DD 0F  |RRCA         |2   |8     |--Y0X-0C|
|DD 10  |DJNZ r8      |3   |17/12 |--------|
|DD 11  |LD DE,d16    |4   |14    |--------|
|DD 12  |LD (DE),A    |2   |11    |--------|
|DD 13  |INC DE       |2   |10    |--------|
|DD 14  |INC D        |2   |8     |-----V0-|
|DD 15  |DEC D        |2   |8     |-----V1-|
|DD 16  |LD D,d8      |3   |11    |--------|
|DD 17  |RLA          |2   |8     |--Y0X-0C|
|DD 18  |JR r8        |3   |16    |--------|
|DD 19  |ADD IX,DE    |2   |15    |--YHX-0C|
|DD 1A  |LD A,(DE)    |2   |11    |--------|
|DD 1B  |DEC DE       |2   |10    |--------|
|DD 1C  |INC E        |2   |8     |-----V0-|
|DD 1D  |DEC E        |2   |8     |-----V1-|
|DD 1E  |LD E,d8      |3   |11    |--------|
|DD 1F  |RRA          |2   |8     |--Y0X-0C|
|DD 20  |JR NZ,r8     |3   |16/11 |--------|
|DD 21  |LD IX,d16    |4   |14    |--------|
|DD 22  |LD (a16),IX  |4   |20    |--------|
|DD 23  |INC IX       |2   |10    |--------|
|DD 24  |INC IXh      |2   |8     |-----V0-|
|DD 25  |DEC IXh      |2   |8     |-----V1-|
|DD 26  |LD IXh,d8    |3   |11    |--------|
|DD 27  |DAA          |2   |8     |SZYHXP-C|
|DD 28  |JR Z,r8      |3   |16/11 |--------|
|DD 29  |ADD IX,IX    |2   |15    |--YHX-0C|
|DD 2A  |LD IX,(a16)  |4   |20    |--------|
|DD 2B  |DEC IX       |2   |10    |--------|
|DD 2C  |INC IXl      |2   |8     |-----V0-|
|DD 2D  |DEC IXl      |2   |8     |-----V1-|
|DD 2E  |LD IXl,d8    |3   |11    |--------|
|DD 2F  |CPL          |2   |8     |--Y1X-1-|
|DD 30  |JR NC,r8     |3   |16/11 |--------|
|DD 31  |LD SP,d16    |4   |14    |--------|
|DD 32  |LD (a16),A   |4   |17    |--------|
|DD 33  |INC SP       |2   |10    |--------|
|DD 34  |INC (IX+r8)  |3   |23    |-----V0-|
|DD 35  |DEC (IX+r8)  |3   |23    |-----V1-|
|DD 36  |LD (IX+r8),d8|4   |19    |--------|
|DD 37  |SCF          |2   |8     |--Y0X-01|
|DD 38  |JR C,r8      |3   |16/11 |--------|
|DD 39  |ADD IX,SP    |2   |15    |--YHX-0C|
|DD 3A  |LD A,(a16)   |4   |17    |--------|
|DD 3B  |DEC SP       |2   |10    |--------|
|DD 3C  |INC A        |2   |8     |-----V0-|
|DD 3D  |DEC A        |2   |8     |-----V1-|
|DD 3E  |LD A,d8      |3   |11    |--------|
|DD 3F  |CCF          |2   |8     |--YHX-0C|
|DD 40  |LD B,B       |2   |8     |--------|
|DD 41  |LD B,C       |2   |8     |--------|
|DD 42  |LD B,D       |2   |8     |--------|
|DD 43  |LD B,E       |2   |8     |--------|
|DD 44  |LD B,IXh     |2   |8     |--------|
|DD 45  |LD B,IXl     |2   |8     |--------|
|DD 46  |LD B,(IX+r8) |3   |19    |--------|
|DD 47  |LD B,A       |2   |8     |--------|
|DD 48  |LD C,B       |2   |8     |--------|
|DD 49  |LD C,C       |2   |8     |--------|
|DD 4A  |LD C,D       |2   |8     |--------|
|DD 4B  |LD C,E       |2   |8     |--------|
|DD 4C  |LD C,IXh     |2   |8     |--------|
|DD 4D  |LD C,IXl     |2   |8     |--------|
|DD 4E  |LD C,(IX+r8) |3   |19    |--------|
|DD 4F  |LD C,A       |2   |8     |--------|
|DD 50  |LD D,B       |2   |8     |--------|
|DD 51  |LD D,C       |2   |8     |--------|
|DD 52  |LD D,D       |2   |8     |--------|
|DD 53  |LD D,E       |2   |8     |--------|
|DD 54  |LD D,IXh     |2   |8     |--------|
|DD 55  |LD D,IXl     |2   |8     |--------|
|DD 56  |LD D,(IX+r8) |3   |19    |--------|
|DD 57  |LD D,A       |2   |8     |--------|
|DD 58  |LD E,B       |2   |8     |--------|
|DD 59  |LD E,C       |2   |8     |--------|
|DD 5A  |LD E,D       |2   |8     |--------|
|DD 5B  |LD E,E       |2   |8     |--------|
|DD 5C  |LD E,IXh     |2   |8     |--------|
|DD 5D  |LD E,IXl     |2   |8     |--------|
|DD 5E  |LD E,(IX+r8) |3   |19    |--------|
|DD 5F  |LD E,A       |2   |8     |--------|
|DD 60  |LD IXh,B     |2   |8     |--------|
|DD 61  |LD IXh,C     |2   |8     |--------|
|DD 62  |LD IXh,D     |2   |8     |--------|
|DD 63  |LD IXh,E     |2   |8     |--------|
|DD 64  |LD IXh,IXh   |2   |8     |--------|
|DD 65  |LD IXh,IXl   |2   |8     |--------|
|DD 66  |LD H,(IX+r8) |3   |19    |--------|
|DD 67  |LD IXh,A     |2   |8     |--------|
|DD 68  |LD IXl,B     |2   |8     |--------|
|DD 69  |LD IXl,C     |2   |8     |--------|
|DD 6A  |LD IXl,D     |2   |8     |--------|
|DD 6B  |LD IXl,E     |2   |8     |--------|
|DD 6C  |LD IXl,IXh   |2   |8     |--------|
|DD 6D  |LD IXl,IXl   |2   |8     |--------|
|DD 6E  |LD L,(IX+r8) |3   |19    |--------|
|DD 6F  |LD IXl,A     |2   |8     |--------|
|DD 70  |LD (IX+r8),B |3   |19    |--------|
|DD 71  |LD (IX+r8),C |3   |19    |--------|
|DD 72  |LD (IX+r8),D |3   |19    |--------|
|DD 73  |LD (IX+r8),E |3   |19    |--------|
|DD 74  |LD (IX+r8),H |3   |19    |--------|
|DD 75  |LD (IX+r8),L |3   |19    |--------|
|DD 76  |HALT         |2   |8     |--------|
|DD 77  |LD (IX+r8),A |3   |19    |--------|
|DD 78  |LD A,B       |2   |8     |--------|
|DD 79  |LD A,C       |2   |8     |--------|
|DD 7A  |LD A,D       |2   |8     |--------|
|DD 7B  |LD A,E       |2   |8     |--------|
|DD 7C  |LD A,IXh     |2   |8     |--------|
|DD 7D  |LD A,IXl     |2   |8     |--------|
|DD 7E  |LD A,(IX+r8) |3   |19    |--------|
|DD 7F  |LD A,A       |2   |8     |--------|
|DD 80  |ADD A,B      |2   |8     |SZYHXV0C|
|DD 81  |ADD A,C      |2   |8     |SZYHXV0C|
|DD 82  |ADD A,D      |2   |8     |SZYHXV0C|
|DD 83  |ADD A,E      |2   |8     |SZYHXV0C|
|DD 84  |ADD A,IXh    |2   |8     |SZYHXV0C|
|DD 85  |ADD A,IXl    |2   |8     |SZYHXV0C|
|DD 86  |ADD A,(IX+r8)|3   |19    |SZYHXV0C|
|DD 87  |ADD A,A      |2   |8     |SZYHXV0C|
|DD 88  |ADC A,B      |2   |8     |SZYHXV0C|
|DD 89  |ADC A,C      |2   |8     |SZYHXV0C|
|DD 8A  |ADC A,D      |2   |8     |SZYHXV0C|
|DD 8B  |ADC A,E      |2   |8     |SZYHXV0C|
|DD 8C  |ADC A,IXh    |2   |8     |SZYHXV0C|
|DD 8D  |ADC A,IXl    |2   |8     |SZYHXV0C|
|DD 8E  |ADC A,(IX+r8)|3   |19    |SZYHXV0C|
|DD 8F  |ADC A,A      |2   |8     |SZYHXV0C|
|DD 90  |SUB B        |2   |8     |SZYHXV1C|
|DD 91  |SUB C        |2   |8     |SZYHXV1C|
|DD 92  |SUB D        |2   |8     |SZYHXV1C|
|DD 93  |SUB E        |2   |8     |SZYHXV1C|
|DD 94  |SUB IXh      |2   |8     |SZYHXV1C|
|DD 95  |SUB IXl      |2   |8     |SZYHXV1C|
|DD 96  |SUB (IX+r8)  |3   |19    |SZYHXV1C|
|DD 97  |SUB A        |2   |8     |SZYHXV1C|
|DD 98  |SBC A,B      |2   |8     |SZYHXV1C|
|DD 99  |SBC A,C      |2   |8     |SZYHXV1C|
|DD 9A  |SBC A,D      |2   |8     |SZYHXV1C|
|DD 9B  |SBC A,E      |2   |8     |SZYHXV1C|
|DD 9C  |SBC A,IXh    |2   |8     |SZYHXV1C|
|DD 9D  |SBC A,IXl    |2   |8     |SZYHXV1C|
|DD 9E  |SBC A,(IX+r8)|3   |19    |SZYHXV1C|
|DD 9F  |SBC A,A      |2   |8     |SZYHXV1C|
|DD A0  |AND B        |2   |8     |SZY1XP00|
|DD A1  |AND C        |2   |8     |SZY1XP00|
|DD A2  |AND D        |2   |8     |SZY1XP00|
|DD A3  |AND E        |2   |8     |SZY1XP00|
|DD A4  |AND IXh      |2   |8     |SZY1XP00|
|DD A5  |AND IXl      |2   |8     |SZY1XP00|
|DD A6  |AND (IX+r8)  |3   |19    |SZY1XP00|
|DD A7  |AND A        |2   |8     |SZY1XP00|
|DD A8  |XOR B        |2   |8     |SZY1XP00|
|DD A9  |XOR C        |2   |8     |SZY1XP00|
|DD AA  |XOR D        |2   |8     |SZY1XP00|
|DD AB  |XOR E        |2   |8     |SZY1XP00|
|DD AC  |XOR IXh      |2   |8     |SZY1XP00|
|DD AD  |XOR IXl      |2   |8     |SZY1XP00|
|DD AE  |XOR (IX+r8)  |3   |19    |SZY1XP00|
|DD AF  |XOR A        |2   |8     |SZY1XP00|
|DD B0  |OR B         |2   |8     |SZY1XP00|
|DD B1  |OR C         |2   |8     |SZY1XP00|
|DD B2  |OR D         |2   |8     |SZY1XP00|
|DD B3  |OR E         |2   |8     |SZY1XP00|
|DD B4  |OR IXh       |2   |8     |SZY1XP00|
|DD B5  |OR IXl       |2   |8     |SZY1XP00|
|DD B6  |OR (IX+r8)   |3   |19    |SZY1XP00|
|DD B7  |OR A         |2   |8     |SZY1XP00|
|DD B8  |CP B         |2   |8     |SZYHXV1C|
|DD B9  |CP C         |2   |8     |SZYHXV1C|
|DD BA  |CP D         |2   |8     |SZYHXV1C|
|DD BB  |CP E         |2   |8     |SZYHXV1C|
|DD BC  |CP IXh       |2   |8     |SZYHXV1C|
|DD BD  |CP IXl       |2   |8     |SZYHXV1C|
|DD BE  |CP (IX+r8)   |3   |19    |SZYHXV1C|
|DD BF  |CP A         |2   |8     |SZYHXV1C|
|DD C0  |RET NZ       |2   |15/9  |--------|
|DD C1  |POP BC       |2   |14    |--------|
|DD C2  |JP NZ,a16    |4   |14    |--------|
|DD C3  |JP a16       |4   |14    |--------|
|DD C4  |CALL NZ,a16  |4   |21/14 |--------|
|DD C5  |PUSH BC      |2   |15    |--------|
|DD C6  |ADD A,d8     |3   |11    |SZYHXV0C|
|DD C7  |RST 00H      |2   |15    |--------|
|DD C8  |RET Z        |2   |15/9  |--------|
|DD C9  |RET          |2   |14    |--------|
|DD CA  |JP Z,a16     |4   |14    |--------|
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
       RunOpCode(b2, prDDCB);
     end;
{ 
|DD CC  |CALL Z,a16   |4   |21/14 |--------|
|DD CD  |CALL a16     |4   |21    |--------|
|DD CE  |ADC A,d8     |3   |11    |SZYHXV0C|
|DD CF  |RST 08H      |2   |15    |--------|
|DD D0  |RET NC       |2   |15/9  |--------|
|DD D1  |POP DE       |2   |14    |--------|
|DD D2  |JP NC,a16    |4   |14    |--------|
|DD D3  |OUT (d8),A   |3   |15    |--------|
|DD D4  |CALL NC,a16  |4   |21/14 |--------|
|DD D5  |PUSH DE      |2   |15    |--------|
|DD D6  |SUB d8       |3   |11    |SZYHXV1C|
|DD D7  |RST 10H      |2   |15    |--------|
|DD D8  |RET C        |2   |15/9  |--------|
|DD D9  |EXX          |2   |8     |--------|
|DD DA  |JP C,a16     |4   |14    |--------|
|DD DB  |IN A,(d8)    |3   |15    |--------|
|DD DC  |CALL C,a16   |4   |21/14 |--------|
|DD DD  |PREFIX DD    |    |      |        |
|DD DE  |SBC A,d8     |3   |11    |SZYHXV1C|
|DD DF  |RST 18H      |2   |15    |--------|
|DD E0  |RET PO       |2   |15/9  |--------|
|DD E1  |POP IX       |2   |14    |--------|
|DD E2  |JP PO,a16    |4   |14    |--------|
|DD E3  |EX (SP),IX   |2   |23    |--------|
|DD E4  |CALL PO,a16  |4   |21/14 |--------|
|DD E5  |PUSH IX      |2   |15    |--------|
|DD E6  |AND d8       |3   |11    |SZY1XP00|
|DD E7  |RST 20H      |2   |15    |--------|
|DD E8  |RET PE       |2   |15/9  |--------|
|DD E9  |JP (IX)      |2   |8     |--------|
|DD EA  |JP PE,a16    |4   |14    |--------|
|DD EB  |EX DE,HL     |2   |8     |--------|
|DD EC  |CALL PE,a16  |4   |21/14 |--------|
|DD ED  |PREFIX ED    |    |      |        |
|DD EE  |XOR d8       |3   |11    |SZY1XP00|
|DD EF  |RST 28H      |2   |15    |--------|
|DD F0  |RET P        |2   |15/9  |--------|
|DD F1  |POP AF       |2   |14    |SZYHXPNC|
|DD F2  |JP P,a16     |4   |14    |--------|
|DD F3  |DI           |2   |8     |--------|
|DD F4  |CALL P,a16   |4   |21/14 |--------|
|DD F5  |PUSH AF      |2   |15    |--------|
|DD F6  |OR d8        |3   |11    |SZY1XP00|
|DD F7  |RST 30H      |2   |15    |--------|
|DD F8  |RET M        |2   |15/9  |--------|
|DD F9  |LD SP,IX     |2   |10    |--------|
|DD FA  |JP M,a16     |4   |14    |--------|
|DD FB  |EI           |2   |8     |--------|
|DD FC  |CALL M,a16   |4   |21/14 |--------|
|DD FD  |PREFIX FD    |    |      |        |
|DD FE  |CP d8        |3   |11    |SZYHXV1C|
|DD FF  |RST 38H      |2   |15    |--------|
}
  end;

