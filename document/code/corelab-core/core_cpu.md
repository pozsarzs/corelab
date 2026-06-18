# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCPU base class

### Public properties

|name            |type            |description                            |
|----------------|----------------|---------------------------------------|
|AddressWidth    |byte            |Address bus width in bits              |
|Architecture    |TArchitecture   |Type of architecture                   |
|BitWidth        |byte            |Main processor word size in bits       |
|Cycles          |qword           |Total cycles                           |
|Description     |PChar           |Short description                      |
|Endianness      |TEndianness     |Byte order                             |
|Halted          |boolean         |CPU HALT state                         |
|HasSeparateIOBus|boolean         |Indicates separate memory and I/O buses|
|Instructions    |qword           |Total executed instructions            |
|InterruptEnabled|boolean         |Global interrupt enable flag           |
|IRQPending      |boolean         |Pending maskable interrupt             |
|MaxCodeAddress  |qword           |The highest code memory address        |
|MaxIOPortAddress|qword           |The highest I/O port address           |
|MaxMemAddress   |qword           |The highest (data) memory address      |
|Modname         |PChar           |Module name (CPU type)                 |
|NMIPending      |boolean         |Pending non-maskable interrupt         |
|OnEvent         |TCPUEventHandler|Event callback                         |
|Running         |boolean         |CPU execution state                    |

### Public methods

|name                                                        |description                                             |
|------------------------------------------------------------|--------------------------------------------------------|
|`constructor Create;`                                       |Sets the initial values for the new object.             |
|`destructor Destroy;`                                       |Frees the object's resources.                           |
|`function CheckInterrupts: boolean;`                        |Interrupt handler.                                      |
|`function GetCurrentInstruction: PChar;`                    |Get last instruction (machine code, mnemonic, operands).|
|`function GetRegister(const RegName: PChar): qword;`        |Get register content.                                   |
|`procedure ConnectBus(const Bus: ICPUBus);`                 |Connect CPU to external system bus.                     |
|`procedure IRQ;`                                            |Signal maskable interrupt.                              |
|`procedure NMI;`                                            |Signal non-maskable interrupt.                          |
|`procedure Reset;`                                          |Reset CPU.                                              |
|`procedure Run;`                                            |Start CPU execution.                                    |
|`procedure SetRegister(const RegName: PChar; Value: qword);`|Set register content.                                   |
|`procedure Step;`                                           |Start CPU execution.                                    |
|`procedure Stop;`                                           |Stop CPU execution.                                     |
