# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## ISysBus from sysbus unit

`ISysBus` is the CoreLAB system-bus interface. It defines the memory and I/O
operations used by a CPU to communicate with memory and I/O-port devices through
the system bus.

The source identifies the interface as the CPU-to-device path from `TCPU` to
`TIOPort` and `TMemory`.

### Interface methods

|name                                                    |description                                                                                                                         |
|--------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
|`function ReadMemory(AAddress: DWord): QWord;`          |Reads a value from the memory address specified by `AAddress`. The source specifies this operation as implemented only in `TMemory`.|
|`procedure WriteMemory(AAddress: DWord; AValue: QWord);`|Writes a value to the memory address specified by `AAddress`. The source specifies this operation as implemented only in `TMemory`. |
|`function ReadPort(APort: Word): Byte;`                 |Reads a byte from the specified I/O port. The source specifies this operation as implemented only in `TIOPort`.                     |
|`procedure WritePort(APort: Word; AValue: Byte);`       |Writes a byte to the specified I/O port. The source specifies this operation as implemented only in `TIOPort`.                      |

### Interface identifier

`ISysBus` is identified by GUID:

`{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}`

### Usage

The source comment identifies `ISysBus` as the communication path from `TCPU` to
`TIOPort` and `TMemory`.

`TBus` implements `ISysBus` and therefore provides the bus-level implementation
of these operations.
