# CoreLAB

## Help

### Intel 8008 microprocessor
### Technical Parameters

| Parameter | Specification |
| --- | --- |
| **Release Date** | Not specified in document |
| **Process Technology** | Not specified in document |
| **Transistor Count** | Not specified in document |
| **Architecture** | Not specified in document |
| **Data Bus Width** | Not specified in document |
| **Address Bus Width** | 14-bit 

 |
| **Maximum Addressable Memory** | 16 kB RAM 

 |
| **Maximum Addressable I/O area** | Not specified in document |
| **Clock Speed** | Upto 500 kHz (8008), upto 800 kHz (8008-1) 

 |
| **Internal Stack** | 7 levels deep (8x14-bit register file) 

 |
| **General Purpose Registers** | A, B, C, D, E, H, L 

 |
| **Special Registers** | PC (Program Counter) 

 |

---

### Opcodes

| Opcode | Mnemonic | Operation | Flagek |
| --- | --- | --- | --- |
| 00 | HLT | Halt | None |
|  | 01 | HLT | Halt (Alternative opcode)* 

 |
|  | 02 | RLC | Rotate Left Circular |
| 03 | RFC | Return if False Carry (Carry = 0) | None |
|  | 04 | ADI d8 | Add immediate data to A |
| 05 | RST 0 | Restart 0 | None |
| 06 | LAI d8 | Load immediate data into A | None |
| 07 | RET | Return | None |
|  | 08 | INB | Increment register B |
|  | 09 | DCB | Decrement register B |
|  | 0A | RRC | Rotate Right Circular |
| 0B | RFZ | Return if False Zero (Zero = 0) | None |
| 0C | ACI d8 | Add with carry immediate data to A | SZPC |
| 0D | RST 1 | Restart 1 | None |
| 0E | LBI d8 | Load immediate data into B | None |
| 0F | RET | Return (Alternative opcode)* | None |
| 10 | INC | Increment register A | SZP- |
| 11 | INE | Increment register E | SZP |
| 12 | DCC | Decrement register C | SZP- |
| 13 | DCE | Decrement register E | SZP- |
| 14 | RAL | Rotate Left through Carry | C |
| 15 | RFS | Return if False Sign (Sign = 0) | None |
| 16 | RTC | Return if True Carry (Carry = 1) | None |
| 17 | SUI d8 | Subtract immediate data from A | SZPC |
| 18 | NDI d8 | Logical AND immediate data with A | SZPC |
| 19 | RST 2 | Restart 2 | None |
| 1A | RST 4 | Restart 4 | None |
| 1B | LCI d8 | Load immediate data into C | None |
| 1C | LEI d8 | Load immediate data into E | None |
| 1D | RET | Return (Alternative opcode)* | None |
| 1E | RET | Return (Alternative opcode)* | None |
| 1F | IND | Increment register D | SZP- |
| 20 | INH | Increment register H | SZP- |
| 21 | DCD | Decrement register D | SZP- |
| 22 | DCH | Decrement register H | SZP- |
| 23 | RAR | Rotate Right through Carry | C |
| 24 | RFP | Return if False Parity (Parity = 0) | None |
| 25 | RTZ | Return if True Zero (Zero = 1) | None |
| 26 | SBI d8 | Subtract with borrow immediate data from A | SZPC |
| 27 | XRI d8 | Exclusive OR immediate data with A | SZPC |
| 28 | RST 3 | Restart 3 | None |
| 29 | RST 5 | Restart 5 | None |
| 2A | LDI d8 | Load immediate data into D | None |
| 2B | LHI d8 | Load immediate data into H | None |
| 2C | RET | Return (Alternative opcode)* | None |
| 2D | RET | Return (Alternative opcode)* | None |
| 2E | INL | Increment register L | SZP- |
| 2F | DCL | Decrement register L | SZP- |
| 30 | RTS | Return if True Sign (Sign = 1) | None |
| 31 | RTP | Return if True Parity (Parity = 1) | None |
| 32 | ORI d8 | Logical OR immediate data with A | SZPC |
| 33 | CPI d8 | Compare immediate data with A | SZPC |
| 34 | RST 6 | Restart 6 | None |
| 35 | RST 7 | Restart 7 | None |
| 36 | LLI d8 | Load immediate data into L | None |
| 37 | LMI d8 | Load immediate data into Memory M | None |
| 38 | RET | Return (Alternative opcode)* | None |
| 39 | RET | Return (Alternative opcode)* | None |
| 3A | JFC a16 | Jump if False Carry (Carry = 0) | None |
| 3B | JFS a16 | Jump if False Sign (Sign = 0) | None |
| 3C | INP 0 | Input from port 0 | None |
| 3D | OUT 8 | Output to port 8 | None |
| 3E | CFC a16 | Call if False Carry (Carry = 0) | None |
| 3F | CFS a16 | Call if False Sign (Sign = 0) | None |
| 40 | INP 1 | Input from port 1 | None |
| 41 | OUT 9 | Output to port 9 | None |
| 42 | JMP a16 | Jump unconditionally | None |
| 43 | JMP a16 | Jump unconditionally (Alternative opcode)* | None |
| 44 | INP 2 | Input from port 2 | None |
| 45 | OUT 10 | Output to port 10 | None |
| 46 | CAL a16 | Call unconditionally | None |
| 47 | CAL a16 | Call unconditionally (Alternative opcode)* | None |
| 48 | INP 3 | Input from port 3 | None |
| 49 | OUT 11 | Output to port 11 | None |
| 4A | JFZ a16 | Jump if False Zero (Zero = 0) | None |
| 4B | JFP a16 | Jump if False Parity (Parity = 0) | None |
| 4C | INP 4 | Input from port 4 | None |
| 4D | OUT 12 | Output to port 12 | None |
| 4E | CFZ a16 | Call if False Zero (Zero = 0) | None |
| 4F | CFP a16 | Call if False Parity (Parity = 0) | None |
| 50 | INP 5 | Input from port 5 | None |
| 51 | OUT 13 | Output to port 13 | None |
| 52 | JMP a16 | Jump unconditionally (Alternative opcode)* | None |
| 53 | JMP a16 | Jump unconditionally (Alternative opcode)* | None |
| 54 | INP 6 | Input from port 6 | None |
| 55 | OUT 14 | Output to port 14 | None |
| 56 | CAL a16 | Call unconditionally (Alternative opcode)* | None |
| 57 | CAL a16 | Call unconditionally (Alternative opcode)* | None |
| 58 | INP 7 | Input from port 7 | None |
| 59 | OUT 15 | Output to port 15 | None |
| 5A | JTC a16 | Jump if True Carry (Carry = 1) | None |
| 5B | OUT 16 | Output to port 16 | None |
| 5C | CTC a16 | Call if True Carry (Carry = 1) | None |
| 5D | OUT 17 | Output to port 17 | None |
| 5E | JMP a16 | Jump unconditionally (Alternative opcode)* | None |
| 5F | OUT 18 | Output to port 18 | None |
| 60 | CAL a16 | Call unconditionally (Alternative opcode)* | None |
| 61 | OUT 19 | Output to port 19 | None |
| 62 | JTZ a16 | Jump if True Zero (Zero = 1) | None |
| 63 | OUT 20 | Output to port 20 | None |
| 64 | CTZ a16 | Call if True Zero (Zero = 1) | None |
| 65 | OUT 21 | Output to port 21 | None |
| 66 | JMP a16 | Jump unconditionally (Alternative opcode)* | None |
| 67 | OUT 22 | Output to port 22 | None |
| 68 | CAL a16 | Call unconditionally (Alternative opcode)* | None |
| 69 | OUT 23 | Output to port 23 | None |
| 6A | JTS a16 | Jump if True Sign (Sign = 1) | None |
| 6B | OUT 24 | Output to port 24 | None |
| 6C | CTS a16 | Call if True Sign (Sign = 1) | None |
| 6D | OUT 25 | Output to port 25 | None |
| 6E | JMP a16 | Jump unconditionally (Alternative opcode)* | None |
| 6F | OUT 26 | Output to port 26 | None |
| 70 | CAL a16 | Call unconditionally (Alternative opcode)* | None |
| 71 | OUT 27 | Output to port 27 | None |
| 72 | JTP a16 | Jump if True Parity (Parity = 1) | None |
| 73 | OUT 28 | Output to port 28 | None |
| 74 | CTP a16 | Call if True Parity (Parity = 1) | None |
| 75 | OUT 29 | Output to port 29 | None |
| 76 | JMP a16 | Jump unconditionally (Alternative opcode)* | None |
| 77 | OUT 30 | Output to port 30 | None |
| 78 | CAL a16 | Call unconditionally (Alternative opcode)* | None |
| 79 | OUT 31 | Output to port 31 | None |
| 7A | ADA | Add register A to A | SZPC |
| 7B | ADB | Add register B to A | SZPC |
| 7C | ADC | Add register C to A | SZPC |
| 7D | ADD | Add register D to A | SZPC |
| 7E | ADE | Add register E to A | SZPC |
| 7F | ADH | Add register H to A | SZPC |
| 80 | ADL | Add register L to A | SZPC |
| 81 | ADM | Add Memory M to A | SZPC |
| 82 | ACA | Add with carry register A to A | SZPC |
| 83 | ACB | Add with carry register B to A | SZPC |
| 84 | ACC | Add with carry register C to A | SZPC |
| 85 | ACD | Add with carry register D to A | SZPC |
| 86 | ACE | Add with carry register E to A | SZPC |
| 87 | ACH | Add with carry register H to A | SZPC |
| 88 | ACL | Add with carry register L to A | SZPC |
| 89 | ACM | Add with carry Memory M to A | SZPC |
| 8A | SUA | Subtract register A from A | SZPC |
| 8B | SUB | Subtract register B from A | SZPC |
| 8C | SUC | Subtract register C from A | SZPC |
| 8D | SUD | Subtract register D from A | SZPC |
| 8E | SUE | Subtract register E from A | SZPC |
| 8F | SUH | Subtract register H from A | SZPC |
| 90 | SUL | Subtract register L from A | SZPC |
| 91 | SUM | Subtract Memory M from A | SZPC |
| 92 | SBA | Subtract with borrow register A from A | SZPC |
| 93 | SBB | Subtract with borrow register B from A | SZPC |
| 94 | SBC | Subtract with borrow register C from A | SZPC |
| 95 | SBD | Subtract with borrow register D from A | SZPC |
| 96 | SBE | Subtract with borrow register E from A | SZPC |
| 97 | SBH | Subtract with borrow register H from A | SZPC |
| 98 | SBL | Subtract with borrow register L from A | SZPC |
| 99 | SBM | Subtract with borrow Memory M from A | SZPC |
| 9A | NDA | Logical AND register A with A | SZPC |
| 9B | NDB | Logical AND register B with A | SZPC |
| 9C | NDC | Logical AND register C with A | SZPC |
| 9D | NDD | Logical AND register D with A | SZPC |
| 9E | NDE | Logical AND register E with A | SZPC |
| 9F | NDH | Logical AND register H with A | SZPC |
| A0 | NDL | Logical AND register L with A | SZPC |
| A1 | NDM | Logical AND Memory M with A | SZPC |
| A2 | XRA | Exclusive OR register A with A | SZPC |
| A3 | XRB / BHX | Exclusive OR register B with A | SZPC |
| A4 | XRC | Exclusive OR register C with A | SZPC |
| A5 | XRD | Exclusive OR register D with A | SZPC |
| A6 | XRE | Exclusive OR register E with A | SZPC |
| A7 | XRH | Exclusive OR register H with A | SZPC |
| A8 | XRL | Exclusive OR register L with A | SZPC |
| A9 | XRM | Exclusive OR Memory M with A | SZPC |
| AA | ORA | Logical OR register A with A | SZPC |
| AB | ORE | Logical OR register B with A | SZPC |
| AC | ORC | Logical OR register C with A | SZPC |
| AD | ORD | Logical OR register D with A | SZPC |
| AE | ORE | Logical OR register E with A | SZPC |
| AF | ORH | Logical OR register H with A | SZPC |
| B0 | ORL | Logical OR register L with A | SZPC |
| B1 | ORM | Logical OR Memory M with A | SZPC |
| B2 | CPA | Compare register A with A | SZPC |
| B3 | CPB | Compare register B with A | SZPC |
| B4 | CPC | Compare register C with A | SZPC |
| B5 | CPD | Compare register D with A | SZPC |
| B6 | CPE | Compare register E with A | SZPC |
| B7 | CPH | Compare register H with A | SZPC |
| B8 | CPL | Compare register L with A | SZPC |
| B9 | CPM | Compare Memory M with A | SZPC |
| BA | NOP | No Operation | None |
| BB | LAB | Load register B into A | None |
| BC | LAC | Load register C into A | None |
| BD | LAD | Load register D into A | None |
| BE | LAE | Load register E into A | None |
| BF | LAH | Load register H into A | None |
| C0 | LAL | Load register L into A | None |
| C1 | LAM | Load Memory M into A | None |
| C2 | LBA | Load register A into B | None |
| C3 | LBB | Load register B into B | None |
| C4 | LBC | Load register C into B | None |
| C5 | LBD | Load register D into B | None |
| C6 | LBE | Load register E into B | None |
| C7 | LBF | Load register H into B | None |
| C8 | LBL | Load register L into B | None |
| C9 | LBM | Load Memory M into B | None |
| CA | LCA | Load register A into C | None |
| CB | LCB | Load register B into C | None |
| CC | LCC | Load register C into C | None |
| CD | LCD | Load register D into C | None |
| CE | LCE | Load register E into C | None |
| CF | LCH | Load register H into C | None |
| D0 | LCL | Load register L into C | None |
| D1 | LCM | Load Memory M into C | None |
| D2 | LDA | Load register A into D | None |
| D3 | LDB | Load register B into D | None |
| D4 | LDC | Load register C into D | None |
| D5 | LDD | Load register D into D | None |
| D6 | LDE | Load register E into D | None |
| D7 | LDH | Load register H into D | None |
| D8 | LDL | Load register L into D | None |
| D9 | LDM | Load Memory M into D | None |
| DA | LEA | Load register A into E | None |
| DB | LEB | Load register B into E | None |
| DC | LEC | Load register C into E | None |
| DD | LED | Load register D into E | None |
| DE | LEE | Load register E into E | None |
| DF | LEH | Load register H into E | None |
| E0 | LEL | Load register L into E | None |
| E1 | LEM | Load Memory M into E | None |
| E2 | LHA | Load register A into H | None |
| E3 | LHB | Load register B into H | None |
| E4 | LHC | Load register C into H | None |
| E5 | LHD | Load register D into H | None |
| E6 | LHE | Load register E into H | None |
| E7 | LHH | Load register H into H | None |
| E8 | LHL | Load register L into H | None |
| E9 | LHM | Load Memory M into H | None |
| EA | LLA | Load register A into L | None |
| EB | LLB | Load register B into L | None |
| EC | LLC | Load register C into L | None |
| ED | LLD | Load register D into L | None |
| EE | LLE | Load register E into L | None |
| EF | LLH | Load register H into L | None |
| F0 | LEL | Load register L into L | None |
| F1 | LIM | Load Memory M into L | None |
| F2 | LMA | Load register A into Memory M | None |
| F3 | LMB | Load register B into Memory M | None |
| F4 | LMC | Load register C into Memory M | None |
| F5 | LMD | Load register D into Memory M | None |
| F6 | LME | Load register E into Memory M | None |
| F7 | LMH | Load register H into Memory M | None |
| F8 | LML | Load register L into Memory M | None |
| F9 | HLT | Halt | None |

* Megjegyzés: Az így jelölt utasítások alternatív opcode-ok, használatuk nem javasolt.
