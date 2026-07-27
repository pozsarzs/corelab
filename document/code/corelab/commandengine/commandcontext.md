# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandContext base class in CommandContext unit

TCommandContext is the base class that provides the context for executing
commands. It manages the variables and constants used during the simulator's
execution (TContextDict), as well as the text output buffer (FOutput).

### UML diagram

![Class diagram](../diagrams/_png/commandengine.png "CoreLAB CommandEngine class diagram")

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

|name         |type                                         |description                                            |
|-------------|---------------------------------------------|-------------------------------------------------------|
|TContextValue|record                                       |It storing the value and RO state of a context variable|
|.RawValue    |string                                       |The string representation of the value                 |
|.IsReadOnly  |Boolean                                      |Indicates if the value is read-only (constant)         |
|TContextDict |specialize TDictionary<string, TContextValue>|Dictionary storing context variables by their names    |

### Protected fields

|name      |type        |flags|description                                              |default|
|----------|------------|:---:|---------------------------------------------------------|-------|
|FOutput   |TStrings    |     |Buffer for command execution output strings              |       |
|FVariables|TContextDict|     |Dictionary containing the context variables and constants|       |


### Public properties

|name  |type    |flags |description|default|
|------|--------|:----:|-----------|-------|
|Output|TStrings|Re, Wr|= FOutput  |       |

### Public methods

|name                                                      |flags|description                                       |
|----------------------------------------------------------|:---:|--------------------------------------------------|
|`constructor Create;`                                     |Vi   |Sets the initial values for the new object        |
|`destructor Destroy;`                                     |Or   |x|Frees the object's resources                    |
|`function GetConst(const AName: string): string;`         |Vi   |Retrieves the value of a constant by its name     |
|`function GetVar(const AName: string): string;`           |Vi   |Retrieves the value of a variable by its name     |
|`function SetConst(const AName, AValue: string): Boolean;`|Vi   |Sets a new constant or updates its value          |
|`function SetVar(const AName, AValue: string): Boolean;`  |Vi   |Sets a new variable or updates its value          |
|`procedure Clear;`                                        |Vi   |Clears all context variables and the output buffer|
|`procedure WriteOutput(const AText: string);`             |Vi   |Appends a text string to the output buffer        |
