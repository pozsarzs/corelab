# CLProcessor – Help

## 1. Introduction

CLProcessor is a graphical application for loading and testing processor plugins in the CoreLAB framework. The loaded processor is connected to the test environment, where it can be run step by step or continuously.

### 1.1 Main Features

- Search for and load processor plugins.
- Display processor properties and registers.
- Load register values from the processor and write values back to it.
- Reset the processor.
- Issue NMI and IRQ interrupt requests.
- Run the processor program step by step or continuously.
- Log program execution.
- Examine, clear, load, and save memory contents.
- Use the test environment's standard I/O ports and ASCII console.
- Save and restore the processor state.

### 1.2 System Requirements

The application can be used on FreeBSD, Linux, and Windows.

## 2. User Interface

### 2.1 Main Window

The main window contains the controls for selecting and loading plugins, the processor properties and registers, and the commands for running the processor and managing the test environment.

### 2.2 Processor Properties

The properties list displays information and configuration characteristics of the loaded processor. The properties handled in the source code are:

| Property | Description |
|---|---|
| Filename | The filename of the loaded plugin. |
| Modname | The name of the processor plugin. |
| Description | A description of the plugin. |
| Architecture | The processor architecture. |
| Enabled | Whether the processor is enabled. |
| AddressWidth | The width of the processor's address bus. |
| Architecture | The processor architecture. |
| Endianness | The byte order used to store data. |
| HasSeparateIOBus | Whether the processor uses a separate I/O bus. |
| MaxCodeAddress | The maximum address of code memory. |
| MaxIOPortAddress | The maximum address of I/O ports. |
| MaxMemAddress | The maximum memory address. |

### 2.3 Register List

The register list displays the registers of the loaded processor and their current values. Register names and sizes depend on the processor plugin.

The values are displayed in hexadecimal format. The input field checks whether a value is hexadecimal and whether it fits within the size of the corresponding register.

### 2.4 Memory

The test environment's memory contents are managed in banks. According to the source, bank 0 is the code memory for Neumann and Harvard architecture processors, while bank 1 is the Harvard data memory.

The memory size is defined in the program by the `MEM_SIZE` constant.

### 2.5 Status Bar

The status bar displays the load sequence number, the name of the selected plugin, and brief feedback about operations.

## 3. Using the Application

### 3.1 Selecting the Plugin Directory

1. Select the **Select plugin directory** command.
2. Select the directory containing the processor plugins.
3. The file list is refreshed.

The **Refresh plugin list** command rereads the contents of the current directory.

### 3.2 Loading or Changing a Processor

1. Select the desired processor plugin in the file list.
2. Run the **Load/change plugin** command.
3. If loading succeeds, the processor instance is created and connected to the test bus. The properties and register lists are then updated.

### 3.3 Loading Register Values from the Processor

The **Load register values from CPU** command refreshes the register list with the processor's current values.

### 3.4 Writing Register Values to the Processor

1. Modify the desired register value in the register list.
2. Select the **Save register values to CPU** command.
3. The program writes the displayed values back to the processor registers.

The value must be hexadecimal and must fit within the size of the corresponding register.

### 3.5 Resetting the Processor

The **Reset** command invokes the processor's reset operation and then refreshes the register list.

### 3.6 Interrupt Requests

- **NMI:** Sends a non-maskable interrupt request to the processor.
- **IRQ:** Sends an interrupt request to the processor using the interrupt vector specified in the main window.

The IRQ vector field accepts a hexadecimal value. In the source code, the vector is formatted as two hexadecimal digits.

### 3.7 Running the Program Step by Step

The **Step** command performs one processor step and then refreshes the register list.

### 3.8 Running and Stopping the Program

- **Run:** Starts repeated processor stepping.
- **Stop:** Stops repeated stepping and then refreshes the register list.

The execution speed can be adjusted using the slider; its position sets the interval of the stepping timer.

### 3.9 Execution Log

The **RunLogger** command displays the execution log window. The processor's event handler records the current instruction at instruction boundaries.

### 3.10 Examining Memory Contents

The **Examine/Deposit** command opens the window used to examine and modify memory.

The **HexViewer** command displays the HexViewer window. The window receives the loaded processor's architecture and the size of the test memory.

### 3.11 Loading Memory Contents from a File

The **Load memory content** command loads memory contents from a file. The target bank and address range must be specified before loading.

The source code supports two file formats:

- Binary (`.bin`)
- Intel HEX (`.hex`)

For a binary file, the bytes read are placed in the selected address range. Before loading an Intel HEX file, the contents of the target bank are cleared.

### 3.12 Saving Memory Contents to a File

The **Save memory content** command saves the specified address range of the selected bank to a file. The supported formats are:

