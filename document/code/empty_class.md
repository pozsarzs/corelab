# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## ... base class in ... unit

## ... from ... class in ... unit

(...)

### UML diagram

![Alternate Text](image_path "Optional tooltip title")

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

### Own data types

|name|type|description|
|----|----|-----------|
|    |    |           |

### Own interfaces

|name|description|
|----|-----------|
|    |           |

### Protected fields

|name|type|flags|description|default|
|----|----|:---:|-----------|-------|
|    |    |     |           |       |

### Protected methods

|name |flags|description|
|-----|:---:|-----------|
|` `  |     |           |

### Public properties

|name|type|flags|description|default|
|----|----|:---:|-----------|-------|
|    |    |     |=          |       |

### Public methods

|name                 |flags|description                               |
|---------------------|:---:|------------------------------------------|
|`constructor Create;`|Vi   |Sets the initial values for the new object|
|`destructor Destroy;`|Or   |Frees the object's resources              |

### Exported functions and procedures

**Calling mode:**  

- on Windows: `stdcall`,
- on Unix-like OS: `cdecl`.

|name                                    |exported name |description |
|----------------------------------------|--------------|------------|
|`function CreatePort: TIOPort;`         |ioport_create |Create port |
|`procedure DestroyPort(Port: TIOPort));`|ioport_destroy|Destroy port|
