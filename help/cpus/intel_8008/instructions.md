# CoreLab

## Opcodes for Intel 8008 microprocessor

* `r` represents a general-purpose register: `A` (000), `B` (001), `C` (010),
  `D` (011), `E` (100), `H` (101), `L` (110).
* `M` represents the memory location pointed to by the `H` and `L`
   registers (111).
* `data8` / `data16` represent 8-bit or 16-bit immediate constants.
* **Flags:** `C` (Carry), `Z` (Zero), `S` (Sign), `P` (Parity). `None`
   means the instruction does not alter the flags.

### Data Transfer Group (MOV, MVI)

| Opcode (Hex) | Mnemonic | Operation | Used Flags |
| --- | --- | --- | --- |
| `06` | MVI B, data8 | Move immediate `data8` to B | None |
| `0E` | MVI C, data8 | Move immediate `data8` to C | None |
| `16` | MVI D, data8 | Move immediate `data8` to D | None |
| `1E` | MVI E, data8 | Move immediate `data8` to E | None |
| `26` | MVI H, data8 | Move immediate `data8` to H | None |
| `2E` | MVI L, data8 | Move immediate `data8` to L | None |
| `36` | MVI M, data8 | Move immediate `data8` to Memory | None |
| `3E` | MVI A, data8 | Move immediate `data8` to A | None |
| `40` | MOV B, B | Move B to B (NOP-like) | None |
| `41` | MOV B, C | Move C to B | None |
| `42` | MOV B, D | Move D to B | None |
| `43` | MOV B, E | Move E to B | None |
| `44` | MOV B, H | Move H to B | None |
| `45` | MOV B, L | Move L to B | None |
| `46` | MOV B, M | Move Memory to B | None |
| `47` | MOV B, A | Move A to B | None |
| `48` | MOV C, B | Move B to C | None |
| `49` | MOV C, C | Move C to C (NOP-like) | None |
| `4A` | MOV C, D | Move D to C | None |
| `4B` | MOV C, E | Move E to C | None |
| `4C` | MOV C, H | Move H to C | None |
| `4D` | MOV C, L | Move L to C | None |
| `4E` | MOV C, M | Move Memory to C | None |
| `4F` | MOV C, A | Move A to C | None |
| `50` | MOV D, B | Move B to D | None |
| `51` | MOV D, C | Move C to D | None |
| `52` | MOV D, D | Move D to D (NOP-like) | None |
| `53` | MOV D, E | Move E to D | None |
| `54` | MOV D, H | Move H to D | None |
| `55` | MOV D, L | Move L to D | None |
| `56` | MOV D, M | Move Memory to D | None |
| `57` | MOV D, A | Move A to D | None |
| `58` | MOV E, B | Move B to E | None |
| `59` | MOV E, C | Move C to E | None |
| `5A` | MOV E, D | Move D to E | None |
| `5B` | MOV E, E | Move E to E (NOP-like) | None |
| `5C` | MOV E, H | Move H to E | None |
| `5D` | MOV E, L | Move L to E | None |
| `5E` | MOV E, M | Move Memory to E | None |
| `5F` | MOV E, A | Move A to E | None |
| `60` | MOV H, B | Move B to H | None |
| `61` | MOV H, C | Move C to H | None |
| `62` | MOV H, D | Move D to H | None |
| `63` | MOV H, E | Move E to H | None |
| `64` | MOV H, H | Move H to H (NOP-like) | None |
| `65` | MOV H, L | Move L to H | None |
| `66` | MOV H, M | Move Memory to H | None |
| `67` | MOV H, A | Move A to H | None |
| `68` | MOV L, B | Move B to L | None |
| `69` | MOV L, C | Move C to L | None |
| `6A` | MOV L, D | Move D to L | None |
| `6B` | MOV L, E | Move E to L | None |
| `6C` | MOV L, H | Move H to L | None |
| `6D` | MOV L, L | Move L to L (NOP-like) | None |
| `6E` | MOV L, M | Move Memory to L | None |
| `6F` | MOV L, A | Move A to L | None |
| `70` | MOV M, B | Move B to Memory | None |
| `71` | MOV M, C | Move C to Memory | None |
| `72` | MOV M, D | Move D to Memory | None |
| `73` | MOV M, E | Move E to Memory | None |
| `74` | MOV M, H | Move H to Memory | None |
| `75` | MOV M, L | Move L to Memory | None |
| `77` | MOV M, A | Move A to Memory | None |
| `78` | MOV A, B | Move B to A | None |
| `79` | MOV A, C | Move C to A | None |
| `7A` | MOV A, D | Move D to A | None |
| `7B` | MOV A, E | Move E to A | None |
| `7C` | MOV A, H | Move H to A | None |
| `7D` | MOV A, L | Move L to A | None |
| `7E` | MOV A, M | Move Memory to A | None |
| `7F` | MOV A, A | Move A to A (NOP-like) | None |

