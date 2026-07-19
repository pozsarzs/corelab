> [!WARNING]
> The program is still under development, it is not yet suitable for its task.  
>

<img align="left" style="float: left; margin: 0 10px 0 0;" alt="Icon"
  src="desktop/48x48/apps/corelab-orange.png">

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## I. Introduction and Project Goals

The CoreLAB project is a functional CPU, microprocessor, and microcontroller
simulator born from a fusion of academic research, technical passion, and
historical preservation. The project was initiated with several key objectives
in mind:

* **A Tribute to the Pioneers (Hardware and Human):** The project serves as a
    respectful nod to the early eras of computing architecture and the brilliant
    minds who designed them. By keeping the logic of these foundational
    processors alive, it preserves the digital heritage that paved the way for
    modern computing.
* **Learning Machine Code Programming:** It provides an accessible, hands-on
    educational platform to study low-level programming on classic architectures
    (such as the i40xx, i80xx, or TMS1000). Many of these physical chips are now
    rare, expensive, or completely obsolete, making software simulation the only
    viable way to experience them.
* **Academic Research (University Thesis):** The development of this simulator
    and its modular plugin system forms the core framework of my university
    thesis, exploring dynamic software architectures and instructional simulation
    methodologies.
* **Functional Execution over Full Emulation:** Unlike comprehensive emulators,
    the goal of CoreLAB is **not** to replicate entire vintage computer systems,
    run historical operating systems, or simulate cycle-accurate hardware quirks.
    Instead, it focuses strictly on the clean, functional execution of
    instructions, making the code's logic transparent and easy to analyze.
* **A Playground for System Design and Modeling:**  Beyond a simple educational
    tool, the project serves as a practical application of advanced system
    design and hardware modeling concepts. It provides a platform to explore
    how complex, real-world physical systems - such as buses, registers, memory
    layouts, and I/O lines - can be accurately modeled, decoupled, and
    reconfigured dynamically in software using modern software engineering
    patterns.
* **Bridging Vintage Logic with Modern Automation:** A key innovation of the
    project is wrapping these classic CPU architectures into a modern, scriptable
    environment. By allowing users to dynamically build topologies, manipulate
    registers, and automate tests via a command-line shell, it applies modern
    DevOps and debugging workflows to the foundational hardware of the past.

## II. Features

### General features

|Features                  |Specification / Description                                                      |
|--------------------------|---------------------------------------------------------------------------------|
|**project type**          |Functional CPU/uP/MCU simulator                                                  |
|**actual version**        |v0.1                                                                             |
|**licence**               |EUPL v1.2                                                                        |
|**language**              |en, hu                                                                           |
|**architecture**          |amd64, armhf, i386, x86_64                                                       |
|**operation system**      |FreeBSD, Linux, Windows                                                          |
|**user interface**        |Graphical User Interface (GUI) with scriptable command-line control              |
|**running modes**         |Normal or interpreter                                                            |
|**simulation type**       |Instruction-level operation (not cycle-accurate)                                 |
|**supported architecture**|Neumann and Harvard architectures                                                |
|**supported processors**  |Word-based CPUs up to 64-bit, 4–16 bit uPs and 4–8 bit, simple MCUs              |
|**simulation environment**|Configurable memory space and virtual I/O ports                                  |
|**modular architecture**  |Dynamically loadable CPUs, peripherals, and devices                              |
|**dump**                  |Displaying memory and register contents, with export to binary or Intel HEX files|
|**logging**               |Runtime log exportable to file                                                   |
|**debug features**        |Breakpoints, memory monitoring, single-stepping, and commentable memory addresses|
|**program loading**       |Via keyboard entry or from binary/Intel HEX files                                |
|**state saving**          |Saving and restoring CPU and full environment state                              |

### Integrated modules

|Features                       |Specification / Description                                        |
|-------------------------------|-------------------------------------------------------------------|
|**Breakpoint Manager**         |Managing code, memory, and conditional hardware breakpoints        |
|**Bus Monitor / Tracer**       |Passive real-time tracing of address, data, and control buses      |
|**CPU Register Viewer**        |Real-time inspection of registers, program counter, and flag status|
|**Device Manager Map**         |Overview of mapped virtual peripheral addresses and memory spaces  |
|**HexEditor**                  |Memory viewer and editor component                                 |
|**Interrupt Controller Status**|Monitoring interrupt requests, masks, and priorities               |
|**RunLogger**                  |Real-time output of address, machine code, and mnemonic            |
|**Script Editor**              |Built-in environment for writing and executing control scripts     |
|**Virtual System Monitor**     |Altair-style virtual front panel with toggles and LED indicators   |

### Plug-in modules

