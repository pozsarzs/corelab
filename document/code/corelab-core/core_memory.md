# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TMemory from TMemory class in core_memory unit

`TMemory` is the abstract memory component of the CoreLAB framework. It provides a byte-addressable memory array with configurable address-space size, RAM/ROM operation mode, enable state, instance identification and stream-based state persistence.

### TMemoryMode

`TMemoryMode` defines the memory operation mode:

|value|description|
|---|---|
|`mmRAM`|Memory contents can be written when the memory is enabled.|
|`mmROM`|Memory contents are read-only through `WriteMemory`.|

### TMemoryModeHelper

|name|description|
|---|---|
|`ToString`|Converts the current `TMemoryMode` value to its enumeration name.|
|`FromString(const Value: string)`|Converts an enumeration name to a `TMemoryMode` value using RTTI.|

### TSemanticVersion

`TSemanticVersion` stores the module version as three integer components.

|field|type|description|
|---|---|---|
|`Major`|`Integer`|Major version number.|
|`Minor`|`Integer`|Minor version number.|
|`Patch`|`Integer`|Patch version number.|

### TSemanticVersionHelper

|name|description|
|---|---|
|`ToString`|Formats the version as `Major.Minor.Patch`.|
|`Compare(AOther: TSemanticVersion)`|Compares the other version with the current version and returns `-1`, `0` or `1`. The result is negative when `AOther` is newer, positive when it is older, and zero when both versions are equal.|

### Protected fields

|name|type|description|default|
|---|---|---|---|
|`FAddressRangeSize`|`DWord`|Number of addressable memory cells.|`1024`|
|`FDescription`|`PChar`|Short module description.|`Conventional memory.`|
|`FEnabled`|`Boolean`|Enables memory access without detaching the component from the bus.|`False`|
|`FInstanceID`|`Integer`|Module instance identifier.|not explicitly initialized|
|`FMemoryMode`|`TMemoryMode`|RAM or ROM operation mode.|`mmRAM`|
|`FMemCells`|`array of Byte`|Internal byte-addressable memory storage.|1024 bytes initially|
|`FModname`|`PChar`|Module name.|`RAM`|
|`FVersion`|`TSemanticVersion`|Module version.|`0.1.0`|

### Protected methods

|name|flags|description|
|---|:---:|---|
|`procedure SetFAddressRangeSize(AAddressRangeSize: DWord);`| |Sets the address-space size and resizes the internal memory array. Values above `2^24` are limited to `2^24` bytes. A value of zero is ignored.|

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Vi|Initializes a 1024-byte RAM memory module, disables it, sets its module information and clears its memory contents.|
|`destructor Destroy;`|Or|Destroys the memory object.|
|`procedure Reset;`|Vi|Fills all allocated memory cells with zero.|
|`function ReadMemory(AAddress: DWord): Byte;`|Vi|Returns the byte at the specified address when the memory is enabled and the address is inside the configured range. Otherwise returns `0`.|
|`procedure WriteMemory(AAddress: DWord; AValue: Byte);`|Vi|Writes a byte only when the memory is enabled, the mode is `mmRAM`, and the address is inside the configured range.|
|`function LoadState(AStream: TStream): Boolean;`|Vi|Loads the enabled state, memory mode, address-range size and complete memory contents from a stream. Returns `False` if a stream read raises an exception.|
|`function SaveState(AStream: TStream): Boolean;`|Vi|Saves the enabled state, memory mode, address-range size and complete memory contents. Returns `True` only when `InstanceID > -1` and the data is written.|
|`procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord);`|Vi|Loads `ACount` bytes from the current stream position into memory starting at `AAddress`, provided the memory is enabled and both memory and stream bounds are valid.|
|`procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord);`|Vi|Writes `ACount` bytes from memory starting at `AAddress` to the current stream position, provided the memory is enabled and the memory bounds are valid.|

### Public properties

|name|type|access|description|
|---|---|---|---|
|`AddressRangeSize`|`DWord`|read/write|Configured memory address-space size. The setter also resizes the internal memory array and limits the size to `2^24` bytes.|
|`Description`|`PChar`|read|Short module description.|
|`Enabled`|`Boolean`|read/write|Enables or disables memory access.|
|`InstanceID`|`Integer`|read/write|Module instance identifier.|
|`MemoryMode`|`TMemoryMode`|read/write|Selects RAM or ROM operation.|
|`ModName`|`PChar`|read|Module name.|
|`Version`|`TSemanticVersion`|read|Module version.|

### Memory operation

|condition|`ReadMemory`|`WriteMemory`|
|---|---|---|
|`Enabled = False`|returns `0`|no operation|
|Address outside range|returns `0`|no operation|
|`MemoryMode = mmRAM`|reads normally|writes normally|
|`MemoryMode = mmROM`|reads normally|no operation|

### Module information

|item|value|
|---|---|
|Module name|`RAM`|
|Description|`Conventional memory.`|
|Version|`0.1.0`|
|Initial address range|1024 bytes|
|Maximum address range|`2^24` bytes|
|Initial memory mode|`mmRAM`|
|Initial enabled state|`False`|
