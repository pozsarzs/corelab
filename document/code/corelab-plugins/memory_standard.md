# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TStandardMemory class

TStandardMemory is a generic RAM/ROM implementation module derived from the
TMemory abstract base class.

### Modified inherited protected fields

|name        |type |C|description      |value|
|------------|-----|-|-----------------|:---:|
|FDescription|PChar| |Short description|     |
|FModName    |PChar| |Module name      |     |

**Note**:  
- _C_: means 'constant'.

### Own public methods

|name                                           |V|A|O|description                               |
|-----------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                          | | |x|Sets the initial values for the new object|
|`destructor Destroy;`                          | | |x|Frees the object's resources              |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                       |exported name |description   |
|-------------------------------------------|--------------|--------------|
|`function CreateMemory: TMemory;`          |memory_create |Create memory |
|`procedure DestroyMemory(Memory: TMemory);`|memory_destroy|Destroy memory|
