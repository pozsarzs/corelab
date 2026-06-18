# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TIOPort base class

### Public properties

|name            |type     |description                            |
|----------------|---------|---------------------------------------|
|AddressRangeSize|byte     |Address range size                     |
|Description     |PChar    |Short description                      |
|Enabled         |boolean  |Enable port without detach from bus    |
|HasGUI          |boolean  |Does the implementation have a GUI?    |
|LatchedOutput   |boolean  |Latched output                         |
|Modname         |PChar    |Module name                            |
|OutNegation     |boolean  |Negation of matrix output bits         |
|PortMode        |TPortMode|Port operation mode                    |
|ReadBackOutput  |boolean  |Output port with read-back capability  |
|Response        |TResponse|Response type of the null device       |
|SelNegation     |boolean  |Negation of matrix selector bits       |
|Title           |PChar    |Form title                             |

### Public methods

|name                                           |description                                |
|-----------------------------------------------|-------------------------------------------|
|`constructor Create;`                          |Sets the initial values for the new object.|
|`destructor Destroy;`                          |Frees the object's resources.              |
|`function ReadPort(Port: byte): byte;`         |Read virtual port.                         |
|`procedure Reset;`                             |Reset virtual port.                        |
|`procedure WritePort(Port: byte; Value: byte);`|Write virtual port.                        |
