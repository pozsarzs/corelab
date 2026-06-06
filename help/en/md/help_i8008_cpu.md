# CoreLAB

## Intel 8008 microprocessor

### Technical Parameters

|Parameter                      |Specification                  |
|--------------------------------|--------------------------------|
|**Release Date**               |April 1972                     |
|**Process Technology**         |10 µm PMOS                     |
|**Transistor Count**           |3,500 (LSI)                    |
|**Architecture**               |Neumann                        |
|**Data Bus Width**             |8-bit                          |
|**Address Bus Width**          |14-bit (multiplexed)           |
|**Maximum Addressable Memory** |16 KB (RAM/ROM)                |
|**Maximum Addressable I/O area**|32 input ports + 32 output ports|
|**Clock Speed**                |200 kHz to 800 kHz             |
|**Internal Stack**             |7 levels deep (address stack)  |
|**General Purpose Registers**  |7 (A, B, C, D, E, H, L)        |
|**Special Registers**          |SP, Flags                      |

### Opcodes

Flag abbreviations:

* **S** – Sign Flag
* **Z** – Zero Flag
* **P** – Parity Flag
* **CY** – Carry Flag

Flag notation used in the tables:

* **✔** – Modified according to the result of the operation.
* **0** – Cleared.
* **1** – Set.
* **-** – Unaffected.

#### Data Transfer Instructions

|Opcode(s)                         |Mnemonic       |Description / Operation                              |S|Z|AC|P|CY|
|-----------------------------------|----------------|------------------------------------------------------|-|-|--|-|--|
|`06`|LAI d8|Load immediate `d8` to A|16|-|
|`0E`|LBI d8|Load immediate `d8` to B|16|-|
|`16`|LCI d8|Load immediate `d8` to C|16|-|
|`1E`|LDI d8|Load immediate `d8` to D|16|-|
|`26`|LEI d8|Load immediate `d8` to E|16|-|
|`2E`|LHI d8|Load immediate `d8` to H|16|-|
|`36`|LLI d8|Load immediate `d8` to L|16|-|
|`3E`|LMI d8|Load immediate `d8` to Memory|18|-|
|`C0`|LAA|Load A from A|10|-|
|`C1`|LAB|Load A from B|10|-|
|`C2`|LAC|Load A from C|10|-|
|`C3`|LAD|Load A from D|10|-|
|`C4`|LAE|Load A from E|10|-|
|`C5`|LAH|Load A from H|10|-|
|`C6`|LAL|Load A from L|10|-|
|`C7`|LAM|Load A from Memory|16|-|
|`C8`|LBA|Load B from A|10|-|
|`...`|`Lr1r2`|Minden regiszter->regiszter töltés|10|-|
|`...`|`Lr1M`|Minden memória->regiszter töltés|16|-|
|`...`|`LMr2`|Minden regiszter->memória töltés (`F8`-`FE`)|14|-|

#### Arithmetic Instructions

|Opcode(s)                              |Mnemonic|Description / Operation                   |S|Z|AC|P|CY|
|----------------------------------------|--------|-------------------------------------------|-|-|--|-|--|
|`04`|ADI d8|Add immediate `d8` to A|16|SZPC|
|`08`|INB|Increment B|10|SZP-|
|`09`|DCB|Decrement B|10|SZP-|
|`0C`|ACI d8|Add immediate `d8` with Carry to A|16|SZPC|
|`10`|INC|Increment C|10|SZP-|
|`11`|DCC|Decrement C|10|SZP-|
|`14`|SUI d8|Subtract immediate `d8` from A|16|SZPC|
|`18`|IND|Increment D|10|SZP-|
|`19`|DCD|Decrement D|10|SZP-|
|`1C`|SBI d8|Subtract immediate `d8` with Borrow from A|16|SZPC|
|`20`|INE|Increment E|10|SZP-|
|`21`|DCE|Decrement E|10|SZP-|
|`28`|INH|Increment H|10|SZP-|
|`29`|DCH|Decrement H|10|SZP-|
|`30`|INL|Increment L|10|SZP-|
|`31`|DCL|Decrement L|10|SZP-|
|`80`-`86`|ADr|Add reg `r` to A|10|SZPC|
|`87`     |ADM|Add Memory to A|16|SZPC|
|`88`-`8E`|ACr|Add reg `r` with Carry to A|10|SZPC|
|`8F`     |ACM|Add Memory with Carry to A|16|SZPC|
|`90`-`96`|SUr|Subtract reg `r` from A|10|SZPC|
|`97`     |SUM|Subtract Memory from A|16|SZPC|
|`98`-`9E`|SBr|Subtract reg `r` with Borrow from A|10|SZPC|
|`9F`     |SBM|Subtract Memory with Borrow from A|16|SZPC|

#### Logical and Compare Instructions