### Arithmetic Group (ADD, ADC, SUB, SBB, INR, DCR)

| Opcode (Hex) | Mnemonic | Operation | Used Flags |
| --- | --- | --- | --- |
| `00` | INR B | Increment B by 1 | Z, S, P |
| `08` | DCR B | Decrement B by 1 | Z, S, P |
| `0A` | INR C | Increment C by 1 | Z, S, P |
| `12` | DCR C | Decrement C by 1 | Z, S, P |
| `14` | INR D | Increment D by 1 | Z, S, P |
| `1C` | DCR D | Decrement D by 1 | Z, S, P |
| `1E` | INR E | Increment E by 1 | Z, S, P |
| `26` | DCR E | Decrement E by 1 | Z, S, P |
| `28` | INR H | Increment H by 1 | Z, S, P |
| `30` | DCR H | Decrement H by 1 | Z, S, P |
| `32` | INR L | Increment L by 1 | Z, S, P |
| `3A` | DCR L | Decrement L by 1 | Z, S, P |
| `04` | ADI data8 | Add immediate to A | C, Z, S, P |
| `0C` | ACI data8 | Add immediate to A with Carry | C, Z, S, P |
| `14` | SUI data8 | Subtract immediate from A | C, Z, S, P |
| `1C` | SBI data8 | Subtract immediate from A with Borrow | C, Z, S, P |
| `80` | ADD B | Add B to A | C, Z, S, P |
| `81` | ADD C | Add C to A | C, Z, S, P |
| `82` | ADD D | Add D to A | C, Z, S, P |
| `83` | ADD E | Add E to A | C, Z, S, P |
| `84` | ADD H | Add H to A | C, Z, S, P |
| `85` | ADD L | Add L to A | C, Z, S, P |
| `86` | ADD M | Add Memory to A | C, Z, S, P |
| `87` | ADD A | Add A to A | C, Z, S, P |
| `88` | ADC B | Add B to A with Carry | C, Z, S, P |
| `89` | ADC C | Add C to A with Carry | C, Z, S, P |
| `8A` | ADC D | Add D to A with Carry | C, Z, S, P |
| `8B` | ADC E | Add E to A with Carry | C, Z, S, P |
| `8C` | ADC H | Add H to A with Carry | C, Z, S, P |
| `8D` | ADC L | Add L to A with Carry | C, Z, S, P |
| `8E` | ADC M | Add Memory to A with Carry | C, Z, S, P |
| `8F` | ADC A | Add A to A with Carry | C, Z, S, P |
| `90` | SUB B | Subtract B from A | C, Z, S, P |
| `91` | SUB C | Subtract C from A | C, Z, S, P |
| `92` | SUB D | Subtract D from A | C, Z, S, P |
| `93` | SUB E | Subtract E from A | C, Z, S, P |
| `94` | SUB H | Subtract H from A | C, Z, S, P |
| `95` | SUB L | Subtract L from A | C, Z, S, P |
| `96` | SUB M | Subtract Memory from A | C, Z, S, P |
| `97` | SUB A | Subtract A from A (Clears A) | C, Z, S, P |
| `98` | SBB B | Subtract B from A with Borrow | C, Z, S, P |
| `99` | SBB C | Subtract C from A with Borrow | C, Z, S, P |
| `9A` | SBB D | Subtract D from A with Borrow | C, Z, S, P |
| `9B` | SBB E | Subtract E from A with Borrow | C, Z, S, P |
| `9C` | SBB H | Subtract H from A with Borrow | C, Z, S, P |
| `9D` | SBB L | Subtract L from A with Borrow | C, Z, S, P |
| `9E` | SBB M | Subtract Memory from A with Borrow | C, Z, S, P |
| `9F` | SBB A | Subtract A from A with Borrow | C, Z, S, P |

