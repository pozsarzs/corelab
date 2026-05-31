# CoreLAB

## Documentation

### Technical Parameters

|Parameter                       |Specification                                 |
|--------------------------------|----------------------------------------------|
|**Release Date**                |April 1974                                    |
|**Process Technology**          |6 µm NMOS                                     |
|**Transistor Count**            |~4,500 (LSI)                                  |
|**Architecture**                |Von Neumann                                   |
|**Data Bus Width**              |8-bit                                         |
|**Address Bus Width**           |16-bit                                        |
|**Maximum Addressable Memory**  |64 KB                                         |
|**Maximum Addressable I/O area**|256 ports (8-bit I/O address space)           |
|**Clock Speed**                 |2 MHz (Intel 8080A), up to 3.125 MHz (8080A-1)|
|**Internal Stack**              |No (External, RAM-based via Stack Pointer)    |
|**General Purpose Registers**   |A, B, C, D, E, H, L                           |
|**Special Registers**           |PC, SP, Flags                                 |

### Opcodes

The following notation is used throughout the tables:

* **`r`, `r1`, `r2`**: Any 8-bit register (`B`, `C`, `D`, `E`, `H`, `L`, `A`) or `M` (the memory location addressed by `HL`).
* **`rp`**: A 16-bit register pair (`BC`, `DE`, `HL`, `SP`).
* **`d8` / `d16`**: 8-bit or 16-bit immediate data.
* **`a16`**: 16-bit memory address.
* **`p8`**: 8-bit I/O port address.

Flag abbreviations:

* **S** – Sign Flag
* **Z** – Zero Flag
* **AC** – Auxiliary Carry Flag
* **P** – Parity Flag
* **CY** – Carry Flag

Flag notation used in the tables:

* **✔** – Modified according to the result of the operation.
* **0** – Cleared.
* **1** – Set.
* **-** – Unaffected.

#### Data Transfer Instructions

|Opcode(s)                          |Mnemonic        |Description / Operation                               |S|Z|AC|P|CY|
|-----------------------------------|----------------|------------------------------------------------------|-|-|--|-|--|
|`$40`–`$7F` (except `$76`)         |`MOV r1, r2`    |Register-to-register or register-to-memory transfer   |-|-|- |-|- |
|`$06, $0E, $16, $1E, $26, $2E, $3E`|`MVI r, d8`     |Load 8-bit immediate data into register               |-|-|- |-|- |
|`$36`                              |`MVI M, d8`     |Store 8-bit immediate data into memory location `[HL]`|-|-|- |-|- |
|`$01, $11, $21, $31`               |`LXI rp, d16`   |Load 16-bit immediate data into register pair         |-|-|- |-|- |
|`$3A`                              |`LDA a16`       |Load accumulator from direct memory address           |-|-|- |-|- |
|`$32`                              |`STA a16`       |Store accumulator to direct memory address            |-|-|- |-|- |
|`$0A` / `$1A`                      |`LDAX BC` / `DE`|Load accumulator from memory pointed to by BC or DE   |-|-|- |-|- |
|`$02` / `$12`                      |`STAX BC` / `DE`|Store accumulator to memory pointed to by BC or DE    |-|-|- |-|- |
|`$2A`                              |`LHLD a16`      |Load HL pair directly from memory (2 bytes)           |-|-|- |-|- |
|`$22`                              |`SHLD a16`      |Store HL pair directly to memory (2 bytes)            |-|-|- |-|- |
|`$EB`                              |`XCHG`          |Exchange DE and HL register pairs                     |-|-|- |-|- |

#### Arithmetic Instructions

