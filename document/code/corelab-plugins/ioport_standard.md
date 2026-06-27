# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TStandardPort class

TStandardPort is a module implementing general-purpose input and output
operations from the TIOPort abstract base class. It has its own graphical
interface, which in a simple window provides the possibility to display the
(output) values sent to the port in hexadecimal format, as well as to manually
specify the (input) values​to be read from it.

### New default value of the protected fields

|name          |type   |C|description                  |default            |
|--------------|:-----:|-|-----------------------------|:-----------------:|
|FDescription  |PChar  | |Short description            |short text         |
|FHasGUI       |Boolean| |Has UI                       |true               |
|FLatchedOutput|Boolean| |Storing value written to port|true               |
|FModName      |PChar  | |Module name                  |'Standard I/O port'|

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
