# CoreLAB - Help

## 7. Settings

The Settings dialog allows you to customize the visual appearance of the application. The program automatically saves the size and position of all windows, as well as the column widths of the internal loggers and viewers. These configurations are stored in an INI file within your user profile directory.

### 7.1 Configurable Colors

You can modify the background and font colors for several internal modules to suit your preferences:

- **SysConsole:** General background and font colors.
- **ScriptConsole:** General background and font colors.
- **ScriptEditor:** Background, font, and line number gutter font colors. You can also toggle the visibility of line numbers and syntax highlighting.
- **HexViewer:** Colors for address, data, line selector, and alternating row backgrounds (odd/even).
- **RunLogger:** Colors for instruction count, address, opcode, mnemonic, cycles, total cycles, line selector, and alternating row backgrounds.
- **BusLogger:** Colors for operation, device, absolute address, relative address, data, status, line selector, and alternating row backgrounds.
- **IntLogger:** Colors for sender, interrupt vector, status, flags, line selector, and alternating row backgrounds.

Modifications to these color settings are applied immediately upon closing the Settings dialog with the OK button.

### 7.2 Automatically Saved Properties

The application automatically remembers the layout and state of the workspace upon exit, so you don't have to manually arrange the windows every time you start CoreLAB. The following properties are saved:

- **Main Window:** Position (top, left), size (width, height), and the splitter position.
- **Internal Windows:** The position and size of the BreakPoint Manager, HexViewer, IntLogger, Module Explorer, Module Properties, RegViewer, RunLogger, ScriptConsole, ScriptEditor, and SysConsole.
- **Table Columns:** The widths of individual columns in the BusLogger, IntLogger, Module Explorer, Module Properties, RegViewer, and RunLogger.
- **Visibility:** The open/closed state of the Module Explorer window.

### 7.3 Configuration File Location

The application stores the settings in a `corelab.ini` file. Its location depends on the operating system:

- **Windows:** `<UserDirectory>\Appdata\Local\corelab\corelab.ini`
- **Linux / FreeBSD:** `<UserDirectory>/.config/corelab/corelab.ini`

If the configuration file is missing or cannot be loaded, the application uses default values.
