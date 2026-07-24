# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TNULLPort class

Class TNULLPort is an I/O port that implements an empty or dummy peripheral
derived from the TIOPort abstract base class, and is primarily used for testing
purposes. It returns a constant `00h` to read operations.

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
|`function ReadPort(Port: Byte): Byte;`         | | |x|Read virtual port                         |
|`procedure Reset;`                             | | |x|Reset virtual port                        |
|`procedure WritePort(Port: Byte; Value: Byte);`| | |x|Write virtual port                        |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                    |exported name |description     |
|----------------------------------------|--------------|----------------|
|`function CreatePort: TIOPort;`         |ioport_create |Create instance |
|`procedure DestroyPort(Port: TIOPort));`|ioport_destroy|Destroy instance|