- Binary (`.bin`)
- Intel HEX (`.hex`)

### 3.13 Clearing Memory Banks

- **Clear (code) memory:** Sets every byte in bank 0 to zero.
- **Clear data memory:** Sets every byte in bank 1 to zero.

### 3.14 ASCII Console

The **ASCII Console** command creates and displays the ASCII console panel. The panel name contains the console's I/O address. The console also receives an interrupt handler and uses the interrupt vector configured in the main window.

### 3.15 Standard I/O Port

The **Standard I/O Port** command creates and displays the standard I/O port panel.

### 3.16 I/O Port Interrupt Requests

The corresponding menu item enables or disables forwarding of interrupt requests originating from the I/O port.

### 3.17 Resetting I/O Ports

The **Reset ports** command resets the created ASCII console and standard I/O port.

### 3.18 Saving and Loading Processor State

- **Save status:** Saves the processor state to a `.clpst` file.
- **Load status:** Restores the processor state from the selected `.clpst` file.

The properties list is refreshed after a successful load.

## 4. Menu Commands

### 4.1 File

- Select plugin directory
- Usual places
- Refresh plugin List
- Load/change plugin
- Restart application
- Exit

The **Usual places** submenu may contain the following paths, if they exist:

- `./`
- `/usr/lib/corelab/`
- `/usr/local/lib/corelab/`
- `./plugins/`
- `~/.local/lib/corelab/`

### 4.2 Processor

- Load register values from CPU
- Save register values to CPU
- Reset (Resets the processor.)
- NMI (Sends a non-maskable interrupt request.)
- IRQ (Sends an interrupt request using the specified vector.)
- Step (Executes one processor step.)
- Run (Starts continuous execution.)
- Stop (Stops continuous execution.)
- RunLogger
- Load status
- Save status

### 4.3 Memory

- Examine/Deposit (Examines or modifies memory addresses and data.)
- HexViewer
- Load memory content
- Save memory content
- Clear code memory
- Clear data memory

### 4.4 I/O

- ASCII Console (Displays the ASCII console.)
- Standard I/O Port (Displays the standard I/O port.)
- Reset ports (Resets the test environment's I/O ports.)
- IRQ request (Enables or disables forwarding of interrupt requests from the I/O port.)

### 4.5 Help

- Help
- About

## 5. Settings

### 5.1 Execution Speed

The execution speed can be controlled using the slider in the main window. The slider sets the interval of the timer that performs processor stepping.

### 5.2 IRQ Vector

The IRQ vector can be specified in the main window. The field accepts a hexadecimal value.

### 5.3 I/O Interrupts

The menu can be used to enable or disable forwarding of interrupt requests from I/O ports.

## 6. Troubleshooting

| Problem | Possible Cause / Action |
|---|---|
| The specified directory does not exist. | Check the path of the plugin directory. |
| The processor plugin cannot be loaded. | Check the file and the error reported by the loader. |
| The file is not a CoreLAB processor plugin. | Select a plugin that provides the required processor entry points. |
| Invalid register value. | The value must be hexadecimal and fit within the register size. |
| Invalid IRQ vector. | Enter a valid value representable by two hexadecimal digits. |
| The memory file cannot be read or saved. | Check file availability and permissions. |
| An error occurs while loading the Intel HEX file. | Check the file format and contents. |
| The help file or help viewer is missing. | Check the availability of `corelab_<language>.chm`, `corelab_en.chm`, and `lhelp`. |

## 7. Appendix

### 7.1 File Formats

| Extension / Pattern | Purpose |
|---|---|
| `cpu_*.dll` | Windows processor plugin. |
| `libcpu_*.so` | Linux/Unix processor plugin. |
| `*.clpst` | CoreLAB plugin state file. |
| `*.bin` | Binary memory contents. |
| `*.hex` | Intel HEX memory contents. |

### 7.2 Keyboard Shortcuts

| Shortcut | Description |
|:-:|---|---|
| Ctrl-D | Select plugin directory |
| Ctrl-H | HexViewer |
| Ctrl-L | RunLogger |
| F4     | Examine/deposit |
| F5     | Load register values from CPU |
| F8     | Step |
| F9     | Run |
| F10    | Stop |

### 7.3 Glossary

- **Processor plugin:** A dynamically loaded module that implements a processor.
- **Register:** An internal processor storage location with a name and size.
- **NMI:** Non-maskable interrupt request.
- **IRQ:** Interrupt request for which the test environment supplies a vector.
- **Intel HEX:** A text-based file format used to store memory contents.
- **RunLogger:** A log window associated with processor execution.
- **HexViewer:** A window for displaying memory in hexadecimal form.

### 7.4 Version History

- **v0.1.0:** First release.
