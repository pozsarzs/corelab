# CoreLAB

## Zilog Z80 microprocessor

### Technical Parameters

|Parameter                       |Specification                                                                  |
|--------------------------------|-------------------------------------------------------------------------------|
|**Release date**                |July 1976                                                                      |
|**Process technology**          |4 µm NMOS silicon-gate                                                         |
|**Transistor count**            |~8,500                                                                         |
|**Architecture**                |Neumann                                                                        |
|**Data bus width**              |8-bit                                                                          |
|**Address bus width**           |16-bit                                                                         |
|**Clock speed**                 |2.5 MHz (Z80), up to 4 MHz (Z80A)                                              |
|**Maximum addressable memory**  |64 KB                                                                          |
|**Maximum addressable I/O area**|256 ports (8-bit I/O address space)                                            |
|**Stack**                       |External, RAM-based via Stack Pointer.                                         |
|**General purpose registers**   |A, F, B, C, D, E, H, L, A', F', B', C', D', E', H', L'                         |
|**Special registers**           |PC, SP, IX, IY, I, R                                                           |
|**Interrupt handling**          |Maskable INT and non-maskable NMI; three maskable interrupt modes (IM 0, 1, 2).|

**Flag abbreviations:**

* **S** - Sign Flag
* **Z** - Zero Flag
* **Y** - Y Flag, undocumented
* **H** - Half Carry Flag
* **X** - X Flag, undocumented
* **P** - Parity / Overflow Flag
* **N** - Add/Subtract Flag
* **C** - Carry Flag

### OpCodes

- `/`: operation occurs/does not occur.
- `*`: alternative opcodes; must not be used.
- `d8` or `d16`: 8-bit or 16-bit immediate data.
- `a16`: 16-bit memory address.
- `r8`: 8 bit signed data, added to PC, IX or IY.

