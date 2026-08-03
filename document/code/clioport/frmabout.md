> [!NOTE]
> This documentation does not include fields and methods created by the IDE.
>

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TForm2 from TForm class in frmAbout unit

(...)

### UML diagram

![Class diagram](../diagrams/_png/clioport.png "CLIOPort class diagram")

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

|name        |type      |description|
|------------|----------|-----------|
|TAboutLabels|record    |           |
|.Copyright  |string[32]|           |
|.Description|string[32]|           |
|.Email      |string[32]|           |
|.Homepage:  |string[32]|           |
|.Name:      |string[32]|           |
|.Version:   |string[32]|           |

### Public methods

|name                                              |flags|description                               |
|--------------------------------------------------|:---:|------------------------------------------|
|`procedure SetAboutLabels(aLabels: TAboutLabels);`|     |                                          |
