{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cpu_z80_microcode_fdcbxx.pas                                             | }
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
    NumPrefix := 1;
    Prefixes[NumPrefix] := OpCode
  end;
  // instructions
//  case AOC of
{ 
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
}  
//  end;
