# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TNULLPort from TIOPort class in ioport_null unit

Class TNULLPort is an I/O port that implements an empty or dummy peripheral
derived from the TIOPort abstract base class, and is primarily used for testing
purposes. It returns a constant `00h` to read operations.

### UML diagram

![Class diagram](../diagrams/_png/ioport.png "IOPort plugin class diagram")

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
|FDescription|PChar|     |Short description|       |
|FModName    |PChar|     |Module name      |       |

### Public methods

|name                                           |flags|description                               |
|-----------------------------------------------|-----|------------------------------------------|
|`constructor Create;`                          |Or   |Sets the initial values for the new object|
|`destructor Destroy;`                          |Or   |Frees the object's resources              |
|`function ReadPort(Port: Byte): Byte;`         |Or   |Read virtual port                         |
|`procedure Reset;`                             |Or   |Reset virtual port                        |
|`procedure WritePort(Port: Byte; Value: Byte);`|Or   |Write virtual port                        |

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                    |exported name |description |
|----------------------------------------|--------------|------------|
|`function CreatePort: TIOPort;`         |ioport_create |Create port |
|`procedure DestroyPort(Port: TIOPort));`|ioport_destroy|Destroy port|
