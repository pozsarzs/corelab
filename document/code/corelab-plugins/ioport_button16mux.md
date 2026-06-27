# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TButton16Mux class

TButton16Mux is a module that simulates a read-only input peripheral derived
from the abstract base class TIOPort. It has its own graphical user interface,
which displays a matrix of 16 push buttons. The column to be read can be selected
directly by an active bit (up to 8 lines) or by specifying the line BCD (up to
16 lines). The active bit can be high or low). The output returns the button
status and then releases them immediately.

### New default value of the protected fields

|name        |type     |C|description        |default         |
|------------|:-------:|-|-------------------|:--------------:|
|FDescription|PChar    | |Short description  |short text      |
|FHasGUI     |Boolean  | |Has UI             |true            |
|FPortMode   |TPortMode| |Port operation mode|pmReadOnly      |
|FModName    |PChar    | |Module name        |short text      |

**Note**:  
- _C_: means 'constant'.

### Own protected methods

|name                             |V|A|O|description       |
|---------------------------------|-|-|-|------------------|
|`procedure AllRelease(mx: byte);`| | | |Release all button|

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.

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
