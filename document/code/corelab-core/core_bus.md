# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## Bus interfaces and types from core_bus unit

The `core_bus` unit declares the bus types and interfaces used by the CoreLAB
framework to connect CPUs with memory and I/O devices. It defines two bus
interfaces: `IStandardBus` for standard memory and I/O-port access, and
`IMCS4Bus` for the Intel MCS-4 family of RAM and ROM devices.

### Record types

|name        |fields                  |description                                          |
|------------|------------------------|-----------------------------------------------------|
|`TBusLogRec`|`Operation: string[31]` |Name of the bus operation recorded by the bus logger.|
|            |`Device: string[31]`    |Device involved in the operation.                    |
|            |`Address: string[31]`   |Address used by the operation.                       |
|            |`RelAddress: string[31]`|Relative address used by the operation.              |
|            |`Data: string[31]`      |Data associated with the operation.                  |
|            |`Status: string[31]`    |Status information associated with the operation.    |

`TBusLogRec` is documented in the source comment as the record for the last bus
operation used by `BusLogger`.

### Bus type

`TBusType` identifies the system-bus type:

|value       |description         |
|------------|--------------------|
|`btStandard`|Standard system bus.|
|`btMCS4`    |Intel MCS-4 bus.    |

### TBusTypeHelper

The `TBusTypeHelper` type helper adds string conversion methods to `TBusType`.

|name                                                 |description                                                                                                                                                                                                      |
|-----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`function ToString: string;`                         |Converts the current enumeration value to its string representation using `WriteStr`.                                                                                                                            |
|`function FromString(const Value: string): TBusType;`|Converts the supplied string to a `TBusType` value using `GetEnumValue` and `TypeInfo(TBusType)`. This is declared as an instance helper method; the implementation uses the supplied `Value` for the conversion.|

### IStandardBus interface

`IStandardBus` defines byte-wide memory and I/O-port access for the standard bus.

|name                                                   |description                                        |
|-------------------------------------------------------|---------------------------------------------------|
|`function ReadMemory(AAddress: DWord): Byte;`          |Reads one byte from the specified memory address.  |
|`procedure WriteMemory(AAddress: DWord; AValue: Byte);`|Writes one byte to the specified memory address.   |
|`function ReadPort(APort: DWord): Byte;`               |Reads one byte from the specified I/O-port address.|
|`procedure WritePort(APort: DWord; AValue: Byte);`     |Writes one byte to the specified I/O-port address. |

Interface GUID:

`{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}`

### IMCS4Bus interface

`IMCS4Bus` defines the operations required by Intel MCS-4-family memory and I/O devices.

|name                                                  |description                                        |
|------------------------------------------------------|---------------------------------------------------|
|`procedure SendSRC(AAddress: Byte);`                  |Sends the common SRC addressing/control value.     |
|`function ReadRAM: Byte;`                             |Reads data from the selected RAM location.         |
|`procedure WriteRAM(AData: Byte);`                    |Writes data to the selected RAM location.          |
|`function ReadRAMStatus(AIndex: Byte): Byte;`         |Reads a RAM status character selected by `AIndex`. |
|`procedure WriteRAMStatus(AIndex: Byte; AData: Byte);`|Writes a RAM status character selected by `AIndex`.|
|`procedure WriteRAMIOPort(AData: Byte);`              |Writes data to a RAM device's I/O port.            |
|`function ReadROM(AAddress: Word): Byte;`             |Reads data from the specified ROM address.         |
|`function ReadROMIOPort: Byte;`                       |Reads data from a ROM device's I/O port.           |
|`procedure WriteROMIOPort(AData: Byte);`              |Writes data to a ROM device's I/O port.            |

Interface GUID:

`{923A5391-77FD-41FB-B935-046D62F45C18}`

### Unit contents and scope

The `core_bus` unit declares the bus-related record, enumeration, type helper,
and interfaces. It does not declare a concrete bus class or implement the
memory and I/O operations itself. Implementations of `IStandardBus` and
`IMCS4Bus` are provided by the device or bus classes elsewhere in the
framework.
