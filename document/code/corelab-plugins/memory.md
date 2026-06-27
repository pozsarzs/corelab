# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TMemory implementations

This document describes concrete memory implementations based on the TMemory
abstract base class and how to export modules as dynamic link libraries (DLL/SO).

### Exported functions and procedures

|name                                       |exported name   |description             |call |
|-------------------------------------------|----------------|------------------------|-----|
|`function CreateMemory: TMemory;`          |_memory_create_ |Create TMemory instance |cdecl|
|`procedure DestroyMemory(Memory: TMemory);`|_memory_destroy_|Destroy TMemory instance|cdecl|

### Libraries (.so/.dll) with available features

|name           | class         |mode|GUI|p01234|m01234|e01|description        |
|---------------|---------------|----|---|-----:|-----:|--:|-------------------|
|memory_standard|TStandardMemory|R/W | - | +++++| +++++| ++|RAM/ROM up to 16 MB|

**Note**:  

|col|type    |name            |
|--:|--------|----------------|
|p0 |property|AddressRangeSize|
|1  |property|Description     |
|2  |property|Enabled         |
|3  |property|MemoryMode      |
|4  |property|ModName         |
|m0 |method  |LoadFromStream  |
|1  |method  |ReadMemory      |
|2  |method  |Reset           |
|3  |method  |SaveToStream    |
|4  |method  |WriteMemory     |
|e0 |export  |CreateMemory    |
|1  |export  |DestroyMemory   |
