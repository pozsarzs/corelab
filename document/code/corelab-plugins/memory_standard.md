# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TStandardMemory from TMemory class in memory_standard unit

`TStandardMemory` is the standard memory plugin of the CoreLAB framework. It is derived from `TMemory` and provides a memory component configured for up to 16 MB of RAM or ROM operation.

### Protected fields

`TStandardMemory` does not declare additional protected fields. It uses the inherited fields of `TMemory`.

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Or|Creates a standard memory object by calling the inherited constructor and configuring the module as `Standard memory`, with the description `Up to 16MB RAM/ROM` and RAM mode selected.|
|`destructor Destroy;`|Or|Destroys the standard memory object by calling the inherited destructor.|

### Inherited interface

The class inherits the complete memory interface from `TMemory`, including:

|member|description|
|---|---|
|`AddressRangeSize`|Configurable memory address-space size.|
|`DataWidth`|Configurable memory data width.|
|`Description`|Module description.|
|`Enabled`|Enables or disables memory access.|
|`InstanceID`|Module instance identifier.|
|`MemoryMode`|Selects RAM or ROM operation.|
|`ModName`|Module name.|
|`Version`|Module version.|
|`ReadMemory`|Reads a byte from memory.|
|`WriteMemory`|Writes a byte when the memory is enabled and operating in RAM mode.|
|`Reset`|Clears the memory contents.|
|`LoadState`|Loads the memory state from a stream.|
|`SaveState`|Saves the memory state to a stream.|
|`LoadFromStream`|Loads a block of data into memory.|
|`SaveToStream`|Saves a block of memory data to a stream.|

### Exported functions

|exported name|function|description|
|---|---|---|
|`memory_create`|`CreateMemory`|Creates and returns a new `TStandardMemory` instance.|
|`memory_destroy`|`DestroyMemory`|Destroys the supplied memory object when it is assigned.|
|`memory_loadstate`|`LoadState`|Loads the state of the supplied memory object from a stream. Returns `False` when the memory object is `nil`.|
|`memory_savestate`|`SaveState`|Saves the state of the supplied memory object to a stream. Returns `False` when the memory object is `nil`.|

### Module configuration

|item|value|
|---|---|
|Module class|`TStandardMemory`|
|Base class|`TMemory`|
|Module name|`RAM/ROM`|
|Description|`Standard memory with 4-64 bit data width.`|
|Initial memory mode|`mmRAM`|
|Library|`memory_standard`|