|opcode |mnemonic     |size|cycles|flags   |
|:-----:|:------------|---:|-----:|:-------|
|00     |NOP          |1   |4     |--------|
|01     |LD BC,d16    |3   |10    |--------|
|02     |LD (BC),A    |1   |7     |--------|
|03     |INC BC       |1   |6     |--------|
|04     |INC B        |1   |4     |-----V0-|
|05     |DEC B        |1   |4     |-----V1-|
|06     |LD B,d8      |2   |7     |--------|
|07     |RLCA         |1   |4     |--Y0X-0C|
|08     |EX AF,AF'    |1   |4     |--------|
|09     |ADD HL,BC    |1   |11    |--YHX-0C|
|0A     |LD A,(BC)    |1   |7     |--------|
|0B     |DEC BC       |1   |6     |--------|
|0C     |INC C        |1   |4     |-----V0-|
|0D     |DEC C        |1   |4     |-----V1-|
|0E     |LD C,d8      |2   |7     |--------|
|0F     |RRCA         |1   |4     |--Y0X-0C|
|10     |DJNZ r8      |2   |13/8  |--------|
|11     |LD DE,d16    |3   |10    |--------|
|12     |LD (DE),A    |1   |7     |--------|
|13     |INC DE       |1   |6     |--------|
|14     |INC D        |1   |4     |-----V0-|
|15     |DEC D        |1   |4     |-----V1-|
|16     |LD D,d8      |2   |7     |--------|
|17     |RLA          |1   |4     |--Y0X-0C|
|18     |JR r8        |2   |12    |--------|
|19     |ADD HL,DE    |1   |11    |--YHX-0C|
|1A     |LD A,(DE)    |1   |7     |--------|
|1B     |DEC DE       |1   |6     |--------|
|1C     |INC E        |1   |4     |-----V0-|
|1D     |DEC E        |1   |4     |-----V1-|
|1E     |LD E,d8      |2   |7     |--------|
|1F     |RRA          |1   |4     |--Y0X-0C|
|20     |JR NZ,r8     |2   |12/7  |--------|
|21     |LD HL,d16    |3   |10    |--------|
|22     |LD (a16),HL  |3   |16    |--------|
|23     |INC HL       |1   |6     |--------|
|24     |INC H        |1   |4     |-----V0-|
|25     |DEC H        |1   |4     |-----V1-|
|26     |LD H,d8      |2   |7     |--------|
|27     |DAA          |1   |4     |SZYHXP-C|
|28     |JR Z,r8      |2   |12/7  |--------|
|29     |ADD HL,HL    |1   |11    |--YHX-0C|
|2A     |LD HL,(a16)  |3   |16    |--------|
|2B     |DEC HL       |1   |6     |--------|
|2C     |INC L        |1   |4     |-----V0-|
|2D     |DEC L        |1   |4     |-----V1-|
|2E     |LD L,d8      |2   |7     |--------|
|2F     |CPL          |1   |4     |--Y1X-1-|
|30     |JR NC,r8     |2   |12/7  |--------|
|31     |LD SP,d16    |3   |10    |--------|
|32     |LD (a16),A   |3   |13    |--------|
|33     |INC SP       |1   |6     |--------|
|34     |INC (HL)     |1   |11    |-----V0-|
|35     |DEC (HL)     |1   |11    |-----V1-|
|36     |LD (HL),d8   |2   |10    |--------|
|37     |SCF          |1   |4     |--Y0X-01|
|38     |JR C,r8      |2   |12/7  |--------|
|39     |ADD HL,SP    |1   |11    |--YHX-0C|
|3A     |LD A,(a16)   |3   |13    |--------|
|3B     |DEC SP       |1   |6     |--------|
|3C     |INC A        |1   |4     |-----V0-|
|3D     |DEC A        |1   |4     |-----V1-|
|3E     |LD A,d8      |2   |7     |--------|
|3F     |CCF          |1   |4     |--YHX-0C|
|40     |LD B,B       |1   |4     |--------|
|41     |LD B,C       |1   |4     |--------|
|42     |LD B,D       |1   |4     |--------|
|43     |LD B,E       |1   |4     |--------|
|44     |LD B,H       |1   |4     |--------|
|45     |LD B,L       |1   |4     |--------|
|46     |LD B,(HL)    |1   |7     |--------|
|47     |LD B,A       |1   |4     |--------|
|48     |LD C,B       |1   |4     |--------|
|49     |LD C,C       |1   |4     |--------|
|4A     |LD C,D       |1   |4     |--------|
|4B     |LD C,E       |1   |4     |--------|
|4C     |LD C,H       |1   |4     |--------|
|4D     |LD C,L       |1   |4     |--------|
|4E     |LD C,(HL)    |1   |7     |--------|
|4F     |LD C,A       |1   |4     |--------|
|50     |LD D,B       |1   |4     |--------|
|51     |LD D,C       |1   |4     |--------|
|52     |LD D,D       |1   |4     |--------|
|53     |LD D,E       |1   |4     |--------|
|54     |LD D,H       |1   |4     |--------|
|55     |LD D,L       |1   |4     |--------|
|56     |LD D,(HL)    |1   |7     |--------|
|57     |LD D,A       |1   |4     |--------|
|58     |LD E,B       |1   |4     |--------|
|59     |LD E,C       |1   |4     |--------|
|5A     |LD E,D       |1   |4     |--------|
|5B     |LD E,E       |1   |4     |--------|
|5C     |LD E,H       |1   |4     |--------|
|5D     |LD E,L       |1   |4     |--------|
|5E     |LD E,(HL)    |1   |7     |--------|
|5F     |LD E,A       |1   |4     |--------|
|60     |LD H,B       |1   |4     |--------|
|61     |LD H,C       |1   |4     |--------|
|62     |LD H,D       |1   |4     |--------|
|63     |LD H,E       |1   |4     |--------|
|64     |LD H,H       |1   |4     |--------|
|65     |LD H,L       |1   |4     |--------|
|66     |LD H,(HL)    |1   |7     |--------|
|67     |LD H,A       |1   |4     |--------|
|68     |LD L,B       |1   |4     |--------|
|69     |LD L,C       |1   |4     |--------|
|6A     |LD L,D       |1   |4     |--------|
|6B     |LD L,E       |1   |4     |--------|
|6C     |LD L,H       |1   |4     |--------|
|6D     |LD L,L       |1   |4     |--------|
|6E     |LD L,(HL)    |1   |7     |--------|
|6F     |LD L,A       |1   |4     |--------|
|70     |LD (HL),B    |1   |7     |--------|
|71     |LD (HL),C    |1   |7     |--------|
|72     |LD (HL),D    |1   |7     |--------|
|73     |LD (HL),E    |1   |7     |--------|
|74     |LD (HL),H    |1   |7     |--------|
|75     |LD (HL),L    |1   |7     |--------|
|76     |HALT         |1   |4     |--------|
|77     |LD (HL),A    |1   |7     |--------|
|78     |LD A,B       |1   |4     |--------|
|79     |LD A,C       |1   |4     |--------|
|7A     |LD A,D       |1   |4     |--------|
|7B     |LD A,E       |1   |4     |--------|
|7C     |LD A,H       |1   |4     |--------|
|7D     |LD A,L       |1   |4     |--------|
|7E     |LD A,(HL)    |1   |7     |--------|
|7F     |LD A,A       |1   |4     |--------|
|80     |ADD A,B      |1   |4     |SZYHXV0C|
|81     |ADD A,C      |1   |4     |SZYHXV0C|
|82     |ADD A,D      |1   |4     |SZYHXV0C|
|83     |ADD A,E      |1   |4     |SZYHXV0C|
|84     |ADD A,H      |1   |4     |SZYHXV0C|
|85     |ADD A,L      |1   |4     |SZYHXV0C|
|86     |ADD A,(HL)   |1   |7     |SZYHXV0C|
|87     |ADD A,A      |1   |4     |SZYHXV0C|
|88     |ADC A,B      |1   |4     |SZYHXV0C|
|89     |ADC A,C      |1   |4     |SZYHXV0C|
|8A     |ADC A,D      |1   |4     |SZYHXV0C|
|8B     |ADC A,E      |1   |4     |SZYHXV0C|
|8C     |ADC A,H      |1   |4     |SZYHXV0C|
|8D     |ADC A,L      |1   |4     |SZYHXV0C|
|8E     |ADC A,(HL)   |1   |7     |SZYHXV0C|
|8F     |ADC A,A      |1   |4     |SZYHXV0C|
|90     |SUB B        |1   |4     |SZYHXV1C|
|91     |SUB C        |1   |4     |SZYHXV1C|
|92     |SUB D        |1   |4     |SZYHXV1C|
|93     |SUB E        |1   |4     |SZYHXV1C|
|94     |SUB H        |1   |4     |SZYHXV1C|
|95     |SUB L        |1   |4     |SZYHXV1C|
|96     |SUB (HL)     |1   |7     |SZYHXV1C|
|97     |SUB A        |1   |4     |SZYHXV1C|
|98     |SBC A,B      |1   |4     |SZYHXV1C|
|99     |SBC A,C      |1   |4     |SZYHXV1C|
|9A     |SBC A,D      |1   |4     |SZYHXV1C|
|9B     |SBC A,E      |1   |4     |SZYHXV1C|
|9C     |SBC A,H      |1   |4     |SZYHXV1C|
|9D     |SBC A,L      |1   |4     |SZYHXV1C|
|9E     |SBC A,(HL)   |1   |7     |SZYHXV1C|
|9F     |SBC A,A      |1   |4     |SZYHXV1C|
|A0     |AND B        |1   |4     |SZY1XP00|
|A1     |AND C        |1   |4     |SZY1XP00|
|A2     |AND D        |1   |4     |SZY1XP00|
|A3     |AND E        |1   |4     |SZY1XP00|
|A4     |AND H        |1   |4     |SZY1XP00|
|A5     |AND L        |1   |4     |SZY1XP00|
|A6     |AND (HL)     |1   |7     |SZY1XP00|
|A7     |AND A        |1   |4     |SZY1XP00|
|A8     |XOR B        |1   |4     |SZY1XP00|
|A9     |XOR C        |1   |4     |SZY1XP00|
|AA     |XOR D        |1   |4     |SZY1XP00|
|AB     |XOR E        |1   |4     |SZY1XP00|
|AC     |XOR H        |1   |4     |SZY1XP00|
|AD     |XOR L        |1   |4     |SZY1XP00|
|AE     |XOR (HL)     |1   |7     |SZY1XP00|
|AF     |XOR A        |1   |4     |SZY1XP00|
|B0     |OR B         |1   |4     |SZY1XP00|
|B1     |OR C         |1   |4     |SZY1XP00|
|B2     |OR D         |1   |4     |SZY1XP00|
|B3     |OR E         |1   |4     |SZY1XP00|
|B4     |OR H         |1   |4     |SZY1XP00|
|B5     |OR L         |1   |4     |SZY1XP00|
|B6     |OR (HL)      |1   |7     |SZY1XP00|
|B7     |OR A         |1   |4     |SZY1XP00|
|B8     |CP B         |1   |4     |SZYHXV1C|
|B9     |CP C         |1   |4     |SZYHXV1C|
|BA     |CP D         |1   |4     |SZYHXV1C|
|BB     |CP E         |1   |4     |SZYHXV1C|
|BC     |CP H         |1   |4     |SZYHXV1C|
|BD     |CP L         |1   |4     |SZYHXV1C|
|BE     |CP (HL)      |1   |7     |SZYHXV1C|
|BF     |CP A         |1   |4     |SZYHXV1C|
|C0     |RET NZ       |1   |11/5  |--------|
|C1     |POP BC       |1   |10    |--------|
|C2     |JP NZ,a16    |3   |10    |--------|
|C3     |JP a16       |3   |10    |--------|
|C4     |CALL NZ,a16  |3   |17/10 |--------|
|C5     |PUSH BC      |1   |11    |--------|
|C6     |ADD A,d8     |2   |7     |SZYHXV0C|
|C7     |RST 00H      |1   |11    |--------|
|C8     |RET Z        |1   |11/5  |--------|
|C9     |RET          |1   |10    |--------|
|CA     |JP Z,a16     |3   |10    |--------|
|CB     |PREFIX CB    |    |      |        |
|CC     |CALL Z,a16   |3   |17/10 |--------|
|CD     |CALL a16     |3   |17    |--------|
|CE     |ADC A,d8     |2   |7     |SZYHXV0C|
|CF     |RST 08H      |1   |11    |--------|
|D0     |RET NC       |1   |11/5  |--------|
|D1     |POP DE       |1   |10    |--------|
|D2     |JP NC,a16    |3   |10    |--------|
|D3     |OUT (d8),A   |2   |11    |--------|
|D4     |CALL NC,a16  |3   |17/10 |--------|
|D5     |PUSH DE      |1   |11    |--------|
|D6     |SUB d8       |2   |7     |SZYHXV1C|
|D7     |RST 10H      |1   |11    |--------|
|D8     |RET C        |1   |11/5  |--------|
|D9     |EXX          |1   |4     |--------|
|DA     |JP C,a16     |3   |10    |--------|
|DB     |IN A,(d8)    |2   |11    |--------|
|DC     |CALL C,a16   |3   |17/10 |--------|
|DD     |PREFIX DD    |    |      |        |
|DE     |SBC A,d8     |2   |7     |SZYHXV1C|
|DF     |RST 18H      |1   |11    |--------|
|E0     |RET PO       |1   |11/5  |--------|
|E1     |POP HL       |1   |10    |--------|
|E2     |JP PO,a16    |3   |10    |--------|
|E3     |EX (SP),HL   |1   |19    |--------|
|E4     |CALL PO,a16  |3   |17/10 |--------|
|E5     |PUSH HL      |1   |11    |--------|
|E6     |AND d8       |2   |7     |SZY1XP00|
|E7     |RST 20H      |1   |11    |--------|
|E8     |RET PE       |1   |11/5  |--------|
|E9     |JP (HL)      |1   |4     |--------|
|EA     |JP PE,a16    |3   |10    |--------|
|EB     |EX DE,HL     |1   |4     |--------|
|EC     |CALL PE,a16  |3   |17/10 |--------|
|ED     |PREFIX ED    |    |      |        |
|EE     |XOR d8       |2   |7     |SZY1XP00|
|EF     |RST 28H      |1   |11    |--------|
|F0     |RET P        |1   |11/5  |--------|
|F1     |POP AF       |1   |10    |SZYHXPNC|
|F2     |JP P,a16     |3   |10    |--------|
|F3     |DI           |1   |4     |--------|
|F4     |CALL P,a16   |3   |17/10 |--------|
|F5     |PUSH AF      |1   |11    |--------|
|F6     |OR d8        |2   |7     |SZY1XP00|
|F7     |RST 30H      |1   |11    |--------|
|F8     |RET M        |1   |11/5  |--------|
|F9     |LD SP,HL     |1   |6     |--------|
|FA     |JP M,a16     |3   |10    |--------|
|FB     |EI           |1   |4     |--------|
|FC     |CALL M,a16   |3   |17/10 |--------|
|FD     |PREFIX FD    |    |      |        |
|FE     |CP d8        |2   |7     |SZYHXV1C|
|FF     |RST 38H      |1   |11    |--------|
|CB 00  |RLC B        |2   |8     |SZY0XP0C|
|CB 01  |RLC C        |2   |8     |SZY0XP0C|
|CB 02  |RLC D        |2   |8     |SZY0XP0C|
|CB 03  |RLC E        |2   |8     |SZY0XP0C|
|CB 04  |RLC H        |2   |8     |SZY0XP0C|
|CB 05  |RLC L        |2   |8     |SZY0XP0C|
|CB 06  |RLC (HL)     |2   |15    |SZY0XP0C|
|CB 07  |RLC A        |2   |8     |SZY0XP0C|
|CB 08  |RRC B        |2   |8     |SZY0XP0C|
|CB 09  |RRC C        |2   |8     |SZY0XP0C|
|CB 0A  |RRC D        |2   |8     |SZY0XP0C|
|CB 0B  |RRC E        |2   |8     |SZY0XP0C|
|CB 0C  |RRC H        |2   |8     |SZY0XP0C|
|CB 0D  |RRC L        |2   |8     |SZY0XP0C|
|CB 0E  |RRC (HL)     |2   |15    |SZY0XP0C|
|CB 0F  |RRC A        |2   |8     |SZY0XP0C|
|CB 10  |RL B         |2   |8     |SZY0XP0C|
|CB 11  |RL C         |2   |8     |SZY0XP0C|
|CB 12  |RL D         |2   |8     |SZY0XP0C|
|CB 13  |RL E         |2   |8     |SZY0XP0C|
|CB 14  |RL H         |2   |8     |SZY0XP0C|
|CB 15  |RL L         |2   |8     |SZY0XP0C|
|CB 16  |RL (HL)      |2   |15    |SZY0XP0C|
|CB 17  |RL A         |2   |8     |SZY0XP0C|
|CB 18  |RR B         |2   |8     |SZY0XP0C|
|CB 19  |RR C         |2   |8     |SZY0XP0C|
|CB 1A  |RR D         |2   |8     |SZY0XP0C|
|CB 1B  |RR E         |2   |8     |SZY0XP0C|
|CB 1C  |RR H         |2   |8     |SZY0XP0C|
|CB 1D  |RR L         |2   |8     |SZY0XP0C|
|CB 1E  |RR (HL)      |2   |15    |SZY0XP0C|
|CB 1F  |RR A         |2   |8     |SZY0XP0C|
|CB 20  |SLA B        |2   |8     |SZY0XP0C|
|CB 21  |SLA C        |2   |8     |SZY0XP0C|
|CB 22  |SLA D        |2   |8     |SZY0XP0C|
|CB 23  |SLA E        |2   |8     |SZY0XP0C|
|CB 24  |SLA H        |2   |8     |SZY0XP0C|
|CB 25  |SLA L        |2   |8     |SZY0XP0C|
|CB 26  |SLA (HL)     |2   |15    |SZY0XP0C|
|CB 27  |SLA A        |2   |8     |SZY0XP0C|
|CB 28  |SRA B        |2   |8     |SZY0XP0C|
|CB 29  |SRA C        |2   |8     |SZY0XP0C|
|CB 2A  |SRA D        |2   |8     |SZY0XP0C|
|CB 2B  |SRA E        |2   |8     |SZY0XP0C|
|CB 2C  |SRA H        |2   |8     |SZY0XP0C|
|CB 2D  |SRA L        |2   |8     |SZY0XP0C|
|CB 2E  |SRA (HL)     |2   |15    |SZY0XP0C|
|CB 2F  |SRA A        |2   |8     |SZY0XP0C|
|CB 30  |SLL B        |2   |8     |SZY0XP0C|
|CB 31  |SLL C        |2   |8     |SZY0XP0C|
|CB 32  |SLL D        |2   |8     |SZY0XP0C|
|CB 33  |SLL E        |2   |8     |SZY0XP0C|
|CB 34  |SLL H        |2   |8     |SZY0XP0C|
|CB 35  |SLL L        |2   |8     |SZY0XP0C|
|CB 36  |SLL (HL)     |2   |15    |SZY0XP0C|
|CB 37  |SLL A        |2   |8     |SZY0XP0C|
|CB 38  |SRL B        |2   |8     |SZY0XP0C|
|CB 39  |SRL C        |2   |8     |SZY0XP0C|
|CB 3A  |SRL D        |2   |8     |SZY0XP0C|
|CB 3B  |SRL E        |2   |8     |SZY0XP0C|
|CB 3C  |SRL H        |2   |8     |SZY0XP0C|
|CB 3D  |SRL L        |2   |8     |SZY0XP0C|
|CB 3E  |SRL (HL)     |2   |15    |SZY0XP0C|
|CB 3F  |SRL A        |2   |8     |SZY0XP0C|
|CB 40  |BIT 0,B      |2   |8     |SZY1XU0-|
|CB 41  |BIT 0,C      |2   |8     |SZY1XU0-|
|CB 42  |BIT 0,D      |2   |8     |SZY1XU0-|
|CB 43  |BIT 0,E      |2   |8     |SZY1XU0-|
|CB 44  |BIT 0,H      |2   |8     |SZY1XU0-|
|CB 45  |BIT 0,L      |2   |8     |SZY1XU0-|
|CB 46  |BIT 0,(HL)   |2   |12    |SZY1XU0-|
|CB 47  |BIT 0,A      |2   |8     |SZY1XU0-|
|CB 48  |BIT 1,B      |2   |8     |SZY1XU0-|
|CB 49  |BIT 1,C      |2   |8     |SZY1XU0-|
|CB 4A  |BIT 1,D      |2   |8     |SZY1XU0-|
|CB 4B  |BIT 1,E      |2   |8     |SZY1XU0-|
|CB 4C  |BIT 1,H      |2   |8     |SZY1XU0-|
|CB 4D  |BIT 1,L      |2   |8     |SZY1XU0-|
|CB 4E  |BIT 1,(HL)   |2   |12    |SZY1XU0-|
|CB 4F  |BIT 1,A      |2   |8     |SZY1XU0-|
|CB 50  |BIT 2,B      |2   |8     |SZY1XU0-|
|CB 51  |BIT 2,C      |2   |8     |SZY1XU0-|
|CB 52  |BIT 2,D      |2   |8     |SZY1XU0-|
|CB 53  |BIT 2,E      |2   |8     |SZY1XU0-|
|CB 54  |BIT 2,H      |2   |8     |SZY1XU0-|
|CB 55  |BIT 2,L      |2   |8     |SZY1XU0-|
|CB 56  |BIT 2,(HL)   |2   |12    |SZY1XU0-|
|CB 57  |BIT 2,A      |2   |8     |SZY1XU0-|
|CB 58  |BIT 3,B      |2   |8     |SZY1XU0-|
|CB 59  |BIT 3,C      |2   |8     |SZY1XU0-|
|CB 5A  |BIT 3,D      |2   |8     |SZY1XU0-|
|CB 5B  |BIT 3,E      |2   |8     |SZY1XU0-|
|CB 5C  |BIT 3,H      |2   |8     |SZY1XU0-|
|CB 5D  |BIT 3,L      |2   |8     |SZY1XU0-|
|CB 5E  |BIT 3,(HL)   |2   |12    |SZY1XU0-|
|CB 5F  |BIT 3,A      |2   |8     |SZY1XU0-|
|CB 60  |BIT 4,B      |2   |8     |SZY1XU0-|
|CB 61  |BIT 4,C      |2   |8     |SZY1XU0-|
|CB 62  |BIT 4,D      |2   |8     |SZY1XU0-|
|CB 63  |BIT 4,E      |2   |8     |SZY1XU0-|
|CB 64  |BIT 4,H      |2   |8     |SZY1XU0-|
|CB 65  |BIT 4,L      |2   |8     |SZY1XU0-|
|CB 66  |BIT 4,(HL)   |2   |12    |SZY1XU0-|
|CB 67  |BIT 4,A      |2   |8     |SZY1XU0-|
|CB 68  |BIT 5,B      |2   |8     |SZY1XU0-|
|CB 69  |BIT 5,C      |2   |8     |SZY1XU0-|
|CB 6A  |BIT 5,D      |2   |8     |SZY1XU0-|
|CB 6B  |BIT 5,E      |2   |8     |SZY1XU0-|
|CB 6C  |BIT 5,H      |2   |8     |SZY1XU0-|
|CB 6D  |BIT 5,L      |2   |8     |SZY1XU0-|
|CB 6E  |BIT 5,(HL)   |2   |12    |SZY1XU0-|
|CB 6F  |BIT 5,A      |2   |8     |SZY1XU0-|
|CB 70  |BIT 6,B      |2   |8     |SZY1XU0-|
|CB 71  |BIT 6,C      |2   |8     |SZY1XU0-|
|CB 72  |BIT 6,D      |2   |8     |SZY1XU0-|
|CB 73  |BIT 6,E      |2   |8     |SZY1XU0-|
|CB 74  |BIT 6,H      |2   |8     |SZY1XU0-|
|CB 75  |BIT 6,L      |2   |8     |SZY1XU0-|
|CB 76  |BIT 6,(HL)   |2   |12    |SZY1XU0-|
|CB 77  |BIT 6,A      |2   |8     |SZY1XU0-|
|CB 78  |BIT 7,B      |2   |8     |SZY1XU0-|
|CB 79  |BIT 7,C      |2   |8     |SZY1XU0-|
|CB 7A  |BIT 7,D      |2   |8     |SZY1XU0-|
|CB 7B  |BIT 7,E      |2   |8     |SZY1XU0-|
|CB 7C  |BIT 7,H      |2   |8     |SZY1XU0-|
|CB 7D  |BIT 7,L      |2   |8     |SZY1XU0-|
|CB 7E  |BIT 7,(HL)   |2   |12    |SZY1XU0-|
|CB 7F  |BIT 7,A      |2   |8     |SZY1XU0-|
|CB 80  |RES 0,B      |2   |8     |--------|
|CB 81  |RES 0,C      |2   |8     |--------|
|CB 82  |RES 0,D      |2   |8     |--------|
|CB 83  |RES 0,E      |2   |8     |--------|
|CB 84  |RES 0,H      |2   |8     |--------|
|CB 85  |RES 0,L      |2   |8     |--------|
|CB 86  |RES 0,(HL)   |2   |15    |--------|
|CB 87  |RES 0,A      |2   |8     |--------|
|CB 88  |RES 1,B      |2   |8     |--------|
|CB 89  |RES 1,C      |2   |8     |--------|
|CB 8A  |RES 1,D      |2   |8     |--------|
|CB 8B  |RES 1,E      |2   |8     |--------|
|CB 8C  |RES 1,H      |2   |8     |--------|
|CB 8D  |RES 1,L      |2   |8     |--------|
|CB 8E  |RES 1,(HL)   |2   |15    |--------|
|CB 8F  |RES 1,A      |2   |8     |--------|
|CB 90  |RES 2,B      |2   |8     |--------|
|CB 91  |RES 2,C      |2   |8     |--------|
|CB 92  |RES 2,D      |2   |8     |--------|
|CB 93  |RES 2,E      |2   |8     |--------|
|CB 94  |RES 2,H      |2   |8     |--------|
|CB 95  |RES 2,L      |2   |8     |--------|
|CB 96  |RES 2,(HL)   |2   |15    |--------|
|CB 97  |RES 2,A      |2   |8     |--------|
|CB 98  |RES 3,B      |2   |8     |--------|
|CB 99  |RES 3,C      |2   |8     |--------|
|CB 9A  |RES 3,D      |2   |8     |--------|
|CB 9B  |RES 3,E      |2   |8     |--------|
|CB 9C  |RES 3,H      |2   |8     |--------|
|CB 9D  |RES 3,L      |2   |8     |--------|
|CB 9E  |RES 3,(HL)   |2   |15    |--------|
|CB 9F  |RES 3,A      |2   |8     |--------|
|CB A0  |RES 4,B      |2   |8     |--------|
|CB A1  |RES 4,C      |2   |8     |--------|
|CB A2  |RES 4,D      |2   |8     |--------|
|CB A3  |RES 4,E      |2   |8     |--------|
|CB A4  |RES 4,H      |2   |8     |--------|
|CB A5  |RES 4,L      |2   |8     |--------|
|CB A6  |RES 4,(HL)   |2   |15    |--------|
|CB A7  |RES 4,A      |2   |8     |--------|
|CB A8  |RES 5,B      |2   |8     |--------|
|CB A9  |RES 5,C      |2   |8     |--------|
|CB AA  |RES 5,D      |2   |8     |--------|
|CB AB  |RES 5,E      |2   |8     |--------|
|CB AC  |RES 5,H      |2   |8     |--------|
|CB AD  |RES 5,L      |2   |8     |--------|
|CB AE  |RES 5,(HL)   |2   |15    |--------|
|CB AF  |RES 5,A      |2   |8     |--------|
|CB B0  |RES 6,B      |2   |8     |--------|
|CB B1  |RES 6,C      |2   |8     |--------|
|CB B2  |RES 6,D      |2   |8     |--------|
|CB B3  |RES 6,E      |2   |8     |--------|
|CB B4  |RES 6,H      |2   |8     |--------|
|CB B5  |RES 6,L      |2   |8     |--------|
|CB B6  |RES 6,(HL)   |2   |15    |--------|
|CB B7  |RES 6,A      |2   |8     |--------|
|CB B8  |RES 7,B      |2   |8     |--------|
|CB B9  |RES 7,C      |2   |8     |--------|
|CB BA  |RES 7,D      |2   |8     |--------|
|CB BB  |RES 7,E      |2   |8     |--------|
|CB BC  |RES 7,H      |2   |8     |--------|
|CB BD  |RES 7,L      |2   |8     |--------|
|CB BE  |RES 7,(HL)   |2   |15    |--------|
|CB BF  |RES 7,A      |2   |8     |--------|
|CB C0  |SET 0,B      |2   |8     |--------|
|CB C1  |SET 0,C      |2   |8     |--------|
|CB C2  |SET 0,D      |2   |8     |--------|
|CB C3  |SET 0,E      |2   |8     |--------|
|CB C4  |SET 0,H      |2   |8     |--------|
|CB C5  |SET 0,L      |2   |8     |--------|
|CB C6  |SET 0,(HL)   |2   |15    |--------|
|CB C7  |SET 0,A      |2   |8     |--------|
|CB C8  |SET 1,B      |2   |8     |--------|
|CB C9  |SET 1,C      |2   |8     |--------|
|CB CA  |SET 1,D      |2   |8     |--------|
|CB CB  |SET 1,E      |2   |8     |--------|
|CB CC  |SET 1,H      |2   |8     |--------|
|CB CD  |SET 1,L      |2   |8     |--------|
|CB CE  |SET 1,(HL)   |2   |15    |--------|
|CB CF  |SET 1,A      |2   |8     |--------|
|CB D0  |SET 2,B      |2   |8     |--------|
|CB D1  |SET 2,C      |2   |8     |--------|
|CB D2  |SET 2,D      |2   |8     |--------|
|CB D3  |SET 2,E      |2   |8     |--------|
|CB D4  |SET 2,H      |2   |8     |--------|
|CB D5  |SET 2,L      |2   |8     |--------|
|CB D6  |SET 2,(HL)   |2   |15    |--------|
|CB D7  |SET 2,A      |2   |8     |--------|
|CB D8  |SET 3,B      |2   |8     |--------|
|CB D9  |SET 3,C      |2   |8     |--------|
|CB DA  |SET 3,D      |2   |8     |--------|
|CB DB  |SET 3,E      |2   |8     |--------|
|CB DC  |SET 3,H      |2   |8     |--------|
|CB DD  |SET 3,L      |2   |8     |--------|
|CB DE  |SET 3,(HL)   |2   |15    |--------|
|CB DF  |SET 3,A      |2   |8     |--------|
|CB E0  |SET 4,B      |2   |8     |--------|
|CB E1  |SET 4,C      |2   |8     |--------|
|CB E2  |SET 4,D      |2   |8     |--------|
|CB E3  |SET 4,E      |2   |8     |--------|
|CB E4  |SET 4,H      |2   |8     |--------|
|CB E5  |SET 4,L      |2   |8     |--------|
|CB E6  |SET 4,(HL)   |2   |15    |--------|
|CB E7  |SET 4,A      |2   |8     |--------|
|CB E8  |SET 5,B      |2   |8     |--------|
|CB E9  |SET 5,C      |2   |8     |--------|
|CB EA  |SET 5,D      |2   |8     |--------|
|CB EB  |SET 5,E      |2   |8     |--------|
|CB EC  |SET 5,H      |2   |8     |--------|
|CB ED  |SET 5,L      |2   |8     |--------|
|CB EE  |SET 5,(HL)   |2   |15    |--------|
|CB EF  |SET 5,A      |2   |8     |--------|
|CB F0  |SET 6,B      |2   |8     |--------|
|CB F1  |SET 6,C      |2   |8     |--------|
|CB F2  |SET 6,D      |2   |8     |--------|
|CB F3  |SET 6,E      |2   |8     |--------|
|CB F4  |SET 6,H      |2   |8     |--------|
|CB F5  |SET 6,L      |2   |8     |--------|
|CB F6  |SET 6,(HL)   |2   |15    |--------|
|CB F7  |SET 6,A      |2   |8     |--------|
|CB F8  |SET 7,B      |2   |8     |--------|
|CB F9  |SET 7,C      |2   |8     |--------|
|CB FA  |SET 7,D      |2   |8     |--------|
|CB FB  |SET 7,E      |2   |8     |--------|
|CB FC  |SET 7,H      |2   |8     |--------|
|CB FD  |SET 7,L      |2   |8     |--------|
|CB FE  |SET 7,(HL)   |2   |15    |--------|
|CB FF  |SET 7,A      |2   |8     |--------|
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
|DD CB  |PREFIX DDCB  |    |      |        |
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
|DDCB 00|RLC B        |3   |12    |SZY0XP0C|
|DDCB 01|RLC C        |3   |12    |SZY0XP0C|
|DDCB 02|RLC D        |3   |12    |SZY0XP0C|
|DDCB 03|RLC E        |3   |12    |SZY0XP0C|
|DDCB 04|RLC IXh      |3   |12    |SZY0XP0C|
|DDCB 05|RLC IXl      |3   |12    |SZY0XP0C|
|DDCB 06|RLC (IX+r8)  |4   |23    |SZY0XP0C|
|DDCB 07|RLC A        |3   |12    |SZY0XP0C|
|DDCB 08|RRC B        |3   |12    |SZY0XP0C|
|DDCB 09|RRC C        |3   |12    |SZY0XP0C|
|DDCB 0A|RRC D        |3   |12    |SZY0XP0C|
|DDCB 0B|RRC E        |3   |12    |SZY0XP0C|
|DDCB 0C|RRC IXh      |3   |12    |SZY0XP0C|
|DDCB 0D|RRC IXl      |3   |12    |SZY0XP0C|
|DDCB 0E|RRC (IX+r8)  |4   |23    |SZY0XP0C|
|DDCB 0F|RRC A        |3   |12    |SZY0XP0C|
|DDCB 10|RL B         |3   |12    |SZY0XP0C|
|DDCB 11|RL C         |3   |12    |SZY0XP0C|
|DDCB 12|RL D         |3   |12    |SZY0XP0C|
|DDCB 13|RL E         |3   |12    |SZY0XP0C|
|DDCB 14|RL IXh       |3   |12    |SZY0XP0C|
|DDCB 15|RL IXl       |3   |12    |SZY0XP0C|
|DDCB 16|RL (IX+r8)   |4   |23    |SZY0XP0C|
|DDCB 17|RL A         |3   |12    |SZY0XP0C|
|DDCB 18|RR B         |3   |12    |SZY0XP0C|
|DDCB 19|RR C         |3   |12    |SZY0XP0C|
|DDCB 1A|RR D         |3   |12    |SZY0XP0C|
|DDCB 1B|RR E         |3   |12    |SZY0XP0C|
|DDCB 1C|RR IXh       |3   |12    |SZY0XP0C|
|DDCB 1D|RR IXl       |3   |12    |SZY0XP0C|
|DDCB 1E|RR (IX+r8)   |4   |23    |SZY0XP0C|
|DDCB 1F|RR A         |3   |12    |SZY0XP0C|
|DDCB 20|SLA B        |3   |12    |SZY0XP0C|
|DDCB 21|SLA C        |3   |12    |SZY0XP0C|
|DDCB 22|SLA D        |3   |12    |SZY0XP0C|
|DDCB 23|SLA E        |3   |12    |SZY0XP0C|
|DDCB 24|SLA IXh      |3   |12    |SZY0XP0C|
|DDCB 25|SLA IXl      |3   |12    |SZY0XP0C|
|DDCB 26|SLA (IX+r8)  |4   |23    |SZY0XP0C|
|DDCB 27|SLA A        |3   |12    |SZY0XP0C|
|DDCB 28|SRA B        |3   |12    |SZY0XP0C|
|DDCB 29|SRA C        |3   |12    |SZY0XP0C|
|DDCB 2A|SRA D        |3   |12    |SZY0XP0C|
|DDCB 2B|SRA E        |3   |12    |SZY0XP0C|
|DDCB 2C|SRA IXh      |3   |12    |SZY0XP0C|
|DDCB 2D|SRA IXl      |3   |12    |SZY0XP0C|
|DDCB 2E|SRA (IX+r8)  |4   |23    |SZY0XP0C|
|DDCB 2F|SRA A        |3   |12    |SZY0XP0C|
|DDCB 30|SLL B        |3   |12    |SZY0XP0C|
|DDCB 31|SLL C        |3   |12    |SZY0XP0C|
|DDCB 32|SLL D        |3   |12    |SZY0XP0C|
|DDCB 33|SLL E        |3   |12    |SZY0XP0C|
|DDCB 34|SLL IXh      |3   |12    |SZY0XP0C|
|DDCB 35|SLL IXl      |3   |12    |SZY0XP0C|
|DDCB 36|SLL (IX+r8)  |4   |23    |SZY0XP0C|
|DDCB 37|SLL A        |3   |12    |SZY0XP0C|
|DDCB 38|SRL B        |3   |12    |SZY0XP0C|
|DDCB 39|SRL C        |3   |12    |SZY0XP0C|
|DDCB 3A|SRL D        |3   |12    |SZY0XP0C|
|DDCB 3B|SRL E        |3   |12    |SZY0XP0C|
|DDCB 3C|SRL IXh      |3   |12    |SZY0XP0C|
|DDCB 3D|SRL IXl      |3   |12    |SZY0XP0C|
|DDCB 3E|SRL (IX+r8)  |4   |23    |SZY0XP0C|
|DDCB 3F|SRL A        |3   |12    |SZY0XP0C|
|DDCB 40|BIT 0,B      |3   |12    |SZY1XU0-|
|DDCB 41|BIT 0,C      |3   |12    |SZY1XU0-|
|DDCB 42|BIT 0,D      |3   |12    |SZY1XU0-|
|DDCB 43|BIT 0,E      |3   |12    |SZY1XU0-|
|DDCB 44|BIT 0,IXh    |3   |12    |SZY1XU0-|
|DDCB 45|BIT 0,IXl    |3   |12    |SZY1XU0-|
|DDCB 46|BIT 0,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 47|BIT 0,A      |3   |12    |SZY1XU0-|
|DDCB 48|BIT 1,B      |3   |12    |SZY1XU0-|
|DDCB 49|BIT 1,C      |3   |12    |SZY1XU0-|
|DDCB 4A|BIT 1,D      |3   |12    |SZY1XU0-|
|DDCB 4B|BIT 1,E      |3   |12    |SZY1XU0-|
|DDCB 4C|BIT 1,IXh    |3   |12    |SZY1XU0-|
|DDCB 4D|BIT 1,IXl    |3   |12    |SZY1XU0-|
|DDCB 4E|BIT 1,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 4F|BIT 1,A      |3   |12    |SZY1XU0-|
|DDCB 50|BIT 2,B      |3   |12    |SZY1XU0-|
|DDCB 51|BIT 2,C      |3   |12    |SZY1XU0-|
|DDCB 52|BIT 2,D      |3   |12    |SZY1XU0-|
|DDCB 53|BIT 2,E      |3   |12    |SZY1XU0-|
|DDCB 54|BIT 2,IXh    |3   |12    |SZY1XU0-|
|DDCB 55|BIT 2,IXl    |3   |12    |SZY1XU0-|
|DDCB 56|BIT 2,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 57|BIT 2,A      |3   |12    |SZY1XU0-|
|DDCB 58|BIT 3,B      |3   |12    |SZY1XU0-|
|DDCB 59|BIT 3,C      |3   |12    |SZY1XU0-|
|DDCB 5A|BIT 3,D      |3   |12    |SZY1XU0-|
|DDCB 5B|BIT 3,E      |3   |12    |SZY1XU0-|
|DDCB 5C|BIT 3,IXh    |3   |12    |SZY1XU0-|
|DDCB 5D|BIT 3,IXl    |3   |12    |SZY1XU0-|
|DDCB 5E|BIT 3,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 5F|BIT 3,A      |3   |12    |SZY1XU0-|
|DDCB 60|BIT 4,B      |3   |12    |SZY1XU0-|
|DDCB 61|BIT 4,C      |3   |12    |SZY1XU0-|
|DDCB 62|BIT 4,D      |3   |12    |SZY1XU0-|
|DDCB 63|BIT 4,E      |3   |12    |SZY1XU0-|
|DDCB 64|BIT 4,IXh    |3   |12    |SZY1XU0-|
|DDCB 65|BIT 4,IXl    |3   |12    |SZY1XU0-|
|DDCB 66|BIT 4,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 67|BIT 4,A      |3   |12    |SZY1XU0-|
|DDCB 68|BIT 5,B      |3   |12    |SZY1XU0-|
|DDCB 69|BIT 5,C      |3   |12    |SZY1XU0-|
|DDCB 6A|BIT 5,D      |3   |12    |SZY1XU0-|
|DDCB 6B|BIT 5,E      |3   |12    |SZY1XU0-|
|DDCB 6C|BIT 5,IXh    |3   |12    |SZY1XU0-|
|DDCB 6D|BIT 5,IXl    |3   |12    |SZY1XU0-|
|DDCB 6E|BIT 5,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 6F|BIT 5,A      |3   |12    |SZY1XU0-|
|DDCB 70|BIT 6,B      |3   |12    |SZY1XU0-|
|DDCB 71|BIT 6,C      |3   |12    |SZY1XU0-|
|DDCB 72|BIT 6,D      |3   |12    |SZY1XU0-|
|DDCB 73|BIT 6,E      |3   |12    |SZY1XU0-|
|DDCB 74|BIT 6,IXh    |3   |12    |SZY1XU0-|
|DDCB 75|BIT 6,IXl    |3   |12    |SZY1XU0-|
|DDCB 76|BIT 6,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 77|BIT 6,A      |3   |12    |SZY1XU0-|
|DDCB 78|BIT 7,B      |3   |12    |SZY1XU0-|
|DDCB 79|BIT 7,C      |3   |12    |SZY1XU0-|
|DDCB 7A|BIT 7,D      |3   |12    |SZY1XU0-|
|DDCB 7B|BIT 7,E      |3   |12    |SZY1XU0-|
|DDCB 7C|BIT 7,IXh    |3   |12    |SZY1XU0-|
|DDCB 7D|BIT 7,IXl    |3   |12    |SZY1XU0-|
|DDCB 7E|BIT 7,(IX+r8)|4   |20    |SZY1XU0-|
|DDCB 7F|BIT 7,A      |3   |12    |SZY1XU0-|
|DDCB 80|RES 0,B      |3   |12    |--------|
|DDCB 81|RES 0,C      |3   |12    |--------|
|DDCB 82|RES 0,D      |3   |12    |--------|
|DDCB 83|RES 0,E      |3   |12    |--------|
|DDCB 84|RES 0,IXh    |3   |12    |--------|
|DDCB 85|RES 0,IXl    |3   |12    |--------|
|DDCB 86|RES 0,(IX+r8)|4   |23    |--------|
|DDCB 87|RES 0,A      |3   |12    |--------|
|DDCB 88|RES 1,B      |3   |12    |--------|
|DDCB 89|RES 1,C      |3   |12    |--------|
|DDCB 8A|RES 1,D      |3   |12    |--------|
|DDCB 8B|RES 1,E      |3   |12    |--------|
|DDCB 8C|RES 1,IXh    |3   |12    |--------|
|DDCB 8D|RES 1,IXl    |3   |12    |--------|
|DDCB 8E|RES 1,(IX+r8)|4   |23    |--------|
|DDCB 8F|RES 1,A      |3   |12    |--------|
|DDCB 90|RES 2,B      |3   |12    |--------|
|DDCB 91|RES 2,C      |3   |12    |--------|
|DDCB 92|RES 2,D      |3   |12    |--------|
|DDCB 93|RES 2,E      |3   |12    |--------|
|DDCB 94|RES 2,IXh    |3   |12    |--------|
|DDCB 95|RES 2,IXl    |3   |12    |--------|
|DDCB 96|RES 2,(IX+r8)|4   |23    |--------|
|DDCB 97|RES 2,A      |3   |12    |--------|
|DDCB 98|RES 3,B      |3   |12    |--------|
|DDCB 99|RES 3,C      |3   |12    |--------|
|DDCB 9A|RES 3,D      |3   |12    |--------|
|DDCB 9B|RES 3,E      |3   |12    |--------|
|DDCB 9C|RES 3,IXh    |3   |12    |--------|
|DDCB 9D|RES 3,IXl    |3   |12    |--------|
|DDCB 9E|RES 3,(IX+r8)|4   |23    |--------|
|DDCB 9F|RES 3,A      |3   |12    |--------|
|DDCB A0|RES 4,B      |3   |12    |--------|
|DDCB A1|RES 4,C      |3   |12    |--------|
|DDCB A2|RES 4,D      |3   |12    |--------|
|DDCB A3|RES 4,E      |3   |12    |--------|
|DDCB A4|RES 4,IXh    |3   |12    |--------|
|DDCB A5|RES 4,IXl    |3   |12    |--------|
|DDCB A6|RES 4,(IX+r8)|4   |23    |--------|
|DDCB A7|RES 4,A      |3   |12    |--------|
|DDCB A8|RES 5,B      |3   |12    |--------|
|DDCB A9|RES 5,C      |3   |12    |--------|
|DDCB AA|RES 5,D      |3   |12    |--------|
|DDCB AB|RES 5,E      |3   |12    |--------|
|DDCB AC|RES 5,IXh    |3   |12    |--------|
|DDCB AD|RES 5,IXl    |3   |12    |--------|
|DDCB AE|RES 5,(IX+r8)|4   |23    |--------|
|DDCB AF|RES 5,A      |3   |12    |--------|
|DDCB B0|RES 6,B      |3   |12    |--------|
|DDCB B1|RES 6,C      |3   |12    |--------|
|DDCB B2|RES 6,D      |3   |12    |--------|
|DDCB B3|RES 6,E      |3   |12    |--------|
|DDCB B4|RES 6,IXh    |3   |12    |--------|
|DDCB B5|RES 6,IXl    |3   |12    |--------|
|DDCB B6|RES 6,(IX+r8)|4   |23    |--------|
|DDCB B7|RES 6,A      |3   |12    |--------|
|DDCB B8|RES 7,B      |3   |12    |--------|
|DDCB B9|RES 7,C      |3   |12    |--------|
|DDCB BA|RES 7,D      |3   |12    |--------|
|DDCB BB|RES 7,E      |3   |12    |--------|
|DDCB BC|RES 7,IXh    |3   |12    |--------|
|DDCB BD|RES 7,IXl    |3   |12    |--------|
|DDCB BE|RES 7,(IX+r8)|4   |23    |--------|
|DDCB BF|RES 7,A      |3   |12    |--------|
|DDCB C0|SET 0,B      |3   |12    |--------|
|DDCB C1|SET 0,C      |3   |12    |--------|
|DDCB C2|SET 0,D      |3   |12    |--------|
|DDCB C3|SET 0,E      |3   |12    |--------|
|DDCB C4|SET 0,IXh    |3   |12    |--------|
|DDCB C5|SET 0,IXl    |3   |12    |--------|
|DDCB C6|SET 0,(IX+r8)|4   |23    |--------|
|DDCB C7|SET 0,A      |3   |12    |--------|
|DDCB C8|SET 1,B      |3   |12    |--------|
|DDCB C9|SET 1,C      |3   |12    |--------|
|DDCB CA|SET 1,D      |3   |12    |--------|
|DDCB CB|SET 1,E      |3   |12    |--------|
|DDCB CC|SET 1,IXh    |3   |12    |--------|
|DDCB CD|SET 1,IXl    |3   |12    |--------|
|DDCB CE|SET 1,(IX+r8)|4   |23    |--------|
|DDCB CF|SET 1,A      |3   |12    |--------|
|DDCB D0|SET 2,B      |3   |12    |--------|
|DDCB D1|SET 2,C      |3   |12    |--------|
|DDCB D2|SET 2,D      |3   |12    |--------|
|DDCB D3|SET 2,E      |3   |12    |--------|
|DDCB D4|SET 2,IXh    |3   |12    |--------|
|DDCB D5|SET 2,IXl    |3   |12    |--------|
|DDCB D6|SET 2,(IX+r8)|4   |23    |--------|
|DDCB D7|SET 2,A      |3   |12    |--------|
|DDCB D8|SET 3,B      |3   |12    |--------|
|DDCB D9|SET 3,C      |3   |12    |--------|
|DDCB DA|SET 3,D      |3   |12    |--------|
|DDCB DB|SET 3,E      |3   |12    |--------|
|DDCB DC|SET 3,IXh    |3   |12    |--------|
|DDCB DD|SET 3,IXl    |3   |12    |--------|
|DDCB DE|SET 3,(IX+r8)|4   |23    |--------|
|DDCB DF|SET 3,A      |3   |12    |--------|
|DDCB E0|SET 4,B      |3   |12    |--------|
|DDCB E1|SET 4,C      |3   |12    |--------|
|DDCB E2|SET 4,D      |3   |12    |--------|
|DDCB E3|SET 4,E      |3   |12    |--------|
|DDCB E4|SET 4,IXh    |3   |12    |--------|
|DDCB E5|SET 4,IXl    |3   |12    |--------|
|DDCB E6|SET 4,(IX+r8)|4   |23    |--------|
|DDCB E7|SET 4,A      |3   |12    |--------|
|DDCB E8|SET 5,B      |3   |12    |--------|
|DDCB E9|SET 5,C      |3   |12    |--------|
|DDCB EA|SET 5,D      |3   |12    |--------|
|DDCB EB|SET 5,E      |3   |12    |--------|
|DDCB EC|SET 5,IXh    |3   |12    |--------|
|DDCB ED|SET 5,IXl    |3   |12    |--------|
|DDCB EE|SET 5,(IX+r8)|4   |23    |--------|
|DDCB EF|SET 5,A      |3   |12    |--------|
|DDCB F0|SET 6,B      |3   |12    |--------|
|DDCB F1|SET 6,C      |3   |12    |--------|
|DDCB F2|SET 6,D      |3   |12    |--------|
|DDCB F3|SET 6,E      |3   |12    |--------|
|DDCB F4|SET 6,IXh    |3   |12    |--------|
|DDCB F5|SET 6,IXl    |3   |12    |--------|
|DDCB F6|SET 6,(IX+r8)|4   |23    |--------|
|DDCB F7|SET 6,A      |3   |12    |--------|
|DDCB F8|SET 7,B      |3   |12    |--------|
|DDCB F9|SET 7,C      |3   |12    |--------|
|DDCB FA|SET 7,D      |3   |12    |--------|
|DDCB FB|SET 7,E      |3   |12    |--------|
|DDCB FC|SET 7,IXh    |3   |12    |--------|
|DDCB FD|SET 7,IXl    |3   |12    |--------|
|DDCB FE|SET 7,(IX+r8)|4   |23    |--------|
|DDCB FF|SET 7,A      |3   |12    |--------|
|ED 00  |NOP          |2   |8     |--------|
|ED 01  |NOP          |2   |8     |--------|
|ED 02  |NOP          |2   |8     |--------|
|ED 03  |NOP          |2   |8     |--------|
|ED 04  |NOP          |2   |8     |--------|
|ED 05  |NOP          |2   |8     |--------|
|ED 06  |NOP          |2   |8     |--------|
|ED 07  |NOP          |2   |8     |--------|
|ED 08  |NOP          |2   |8     |--------|
|ED 09  |NOP          |2   |8     |--------|
|ED 0A  |NOP          |2   |8     |--------|
|ED 0B  |NOP          |2   |8     |--------|
|ED 0C  |NOP          |2   |8     |--------|
|ED 0D  |NOP          |2   |8     |--------|
|ED 0E  |NOP          |2   |8     |--------|
|ED 0F  |NOP          |2   |8     |--------|
|ED 10  |NOP          |2   |8     |--------|
|ED 11  |NOP          |2   |8     |--------|
|ED 12  |NOP          |2   |8     |--------|
|ED 13  |NOP          |2   |8     |--------|
|ED 14  |NOP          |2   |8     |--------|
|ED 15  |NOP          |2   |8     |--------|
|ED 16  |NOP          |2   |8     |--------|
|ED 17  |NOP          |2   |8     |--------|
|ED 18  |NOP          |2   |8     |--------|
|ED 19  |NOP          |2   |8     |--------|
|ED 1A  |NOP          |2   |8     |--------|
|ED 1B  |NOP          |2   |8     |--------|
|ED 1C  |NOP          |2   |8     |--------|
|ED 1D  |NOP          |2   |8     |--------|
|ED 1E  |NOP          |2   |8     |--------|
|ED 1F  |NOP          |2   |8     |--------|
|ED 20  |NOP          |2   |8     |--------|
|ED 21  |NOP          |2   |8     |--------|
|ED 22  |NOP          |2   |8     |--------|
|ED 23  |NOP          |2   |8     |--------|
|ED 24  |NOP          |2   |8     |--------|
|ED 25  |NOP          |2   |8     |--------|
|ED 26  |NOP          |2   |8     |--------|
|ED 27  |NOP          |2   |8     |--------|
|ED 28  |NOP          |2   |8     |--------|
|ED 29  |NOP          |2   |8     |--------|
|ED 2A  |NOP          |2   |8     |--------|
|ED 2B  |NOP          |2   |8     |--------|
|ED 2C  |NOP          |2   |8     |--------|
|ED 2D  |NOP          |2   |8     |--------|
|ED 2E  |NOP          |2   |8     |--------|
|ED 2F  |NOP          |2   |8     |--------|
|ED 30  |NOP          |2   |8     |--------|
|ED 31  |NOP          |2   |8     |--------|
|ED 32  |NOP          |2   |8     |--------|
|ED 33  |NOP          |2   |8     |--------|
|ED 34  |NOP          |2   |8     |--------|
|ED 35  |NOP          |2   |8     |--------|
|ED 36  |NOP          |2   |8     |--------|
|ED 37  |NOP          |2   |8     |--------|
|ED 38  |NOP          |2   |8     |--------|
|ED 39  |NOP          |2   |8     |--------|
|ED 3A  |NOP          |2   |8     |--------|
|ED 3B  |NOP          |2   |8     |--------|
|ED 3C  |NOP          |2   |8     |--------|
|ED 3D  |NOP          |2   |8     |--------|
|ED 3E  |NOP          |2   |8     |--------|
|ED 3F  |NOP          |2   |8     |--------|
|ED 40  |IN B,(C)     |2   |12    |SZX0XP0-|
|ED 41  |OUT (C),B    |2   |12    |--------|
|ED 42  |SBC HL,BC    |2   |15    |SZXHXV1C|
|ED 43  |LD (a16),BC  |4   |20    |--------|
|ED 44  |NEG          |2   |8     |SZXHXV1C|
|ED 45  |RETN         |2   |14    |--------|
|ED 46  |IM 0         |2   |8     |--------|
|ED 47  |LD I,A       |2   |9     |--------|
|ED 48  |IN C,(C)     |2   |12    |SZX0XP0-|
|ED 49  |OUT (C),C    |2   |12    |--------|
|ED 4A  |ADC HL,BC    |2   |15    |SZXHXV0C|
|ED 4B  |LD BC,(a16)  |4   |20    |--------|
|ED 4C  |NEG          |2   |8     |SZXHXV1C|
|ED 4D  |RETI         |2   |14    |--------|
|ED 4E  |IM 0         |2   |8     |--------|
|ED 4F  |LD R,A       |2   |9     |--------|
|ED 50  |IN D,(C)     |2   |12    |SZX0XP0-|
|ED 51  |OUT (C),D    |2   |12    |--------|
|ED 52  |SBC HL,DE    |2   |15    |SZXHXV1C|
|ED 53  |LD (a16),DE  |4   |20    |--------|
|ED 54  |NEG          |2   |8     |SZXHXV1C|
|ED 55  |RETN         |2   |14    |--------|
|ED 56  |IM 1         |2   |8     |--------|
|ED 57  |LD A,I       |2   |9     |SZY0XP0-|
|ED 58  |IN E,(C)     |2   |12    |SZX0XP0-|
|ED 59  |OUT (C),E    |2   |12    |--------|
|ED 5A  |ADC HL,DE    |2   |15    |SZXHXV0C|
|ED 5B  |LD DE,(a16)  |4   |20    |--------|
|ED 5C  |NEG          |2   |8     |SZXHXV1C|
|ED 5D  |RETN         |2   |14    |--------|
|ED 5E  |IM 2         |2   |8     |--------|
|ED 5F  |LD A,R       |2   |9     |SZY0XP0-|
|ED 60  |IN H,(C)     |2   |12    |SZX0XP0-|
|ED 61  |OUT (C),H    |2   |12    |--------|
|ED 62  |SBC HL,HL    |2   |15    |SZXHXV1C|
|ED 63  |LD (a16),HL  |4   |20    |--------|
|ED 64  |NEG          |2   |8     |SZXHXV1C|
|ED 65  |RETN         |2   |14    |--------|
|ED 66  |IM 0         |2   |8     |--------|
|ED 67  |RRD          |2   |18    |SZX0XP0-|
|ED 68  |IN L,(C)     |2   |12    |SZX0XP0-|
|ED 69  |OUT (C),L    |2   |12    |--------|
|ED 6A  |ADC HL,HL    |2   |15    |SZXHXV0C|
|ED 6B  |LD HL,(a16)  |4   |20    |--------|
|ED 6C  |NEG          |2   |8     |SZXHXV1C|
|ED 6D  |RETN         |2   |14    |--------|
|ED 6E  |IM 0         |2   |8     |--------|
|ED 6F  |RLD          |2   |18    |SZX0XP0-|
|ED 70  |IN (C)       |2   |12    |SZX0XP0-|
|ED 71  |OUT (C),0    |2   |12    |--------|
|ED 72  |SBC HL,SP    |2   |15    |SZXHXV1C|
|ED 73  |LD (a16),SP  |4   |20    |--------|
|ED 74  |NEG          |2   |8     |SZXHXV1C|
|ED 75  |RETN         |2   |14    |--------|
|ED 76  |IM 1         |2   |8     |--------|
|ED 77  |NOP          |2   |8     |--------|
|ED 78  |IN A,(C)     |2   |12    |SZX0XP0-|
|ED 79  |OUT (C),A    |2   |12    |--------|
|ED 7A  |ADC HL,SP    |2   |15    |SZXHXV0C|
|ED 7B  |LD SP,(a16)  |4   |20    |--------|
|ED 7C  |NEG          |2   |8     |SZXHXV1C|
|ED 7D  |RETN         |2   |14    |--------|
|ED 7E  |IM 2         |2   |8     |--------|
|ED 7F  |NOP          |2   |8     |--------|
|ED 80  |NOP          |2   |8     |--------|
|ED 81  |NOP          |2   |8     |--------|
|ED 82  |NOP          |2   |8     |--------|
|ED 83  |NOP          |2   |8     |--------|
|ED 84  |NOP          |2   |8     |--------|
|ED 85  |NOP          |2   |8     |--------|
|ED 86  |NOP          |2   |8     |--------|
|ED 87  |NOP          |2   |8     |--------|
|ED 88  |NOP          |2   |8     |--------|
|ED 89  |NOP          |2   |8     |--------|
|ED 8A  |NOP          |2   |8     |--------|
|ED 8B  |NOP          |2   |8     |--------|
|ED 8C  |NOP          |2   |8     |--------|
|ED 8D  |NOP          |2   |8     |--------|
|ED 8E  |NOP          |2   |8     |--------|
|ED 8F  |NOP          |2   |8     |--------|
|ED 90  |NOP          |2   |8     |--------|
|ED 91  |NOP          |2   |8     |--------|
|ED 92  |NOP          |2   |8     |--------|
|ED 93  |NOP          |2   |8     |--------|
|ED 94  |NOP          |2   |8     |--------|
|ED 95  |NOP          |2   |8     |--------|
|ED 96  |NOP          |2   |8     |--------|
|ED 97  |NOP          |2   |8     |--------|
|ED 98  |NOP          |2   |8     |--------|
|ED 99  |NOP          |2   |8     |--------|
|ED 9A  |NOP          |2   |8     |--------|
|ED 9B  |NOP          |2   |8     |--------|
|ED 9C  |NOP          |2   |8     |--------|
|ED 9D  |NOP          |2   |8     |--------|
|ED 9E  |NOP          |2   |8     |--------|
|ED 9F  |NOP          |2   |8     |--------|
|ED A0  |LDI          |2   |16    |--X0XV0-|
|ED A1  |CPI          |2   |16    |SZXHXV1-|
|ED A2  |INI          |2   |16    |SZXHXV1-|
|ED A3  |OUTI         |2   |16    |SZXHXV1-|
|ED A4  |NOP          |2   |8     |--------|
|ED A5  |NOP          |2   |8     |--------|
|ED A6  |NOP          |2   |8     |--------|
|ED A7  |NOP          |2   |8     |--------|
|ED A8  |LDD          |2   |16    |--X0XV0-|
|ED A9  |CPD          |2   |16    |SZXHXV1-|
|ED AA  |IND          |2   |16    |SZXHXV1-|
|ED AB  |OUTD         |2   |16    |SZXHXV1-|
|ED AC  |NOP          |2   |8     |--------|
|ED AD  |NOP          |2   |8     |--------|
|ED AE  |NOP          |2   |8     |--------|
|ED AF  |NOP          |2   |8     |--------|
|ED B0  |LDIR         |2   |21/16 |--X0XV0-|
|ED B1  |CPIR         |2   |21/16 |SZXHXV1-|
|ED B2  |INIR         |2   |21/16 |SZXHXV1-|
|ED B3  |OTIR         |2   |21/16 |SZXHXV1-|
|ED B4  |NOP          |2   |8     |--------|
|ED B5  |NOP          |2   |8     |--------|
|ED B6  |NOP          |2   |8     |--------|
|ED B7  |NOP          |2   |8     |--------|
|ED B8  |LDDR         |2   |21/16 |--X0XV0-|
|ED B9  |CPDR         |2   |21/16 |SZXHXV1-|
|ED BA  |INDR         |2   |21/16 |SZXHXV1-|
|ED BB  |OTDR         |2   |21/16 |SZXHXV1-|
|ED BC  |NOP          |2   |8     |--------|
|ED BD  |NOP          |2   |8     |--------|
|ED BE  |NOP          |2   |8     |--------|
|ED BF  |NOP          |2   |8     |--------|
|ED C0  |NOP          |2   |8     |--------|
|ED C1  |NOP          |2   |8     |--------|
|ED C2  |NOP          |2   |8     |--------|
|ED C3  |NOP          |2   |8     |--------|
|ED C4  |NOP          |2   |8     |--------|
|ED C5  |NOP          |2   |8     |--------|
|ED C6  |NOP          |2   |8     |--------|
|ED C7  |NOP          |2   |8     |--------|
|ED C8  |NOP          |2   |8     |--------|
|ED C9  |NOP          |2   |8     |--------|
|ED CA  |NOP          |2   |8     |--------|
|ED CB  |NOP          |2   |8     |--------|
|ED CC  |NOP          |2   |8     |--------|
|ED CD  |NOP          |2   |8     |--------|
|ED CE  |NOP          |2   |8     |--------|
|ED CF  |NOP          |2   |8     |--------|
|ED D0  |NOP          |2   |8     |--------|
|ED D1  |NOP          |2   |8     |--------|
|ED D2  |NOP          |2   |8     |--------|
|ED D3  |NOP          |2   |8     |--------|
|ED D4  |NOP          |2   |8     |--------|
|ED D5  |NOP          |2   |8     |--------|
|ED D6  |NOP          |2   |8     |--------|
|ED D7  |NOP          |2   |8     |--------|
|ED D8  |NOP          |2   |8     |--------|
|ED D9  |NOP          |2   |8     |--------|
|ED DA  |NOP          |2   |8     |--------|
|ED DB  |NOP          |2   |8     |--------|
|ED DC  |NOP          |2   |8     |--------|
|ED DD  |NOP          |2   |8     |--------|
|ED DE  |NOP          |2   |8     |--------|
|ED DF  |NOP          |2   |8     |--------|
|ED E0  |NOP          |2   |8     |--------|
|ED E1  |NOP          |2   |8     |--------|
|ED E2  |NOP          |2   |8     |--------|
|ED E3  |NOP          |2   |8     |--------|
|ED E4  |NOP          |2   |8     |--------|
|ED E5  |NOP          |2   |8     |--------|
|ED E6  |NOP          |2   |8     |--------|
|ED E7  |NOP          |2   |8     |--------|
|ED E8  |NOP          |2   |8     |--------|
|ED E9  |NOP          |2   |8     |--------|
|ED EA  |NOP          |2   |8     |--------|
|ED EB  |NOP          |2   |8     |--------|
|ED EC  |NOP          |2   |8     |--------|
|ED ED  |NOP          |2   |8     |--------|
|ED EE  |NOP          |2   |8     |--------|
|ED EF  |NOP          |2   |8     |--------|
|ED F0  |NOP          |2   |8     |--------|
|ED F1  |NOP          |2   |8     |--------|
|ED F2  |NOP          |2   |8     |--------|
|ED F3  |NOP          |2   |8     |--------|
|ED F4  |NOP          |2   |8     |--------|
|ED F5  |NOP          |2   |8     |--------|
|ED F6  |NOP          |2   |8     |--------|
|ED F7  |NOP          |2   |8     |--------|
|ED F8  |NOP          |2   |8     |--------|
|ED F9  |NOP          |2   |8     |--------|
|ED FA  |NOP          |2   |8     |--------|
|ED FB  |NOP          |2   |8     |--------|
|ED FC  |NOP          |2   |8     |--------|
|ED FD  |NOP          |2   |8     |--------|
|ED FE  |NOP          |2   |8     |--------|
|ED FF  |NOP          |2   |8     |--------|
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
|FD CB  |PREFIX FDCB  |    |      |        |
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
|FDCB 00|RLC B        |3   |12    |SZY0XP0C|
|FDCB 01|RLC C        |3   |12    |SZY0XP0C|
|FDCB 02|RLC D        |3   |12    |SZY0XP0C|
|FDCB 03|RLC E        |3   |12    |SZY0XP0C|
|FDCB 04|RLC IYh      |3   |12    |SZY0XP0C|
|FDCB 05|RLC IYl      |3   |12    |SZY0XP0C|
|FDCB 06|RLC (IY+r8)  |4   |23    |SZY0XP0C|
|FDCB 07|RLC A        |3   |12    |SZY0XP0C|
|FDCB 08|RRC B        |3   |12    |SZY0XP0C|
|FDCB 09|RRC C        |3   |12    |SZY0XP0C|
|FDCB 0A|RRC D        |3   |12    |SZY0XP0C|
|FDCB 0B|RRC E        |3   |12    |SZY0XP0C|
|FDCB 0C|RRC IYh      |3   |12    |SZY0XP0C|
|FDCB 0D|RRC IYl      |3   |12    |SZY0XP0C|
|FDCB 0E|RRC (IY+r8)  |4   |23    |SZY0XP0C|
|FDCB 0F|RRC A        |3   |12    |SZY0XP0C|
|FDCB 10|RL B         |3   |12    |SZY0XP0C|
|FDCB 11|RL C         |3   |12    |SZY0XP0C|
|FDCB 12|RL D         |3   |12    |SZY0XP0C|
|FDCB 13|RL E         |3   |12    |SZY0XP0C|
|FDCB 14|RL IYh       |3   |12    |SZY0XP0C|
|FDCB 15|RL IYl       |3   |12    |SZY0XP0C|
|FDCB 16|RL (IY+r8)   |4   |23    |SZY0XP0C|
|FDCB 17|RL A         |3   |12    |SZY0XP0C|
|FDCB 18|RR B         |3   |12    |SZY0XP0C|
|FDCB 19|RR C         |3   |12    |SZY0XP0C|
|FDCB 1A|RR D         |3   |12    |SZY0XP0C|
|FDCB 1B|RR E         |3   |12    |SZY0XP0C|
|FDCB 1C|RR IYh       |3   |12    |SZY0XP0C|
|FDCB 1D|RR IYl       |3   |12    |SZY0XP0C|
|FDCB 1E|RR (IY+r8)   |4   |23    |SZY0XP0C|
|FDCB 1F|RR A         |3   |12    |SZY0XP0C|
|FDCB 20|SLA B        |3   |12    |SZY0XP0C|
|FDCB 21|SLA C        |3   |12    |SZY0XP0C|
|FDCB 22|SLA D        |3   |12    |SZY0XP0C|
|FDCB 23|SLA E        |3   |12    |SZY0XP0C|
|FDCB 24|SLA IYh      |3   |12    |SZY0XP0C|
|FDCB 25|SLA IYl      |3   |12    |SZY0XP0C|
|FDCB 26|SLA (IY+r8)  |4   |23    |SZY0XP0C|
|FDCB 27|SLA A        |3   |12    |SZY0XP0C|
|FDCB 28|SRA B        |3   |12    |SZY0XP0C|
|FDCB 29|SRA C        |3   |12    |SZY0XP0C|
|FDCB 2A|SRA D        |3   |12    |SZY0XP0C|
|FDCB 2B|SRA E        |3   |12    |SZY0XP0C|
|FDCB 2C|SRA IYh      |3   |12    |SZY0XP0C|
|FDCB 2D|SRA IYl      |3   |12    |SZY0XP0C|
|FDCB 2E|SRA (IY+r8)  |4   |23    |SZY0XP0C|
|FDCB 2F|SRA A        |3   |12    |SZY0XP0C|
|FDCB 30|SLL B        |3   |12    |SZY0XP0C|
|FDCB 31|SLL C        |3   |12    |SZY0XP0C|
|FDCB 32|SLL D        |3   |12    |SZY0XP0C|
|FDCB 33|SLL E        |3   |12    |SZY0XP0C|
|FDCB 34|SLL IYh      |3   |12    |SZY0XP0C|
|FDCB 35|SLL IYl      |3   |12    |SZY0XP0C|
|FDCB 36|SLL (IY+r8)  |4   |23    |SZY0XP0C|
|FDCB 37|SLL A        |3   |12    |SZY0XP0C|
|FDCB 38|SRL B        |3   |12    |SZY0XP0C|
|FDCB 39|SRL C        |3   |12    |SZY0XP0C|
|FDCB 3A|SRL D        |3   |12    |SZY0XP0C|
|FDCB 3B|SRL E        |3   |12    |SZY0XP0C|
|FDCB 3C|SRL IYh      |3   |12    |SZY0XP0C|
|FDCB 3D|SRL IYl      |3   |12    |SZY0XP0C|
|FDCB 3E|SRL (IY+r8)  |4   |23    |SZY0XP0C|
|FDCB 3F|SRL A        |3   |12    |SZY0XP0C|
|FDCB 40|BIT 0,B      |3   |12    |SZY1XU0-|
|FDCB 41|BIT 0,C      |3   |12    |SZY1XU0-|
|FDCB 42|BIT 0,D      |3   |12    |SZY1XU0-|
|FDCB 43|BIT 0,E      |3   |12    |SZY1XU0-|
|FDCB 44|BIT 0,IYh    |3   |12    |SZY1XU0-|
|FDCB 45|BIT 0,IYl    |3   |12    |SZY1XU0-|
|FDCB 46|BIT 0,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 47|BIT 0,A      |3   |12    |SZY1XU0-|
|FDCB 48|BIT 1,B      |3   |12    |SZY1XU0-|
|FDCB 49|BIT 1,C      |3   |12    |SZY1XU0-|
|FDCB 4A|BIT 1,D      |3   |12    |SZY1XU0-|
|FDCB 4B|BIT 1,E      |3   |12    |SZY1XU0-|
|FDCB 4C|BIT 1,IYh    |3   |12    |SZY1XU0-|
|FDCB 4D|BIT 1,IYl    |3   |12    |SZY1XU0-|
|FDCB 4E|BIT 1,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 4F|BIT 1,A      |3   |12    |SZY1XU0-|
|FDCB 50|BIT 2,B      |3   |12    |SZY1XU0-|
|FDCB 51|BIT 2,C      |3   |12    |SZY1XU0-|
|FDCB 52|BIT 2,D      |3   |12    |SZY1XU0-|
|FDCB 53|BIT 2,E      |3   |12    |SZY1XU0-|
|FDCB 54|BIT 2,IYh    |3   |12    |SZY1XU0-|
|FDCB 55|BIT 2,IYl    |3   |12    |SZY1XU0-|
|FDCB 56|BIT 2,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 57|BIT 2,A      |3   |12    |SZY1XU0-|
|FDCB 58|BIT 3,B      |3   |12    |SZY1XU0-|
|FDCB 59|BIT 3,C      |3   |12    |SZY1XU0-|
|FDCB 5A|BIT 3,D      |3   |12    |SZY1XU0-|
|FDCB 5B|BIT 3,E      |3   |12    |SZY1XU0-|
|FDCB 5C|BIT 3,IYh    |3   |12    |SZY1XU0-|
|FDCB 5D|BIT 3,IYl    |3   |12    |SZY1XU0-|
|FDCB 5E|BIT 3,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 5F|BIT 3,A      |3   |12    |SZY1XU0-|
|FDCB 60|BIT 4,B      |3   |12    |SZY1XU0-|
|FDCB 61|BIT 4,C      |3   |12    |SZY1XU0-|
|FDCB 62|BIT 4,D      |3   |12    |SZY1XU0-|
|FDCB 63|BIT 4,E      |3   |12    |SZY1XU0-|
|FDCB 64|BIT 4,IYh    |3   |12    |SZY1XU0-|
|FDCB 65|BIT 4,IYl    |3   |12    |SZY1XU0-|
|FDCB 66|BIT 4,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 67|BIT 4,A      |3   |12    |SZY1XU0-|
|FDCB 68|BIT 5,B      |3   |12    |SZY1XU0-|
|FDCB 69|BIT 5,C      |3   |12    |SZY1XU0-|
|FDCB 6A|BIT 5,D      |3   |12    |SZY1XU0-|
|FDCB 6B|BIT 5,E      |3   |12    |SZY1XU0-|
|FDCB 6C|BIT 5,IYh    |3   |12    |SZY1XU0-|
|FDCB 6D|BIT 5,IYl    |3   |12    |SZY1XU0-|
|FDCB 6E|BIT 5,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 6F|BIT 5,A      |3   |12    |SZY1XU0-|
|FDCB 70|BIT 6,B      |3   |12    |SZY1XU0-|
|FDCB 71|BIT 6,C      |3   |12    |SZY1XU0-|
|FDCB 72|BIT 6,D      |3   |12    |SZY1XU0-|
|FDCB 73|BIT 6,E      |3   |12    |SZY1XU0-|
|FDCB 74|BIT 6,IYh    |3   |12    |SZY1XU0-|
|FDCB 75|BIT 6,IYl    |3   |12    |SZY1XU0-|
|FDCB 76|BIT 6,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 77|BIT 6,A      |3   |12    |SZY1XU0-|
|FDCB 78|BIT 7,B      |3   |12    |SZY1XU0-|
|FDCB 79|BIT 7,C      |3   |12    |SZY1XU0-|
|FDCB 7A|BIT 7,D      |3   |12    |SZY1XU0-|
|FDCB 7B|BIT 7,E      |3   |12    |SZY1XU0-|
|FDCB 7C|BIT 7,IYh    |3   |12    |SZY1XU0-|
|FDCB 7D|BIT 7,IYl    |3   |12    |SZY1XU0-|
|FDCB 7E|BIT 7,(IY+r8)|4   |20    |SZY1XU0-|
|FDCB 7F|BIT 7,A      |3   |12    |SZY1XU0-|
|FDCB 80|RES 0,B      |3   |12    |--------|
|FDCB 81|RES 0,C      |3   |12    |--------|
|FDCB 82|RES 0,D      |3   |12    |--------|
|FDCB 83|RES 0,E      |3   |12    |--------|
|FDCB 84|RES 0,IYh    |3   |12    |--------|
|FDCB 85|RES 0,IYl    |3   |12    |--------|
|FDCB 86|RES 0,(IY+r8)|4   |23    |--------|
|FDCB 87|RES 0,A      |3   |12    |--------|
|FDCB 88|RES 1,B      |3   |12    |--------|
|FDCB 89|RES 1,C      |3   |12    |--------|
|FDCB 8A|RES 1,D      |3   |12    |--------|
|FDCB 8B|RES 1,E      |3   |12    |--------|
|FDCB 8C|RES 1,IYh    |3   |12    |--------|
|FDCB 8D|RES 1,IYl    |3   |12    |--------|
|FDCB 8E|RES 1,(IY+r8)|4   |23    |--------|
|FDCB 8F|RES 1,A      |3   |12    |--------|
|FDCB 90|RES 2,B      |3   |12    |--------|
|FDCB 91|RES 2,C      |3   |12    |--------|
|FDCB 92|RES 2,D      |3   |12    |--------|
|FDCB 93|RES 2,E      |3   |12    |--------|
|FDCB 94|RES 2,IYh    |3   |12    |--------|
|FDCB 95|RES 2,IYl    |3   |12    |--------|
|FDCB 96|RES 2,(IY+r8)|4   |23    |--------|
|FDCB 97|RES 2,A      |3   |12    |--------|
|FDCB 98|RES 3,B      |3   |12    |--------|
|FDCB 99|RES 3,C      |3   |12    |--------|
|FDCB 9A|RES 3,D      |3   |12    |--------|
|FDCB 9B|RES 3,E      |3   |12    |--------|
|FDCB 9C|RES 3,IYh    |3   |12    |--------|
|FDCB 9D|RES 3,IYl    |3   |12    |--------|
|FDCB 9E|RES 3,(IY+r8)|4   |23    |--------|
|FDCB 9F|RES 3,A      |3   |12    |--------|
|FDCB A0|RES 4,B      |3   |12    |--------|
|FDCB A1|RES 4,C      |3   |12    |--------|
|FDCB A2|RES 4,D      |3   |12    |--------|
|FDCB A3|RES 4,E      |3   |12    |--------|
|FDCB A4|RES 4,IYh    |3   |12    |--------|
|FDCB A5|RES 4,IYl    |3   |12    |--------|
|FDCB A6|RES 4,(IY+r8)|4   |23    |--------|
|FDCB A7|RES 4,A      |3   |12    |--------|
|FDCB A8|RES 5,B      |3   |12    |--------|
|FDCB A9|RES 5,C      |3   |12    |--------|
|FDCB AA|RES 5,D      |3   |12    |--------|
|FDCB AB|RES 5,E      |3   |12    |--------|
|FDCB AC|RES 5,IYh    |3   |12    |--------|
|FDCB AD|RES 5,IYl    |3   |12    |--------|
|FDCB AE|RES 5,(IY+r8)|4   |23    |--------|
|FDCB AF|RES 5,A      |3   |12    |--------|
|FDCB B0|RES 6,B      |3   |12    |--------|
|FDCB B1|RES 6,C      |3   |12    |--------|
|FDCB B2|RES 6,D      |3   |12    |--------|
|FDCB B3|RES 6,E      |3   |12    |--------|
|FDCB B4|RES 6,IYh    |3   |12    |--------|
|FDCB B5|RES 6,IYl    |3   |12    |--------|
|FDCB B6|RES 6,(IY+r8)|4   |23    |--------|
|FDCB B7|RES 6,A      |3   |12    |--------|
|FDCB B8|RES 7,B      |3   |12    |--------|
|FDCB B9|RES 7,C      |3   |12    |--------|
|FDCB BA|RES 7,D      |3   |12    |--------|
|FDCB BB|RES 7,E      |3   |12    |--------|
|FDCB BC|RES 7,IYh    |3   |12    |--------|
|FDCB BD|RES 7,IYl    |3   |12    |--------|
|FDCB BE|RES 7,(IY+r8)|4   |23    |--------|
|FDCB BF|RES 7,A      |3   |12    |--------|
|FDCB C0|SET 0,B      |3   |12    |--------|
|FDCB C1|SET 0,C      |3   |12    |--------|
|FDCB C2|SET 0,D      |3   |12    |--------|
|FDCB C3|SET 0,E      |3   |12    |--------|
|FDCB C4|SET 0,IYh    |3   |12    |--------|
|FDCB C5|SET 0,IYl    |3   |12    |--------|
|FDCB C6|SET 0,(IY+r8)|4   |23    |--------|
|FDCB C7|SET 0,A      |3   |12    |--------|
|FDCB C8|SET 1,B      |3   |12    |--------|
|FDCB C9|SET 1,C      |3   |12    |--------|
|FDCB CA|SET 1,D      |3   |12    |--------|
|FDCB CB|SET 1,E      |3   |12    |--------|
|FDCB CC|SET 1,IYh    |3   |12    |--------|
|FDCB CD|SET 1,IYl    |3   |12    |--------|
|FDCB CE|SET 1,(IY+r8)|4   |23    |--------|
|FDCB CF|SET 1,A      |3   |12    |--------|
|FDCB D0|SET 2,B      |3   |12    |--------|
|FDCB D1|SET 2,C      |3   |12    |--------|
|FDCB D2|SET 2,D      |3   |12    |--------|
|FDCB D3|SET 2,E      |3   |12    |--------|
|FDCB D4|SET 2,IYh    |3   |12    |--------|
|FDCB D5|SET 2,IYl    |3   |12    |--------|
|FDCB D6|SET 2,(IY+r8)|4   |23    |--------|
|FDCB D7|SET 2,A      |3   |12    |--------|
|FDCB D8|SET 3,B      |3   |12    |--------|
|FDCB D9|SET 3,C      |3   |12    |--------|
|FDCB DA|SET 3,D      |3   |12    |--------|
|FDCB DB|SET 3,E      |3   |12    |--------|
|FDCB DC|SET 3,IYh    |3   |12    |--------|
|FDCB DD|SET 3,IYl    |3   |12    |--------|
|FDCB DE|SET 3,(IY+r8)|4   |23    |--------|
|FDCB DF|SET 3,A      |3   |12    |--------|
|FDCB E0|SET 4,B      |3   |12    |--------|
|FDCB E1|SET 4,C      |3   |12    |--------|
|FDCB E2|SET 4,D      |3   |12    |--------|
|FDCB E3|SET 4,E      |3   |12    |--------|
|FDCB E4|SET 4,IYh    |3   |12    |--------|
|FDCB E5|SET 4,IYl    |3   |12    |--------|
|FDCB E6|SET 4,(IY+r8)|4   |23    |--------|
|FDCB E7|SET 4,A      |3   |12    |--------|
|FDCB E8|SET 5,B      |3   |12    |--------|
|FDCB E9|SET 5,C      |3   |12    |--------|
|FDCB EA|SET 5,D      |3   |12    |--------|
|FDCB EB|SET 5,E      |3   |12    |--------|
|FDCB EC|SET 5,IYh    |3   |12    |--------|
|FDCB ED|SET 5,IYl    |3   |12    |--------|
|FDCB EE|SET 5,(IY+r8)|4   |23    |--------|
|FDCB EF|SET 5,A      |3   |12    |--------|
|FDCB F0|SET 6,B      |3   |12    |--------|
|FDCB F1|SET 6,C      |3   |12    |--------|
|FDCB F2|SET 6,D      |3   |12    |--------|
|FDCB F3|SET 6,E      |3   |12    |--------|
|FDCB F4|SET 6,IYh    |3   |12    |--------|
|FDCB F5|SET 6,IYl    |3   |12    |--------|
|FDCB F6|SET 6,(IY+r8)|4   |23    |--------|
|FDCB F7|SET 6,A      |3   |12    |--------|
|FDCB F8|SET 7,B      |3   |12    |--------|
|FDCB F9|SET 7,C      |3   |12    |--------|
|FDCB FA|SET 7,D      |3   |12    |--------|
|FDCB FB|SET 7,E      |3   |12    |--------|
|FDCB FC|SET 7,IYh    |3   |12    |--------|
|FDCB FD|SET 7,IYl    |3   |12    |--------|
|FDCB FE|SET 7,(IY+r8)|4   |23    |--------|
|FDCB FF|SET 7,A      |3   |12    |--------|
