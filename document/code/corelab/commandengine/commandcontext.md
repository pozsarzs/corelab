# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCommandContext from commandcontext unit

`TCommandContext` is the base context object used by the command engine to store named constants and variables and to provide command output. Values are stored in a dictionary using case-insensitive keys.

### TContextValue

`TContextValue` is a record containing:

|field|type|description|
|---|---|---|
|`RawValue`|`string`|Stored textual value.|
|`IsReadOnly`|`Boolean`|Indicates whether the stored value is a constant.|

### Protected fields

|name|type|description|default|
|---|---|---|---|
|`FOutput`|`TStrings`|Optional output object.|`nil`|
|`FVariables`|`TContextDict`|Dictionary containing constants and variables.|new dictionary|

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Vi|Creates the context and its value dictionary.|
|`destructor Destroy;`|Or|Frees the value dictionary and destroys the object.|
|`function GetConst(const AName: string): string;`|Vi|Intended to retrieve a named constant. The current implementation has no executable statement and therefore does not assign a return value.|
|`function GetVar(const AName: string): string;`|Vi|Intended to retrieve a named variable. The current implementation has no executable statement and therefore does not assign a return value.|
|`function SetConst(const AName, AValue: string): Boolean;`|Vi|Stores a value as read-only when `AName` is not empty. The current implementation does not explicitly assign the Boolean result.|
|`function SetVar(const AName, AValue: string): Boolean;`|Vi|Stores a value as writable when `AName` is not empty. The current implementation does not explicitly assign the Boolean result.|
|`procedure Clear;`|Vi|Removes all constants and variables.|
|`procedure WriteOutput(const AText: string);`| |Writes text to the assigned output object, or to standard output when no output object is assigned.|

### Public properties

|name|type|access|description|
|---|---|---|---|
|`Output`|`TStrings`|read/write|Output object used by `WriteOutput`.|

### Value storage

Both `SetConst` and `SetVar` convert the supplied name to lowercase before storing it. A constant is stored with `IsReadOnly = True`; a variable is stored with `IsReadOnly = False`.

The current implementation does not provide a separate storage dictionary for constants and variables.