|Opcode(s)                               |Mnemonic|Description / Operation                    |S|Z|AC|P|CY|
|----------------------------------------|--------|-------------------------------------------|-|-|--|-|--|
|`$80`–`$87`                             |`ADD r` |`A := A + r`                               |✔|✔|✔ |✔|✔ |
|`$C6`                                   |`ADI d8`|`A := A + d8`                              |✔|✔|✔ |✔|✔ |
|`$88`–`$8F`                             |`ADC r` |`A := A + r + CY`                          |✔|✔|✔ |✔|✔ |
|`$CE`                                   |`ACI d8`|`A := A + d8 + CY`                         |✔|✔|✔ |✔|✔ |
|`$90`–`$97`                             |`SUB r` |`A := A - r`                               |✔|✔|✔ |✔|✔ |
|`$D6`                                   |`SUI d8`|`A := A - d8`                              |✔|✔|✔ |✔|✔ |
|`$98`–`$9F`                             |`SBB r` |`A := A - r - CY`                          |✔|✔|✔ |✔|✔ |
|`$DE`                                   |`SBI d8`|`A := A - d8 - CY`                         |✔|✔|✔ |✔|✔ |
|`$04, $0C, $14, $1C, $24, $2C, $34, $3C`|`INR r` |`r := r + 1` (**CY unchanged**)            |✔|✔|✔ |✔|- |
|`$05, $0D, $15, $1D, $25, $2D, $35, $3D`|`DCR r` |`r := r - 1` (**CY unchanged**)            |✔|✔|✔ |✔|- |
|`$03, $13, $23, $33`                    |`INX rp`|Increment register pair                    |-|-|- |-|- |
|`$0B, $1B, $2B, $3B`                    |`DCX rp`|Decrement register pair                    |-|-|- |-|- |
|`$09, $19, $29, $39`                    |`DAD rp`|`HL := HL + rp`                            |-|-|- |-|✔ |
|`$27`                                   |`DAA`   |Decimal Adjust Accumulator (BCD correction)|✔|✔|✔ |✔|✔ |

#### Logical and Compare Instructions

|Opcode(s)  |Mnemonic|Description / Operation        |S|Z|AC|P|CY|
|-----------|--------|-------------------------------|-|-|--|-|--|
|`$A0`–`$A7`|`ANA r` |`A := A AND r`                 |✔|✔|1 |✔|0 |
|`$E6`      |`ANI d8`|`A := A AND d8`                |✔|✔|1 |✔|0 |
|`$A8`–`$AF`|`XRA r` |`A := A XOR r`                 |✔|✔|0 |✔|0 |
|`$EE`      |`XRI d8`|`A := A XOR d8`                |✔|✔|0 |✔|0 |
|`$B0`–`$B7`|`ORA r` |`A := A OR r`                  |✔|✔|0 |✔|0 |
|`$F6`      |`ORI d8`|`A := A OR d8`                 |✔|✔|0 |✔|0 |
|`$B8`–`$BF`|`CMP r` |Compare `A` with `r` (`A - r`) |✔|✔|✔ |✔|✔ |
|`$FE`      |`CPI d8`|Compare `A` with immediate data|✔|✔|✔ |✔|✔ |
|`$2F`      |`CMA`   |One's complement of accumulator|-|-|- |-|- |
|`$3F`      |`CMC`   |Complement Carry flag          |-|-|- |-|✔ |
|`$37`      |`STC`   |Set Carry flag                 |-|-|- |-|1 |

#### Rotate Instructions

*Only the Carry flag is affected.*

|Opcode|Mnemonic|Description / Operation                              |S|Z|AC|P|CY|
|------|--------|-----------------------------------------------------|-|-|--|-|--|
|`$07` |`RLC`   |Rotate accumulator left. Bit 7 goes to CY and bit 0. |-|-|- |-|✔ |
|`$0F` |`RRC`   |Rotate accumulator right. Bit 0 goes to CY and bit 7.|-|-|- |-|✔ |
|`$17` |`RAL`   |Rotate accumulator left through Carry.               |-|-|- |-|✔ |
|`$1F` |`RAR`   |Rotate accumulator right through Carry.              |-|-|- |-|✔ |

#### Program Flow Control Instructions

