# CoreLAB - Help

## 3. User Interface

### 3.1 Main Window

The main window of the CoreLAB framework provides a centralized environment for managing the simulation workspace. It consists of the following main sections:

- **Menu bar:** Provides access to all application commands, views, and settings.
- **Toolbars:** Context-sensitive toolbars that offer quick access to frequently used commands. Their availability changes depending on the selected operation mode (Interactive or Script) and the active tab.
- **Run Delay Selector:** A dropdown box used to configure the run delay between execution steps in milliseconds (e.g., 1000 ms).
- **Tabbed Control Panel:** Organizes module management and execution tasks into five distinct tabs:
  - **Operation:** Contains controls for running, stepping, stopping, and resetting the overall simulation, as well as triggering NMI (Non-Maskable Interrupts).
  - **Processor:** Provides tools to create, configure, enable, disable, and attach/detach CPU modules to the system bus.
  - **Memory:** Used for managing memory modules, altering their properties, and loading/saving memory contents (Binary or Intel HEX formats).
  - **I/O port:** Manages input/output ports and virtual devices. It also handles the configuration of their interactive graphical panels.
  - **Script:** Dedicated controls for creating, loading, saving, and executing custom scripts when the framework is in Script mode.
- **System Console (SysConsole):** Located at the bottom of the main window. It serves as an interactive command-line interface and displays system messages, command feedback, and warnings.

### 3.2 Integrated Viewer and Logger Windows

CoreLAB includes several integrated visual modules to inspect the internal state of the simulated hardware and monitor execution. These can be launched as separate windows:

| Module | Description |
|---|---|
| **Module Explorer** | Used for managing and viewing all instantiated CPU, memory, and I/O port modules in a structured tree view. |
| **Breakpoint Manager** | A tool for managing execution breakpoints to halt the simulation at specific conditions or addresses. |
| **HexViewer** | A memory viewer component that allows real-time inspection of a selected memory module's data. |
| **RegViewer** | Displays real-time information about the internal registers and flags of the attached processor. |
| **RunLogger** | Provides real-time output of the executed instructions, including address, machine code, and assembly mnemonic. |
| **BusLogger** | Logs data, address, and control signals passing through the system bus (MEMRD, MEMWR, IORD, IOWR). |
| **IntLogger** | Keeps a log of hardware interrupt requests triggered by connected I/O modules. |
| **ScriptEditor** | A built-in text editor environment for writing, editing, and managing custom control scripts. |
| **ScriptConsole** | A dedicated output console displaying the results and custom text messages from a running script. |

### 3.3 Interactive I/O Panels

Certain virtual I/O modules (like displays, switches, or LED arrays) feature interactive graphical panels. These panels can be moved, resized, renamed, and toggled (hidden/shown) directly via the **I/O port** tab or the **View** menu to customize the virtual hardware workspace according to your needs.
