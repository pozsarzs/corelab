# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TForm1 Main Form in frmmain unit

`TForm1` is the main CoreLAB application form. It manages the plugin directory and dynamically loads IOPort plugins as shared libraries. It creates and destroys plugin instances, reads and writes plugin port data, displays plugin properties, manages optional plugin GUI panels, connects interrupt callbacks, and saves or restores plugin state.

### Types

#### `TPluginAttributes`

|name|type|description|
|---|---|---|
|`PFilename`|`string`|filename of the module|
|`PAddressRangeSize`|`Byte`|address range size|
|`PDataInMode`|`TLineMode`|decoding input data lines|
|`PDataInNegation`|`Boolean`|negation of databit (port -> CPU)|
|`PDataOutMode`|`TLineMode`|decoding output data lines|
|`PDataOutNegation`|`Boolean`|negation of databit (CPU -> port)|
|`PDescription`|`string`|short description|
|`PEnabled`|`Boolean`|enable port without detach from bus|
|`PHasPanel`|`Boolean`|does the implementation have a GUI?|
|`PIntVector`|`Byte`|plugin interrupt vector|
|`PInstanceID`|`Integer`|Module instance ID|
|`PLatchedOutput`|`Boolean`|latched output|
|`PModname`|`string`|module name|
|`PReadBackOutput`|`Boolean`|output port with read-back capability|
|`PSelMode`|`TLineMode`|decoding matrix selector lines|
|`PSelNegation`|`Boolean`|negation of matrix selector bits|

#### `TOpDirection`

|value|description|
|---|---|
|`opPlugin2Var`|Transfer plugin properties to internal variables.|
|`opVar2List`|Transfer internal properties to the property list editor.|
|`opList2Var`|Transfer edited list values to internal variables.|
|`opVar2Plugin`|Transfer internal properties to the plugin.|

### Plugin entry-point procedural types

|name|signature|description|
|---|---|---|
|`TCreatePortFunc`|`function: TIOPort; CALLTYPE`|Plugin entry point type used by the main form.|
|`TDestroyPortProc`|`procedure(Port: TIOPort); CALLTYPE`|Plugin entry point type used by the main form.|
|`TCreatePanelProc`|`procedure(Port: TIOPort); CALLTYPE`|Plugin entry point type used by the main form.|
|`TShowPanelProc`|`procedure(Port: TIOPort); CALLTYPE`|Plugin entry point type used by the main form.|
|`THidePanelProc`|`procedure(Port: TIOPort); CALLTYPE`|Plugin entry point type used by the main form.|
|`TFreePanelProc`|`procedure(Port: TIOPort); CALLTYPE`|Plugin entry point type used by the main form.|
|`TRenamePanelProc`|`procedure(Port: TIOPort; Caption: PChar); CALLTYPE`|Plugin entry point type used by the main form.|
|`TResizePanelProc`|`function(Port: TIOPort; Width, Height: Integer): Boolean; CALLTYPE`|Plugin entry point type used by the main form.|
|`TMovePanelProc`|`function(Port: TIOPort; Left, Top: Integer): Boolean; CALLTYPE`|Plugin entry point type used by the main form.|
|`TSetIntHandler`|`procedure(Port: TIOPort; IntProc: TInterruptCallback; IntVector: Byte); CALLTYPE`|Plugin entry point type used by the main form.|
|`TLoadStateProc`|`function(Port: TIOPort; AStream: TStream): Boolean; CALLTYPE`|Plugin entry point type used by the main form.|
|`TSaveStateProc`|`function(Port: TIOPort; AStream: TStream): Boolean; CALLTYPE`|Plugin entry point type used by the main form.|

### Private fields

|name|type|description|
|---|---|---|
|`CurrentPort`|`TIOPort`|Currently instantiated plugin object.|
|`LibHandle`|`TLibHandle`|Handle of the currently loaded shared library.|
|`LoadedPlugin`|`TPluginAttributes`|Properties of the currently loaded plugin.|
|`CreatePort` ... `SaveState`|Plugin entry-point procedural types|Function and procedure pointers resolved from the loaded plugin.|
|`FIgnoreHelp`|`Boolean`|Controls suppression of help handling.|
|`FLoadCounter`|`Integer`|Counts successfully loaded plugins.|
|`FEXEDirectory`|`string`|Application executable directory.|
|`FPluginDirectory`|`string`|Current plugin directory.|
|`FSystemLanguage`|`string`|Detected system language.|
|`FUserDirectory`|`string`|Current user's directory.|

### Private methods

