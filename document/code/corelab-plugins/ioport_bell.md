# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TBELLPort class

TBELLPort is an I/O port that simulates a simple, write-only output peripheral
derived from the TIOPort abstract base class. Its function is to trigger beeps:
if the value written to the virtual port is greater than zero, the framework
generates a beep.

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
