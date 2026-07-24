# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## TCommandRegistry base class

TCommandRegistry is a base class that registers CoreLAB commands, which maps the
names of the commands to the classes that implement them (TCommandClass) in a
dictionary (TCommandDict).

### Own data types

|name         |type                                         |description                                    |
|-------------|---------------------------------------------|-----------------------------------------------|
|TCommandClass|class of TCommand                            |Class-reference type for registration          |
|TCommandDict |specialize TDictionary<string, TCommandClass>|Dictionary with command name and class elements|

### Protected fields

|name     |type        |C|description                         |default|
|---------|------------|-|------------------------------------|:-----:|
|FCommands|TCommandDict| |Dictionary of commands (name, class)|       |

**Note**:  
- _C_: means 'constant'.

### Public methods

|name                                                                                    |V|A|O|description                                                               |
|----------------------------------------------------------------------------------------|-|-|-|--------------------------------------------------------------------------|
|`constructor Create;`                                                                   |x| | |Sets the initial values for the new object                                |
|`destructor Destroy;`                                                                   |x| | |Frees the object's resources                                              |
|`function TryGetCommand(const AName: string; var ACommandClass: TCommandClass): Boolean`|x| | |Attempts to retrieve a registered command class by its name               |
|`procedure RegisterCommand(const AName: string; ACommandClass: TCommandClass);`         | | |x|Adds a new command name and its associated class reference to the registry|

**Note**:  
- _V_: means 'virtual' method,
- _A_: means 'abstract' method,
- _O_: means 'override' method.
