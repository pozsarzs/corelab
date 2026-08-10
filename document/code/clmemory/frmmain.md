# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## TForm1 from TForm class in frmmain unit

`TForm1` is the main application form for the CoreLAB standard-memory plugin manager. It searches for memory plugins, dynamically loads a selected plugin library, creates its `TMemory` instance, displays and edits its properties, provides direct byte read/write operations, and saves or restores plugin state.

### TPluginAttributes

`TPluginAttributes` stores the memory-plugin properties displayed and edited by the main form.

|field|type|description|
|---|---|---|
|`PFilename`|`string`|Filename of the loaded module.|
|`PAddressRangeSize`|`DWord`|Configured memory address range.|
|`PDataWidth`|`Byte`|Data width (4-64 bits).|
|`PDescription`|`string`|Short module description.|
|`PEnabled`|`Boolean`|Enables or disables memory access.|
|`PInstanceID`|`Integer`|Module instance identifier.|
|`PMemoryMode`|`TMemoryMode`|Memory operation mode, such as RAM or ROM.|
|`PModname`|`string`|Module name.|

### TOpDirection

|value|description|
|---|---|
|`opPlugin2Var`|Imports properties from the loaded plugin into `LoadedPlugin`.|
|`opVar2List`|Copies properties from `LoadedPlugin` to the property editor.|
|`opList2Var`|Reads editable values from the property editor into `LoadedPlugin`.|
|`opVar2Plugin`|Writes editable properties from `LoadedPlugin` to the plugin.|

### Plugin entry-point types

|type|signature|purpose|
|---|---|---|
|`TCreateMemoryFunc`|`function: TMemory`|Creates a memory-plugin instance.|
|`TDestroyMemoryProc`|`procedure(Memory: TMemory)`|Destroys a memory-plugin instance.|
|`TLoadStateProc`|`function(Memory: TMemory; AStream: TStream): Boolean`|Loads plugin state.|
|`TSaveStateProc`|`function(Memory: TMemory; AStream: TStream): Boolean`|Saves plugin state.|

### Protected/private fields

|name|type|description|
|---|---|---|
|`CurrentMemory`|`TMemory`|Currently instantiated memory plugin.|
|`LibHandle`|`TLibHandle`|Handle of the dynamically loaded plugin library.|
|`LoadedPlugin`|`TPluginAttributes`|Cached plugin properties.|
|`CreateMemory`|`TCreateMemoryFunc`|Pointer to the `memory_create` entry point.|
|`DestroyMemory`|`TDestroyMemoryProc`|Pointer to the `memory_destroy` entry point.|
|`LoadState`|`TLoadStateProc`|Pointer to the `memory_loadstate` entry point.|
|`SaveState`|`TSaveStateProc`|Pointer to the `memory_savestate` entry point.|
|`FIgnoreHelp`|`Boolean`|Controls whether the help system is ignored.|
|`FLoadCounter`|`Integer`|Number of successfully loaded plugin instances.|
|`FEXEDirectory`|`string`|Application executable directory.|
|`FPluginDirectory`|`string`|Directory searched for memory plugins.|
|`FSystemLanguage`|`string`|Detected system language.|
|`FUserDirectory`|`string`|User directory.|

### Public properties

|name|type|access|description|
|---|---|---|---|
|`IgnoreHelp`|`Boolean`|read/write|Controls the help system configuration.|
|`EXEDirectory`|`string`|read|Application executable directory.|
|`PluginDirectory`|`string`|read/write|Current memory-plugin directory. Setting it refreshes the plugin list.|
|`SystemLanguage`|`string`|read|Detected system language.|
|`UserDirectory`|`string`|read|User directory.|

### Private methods

|name|description|
|---|---|
|`ImpExpProperties`|Imports plugin properties into `LoadedPlugin` or exports editable properties back to `CurrentMemory`.|
|`RefreshProperties`|Synchronizes `LoadedPlugin` with the property editor and parses edited values.|
|`SetIgnoreHelp`|Configures the CHM help file and LHelp viewer when help is enabled.|
|`SetPluginDirectory`|Stores the plugin directory, updates the directory control and refreshes the plugin list.|

### Main operations

|operation|description|
|---|---|
|Plugin discovery|Searches the selected directory for `memory_*.dll` on Windows or `libmemory_*.so` on Unix-like systems.|
|Plugin loading|Loads the selected library, resolves `memory_create`, `memory_destroy`, `memory_loadstate` and `memory_savestate`, and creates the memory object.|
|Property editing|Displays filename, module name, description, instance ID, enabled state, memory mode and address-range size. Only address range size is editable directly; the other displayed plugin properties are read-only or pick-list values.|
|Examine|Reads data from the hexadecimal address entered by the user and displays the result as a hexadecimal value.|
|Deposit|Writes a hexadecimal data to a hexadecimal address and reports out-of-range or ROM conditions.|
|State loading|Loads a `.clstm` stream file and passes it to the plugin's `memory_loadstate` entry point.|
|State saving|Passes a memory stream to the plugin's `memory_savestate` entry point and saves the resulting data as a `.clstm` file.|
|Restart|Starts a new instance of the application and terminates the current one.|
|Help|Opens `html/clmemory.htm` through the LCL help system.|

### Validation

|field|minimum|maximum|
|---|---:|---:|
|`AddressRangeSize`|16 B |16777216 B|
|`DataWidth`|4 b|64 b|

Invalid input is rejected and the previous value is restored.

### Visual components

The form contains the main menu, toolbar, action list, directory selector, plugin file list, property editors, status bar, timer, dialogs and help components required to operate the memory-plugin manager.

### Plugin lifecycle

1. The form initializes without a loaded memory object.
2. The plugin directory is initialized and scanned.
3. Selecting a plugin unloads the previous instance and library.
4. The selected library is dynamically loaded.
5. Required exported entry points are resolved.
6. `memory_create` creates the `TMemory` descendant.
7. Plugin properties are imported and displayed.
8. The memory object remains active until another plugin is loaded or the form is destroyed.
9. On destruction, the memory object is destroyed and the library handle and entry-point pointers are cleared.
