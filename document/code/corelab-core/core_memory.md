# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TMemory from core_memory unit

`TMemory` is a base class for simulated memory devices. It manages a byte-array memory space, supports RAM and ROM operation modes, provides byte-level memory access, and can transfer ranges of memory contents to and from streams.

### Related types

|name |type |description|
|-----|-----|-----------|
|`TMemoryMode`|enumeration|Memory operation mode: `mmRAM` or `mmROM`|
|`TSemanticVersion`|record|Major, minor, and patch version information|

### Type helpers

|name |description|
|-----|------------|
|`TMemoryModeHelper.ToString`|Converts a memory mode to its enumeration name|
|`TMemoryModeHelper.FromString`|Converts an enumeration name to `TMemoryMode`|
|`TSemanticVersionHelper.ToString`|Formats a version as `Major.Minor.Patch`|
|`TSemanticVersionHelper.Compare`|Compares two semantic versions; returns `-1`, `0`, or `1`|

### Protected fields

|name |type |description |initial value|
|-----|-----|-------------|-------------|
|`FAddressRangeSize`|`DWord`|Address range size|`1024`|
|`FDescription`|`PChar`|Short description|not initialized here|
|`FEnabled`|`Boolean`|Enable memory access|`false`|
|`FMemoryMode`|`TMemoryMode`|Memory operation mode|`mmRAM`|
|`FMemCells`|array of `Byte`|Memory cells|empty until `Reset`|
|`FModname`|`PChar`|Module name|`RAM`|
|`FVersion`|`TSemanticVersion`|Module version|`0.1.0`|

### Public methods

|name |flags|description|
|-----|:---:|-----------|
|`constructor Create;`|Vi|Initialize the default memory configuration|
|`destructor Destroy;`|Or|Destroy the memory object|
|`function ReadMemory(AAddress: DWord): Byte;`|Vi|Read a byte when memory is enabled and the address is in range; otherwise return zero|
|`procedure Reset;`|Vi|Limit the address range to 16 MiB, allocate the memory array, and clear all cells|
|`procedure WriteMemory(AAddress: DWord; AValue: Byte);`|Vi|Write a byte only when memory is enabled, in RAM mode, and the address is in range|
|`procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord);`|Vi|Load a range of bytes into memory when enabled and the requested range fits|
|`procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord);`|Vi|Save a range of bytes from memory when enabled and the requested range fits|

### Public properties

|name |type |access|description|
|-----|-----|:----:|-----------|
|`AddressRangeSize`|`DWord`|Re/Wr|Memory address range size|
|`Description`|`PChar`|Re/Wr|Short description|
|`Enabled`|`Boolean`|Re/Wr|Enable memory access|
|`MemoryMode`|`TMemoryMode`|Re/Wr|RAM or ROM operation mode|
|`ModName`|`PChar`|Re/Wr|Module name|
|`Version`|`TSemanticVersion`|Re|Module version|

### Memory access behavior

`ReadMemory` returns zero when the memory is disabled or the requested address is outside the configured range.

`WriteMemory` modifies memory only in `mmRAM` mode. In `mmROM` mode writes are ignored.

`Reset` allocates `FMemCells` to the current address range after limiting that range to at most `1 shl 24` bytes (16 MiB), and clears the allocated cells to zero.

### Stream operations

`LoadFromStream` and `SaveToStream` silently return when memory is disabled or when the requested range is outside the configured memory size. `LoadFromStream` also checks that enough bytes remain in the source stream.
