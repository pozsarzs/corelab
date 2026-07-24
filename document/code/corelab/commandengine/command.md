# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommand base class

TCommand is the abstract base class for executable commands. It defines the basic
properties necessary for commands to work, such as checking the number of
parameters, the execution scope (TCommandScope), and the abstract interface
required to run the instruction.

### Own data types

|name         |type                                           |description       |
|-------------|-----------------------------------------------|------------------|
|TCommandScope|(csEverywhere, csScriptOnly, csInteractiveOnly)|Command scope type|

### Protected fields

|name          |type         |C|description                                                    |default|
|--------------|-------------|-|---------------------------------------------------------------|:-----:|
|FActionName   |string       | |Internal action name of the command                            |       |
|FExitRequested|Boolean      | |Indicates whether the command requested to terminate the engine|       |
|FMinParamCount|Byte         | |Minimum number of required parameters                          |       |
|FMaxParamCount|Byte         | |Maximum number of allowed parameters                           |       |
|FParamCount   |Byte         | |Actual number of parameters passed                             |       |
|FCommandScope |TCommandScope| |Permitted execution scope for the command                      |       |

**Note**:  
- _C_: means 'constant'.

### Public properties

|name         |type         |R|W|description                |default|
|-------------|-------------|-|-|---------------------------|-------|
|ActionName   |string       |x| |= FActionName              |       |
|CommandScope |TCommandScope|x| |= FCommandScope            |       |
|ExitRequested|Boolean      |x| |= read FExitRequested      |       |
|MinParamCount|Byte         |x| |= FMinParamCount           |       |
|MaxParamCount|Byte         |x| |= FMaxParamCount           |       |
|ParamCount   |Byte         |x|x|= FParamCount/SetParamCount|       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                                       |V|A|O|description                                                             |
|---------------------------------------------------------------------------|-|-|-|------------------------------------------------------------------------|
|`constructor Create;`                                                      |x| | |Sets the initial values for the new object                              |
|`destructor Destroy;`                                                      | | |x|Frees the object's resources                                            |
|`function Execute(Tokens: TTokenList; AContext: TCommandContext): Integer;`|x|x| |Executes the command using the provided token list and execution context|
|`procedure SetParamCount(ACount: Byte);`                                   | | | |Sets the actual number of parameters provided to the command            |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
