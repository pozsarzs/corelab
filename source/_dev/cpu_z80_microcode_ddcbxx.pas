{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_ddcbxx.pas                                             | }
{ | Microcode for Zilog Z80 CPU implementation module                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

  // store prefix for log
  with FLastInstruction do
  begin
    NumPrefix := 2;
    Prefixes[NumPrefix] := AOC;
  end;
  // prefix-depends operations
  //DDCB és FDCB prefixek: Ezek a legnyakatekertebbek. Egyrészt a bájtsorrend kevert (Prefix1, Prefix2, Eltolás, Opkód). Másrészt van egy hírhedt dokumentálatlan trükk: ha az utasítás módosítja az (IX+d) memóriacímet (pl. SET, RES, RLC), a Z80 a hardveres kialakítás miatt az eredményt ezzel egy időben beírja az opkód alsó 3 bitje által mutatott alap 8 bites regiszterbe is (kivéve a BIT utasításokat, amik csak a flageket módosítják). A pontos emulátoroknak ezt a kettős írást is támogatniuk kell.
In the Z80 processor, the DD prefix redirects operations associated with the HL register to the IX register.

The FD prefix, on the other hand, redirects these operations to the IY register.

Memory references: Indirect addressing via (HL) is replaced by indexed addressing using (IX+d) or (IY+d). In this mode, an extra byte—the displacement *d*—always follows the opcode in memory. This is a signed 8-bit value (ranging from -128 to +127) that is added to the 16-bit index register to calculate the actual memory address. For example, the instruction `LD A, (HL)` becomes `LD A, (IX+d)`.  // instructions



//  case AOC of
{ 
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

}  
//  end;
