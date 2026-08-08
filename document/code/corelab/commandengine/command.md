# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCommand from command unit

`TCommand` is the abstract base class for commands executed by the command engine. It stores the command action name, parameter-count limits, execution state and command scope. Descendant classes implement the abstract `Execute` method.

### Command scope

|value|description|
|---|---|
|`csEverywhere`|The command can be executed in any running mode.|
|`csScriptOnly`|The command is intended for script execution.|
|`csInteractiveOnly`|The command is intended for interactive execution.|

### Protected fields

|name|type|description|default|
|---|---|---|---|
|`FActionName`|`string`|Name of the action executed after the command.|`''`|
|`FExitRequested`|`Boolean`|Indicates whether command execution requests termination.|`False`|
|`FMinParamCount`|`Byte`|Minimum accepted parameter count.|`0`|
|`FMaxParamCount`|`Byte`|Maximum accepted parameter count.|`0`|
|`FParamCount`|`Byte`|Actual parameter count assigned by the engine.|`0`|
|`FCommandScope`|`TCommandScope`|Execution scope of the command.|`csEverywhere`|

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Vi|Initializes the command state and sets the default scope to `csEverywhere`.|
|`destructor Destroy;`|Or|Destroys the command object.|
|`function Execute(Tokens: TTokenList; AContext: TCommandContext): Integer;`|Vi|Abstract command operation implemented by descendants.|
|`procedure SetParamCount(ACount: Byte);`| |Sets the actual parameter count.|

### Public properties

|name|type|access|description|
|---|---|---|---|
|`ActionName`|`string`|read|Action name associated with the command.|
|`ExitRequested`|`Boolean`|read|Indicates whether execution requested an exit.|
|`MinParamCount`|`Byte`|read|Minimum parameter count.|
|`MaxParamCount`|`Byte`|read|Maximum parameter count.|
|`ParamCount`|`Byte`|read/write|Actual parameter count; the write operation is handled by `SetParamCount`.|
|`CommandScope`|`TCommandScope`|read|Execution scope.|

`SetParamCount` applies `EnsureRange(ACount, 0, 255)`, although `ACount` is already a `Byte`.
