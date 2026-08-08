# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TCommandEngine from commandengine unit

`TCommandEngine` is the command execution engine. It tokenizes command lines, resolves command names through a command registry, creates command objects, executes them in the current running mode, executes associated actions and stores the resulting exit code.

### Protected fields

|name|type|description|
|---|---|---|
|`FActionList`|`TActionList`|Optional action list used by `ExecuteAction`.|
|`FContext`|`TCommandContext`|Command execution context created by the constructor.|
|`FExitRequested`|`Boolean`|Exit state received from the most recently executed command.|
|`FLastExitCode`|`Integer`|Exit code returned by the most recently executed command-line operation.|
|`FParser`|`TCommandParser`|Command parser created by the constructor.|
|`FRegistry`|`TCommandRegistry`|Command registry used for command lookup.|
|`FRunningMode`|`TCommandScope`|Current execution mode.|

### Public methods

|name|flags|description|
|---|:---:|---|
|`constructor Create;`|Vi|Creates the command context and command parser.|
|`destructor Destroy;`|Or|Frees the command context and parser.|
|`function ExecuteAction(const AName: string): Boolean;`|Vi|Searches the assigned action list for an action with the specified name and executes it.|
|`function ExecuteLine(const ALine: string): Integer;`|Vi|Processes and executes one command line.|

### Public properties

|name|type|access|description|
|---|---|---|---|
|`ExitRequested`|`Boolean`|read|Exit state set by the executed command.|
|`ActionList`|`TActionList`|read/write|Action list used for post-command actions.|
|`Registry`|`TCommandRegistry`|read/write|Registry used to resolve command names.|
|`LastExitCode`|`Integer`|read|Result of the last `ExecuteLine` call.|
|`RunningMode`|`TCommandScope`|read/write|Current command execution mode.|

### ExecuteLine result codes

|code|condition|
|---:|---|
|`0`|Empty/comment line, no tokens, or successful command execution with return value `0`.|
|`-1`|Command name is not registered.|
|`-2`|The command is not permitted in the current running mode.|
|other|Return value supplied by the command's `Execute` method.|

An empty line or a line whose first character is `#` is ignored. The parser is used to create a token list, and the first token is interpreted as the command name.

The constructor creates `FContext` and `FParser`, but the source does not initialize `FActionList`, `FRegistry`, `FExitRequested`, `FLastExitCode` or `FRunningMode`. These fields therefore retain their language/runtime initialization state unless assigned elsewhere.