### Logical Group (ANA, XRA, ORA, CMP)

| Opcode (Hex) | Mnemonic | Operation | Used Flags |
| --- | --- | --- | --- |
| `24` | ANI data8 | Logical AND immediate with A | C (0), Z, S, P |
| `2C` | XRI data8 | Exclusive OR immediate with A | C (0), Z, S, P |
| `34` | ORI data8 | Logical OR immediate with A | C (0), Z, S, P |
| `3C` | CPI data8 | Compare immediate with A | C, Z, S, P |
| `A0` | ANA B | Logical AND B with A | C (0), Z, S, P |
| `A1` | ANA C | Logical AND C with A | C (0), Z, S, P |
| `A2` | ANA D | Logical AND D with A | C (0), Z, S, P |
| `A3` | ANA E | Logical AND E with A | C (0), Z, S, P |
| `A4` | ANA H | Logical AND H with A | C (0), Z, S, P |
| `A5` | ANA L | Logical AND L with A | C (0), Z, S, P |
| `A6` | ANA M | Logical AND Memory with A | C (0), Z, S, P |
| `A7` | ANA A | Logical AND A with A (Sets flags) | C (0), Z, S, P |
| `A8` | XRA B | Exclusive OR B with A | C (0), Z, S, P |
| `A9` | XRA C | Exclusive OR C with A | C (0), Z, S, P |
| `AA` | XRA D | Exclusive OR D with A | C (0), Z, S, P |
| `AB` | XRA E | Exclusive OR E with A | C (0), Z, S, P |
| `AC` | XRA H | Exclusive OR H with A | C (0), Z, S, P |
| `AD` | XRA L | Exclusive OR L with A | C (0), Z, S, P |
| `AE` | XRA M | Exclusive OR Memory with A | C (0), Z, S, P |
| `AF` | XRA A | Exclusive OR A with A (Clears A) | C (0), Z, S, P |
| `B0` | ORA B | Logical OR B with A | C (0), Z, S, P |
| `B1` | ORA C | Logical OR C with A | C (0), Z, S, P |
| `B2` | ORA D | Logical OR D with A | C (0), Z, S, P |
| `B3` | ORA E | Logical OR E with A | C (0), Z, S, P |
| `B4` | ORA H | Logical OR H with A | C (0), Z, S, P |
| `B5` | ORA L | Logical OR L with A | C (0), Z, S, P |
| `B6` | ORA M | Logical OR Memory with A | C (0), Z, S, P |
| `B7` | ORA A | Logical OR A with A (Sets flags) | C (0), Z, S, P |
| `B8` | CMP B | Compare B with A | C, Z, S, P |
| `B9` | CMP C | Compare C with A | C, Z, S, P |
| `BA` | CMP D | Compare D with A | C, Z, S, P |
| `BB` | CMP E | Compare E with A | C, Z, S, P |
| `BC` | CMP H | Compare H with A | C, Z, S, P |
| `BD` | CMP L | Compare L with A | C, Z, S, P |
| `BE` | CMP M | Compare Memory with A | C, Z, S, P |
| `BF` | CMP A | Compare A with A | C, Z, S, P |

### Rotate Group

| Opcode (Hex) | Mnemonic | Operation | Used Flags |
| --- | --- | --- | --- |
| `02` | RLC | Rotate A Left | C |
| `0A` | RRC | Rotate A Right | C |
| `12` | RAL | Rotate A Left through Carry | C |
| `1A` | RAR | Rotate A Right through Carry | C |

### Branch Control Group (JMP, CALL, RET, RST)

