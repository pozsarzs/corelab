# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandEngine base class in CommandEngine unit

TCommandEngine is the base class for the command interpreter and execution of
CoreLAB. Its task is to parse input command lines, find and execute registered
actions in the specified context and execution mode. It plays a central role in
the interactive control of the simulator and the processing of instructions.

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

### Protected fields

|name          |type            |flags|description                       |default|
|--------------|----------------|:---:|----------------------------------|-------|
|FActionList   |TActionList     |     |External TActionList object       |       |
|FContext      |TCommandContext |     |TCommandContex object             |       |
|FExitRequested|Boolean         |     |Request to end program execution  |       |
|FLastExitCode |Integer         |     |The last command is the exit value|       |
|FParser       |TCommandParser  |     |TCommandParser instance           |       |
|FRegistry     |TCommandRegistry|     |External TCommandRegistry object  |       |
|FRunningMode  |TCommandScope   |     |Application running mode          |       |

### Public properties

|name         |type            |flags |description     |default|
|-------------|----------------|:----:|----------------|-------|
|ExitRequested|Boolean         |Re    |= FExitRequested|       |
|ActionList   |TActionList     |Re, Wr|= FActionList   |       |
|Registry     |TCommandRegistry|Re, Wr|= FRegistry     |       |
|LastExitCode |Integer         |Re    |= FLastExitCode |       |
|RunningMode  |TCommandScope   |Re, Wr|= FRunningMode  |       |

### Public methods

|name                                                   |flags|description                                                |
|-------------------------------------------------------|:---:|-----------------------------------------------------------|
|`constructor Create;`                                  |Vi   |Sets the initial values for the new object                 |
|`destructor Destroy;`                                  |Vi   |Frees the object's resources                               |
|`function ExecuteAction(const AName: string): Boolean;`|Vi   |Executes the action specified by AName                     |
|`function ExecuteLine(const ALine: string): Integer;`  |Or   |Parses and executes a command line and returns an exit code|
