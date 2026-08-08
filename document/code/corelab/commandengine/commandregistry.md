# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCommandRegistry from commandregistry unit

`TCommandRegistry` stores the relationship between command names and their `TCommand` descendant classes. Names are normalized to lowercase, making command lookup case-insensitive.

### Type definitions

|name|description|
|---|---|
|`TCommandClass`|Class-reference type for `TCommand` descendants.|
|`TCommandDict`|Dictionary mapping `string` command names to `TCommandClass` references.|

### Protected fields

|name|type|description|
|---|---|---|
|`FCommands`|`TCommandDict`|Dictionary containing registered command classes.|

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Vi|Creates the command dictionary.|
|`destructor Destroy;`|Or|Frees the command dictionary.|
|`function TryGetCommand(const AName: string; var ACommandClass: TCommandClass): Boolean;`|Vi|Looks up a command class by name.|
|`procedure RegisterCommand(const AName: string; ACommandClass: TCommandClass);`|Vi|Registers or replaces a command class under the specified name.|

### Registration rules

`RegisterCommand` ignores an empty name and a `nil` command class. Valid names are converted to lowercase before insertion. Existing entries are replaced by `AddOrSetValue`.

`TryGetCommand` also converts the requested name to lowercase. If the name is not found, it sets `ACommandClass` to `nil` and returns `False`.