| Opcode (Hex) | Mnemonic | Operation | Used Flags |
| --- | --- | --- | --- |
| `40` | JNC data16 | Jump if No Carry (C=0) to `data16` | None |
| `44` | JNZ data16 | Jump if Not Zero (Z=0) to `data16` | None |
| `48` | JP data16 | Jump if Positive (S=0) to `data16` | None |
| `4C` | JPO data16 | Jump if Parity Odd (P=0) to `data16` | None |
| `44` | JC data16 | Jump if Carry (C=1) to `data16` | None |
| `54` | JZ data16 | Jump if Zero (Z=1) to `data16` | None |
| `58` | JM data16 | Jump if Minus (S=1) to `data16` | None |
| `5C` | JPE data16 | Jump if Parity Even (P=1) to `data16` | None |
| `60` | CNC data16 | Call if No Carry (C=0) to `data16` | None |
| `64` | CNZ data16 | Call if Not Zero (Z=0) to `data16` | None |
| `68` | CP data16 | Call if Positive (S=0) to `data16` | None |
| `6C` | CPO data16 | Call if Parity Odd (P=0) to `data16` | None |
| `74` | CC data16 | Call if Carry (C=1) to `data16` | None |
| `74` | CZ data16 | Call if Zero (Z=1) to `data16` | None |
| `78` | CM data16 | Call if Minus (S=1) to `data16` | None |
| `7C` | CPE data16 | Call if Parity Even (P=1) to `data16` | None |
| `03` | JMP data16 | Unconditional Jump to `data16` | None |
| `13` | CALL data16 | Unconditional Call to `data16` | None |
| `07` | RET | Unconditional Return | None |
| `0F` | RNC | Return if No Carry (C=0) | None |
| `17` | RNZ | Return if Not Zero (Z=0) | None |
| `1F` | RP | Return if Positive (S=0) | None |
| `27` | RPO | Return if Parity Odd (P=0) | None |
| `2F` | RC | Return if Carry (C=1) | None |
| `37` | RZ | Return if Zero (Z=1) | None |
| `3F` | RM | Return if Minus (S=1) | None |
| `47` | RPE | Return if Parity Even (P=1) | None |
| `05` | RST 0 | Restart at address 0000H | None |
| `0D` | RST 1 | Restart at address 0008H | None |
| `15` | RST 2 | Restart at address 0010H | None |
| `1D` | RST 3 | Restart at address 0018H | None |
| `25` | RST 4 | Restart at address 0020H | None |
| `2D` | RST 5 | Restart at address 0028H | None |
| `35` | RST 6 | Restart at address 0030H | None |
| `3D` | RST 7 | Restart at address 0038H | None |

### I/O and Machine Control Group (IN, OUT, HLT)

| Opcode (Hex) | Mnemonic | Operation | Used Flags |
| --- | --- | --- | --- |
| `01` | HLT | Halt processor execution | None |
| `41` | IN 0 | Input from Port 0 into A | None |
| `43` | IN 1 | Input from Port 1 into A | None |
| `45` | IN 2 | Input from Port 2 into A | None |
| `47` | IN 3 | Input from Port 3 into A | None |
| `49` | IN 4 | Input from Port 4 into A | None |
| `4B` | IN 5 | Input from Port 5 into A | None |
| `4D` | IN 6 | Input from Port 6 into A | None |
| `4F` | IN 7 | Input from Port 7 into A | None |
| `51` | OUT 8 | Output from A to Port 8 | None |
| `53` | OUT 9 | Output from A to Port 9 | None |
| `55` | OUT 10 | Output from A to Port 10 | None |
| `57` | OUT 11 | Output from A to Port 11 | None |
| `59` | OUT 12 | Output from A to Port 12 | None |
| `5B` | OUT 13 | Output from A to Port 13 | None |
| `5D` | OUT 14 | Output from A to Port 14 | None |
| `5F` | OUT 15 | Output from A to Port 15 | None |
| `61` | OUT 16 | Output from A to Port 16 | None |
| `63` | OUT 17 | Output from A to Port 17 | None |
| `65` | OUT 18 | Output from A to Port 18 | None |
| `67` | OUT 19 | Output from A to Port 19 | None |
| `69` | OUT 20 | Output from A to Port 20 | None |
| `6B` | OUT 21 | Output from A to Port 21 | None |
| `6D` | OUT 22 | Output from A to Port 22 | None |
| `6F` | OUT 23 | Output from A to Port 23 | None |
| `71` | OUT 24 | Output from A to Port 24 | None |
| `73` | OUT 25 | Output from A to Port 25 | None |
| `75` | OUT 26 | Output from A to Port 26 | None |
| `77` | OUT 27 | Output from A to Port 27 | None |
| `79` | OUT 28 | Output from A to Port 28 | None |
| `7B` | OUT 29 | Output from A to Port 29 | None |
| `7D` | OUT 30 | Output from A to Port 30 | None |
| `7F` | OUT 31 | Output from A to Port 31 | None |
