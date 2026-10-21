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

### 9.4 External Editors and Syntax Highlighting

While CoreLAB includes a built-in ScriptEditor, you may prefer writing `.clsce` (Scriptembly) files in your favorite external text editor. To improve readability, the CoreLAB package provides syntax highlighting definition files for several popular editors.
Follow the instructions below to install the syntax highlighting file for your specific editor:

| Editor | File | Installation Path / Method |
|---|---|---|
| **GTKSourceView*** | `corelab.lang` | Copy to `~/.local/share/gtksourceview-?/language-specs/` |
| **MCEdit** | `Syntax` / `corelab.syntax` | Insert `Syntax` content to top of `~/.local/share/mc/Syntax`, then copy `corelab.syntax` to `~/.local/share/mc/Syntax/` |
| **Micro** | `corelab.yaml` | Copy to `~/.config/micro/syntax/` |
| **Nano** | `corelab.nanorc` | Copy to `/usr/share/nano/` |
| **Notepad++** | `corelab.xml` | Copy to `%USERPROFILE%\AppData\Roaming\Notepad++\userDefineLangs\` |
| **(Neo)Vim** | `corelab.vim` / `scripts.vim` | Copy `corelab.vim` to `~/.config/vim/syntax/` and insert `scripts.vim` content into `~/.config/vim/scripts.vim` |
| **Visual Studio Code** | `corelab-script` extension | Copy directory to `~/.vscode/extensions/` OR install the `.vsix` file from the application |

**Notes:**  

- ***GTKSourceView:** Applications using GtkSourceView include Builder, Geany, Gedit, Mousepad, Pluma, and Scribes. Note that the exact target directory might vary depending on the specific application and OS.
- **VSCode Marketplace:** The Visual Studio Code extension can also be installed directly from the Marketplace using this URL: [CoreLAB Script Extension](https://marketplace.visualstudio.com/items?itemName=pozsarzs.corelab-script)

### 9.5 Version History

- **v0.1.0:** First developer test release. Functional processor simulator framework with script engine, plugin support, and basic diagnostic tools.
