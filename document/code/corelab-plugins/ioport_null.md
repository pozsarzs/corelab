# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TNULLPort class

Class TNULLPort is an I/O port that implements an empty or dummy peripheral
derived from the `TIOPort` abstract base class, and is primarily used for testing
purposes. It returns a constant `$00` or `$FF` response to read operations based
on the set `FResponse` value, and zero in all other cases.

### New default value of the protected fields

|name        |type |C|description      |default      |
|------------|:---:|-|-----------------|:-----------:|
|FDescription|PChar| |Short description|short text   |
|FModName    |PChar| |Module name      |'NULL device'|

**Note**:  
- _C_: means 'constant'.

### Own public methods

|name                                           |V|A|O|description                               |
|-----------------------------------------------|-|-|-|------------------------------------------|
|`constructor Create;`                          | | |x|Sets the initial values for the new object|
|`destructor Destroy;`                          | | |x|Frees the object's resources              |
|`function ReadPort(Port: Byte): Byte;`         | | |x|Read virtual port                         |
|`procedure Reset;`                             | | |x|Reset virtual port                        |
|`procedure WritePort(Port: Byte; Value: Byte);`| | |x|Write virtual port                        |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