|Opcode(s)|Mnemonic|Description / Operation      |S|Z|P|C|
|---------|--------|-----------------------------|-|-|-|-|
|`24`     |NDI d8  |Logical AND of imm `d8` and A|SZPC|
|`2C`     |XRI d8  |Logical XOR of imm `d8` and A|SZPC|
|`34`     |ORI d8  |Logical OR of imm `d8` and A |SZPC|
|`3C`     |CPI d8  |Compare imm `d8` with A      |SZPC|
|`A0`-`A6`|NDr     |Logical AND of reg `r` and A |SZPC|
|`A7`     |NDM     |Logical AND of Memory and A  |SZPC|
|`A8`-`AE`|XRr     |Logical XOR of reg `r` and A |SZPC|
|`AF`     |XRM     |Logical XOR of Memory and A  |SZPC|
|`B0`-`B6`|ORr     |Logical OR of reg `r` and A  |SZPC|
|`B7`     |ORM     |Logical OR of Memory and A   |SZPC|
|`B8`-`BE`|CPr     |Compare reg `r` with A       |SZPC|
|`BF`     |CPM     |Compare Memory with A        |SZPC|

#### Rotate Instructions

|Opcode|Mnemonic|Description / Operation     |S|Z|P|C|
|------|--------|----------------------------|-|-|-|-|
|`02`  |RLC     |Rotate A Left               |C|
|`0A`  |RAC     |Rotate A Right              |C|
|`12`  |RAL     |Rotate A Left through Carry |C|
|`1A`  |RAR     |Rotate A Right through Carry|C|

#### Program Flow Control Instructions

|Opcode                                 |Mnemonic        |Condition / Operation              |S|Z|AC|P|CY|
|----------------------------------------|-----------------|------------------------------------|-|-|--|-|--|
|Opcode (Hex)|Mnemonic|Operation|Ciklus|Flagek|
|---|---|---|---|---|
|`40`|JFC a16|Jump if False Carry (C=0)|22/18|-|
|`48`|JFZ a16|Jump if False Zero (Z=0)|22/18|-|
|`50`|JFS a16|Jump if False Sign (S=0)|22/18|-|
|`58`|JFP a16|Jump if False Parity (P=0)|22/18|-|
|`60`|JTC a16|Jump if True Carry (C=1)|22/18|-|
|`68`|JTZ a16|Jump if True Zero (Z=1)|22/18|-|
|`70`|JTS a16|Jump if True Sign (S=1)|22/18|-|
|`78`|JTP a16|Jump if True Parity (P=1)|22/18|-|
|`44`|JMP a16|Unconditional Jump|22|-|
|`42`|CFC a16|Call if False Carry (C=0)|22/18|-|
|`4A`|CFZ a16|Call if False Zero (Z=0)|22/18|-|
|`52`|CFS a16|Call if False Sign (S=0)|22/18|-|
|`5A`|CFP a16|Call if False Parity (P=0)|22/18|-|
|`62`|CTC a16|Call if True Carry (C=1)|22/18|-|
|`6A`|CTZ a16|Call if True Zero (Z=1)|22/18|-|
|`72`|CTS a16|Call if True Sign (S=1)|22/18|-|
|`7A`|CTP a16|Call if True Parity (P=1)|22/18|-|
|`46`|CAL a16|Unconditional Call|22|-|
|`03`|RFC|Return if False Carry (C=0)|10/6|-|
|`0B`|RFZ|Return if False Zero (Z=0)|10/6|-|
|`13`|RFS|Return if False Sign (S=0)|10/6|-|
|`1B`|RFP|Return if False Parity (P=0)|10/6|-|
|`23`|RTC|Return if True Carry (C=1)|10/6|-|
|`2B`|RTZ|Return if True Zero (Z=1)|10/6|-|
|`33`|RTS|Return if True Sign (S=1)|10/6|-|
|`3B`|RTP|Return if True Parity (P=1)|10/6|-|
|`07`|RET|Unconditional Return|10|-|
|`05`|RST 0|Restart subroutine at `$00`|10|-|
|`0D`|RST 1|Restart subroutine at `$08`|10|-|
|`15`|RST 2|Restart subroutine at `$10`|10|-|
|`1D`|RST 3|Restart subroutine at `$18`|10|-|
|`25`|RST 4|Restart subroutine at `$20`|10|-|
|`2D`|RST 5|Restart subroutine at `$28`|10|-|
|`35`|RST 6|Restart subroutine at `$30`|10|-|
|`3D`|RST 7|Restart subroutine at `$38`|10|-|



#### Stack, I/O and Machine Control Instructions

|Opcode          |Mnemonic |Description / Operation                         |S|Z|P|C|
|-----------------|----------|-------------------------------------------------|-|-|-|-|
|`00`-`01`, `FF`|HLT     |Halt processor                                 |-|-|-|-|
|`41`-`4F`      |INP `p` |Input from Port 0-7 into A                     |-|-|-|-|
|`51`-`7F`      |OUT `p` |Output from A to Port 8-31                     |-|-|-|-|
