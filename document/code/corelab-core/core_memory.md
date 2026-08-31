# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TMemory from TMemory class in core_memory unit

`TMemory` is the base memory component of the CoreLAB framework. It provides
byte-addressable memory storage with configurable address-space size, RAM/ROM
operation mode, enable state, instance identification and stream-based state
persistence.

### TMemoryMode

`TMemoryMode` defines the memory operation mode:

|value  |description                                               |
|-------|----------------------------------------------------------|
|`mmRAM`|Memory contents can be written when the memory is enabled.|
|`mmROM`|Memory contents are read-only through `WriteMemory`.      |

### TMemoryModeHelper

|name                             |description                                                      |
|---------------------------------|-----------------------------------------------------------------|
|`ToString`                       |Converts the current `TMemoryMode` value to its enumeration name.|
|`FromString(const Value: string)`|Converts an enumeration name to a `TMemoryMode` value using RTTI.|

### TSemanticVersion

`TSemanticVersion` stores the module version as three integer components.

|field  |type     |description          |
|-------|---------|---------------------|
|`Major`|`Integer`|Major version number.|
|`Minor`|`Integer`|Minor version number.|
|`Patch`|`Integer`|Patch version number.|

### TSemanticVersionHelper

|name                               |description                                                                                             |
|-----------------------------------|--------------------------------------------------------------------------------------------------------|
|`ToString`                         |Formats the version as `Major.Minor.Patch`.                                                             |
|`Compare(AOther: TSemanticVersion)`|Compares the other version with the current version. Returns `-1`, `0` or `1` for newer, equal or older.|

### Protected fields

|name               |type              |description                                  |default                                 |
|-------------------|------------------|---------------------------------------------|----------------------------------------|
|`FAddressRangeSize`|`DWord`           |Number of addressable memory cells.          |`1024`                                  |
|`FDescription`     |`PChar`           |Short module description.                    |`Standard memory with 8 bit data width.`|
|`FEnabled`         |`Boolean`         |Enables memory access without bus detachment.|`False`                                 |
|`FInstanceID`      |`Integer`         |Module instance identifier.                  |not explicitly initialized              |
|`FMemoryMode`      |`TMemoryMode`     |RAM or ROM operation mode.                   |`mmRAM`                                 |
|`FMemCells`        |`array of Byte`   |Internal byte-addressable memory storage.    |1024 bytes initially                    |
|`FModname`         |`PChar`           |Module name.                                 |`RAM/ROM`                               |
|`FVersion`         |`TSemanticVersion`|Module version.                              |`0.1.0`                                 |

### Protected methods

|name                                                       |description                                                                                                               |
|-----------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|
|`procedure SetFAddressRangeSize(AAddressRangeSize: DWord);`|Sets the address-space size and resizes the memory array. Values below `16` are ignored; the maximum size is `2^24` bytes.|

### Public methods

|name                                                                  |flags|description                                                                                                                          |
|----------------------------------------------------------------------|-----|-------------------------------------------------------------------------------------------------------------------------------------|
|`constructor Create;`                                                 |Vi   |Initializes a 1024-byte RAM memory module, disables it, sets its module information and clears its memory contents.                  |
|`destructor Destroy;`                                                 |Or   |Destroys the memory object.                                                                                                          |
|`procedure Reset;`                                                    |Vi   |Fills all allocated memory cells with zero.                                                                                          |
|`function ReadMemory(AAddress: DWord): Byte;`                         |Vi   |Returns the byte at the specified address when enabled and inside the configured range. Otherwise returns `0`.                       |
|`procedure WriteMemory(AAddress: DWord; AValue: Byte);`               |Vi   |Writes a byte when enabled, in `mmRAM` mode and inside the configured range.                                                         |
|`function LoadState(AStream: TStream): Boolean;`                      |Vi   |Loads enabled state, memory mode, address-range size and memory contents from a stream. Returns `False` on a stream read exception.  |
|`function SaveState(AStream: TStream): Boolean;`                      |Vi   |Saves enabled state, memory mode, address-range size and memory contents. Returns `True` when `InstanceID > -1` and writing succeeds.|
|`procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord);`|Vi   |Loads `ACount` bytes from the current stream position into memory when enabled and both memory and stream bounds are valid.          |
|`procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord);`  |Vi   |Writes `ACount` bytes from memory to the current stream position when enabled and memory bounds are valid.                           |

### Public properties

|name              |type              |access    |description                                                                                                                                  |
|------------------|------------------|----------|---------------------------------------------------------------------------------------------------------------------------------------------|
|`AddressRangeSize`|`DWord`           |read/write|Configured memory address-space size. The setter resizes the memory array and limits the size to `2^24` bytes; values below `16` are ignored.|
|`Description`     |`PChar`           |read      |Short module description.                                                                                                                    |
|`Enabled`         |`Boolean`         |read/write|Enables or disables memory access.                                                                                                           |
|`InstanceID`      |`Integer`         |read/write|Module instance identifier.                                                                                                                  |
|`MemoryMode`      |`TMemoryMode`     |read/write|Selects RAM or ROM operation.                                                                                                                |
|`ModName`         |`PChar`           |read      |Module name.                                                                                                                                 |
|`Version`         |`TSemanticVersion`|read      |Module version.                                                                                                                              |