*These instructions do not modify flags; conditional forms only test them.*

|Opcode                                  |Mnemonic         |Condition / Operation               |S|Z|AC|P|CY|
|----------------------------------------|-----------------|------------------------------------|-|-|--|-|--|
|`$C3`                                   |`JMP a16`        |Unconditional jump (`PC := a16`)    |-|-|- |-|- |
|`$CA` / `$C2`                           |`JZ` / `JNZ a16` |Jump if Zero / Not Zero             |-|-|- |-|- |
|`$DA` / `$D2`                           |`JC` / `JNC a16` |Jump if Carry / No Carry            |-|-|- |-|- |
|`$FA` / `$F2`                           |`JM` / `JP a16`  |Jump if Minus / Plus                |-|-|- |-|- |
|`$EA` / `$E2`                           |`JPE` / `JPO a16`|Jump if Even / Odd parity           |-|-|- |-|- |
|`$CD`                                   |`CALL a16`       |Unconditional subroutine call       |-|-|- |-|- |
|`$CC` / `$C4`                           |`CZ` / `CNZ a16` |Call if Zero / Not Zero             |-|-|- |-|- |
|`$DC` / `$D4`                           |`CC` / `CNC a16` |Call if Carry / No Carry            |-|-|- |-|- |
|`$FC` / `$F4`                           |`CM` / `CP a16`  |Call if Minus / Plus                |-|-|- |-|- |
|`$EC` / `$E4`                           |`CPE` / `CPO a16`|Call if Even / Odd parity           |-|-|- |-|- |
|`$C9`                                   |`RET`            |Return from subroutine              |-|-|- |-|- |
|`$C8` / `$C0`                           |`RZ` / `RNZ`     |Return if Zero / Not Zero           |-|-|- |-|- |
|`$D8` / `$D0`                           |`RC` / `RNC`     |Return if Carry / No Carry          |-|-|- |-|- |
|`$F8` / `$F0`                           |`RM` / `RP`      |Return if Minus / Plus              |-|-|- |-|- |
|`$E8` / `$E0`                           |`RPE` / `RPO`    |Return if Even / Odd parity         |-|-|- |-|- |
|`$C7, $CF, $D7, $DF, $E7, $EF, $F7, $FF`|`RST n`          |Software interrupt, vector = `8 × n`|-|-|- |-|- |
|`$E9`                                   |`PCHL`           |`PC := HL`                          |-|-|- |-|- |

#### Stack, I/O and Machine Control Instructions

|Opcode         |Mnemonic  |Description / Operation                          |S|Z|AC|P|CY|
|---------------|----------|-------------------------------------------------|-|-|--|-|--|
|`$C5, $D5, $E5`|`PUSH rp` |Push register pair (`BC`, `DE`, `HL`) onto stack |-|-|- |-|- |
|`$F5`          |`PUSH PSW`|Push accumulator and flags onto stack            |-|-|- |-|- |
|`$C1, $D1, $E1`|`POP rp`  |Pop register pair from stack                     |-|-|- |-|- |
|`$F1`          |`POP PSW` |Restore accumulator and all flags from stack     |✔|✔|✔ |✔|✔ |
|`$E3`          |`XTHL`    |Exchange HL with the word at the top of the stack|-|-|- |-|- |
|`$F9`          |`SPHL`    |`SP := HL`                                       |-|-|- |-|- |
|`$DB`          |`IN p8`   |Read byte from I/O port into accumulator         |-|-|- |-|- |
|`$D3`          |`OUT p8`  |Write accumulator to I/O port                    |-|-|- |-|- |
|`$FB`          |`EI`      |Enable interrupts                                |-|-|- |-|- |
|`$F3`          |`DI`      |Disable interrupts                               |-|-|- |-|- |
|`$76`          |`HLT`     |Halt processor execution                         |-|-|- |-|- |
|`$00`          |`NOP`     |No operation                                     |-|-|- |-|- |
