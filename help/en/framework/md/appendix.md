# CoreLAB - Help

## 9. Appendix

### 9.1 File Formats

| Extension / Pattern | Purpose |
|---|---|
| `*.bin` | General binary file. |
| `*.clprj` | CoreLAB project file. |
| `*.clpst` | CoreLAB plugin status file. |
| `*.clsce` | CoreLAB scriptembly (script) file. |
| `*.clsht` | CoreLAB snapshot file. |
| `*.hex` | Intel hexa file. |
| `*.log` | General log file. |

### 9.2 Keyboard Shortcuts

| Shortcut | Description |
|:-:|---|
| Ctrl-1 | Switch to interactive mode |
| Ctrl-2 | Switch to script mode |
| Ctrl-N | New project |
| Ctrl-O | Load project... |
| Ctrl-S | Save project |
| Ctrl-D | Change work directory |
| Ctrl-P | Settings... |
| F11 | Show Module Explorer... |
| Ctrl-B | Show Breakpoint Manager... |
| Ctrl-B | Show BusLogger... |
| Ctrl-R | Show RunLogger... |
| Ctrl-I | Show IntLogger... |
| Shift-F4 | Show ScriptEditor... |
| Shift-F12 | Show ScriptConsole... |
| F9 | Run |
| F8 | Step |
| F10 | Stop |
| F2 | Make snapshot |
| F3 | Restore snapshot... |
| Ctrl-Shift-N | New script |
| Ctrl-Shift-O | Load script... |
| Ctrl-Shift-S | Save script |
| Shift-F9 | Run script |
| Shift-F8 | Step script |
| Shift-F10 | Stop script |
| F1 | Help |

*Note: Menu commands can also be accessed quickly using standard `Alt` key combinations (e.g., Alt-F for File menu). Additional shortcuts may depend on the operating system.*

### 9.3 Glossary

- **CoreLAB:** Modular Processor Simulation Framework designed for the functional simulation of classic 8-bit microprocessors and microcontrollers.
- **Module/Plugin:** A dynamically loadable software component representing a virtual CPU, memory block, or I/O device (e.g., virtual LED array, switch matrix).
- **Scriptembly:** The custom scripting language used by CoreLAB (`.clsce` files) to automate testing, build topologies, and manipulate registers via the command-line shell.
- **System Bus:** The virtual communication bus that connects the instantiated processor, memory, and I/O modules, enabling data exchange.
- **Snapshot:** A saved execution state of the simulation (`.clsht` file) that can be restored later.
- **Module Explorer:** A built-in graphical tool used to manage and view the hierarchical list of active module instances.

### 9.4 Version History

- **v0.1.0:** First developer test release. Functional processor simulator framework with script engine, plugin support, and basic diagnostic tools.