|name|description|
|---|---|
|`procedure ImpExpProperties(Direction: TOpDirection);`|Imports plugin properties into internal variables or exports them back to the plugin, depending on the direction.|
|`procedure InterruptHandler(Sender: TIOPort; Vector: Byte);`|Handles an interrupt request received from the loaded plugin.|
|`procedure RefreshProperties(Direction: TOpDirection);`|Transfers plugin property values between internal variables and the property list editor.|
|`procedure SetIgnoreHelp(AIgnoreHelp: Boolean);`|Sets the `IgnoreHelp` property value.|
|`procedure SetPluginDirectory(APluginDirectory: string);`|Sets the plugin directory used by the main form.|

### Public properties

|name|type|description|
|---|---|---|
|`IgnoreHelp`|`Boolean read FIgnoreHelp write SetIgnoreHelp`|Enables or disables help suppression.|
|`EXEDirectory`|`string read FEXEDirectory`|Returns the application executable directory.|
|`PluginDirectory`|`string read FPluginDirectory write SetPluginDirectory`|Returns or changes the plugin directory.|
|`SystemLanguage`|`string read FSystemLanguage`|Returns the detected system language.|
|`UserDirectory`|`string read FUserDirectory`|Returns the current user directory.|

### Event handler methods

|name|description|
|---|---|
|`procedure AboutExecute(Sender: TObject)`|Displays the About dialog.|
|`procedure FormCreate(Sender: TObject)`|Initializes plugin state, directories, UI controls and the plugin list.|
|`procedure FormDestroy(Sender: TObject)`|Releases the plugin panel and instance, unloads the shared library and clears entry-point references.|
|`procedure HelpExecute(Sender: TObject)`|Opens the CoreLAB help page for the main application.|
|`procedure LoadChangePluginExecute(Sender: TObject)`|Loads the selected plugin shared library, resolves its entry points, creates the plugin instance and optionally creates its GUI panel.|
|`procedure LoadStatusExecute(Sender: TObject)`|Loads plugin state data from a CoreLAB stream file.|
|`procedure MenuItem14Click(Sender: TObject)`|Handles the corresponding main-menu command.|
|`procedure MenuItem15Click(Sender: TObject)`|Handles the corresponding main-menu command.|
|`procedure MenuItem16Click(Sender: TObject)`|Handles the corresponding main-menu command.|
|`procedure MenuItem17Click(Sender: TObject)`|Handles the corresponding main-menu command.|
|`procedure MenuItem18Click(Sender: TObject)`|Handles the corresponding main-menu command.|
|`procedure QuitExecute(Sender: TObject)`|Terminates the application.|
|`procedure ReadAByteExecute(Sender: TObject)`|Reads a byte from the selected plugin port address and displays the result.|
|`procedure RefreshPluginListExecute(Sender: TObject)`|Refreshes the list of available plugin files.|
|`procedure RestartApplicationExecute(Sender: TObject)`|Starts a new instance of the application and terminates the current instance.|
|`procedure SaveStatusExecute(Sender: TObject)`|Saves plugin state data to a CoreLAB stream file.|
|`procedure SelectPluginDirectoryExecute(Sender: TObject)`|Selects the directory used for plugin files.|
|`procedure SetPluginWindowCaptionExecute(Sender: TObject)`|Displays the caption dialog and applies a new plugin panel caption.|
|`procedure SetPluginWindowSizePositionExecute(Sender: TObject)`|Displays the size/position dialog and applies new plugin panel dimensions and position.|
|`procedure ShowPluginWindowExecute(Sender: TObject)`|Shows the loaded plugin GUI panel when available.|
|`procedure Timer1Timer(Sender: TObject)`|Handles the timer event used by the main form status display.|
|`procedure ValueListEditor1EditingDone(Sender: TObject)`|Handles completion of editing in the plugin property list.|
|`procedure ValueListEditor2EditingDone(Sender: TObject)`|Handles completion of editing in the port data list.|
|`procedure WriteAByteExecute(Sender: TObject)`|Writes the entered byte value to the selected plugin port address.|

### Global variable

|name|type|description|
|---|---|---|
|`Form1`|`TForm1`|Global instance of the main form.|

### Plugin loading interface

The main form resolves the following exported plugin entry points from the loaded shared library:

|exported name|purpose|
|---|---|
|`ioport_create`|Create the plugin port object.|
|`ioport_destroy`|Destroy the plugin port object.|
|`ioport_createpanel`|Create the plugin GUI panel.|
|`ioport_freepanel`|Destroy the plugin GUI panel.|
|`ioport_showpanel`|Show the plugin GUI panel.|
|`ioport_hidepanel`|Hide the plugin GUI panel.|
|`ioport_renamepanel`|Change the plugin GUI panel caption.|
|`ioport_resizepanel`|Resize the plugin GUI panel.|
|`ioport_movepanel`|Move the plugin GUI panel.|
|`ioport_setinthandler`|Set the plugin interrupt callback and vector.|
|`ioport_loadstate`|Load plugin state from a stream.|
|`ioport_savestate`|Save plugin state to a stream.|
