# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## T4002RAM from TMemory class in memory_4002ram unit

`T4002RAM` is the Intel 4002 RAM and I/O chip plugin of the CoreLAB framework.
It is derived from `TMemory` and implements `IMCS4Bus`. The module provides
80 four-bit memory cells: four registers with 16 characters each, plus four
status characters per register. It also provides a four-bit output port.

### Private fields

|name            |type     |description                                                                    |
|----------------|---------|-------------------------------------------------------------------------------|
|`FChipID`       |`Byte`   |Chip identifier used to select the device through SRC control data.            |
|`FActiveReg`    |`Byte`   |Currently selected one of the four RAM registers.                              |
|`FActiveChar`   |`Byte`   |Currently selected character within the active register.                       |
|`FSelected`     |`Boolean`|Indicates whether the chip is selected by the most recently received SRC value.|
|`FTargetAddress`|`Word`   |I/O port address used when writing to the target port.                         |
|`FTargetPort`   |`TIOPort`|Target I/O port receiving the four-bit RAM output data.                        |

### Protected methods

|name                                                    |flags|description                                                                                                                                                                                     |
|--------------------------------------------------------|-----|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`SetFAddressRangeSize(AAddressRangeSize: DWord);`       |Or   |Overrides the memory-size setter. The memory size is fixed at 80 cells, and the memory-cell array is resized accordingly. The supplied argument does not determine the resulting size.          |
|`SetFBaseAddress(ABaseAddress: DWord);`                 |Or   |Overrides the base-address setter. For base addresses up to `$0F00`, it derives the chip identifier by dividing the address by 80 and sets the base address to the corresponding multiple of 80.|
|`SetFMemoryMode(AMemoryMode: TMemoryMode);`             |Or   |Overrides the memory-mode setter and forces `mmRAM`.                                                                                                                                            |
|`QueryInterface(constref iid: TGuid; out obj): LongInt;`|     |Implements interface querying for `IMCS4Bus`.                                                                                                                                                   |
|`_AddRef: LongInt;`                                     |     |Returns `-1`; reference counting is disabled.                                                                                                                                                   |
|`_Release: LongInt;`                                    |     |Returns `-1`; reference counting is disabled.                                                                                                                                                   |

### Public methods

|name                                        |flags|description                                                                                                                                                                                     |
|--------------------------------------------|-----|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                       |Or   |Creates the 4002 RAM object, sets the memory size to 80 cells, selects the MCS-4 bus type and RAM mode, initializes the module metadata, and clears the chip-selection and target-port settings.|
|`SendSRC(AAddress: Byte);`                  |     |Receives the 8-bit SRC control value. Bits 7–6 select the chip ID, bits 5–4 select the RAM register, and bits 3–0 select the character.                                                         |
|`ReadRAM: Byte;`                            |     |Returns the selected four-bit RAM cell when the chip is selected; otherwise returns zero.                                                                                                       |
|`WriteRAM(AData: Byte);`                    |     |Writes the low four bits of the data to the selected RAM cell when the chip is selected.                                                                                                        |
|`ReadRAMStatus(AIndex: Byte): Byte;`        |     |Reads one of the four status characters belonging to the active register. Returns zero if the chip is not selected or the index is outside 0–3.                                                 |
|`WriteRAMStatus(AIndex: Byte; AData: Byte);`|     |Writes the low four bits of the data to one of the active register's four status characters when the chip is selected and the index is outside neither the valid range nor the array bounds.    |
|`WriteRAMIOPort(AData: Byte);`              |     |Writes the low four bits of the data to the configured target I/O port, if the chip is selected and a target port is assigned.                                                                  |
|`ReadROM(AAddress: Word): Byte;`            |     |Unsupported for this RAM module; always returns zero.                                                                                                                                           |
|`ReadROMIOPort: Byte;`                      |     |Unsupported for this RAM module; always returns zero.                                                                                                                                           |
|`WriteROMIOPort(AData: Byte);`              |     |Unsupported for this RAM module; performs no operation.                                                                                                                                         |

### Public properties

|name           |type     |access    |description                                                     |
|---------------|---------|----------|----------------------------------------------------------------|
|`ChipID`       |`Byte`   |read-only |Returns the chip identifier.                                    |
|`TargetAddress`|`Word`   |read/write|Gets or sets the address used for writes to the target I/O port.|
|`TargetPort`   |`TIOPort`|read/write|Gets or sets the target I/O port.                               |

### Inherited interface

The class inherits the memory interface from `TMemory`, including:

|member            |description                                                                      |
|------------------|---------------------------------------------------------------------------------|
|`AddressRangeSize`|Configurable memory address-space size; this implementation fixes it at 80 cells.|
|`DataWidth`       |Configurable memory data width.                                                  |
|`Description`     |Module description.                                                              |
|`Enabled`         |Enables or disables memory access.                                               |
|`InstanceID`      |Module instance identifier.                                                      |
|`MemoryMode`      |Selects RAM or ROM operation; this implementation forces RAM mode.               |
|`ModName`         |Module name.                                                                     |
|`Version`         |Module version.                                                                  |
|`ReadMemory`      |Reads a byte from memory.                                                        |
|`WriteMemory`     |Writes a byte when the memory is enabled and operating in RAM mode.              |
|`Reset`           |Resets the inherited memory component.                                           |
|`LoadState`       |Loads the inherited memory state from a stream.                                  |
|`SaveState`       |Saves the inherited memory state to a stream.                                    |
|`LoadFromStream`  |Loads a block of data into memory.                                               |
|`SaveToStream`    |Saves a block of memory data to a stream.                                        |

### Exported functions

|exported name           |function       |description                                                                                                  |
|------------------------|---------------|-------------------------------------------------------------------------------------------------------------|
|`memory_create`         |`CreateMemory` |Creates and returns a new `T4002RAM` instance as a `TMemory` object.                                         |
|`memory_destroy`        |`DestroyMemory`|Destroys the supplied memory object when it is assigned.                                                     |
|`memory_loadstate`      |`LoadState`    |Loads the state of the supplied memory object from a stream. Returns `False` when the memory object is `nil`.|
|`memory_savestate`      |`SaveState`    |Saves the state of the supplied memory object to a stream. Returns `False` when the memory object is `nil`.  |
|`memory_set_target_port`|`SetTargetPort`|Sets the target I/O port and its address when the supplied object is a `T4002RAM` instance.                  |
