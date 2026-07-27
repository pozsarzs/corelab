> [!NOTE]
> This documentation does not include fields and methods created by the IDE.
>

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TForm4 from TForm class in frmSizePos unit

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

### Private methods

|name                                       |flags|description|
|-------------------------------------------|:---:|-----------|
|`function GetLeftValue: Integer;`          |     |           |
|`function GetHeightValue: Integer;`        |     |           |
|`function GetTopValue: Integer;`           |     |           |
|`function GetWidthValue: Integer;`         |     |           |
|`procedure SetLeftValue(Value: Integer);`  |     |           |
|`procedure SetHeightValue(Value: Integer);`|     |           |
|`procedure SetTopValue(Value: Integer);`   |     |           |
|`procedure SetWidthValue(Value: Integer);` |     |           |

### Public properties

|name       |type   |flags |description                      |default|
|-----------|-------|:----:|---------------------------------|-------|
|PanelLeft  |Integer|Re, Wr|= GetLeftValue / SetLeftValue    |       |
|PanelHeight|Integer|Re, Wr|= GetHeightValue / SetHeightValue|       |
|PanelTop   |Integer|Re, Wr|= GetTopValue / SetTopValue      |       |
|PanelWidth |Integer|Re, Wr|= GetWidthValue /SetWidthValue   |       |