|Features                               |Specification / Description                                                                  |
|---------------------------------------|---------------------------------------------------------------------------------------------|
|**Virtual CPU, uP, and MCU**           |Emulated processor, microprocessor, and microcontroller cores with custom architectures.     |
|**Virtual Memory (RAM/ROM)**           |Configurable volatile and non-volatile memory blocks with custom sizing and address mapping. |
|**Virtual 7-Segment Display**          |Single and multiplexed 7-segment display arrays for numerical and basic character output.    |
|**Virtual Hexadecimal Display**        |Single and multiplexed hex display arrays mapped to virtual port addresses.                  |
|**Virtual LED Array and Matrix**       |Linear LED bars and dot-matrix displays for visual bit-state and coordinate-based output.    |
|**Virtual Pushbutton Array and Matrix**|Linear and matrix-arranged momentary pushbuttons for interactive binary input.               |
|**Virtual Switch Array and Matrix**    |Linear and matrix-arranged toggle switches providing persistent binary data to virtual ports.|
|**Real Port Redirection**              |Bridges virtual port I/O streams directly to the physical hardware ports of the host machine.|
|**Simple Serial Terminal**             |Basic text-based serial console for communication and data stream monitoring.                |

## III. Screenshots

(...)

## IV. Used external libraries, programs and others

 - _Fugue Icons_
   (C) 2013 Yusuke Kamiyamane
   CCA v3.0
 - _InpOut32 v1.0.07 Driver Interface DLL_ [^1]  
   Windows Dynamic Link Library (DLL)  
   (C) 2003-2015 Phil Gibbons  
   (C) 2000 <logix4u.net>  
   Open source/freeware  
 - _LHelp v2021-02-12 CHM help viewer_  
   (C) 2005-2014 Andrew Haines, Lazarus contributors  
   GNU GPL v2.0 or later

## V. About the program

### Project Management

CoreLAB uses a project-based workflow. A project contains not only program code
but also the complete simulation environment, including created CPUs, memories,
peripherals, their interconnections, and associated files and settings. This
allows different developments or experiments to be managed independently from one
another.

### Modular Architecture

One of the most important features of the simulator is its modular design.
Processors, memories, and peripherals can be created as independent objects and
connected dynamically. Users can build custom virtual hardware environments
tailored to the requirements of the system being studied.

### Supported Processor Architectures

CoreLAB is not limited to a single processor type. Different CPU, microprocessor,
and microcontroller architectures can be loaded as plug-ins. This enables the
same environment to be used for studying multiple instruction sets and hardware
models.

### Virtual Memory and I/O Environment

The memory map and I/O address space can be configured freely during simulation.
Virtual peripherals can be assigned to memory locations or I/O ports in the same
way as real hardware devices. This makes it possible to model complete systems
without requiring physical components.

### Debugging Features

CoreLAB provides several built-in diagnostic and debugging tools. Users can halt
execution at breakpoints, execute programs step by step, inspect memory and
register contents, and monitor instruction execution in real time. These features
are especially useful for educational purposes and low-level software
development.

### Bus and System Monitoring

The Bus Monitor and Virtual System Monitor allow users to observe the operation
of the virtual hardware in real time. Address, data, and control bus activity can
be monitored, as well as communication between system components. This provides
visibility into internal system behavior that would often require specialized
measuring equipment on real hardware.

### Scripting and Automation

In addition to the graphical interface, the program includes its own command
interpreter and scripting language. Repetitive tasks, automated tests, and
measurement procedures can be executed through scripts. This makes it possible to
reproduce complex hardware configurations and testing environments efficiently.

### State Saving and Restoration

The complete state of a simulation can be saved and restored at any time. This
includes not only memory contents but also the current state of processors,
peripherals, and other objects. As a result, development and debugging sessions
can be paused and resumed without loss of progress.

### Logging and Data Export

Runtime events and execution logs can be saved to files for later analysis.
Memory contents can be exported in binary or Intel HEX format, allowing results
to be used with other development tools or transferred to real hardware.

## VI. Implemented commands  

