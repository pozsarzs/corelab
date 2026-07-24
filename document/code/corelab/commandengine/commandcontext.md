# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandContext base class

TCommandContext is the base class that provides the context for executing
commands. It manages the variables and constants used during the simulator's
execution (TContextDict), as well as the text output buffer (FOutput).

### Own data types

|name         |type                                         |description                                            |
|-------------|---------------------------------------------|-------------------------------------------------------|
|TContextValue|record                                       |It storing the value and RO state of a context variable|
|.RawValue    |string                                       |The string representation of the value                 |
|.IsReadOnly  |Boolean                                      |Indicates if the value is read-only (constant)         |
|TContextDict |specialize TDictionary<string, TContextValue>|Dictionary storing context variables by their names    |

### Protected fields

|name      |type        |C|description                                              |default|
|----------|------------|-|---------------------------------------------------------|:-----:|
|FOutput   |TStrings    | |Buffer for command execution output strings              |       |
|FVariables|TContextDict| |Dictionary containing the context variables and constants|       |

**Note**:  
- _C_: means 'constant'.

### Public properties

|name  |type    |R|W|description|default|
|------|--------|-|-|-----------|-------|
|Output|TStrings|x|x|= FOutput  |       |

**Note**:  
- _R_: means 'read',
- _W_: means 'write'.

### Public methods

|name                                                      |V|A|O|description                                       |
|----------------------------------------------------------|-|-|-|--------------------------------------------------|
|`constructor Create;`                                     |x| | |Sets the initial values for the new object        |
|`destructor Destroy;`                                     | | |x|Frees the object's resources                      |
|`function GetConst(const AName: string): string;`         |x| | |Retrieves the value of a constant by its name     |
|`function GetVar(const AName: string): string;`           |x| | |Retrieves the value of a variable by its name     |
|`function SetConst(const AName, AValue: string): Boolean;`|x| | |Sets a new constant or updates its value          |
|`function SetVar(const AName, AValue: string): Boolean;`  |x| | |Sets a new variable or updates its value          |
|`procedure Clear;`                                        |x| | |Clears all context variables and the output buffer|
|`procedure WriteOutput(const AText: string);`             |x| | |Appends a text string to the output buffer        |

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
