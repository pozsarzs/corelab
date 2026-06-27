# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TBELLPort class

TBELLPort is an I/O port that simulates a simple, write-only output peripheral
derived from the TIOPort abstract base class. Its function is to trigger beeps:
if the value written to the virtual port is greater than zero, the framework
generates a beep. It does not have its own graphical user interface (GUI), and
its operation relies solely on system sounds.

### New default value of the protected fields

|name        |type     |C|description        |default      |
|------------|:-------:|-|-------------------|:-----------:|
|FDescription|PChar    | |Short description  |short text   |
|FModName    |PChar    | |Module name        |'BELL device'|
|FPortMode   |TPortMode| |Port operation mode|pmWriteOnly  |

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
