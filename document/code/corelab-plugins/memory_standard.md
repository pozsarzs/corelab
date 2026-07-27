# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TStandardMemory from TMemory class in memory_standard unit

TStandardMemory is a generic RAM/ROM implementation module derived from the
TMemory abstract base class.

### UML diagram

![Class diagram](../diagrams/_png/memory.png "Memory plugin class diagram")

### Abbreviations

- _Ab_: means 'abstract',
- _Co_: means 'constant',
- _Il_: means 'inline',
- _Ol_: means 'overload',
- _Or_: means 'override',
- _Re_: means 'read',
- _Ri_: means 'reintroduce',
- _St_: means 'static',
- _Vi_: means 'virtual',
- _Wr_: means 'write'.

### Protected fields

|name        |type |flags|description      |default|
|------------|-----|:---:|-----------------|-------|
|FDescription|PChar|     |Short description|       |
|FModName    |PChar|     |Module name      |       |

### Public methods

|name                 |flags|description                               |
|---------------------|:---:|------------------------------------------|
|`constructor Create;`|Or   |Sets the initial values for the new object|
|`destructor Destroy;`|Or   |Frees the object's resources              |

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                       |exported name |description |
|-------------------------------------------|--------------|------------|
|`function CreateMemory: TMemory;`          |memory_create |Create memory |
|`procedure DestroyMemory(Memory: TMemory);`|memory_destroy|Destroy memory|

