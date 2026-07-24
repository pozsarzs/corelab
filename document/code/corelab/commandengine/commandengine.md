# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandEngine base class

TCommandEngine is the base class for the command interpreter and execution of
CoreLAB. Its task is to parse input command lines, find and execute registered
actions in the specified context and execution mode. It plays a central role in
the interactive control of the simulator and the processing of instructions.

### Protected fields

|name          |type            |C|description                       |default|
|--------------|----------------|-|----------------------------------|:-----:|
|FActionList   |TActionList     | |External TActionList object       |       |
|FContext      |TCommandContext | |TCommandContex object             |       |
|FExitRequested|Boolean         | |Request to end program execution  |       |
|FLastExitCode |Integer         | |The last command is the exit value|       |
|FParser       |TCommandParser  | |TCommandParser instance           |       |
|FRegistry     |TCommandRegistry| |External TCommandRegistry object  |       |
|FRunningMode  |TCommandScope   | |Application running mode          |       |
 
**Note**:  
- _C_: means 'constant'.

### Public properties

|name         |type            |R|W|description      |default|
|-------------|----------------|-|-|-----------------|-------|
|ExitRequested|Boolean         |x| |= FExitRequested|       |
|ActionList   |TActionList     |x|x|= FActionList   |       |
|Registry     |TCommandRegistry|x|x|= FRegistry     |       |
|LastExitCode |Integer         |x| |= FLastExitCode |       |
|RunningMode  |TCommandScope   |x|x|= FRunningMode  |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                   |V|A|O|description                                                |
|-------------------------------------------------------|-|-|-|-----------------------------------------------------------|
|`constructor Create;`                                  |x| | |Sets the initial values for the new object                 |
|`destructor Destroy;`                                  |x| | |Frees the object's resources                               |
|`function ExecuteAction(const AName: string): Boolean;`|x| | |Executes the action specified by AName                     |
|`function ExecuteLine(const ALine: string): Integer;`  | | |x|Parses and executes a command line and returns an exit code|

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
