# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TStandardMemory class

TStandardMemory is a generic RAM/ROM implementation module derived from the
TMemory abstract base class.

### New default value of the protected fields

|name        |type |C|description      |default          |
|------------|:---:|-|-----------------|:---------------:|
|FDescription|PChar| |Short description|short text       |
|FModName    |PChar| |Module name      |'Standard memory'|

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
