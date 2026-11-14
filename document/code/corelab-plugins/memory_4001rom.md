# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## T4001ROM from TMemory class in memory_4001rom unit

`T4001ROM` is the Intel 4001 ROM and I/O chip plugin of the CoreLAB framework.
It is derived from `TMemory` and implements the `IMCS4Bus` interface. The
component provides a 256-byte ROM area and access to a 4-bit I/O port.

### Private and protected fields

|name            |visibility|description                                                    |
|----------------|----------|---------------------------------------------------------------|
|`FChipID`       |Private   |Chip identifier derived from the configured base address.      |
|`FSelected`     |Private   |Indicates whether the chip is selected by the last SRC command.|
|`FTargetAddress`|Private   |Address used when accessing the connected I/O port.            |
|`FTargetPort`   |Private   |Reference to the target `TIOPort` instance.                    |

### Protected methods

|name                                                    |description                                                                                                                                          |
|--------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
|`SetFAddressRangeSize(AAddressRangeSize: DWord);`       |Overrides the inherited setter and fixes the memory size at 256 bytes, resizing `FMemCells`.                                                         |
|`SetFBaseAddress(ABaseAddress: DWord);`                 |For base addresses up to `$0F00`, derives the chip ID by dividing the address by 256 and aligns the base address to the corresponding 256-byte block.|
|`SetFMemoryMode(AMemoryMode: TMemoryMode);`             |Overrides the inherited setter and forces ROM mode.                                                                                                  |
|`QueryInterface(constref iid: TGuid; out obj): LongInt;`|Provides the `IMCS4Bus` interface when the requested interface identifier matches it.                                                                |
|`_AddRef: LongInt;`                                     |Returns `-1`; reference counting is disabled for this interface implementation.                                                                      |
|`_Release: LongInt;`                                    |Returns `-1`; reference counting is disabled for this interface implementation.                                                                      |

### Public methods

|name                                        |flags|description                                                                                                                                                                              |
|--------------------------------------------|-----|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                       |Or   |Calls the inherited constructor, sets the address range to 256 bytes, selects the MCS-4 bus type and ROM mode, and initializes the module information and internal selection/port fields.|
|`SendSRC(AAddress: Byte);`                  |     |Receives an 8-bit SRC control value and updates the chip-selection state by comparing `AAddress shr 4` with the chip ID.                                                                 |
|`ReadRAM: Byte;`                            |     |RAM operation is not supported; always returns `0`.                                                                                                                                      |
|`WriteRAM(AData: Byte);`                    |     |RAM operation is not supported; performs no action.                                                                                                                                      |
|`ReadRAMStatus(AIndex: Byte): Byte;`        |     |RAM status operation is not supported; always returns `0`.                                                                                                                               |
|`WriteRAMStatus(AIndex: Byte; AData: Byte);`|     |RAM status operation is not supported; performs no action.                                                                                                                               |
|`WriteRAMIOPort(AData: Byte);`              |     |RAM I/O operation is not supported; performs no action.                                                                                                                                  |
|`ReadROM(AAddress: Word): Byte;`            |     |Reads a byte from the ROM by calling the inherited `ReadMemory` method.                                                                                                                  |
|`ReadROMIOPort: Byte;`                      |     |When the chip is selected and a target port is assigned, reads the target port and returns its lower 4 bits; otherwise returns `0`.                                                      |
|`WriteROMIOPort(AData: Byte);`              |     |When the chip is selected and a target port is assigned, writes the lower 4 bits of the data to the target port.                                                                         |

### Public properties

|property       |access    |description                                       |
|---------------|----------|--------------------------------------------------|
|`ChipID`       |Read-only |Chip identifier calculated from the base address. |
|`TargetAddress`|Read/write|Address used for access to the target I/O port.   |
|`TargetPort`   |Read/write|Target `TIOPort` instance used for I/O operations.|

### Inherited interface

The class inherits the memory interface from `TMemory`, including:

|member            |description                                                                     |
|------------------|--------------------------------------------------------------------------------|
|`AddressRangeSize`|Memory address-space size; this implementation fixes it at 256 bytes.           |
|`DataWidth`       |Memory data width.                                                              |
|`Description`     |Module description.                                                             |
|`Enabled`         |Enables or disables memory access.                                              |
|`InstanceID`      |Module instance identifier.                                                     |
|`MemoryMode`      |Selects RAM or ROM operation; this implementation forces ROM mode.              |
|`ModName`         |Module name.                                                                    |
|`Version`         |Module version.                                                                 |
|`ReadMemory`      |Reads a byte from memory.                                                       |
|`WriteMemory`     |Writes a byte according to the inherited memory implementation and current mode.|
|`Reset`           |Resets the memory component according to the inherited implementation.          |
|`LoadState`       |Loads the memory state from a stream.                                           |
|`SaveState`       |Saves the memory state to a stream.                                             |
|`LoadFromStream`  |Loads a block of data into memory.                                              |
|`SaveToStream`    |Saves a block of memory data to a stream.                                       |

`T4001ROM` also implements `IMCS4Bus` for connection to the MCS-4 bus. The
interface methods are supplied by the class's `QueryInterface`, `_AddRef`, and
`_Release` implementations.

### Exported functions and procedures

|exported name             |function/procedure|description                                                                                                  |
|--------------------------|------------------|-------------------------------------------------------------------------------------------------------------|
|`memory_create`           |`CreateMemory`    |Creates and returns a new `T4001ROM` instance as a `TMemory` reference.                                      |
|`memory_destroy`          |`DestroyMemory`   |Destroys the supplied memory object when it is assigned.                                                     |
|`memory_loadstate`        |`LoadState`       |Loads the state of the supplied memory object from a stream. Returns `False` when the memory object is `nil`.|
|`memory_savestate`        |`SaveState`       |Saves the state of the supplied memory object to a stream. Returns `False` when the memory object is `nil`.  |
|`memory_set_target_port`  |`SetTargetPort`   |For a `T4001ROM` instance, assigns the target `TIOPort` and the address used for its I/O operations.         |