|command  |category           |description                                                       |
|:-------:|:-----------------:|------------------------------------------------------------------|
|`date`   |General            |Show system date and time                                         |
|`exit`   |General            |Terminate the shell or simulation environment                     |
|`goto`   |General            |Jump to a defined label, optionally conditional upon an expression|
|`help`   |General            |Show description or usage of the commands                         |
|`input`  |General            |Read user input into a variable from console                      |
|`pause`  |General            |Waits for a keystroke or specified time                           |
|`print`  |General            |Output a message or value to the console                          |
|`ver`    |General            |Display version and build information                             |
|`chr`    |Data Management    |Convert byte to char                                              |
|`clear`  |Data Management    |Clear content of an array                                         |
|`fill`   |Data Management    |Fill an array with a character                                    |
|`let`    |Data Management    |Assign a value to a variable or array element                     |
|`ord`    |Data Management    |Convert char to byte                                              |
|`swp`    |Data Management    |Swap the values of two targets                                    |
|`concat` |String Handler     |Concatenate strings                                               |
|`length` |String Handler     |Length of string                                                  |
|`lowcase`|String Handler     |Conversion to lowercase                                           |
|`strdel` |String Handler     |Delete specified element(s) of the string                         |
|`strfind`|String Handler     |Find specified element in the string                              |
|`strins` |String Handler     |Insert element into string                                        |
|`stritem`|String Handler     |Specified element of the string                                   |
|`strrepl`|String Handler     |Replace element in the string                                     |
|`upcase` |String Handler     |Conversion to uppercase                                           | 
|`abs`    |Arithmetic         |Calculate absolute value                                          |
|`add`    |Arithmetic         |Perform addition                                                  |
|`conv`   |Arithmetic         |Convert numbers between BIN, DEC, HEX, and OCT formats            |
|`dec`    |Arithmetic         |Decrement an integer value                                        |
|`div`    |Arithmetic         |Perform floating-point division                                   |
|`idiv`   |Arithmetic         |Perform integer division                                          |
|`imod`   |Arithmetic         |Calculate modulus (remainder of integer division)                 |
|`inc`    |Arithmetic         |Increment an integer value                                        |
|`mul`    |Arithmetic         |Perform multiplication                                            |
|`sub`    |Arithmetic         |Perform subtraction                                               |
|`inrange`|Arithmetic         |Check if a value falls within a specified range                   |
|`and`    |Logic              |Bitwise / Logical AND operation                                   |
|`not`    |Logic              |Bitwise / Logical NOT operation                                   |
|`or`     |Logic              |Bitwise / Logical OR operation                                    |
|`shl`    |Logic              |Bitwise / Logical bit shift to the left                           |
|`shr`    |Logic              |Bitwise / Logical bit shift to the right                          |
|`xor`    |Logic              |Bitwise / Logical XOR operation                                   |
|`create` |Object Management  |Instantiate a hardware module, variable or array                  |
|`destroy`|Object Management  |Delete an object and free its memory                              |
|`attach` |Object Management  |Connect a hardware module to the bus                              |
|`detach` |Object Management  |Disconnect a module from the bus                                  |
|`set`    |Object Management  |Write a value to an internal state, register or memory cell       |
|`get`    |Object Management  |Read an internal state, register or memory cell into a variable   |
|`reset`  |Object Management  |Clear data or restore a hardware module to default state          |
|`load`   |Object Management  |Load binary data or state into an object from a file              |
|`save`   |Object Management  |Save an object's current state or memory dump to a file           |
|`info`   |Object Management  |Display metadata and general status of an object                  |
|`show`   |Object Management  |List all existing objects and the current topology                |
|`run`    |Simulation Control |Start the continuous functional execution of a CPU                |
|`step`   |Simulation Control |Execute a single or a specific number of instructions on a CPU    |
|`stop`   |Simulation Control |Halt the execution of a running CPU                               |

## VII. Predefined (virtual) constants  

|name      |value                                                     |
|:---------|:---------------------------------------------------------|
|`$?`      |exit value of the commands                                |
|`$ARGCNT` |number of the OS command line arguments (interpreter mode)|
|`$ARGx`   |OS command line arguments (interpreter mode)              |
|`$BRND`   |gives a random byte                                       |
|`$HOME`   |user's home directory                                     |
|`$ICNT`   |total number of executed CPU instructions                 |
|`$IRND`   |gives a random integer                                    |
|`$PRJDIR` |directory of the actual project                           |
|`$PRJNAME`|name of the actual project                                |
|`$WRND`   |gives a random word                                       |
$DATE
$TIME
## VIII. Documentation and Help  

CoreLAB features built-in help and comprehensive documentation, accessible
through the following channels:

- Command-line assistance: Type the help command in the terminal to directly
  access usage guides and command references.
- Graphical Help: Under the Help menu in the graphical interface, you can find
  visual guides regarding the software's operation and supported CPU
  architectures.
- Source code documentation: Detailed developer assistance and documentation
  for the source code are available in the document folder.
- Additionally, you can view the manual page from *nix shell (_man corelab_) or
  _corelab.txt_ on other systems.  

## IX. Contributing  

If you find any bugs, please report them! I am also happy to accept pull
requests from anyone. You can use the GitHub issue tracker to report bugs, ask
questions, or suggest new features. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
for details.  

## X. Links  

 - [Homepage](https://www.pozsarzs.hu/60_myprogcom/corelab/)  
 - [GitHub repository](https://github.com/pozsarzs/corelab)  
 - [Project webpage on Github](https://pozsarzs.github.io/corelab)  

### Source packages  

|name                                                                                 |version|
|-------------------------------------------------------------------------------------|:-----:|
|[main.zip](https://github.com/pozsarzs/corelab/archive/refs/heads/main.zip)          |latest |
|[corelab-0.1.tar.gz](https://www.pozsarzs.hu/60_myprogcom/package/corelab-0.1.tar.gz)|v0.1   |

### Binaries and installer packages for several OS and architecture

Not all test versions have binary or installation packages.
To download, visit [CoreLAB's webpage](https://www.pozsarzs.hu/60_myprogcom/corelab/).

[^1]: [InpOut32 Github repository](https://github.com/ellysh/InpOut32)
