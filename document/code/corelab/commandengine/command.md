# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommand base class in Command unit

TCommand is the abstract base class for executable commands. It defines the basic
properties necessary for commands to work, such as checking the number of
parameters, the execution scope (TCommandScope), and the abstract interface
required to run the instruction.

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

|name         |type                                           |description       |
|-------------|-----------------------------------------------|------------------|
|TCommandScope|(csEverywhere, csScriptOnly, csInteractiveOnly)|Command scope type|

### Protected fields

|name          |type         |flags|description                                                |default|
|--------------|-------------|:---:|-----------------------------------------------------------|-------|
|FActionName   |string       |     |Internal action name of the command                        |       |
|FExitRequested|Boolean      | |Indicates whether the command requested to terminate the engine|       |
|FMinParamCount|Byte         | |Minimum number of required parameters                          |       |
|FMaxParamCount|Byte         | |Maximum number of allowed parameters                           |       |
|FParamCount   |Byte         | |Actual number of parameters passed                             |       |
|FCommandScope |TCommandScope| |Permitted execution scope for the command                      |       |

### Public properties

|name         |type         |flags |description                    |default|
|-------------|-------------|:----:|-------------------------------|-------|
|ActionName   |string       |Re    |= FActionName                  |       |
|CommandScope |TCommandScope|Re    |= FCommandScope                |       |
|ExitRequested|Boolean      |Re    |= read FExitRequested          |       |
|MinParamCount|Byte         |Re    |= FMinParamCount               |       |
|MaxParamCount|Byte         |Re    |= FMaxParamCount               |       |
|ParamCount   |Byte         |Re, Wr|x|= FParamCount / SetParamCount|       |

### Public methods

|name                                                                       |flags |description                                                             |
|---------------------------------------------------------------------------|:----:|------------------------------------------------------------------------|
|`constructor Create;`                                                      |Vi    |Sets the initial values for the new object                              |
|`destructor Destroy;`                                                      |Or    |Frees the object's resources                                            |
|`function Execute(Tokens: TTokenList; AContext: TCommandContext): Integer;`|Vi, Ab|Executes the command using the provided token list and execution context|
|`procedure SetParamCount(ACount: Byte);`                                   |      |Sets the actual number of parameters provided to the command            |
