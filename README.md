> [!WARNING]
> The program is still under development, it is not yet suitable for its task.  
>

<img align="left" style="float: left; margin: 0 10px 0 0;" alt="Icon"
  src="desktop/48x48/apps/corelab-orange.png">

# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## I. Introduction and Project Goals

The CoreLAB project is a functional 8 bits microprocessor and microcontroller
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

|Features                  |Specification / Description                                        |
|--------------------------|-------------------------------------------------------------------|
|**project type**          |Functional processor simulator                                     |
|**actual version**        |v0.1                                                               |
|**licence**               |EUPL v1.2                                                          |
|**language**              |en, hu                                                             |
|**architecture**          |amd64, armhf, i386, x86_64                                         |
|**operation system**      |FreeBSD, Linux, Windows                                            |
|**user interface**        |Graphical User Interface (GUI) with scriptable command-line control|
|**running modes**         |Normal or interpreter                                              |
|**simulation type**       |Instruction-level operation (not cycle-accurate)                   |
|**supported architecture**|Neumann and Harvard architectures                                  |
|**supported processors**  |Byte based uPs and simple MCUs                                     |
|**simulation environment**|Configurable memory space and virtual I/O ports or devices         |
|**modular architecture**  |Dynamically loadable CPUs and peripherals                          |
|**state saving**          |Saving and restoring full environment state                        |

### Integrated modules

|Features              |Specification / Description                            |
|----------------------|-------------------------------------------------------|
|**Breakpoint Manager**|Managing breakpoints                                   |
|**BusLogger**         |Logging system bus traffic                             |
|**HexViewer**         |Memory viewer component                                |
|**IntLogger**         |Logging interrupt requests                             |
|**Module Explorer**   |Managing module instances                              |
|**RegViewer**         |Real-time inspection of registers                      |
|**RunLogger**         |Real-time output of address, machine code, and mnemonic|
|**ScriptConsole**     |Console for show running script output                 |
|**ScriptEditor**      |Built-in environment for writing control scripts       |
|**SysConsole**        |Console for system messages and command line interface |

### Plug-in modules

|Features                               |Specification / Description                                                                  |
|---------------------------------------|---------------------------------------------------------------------------------------------|
|**Real Port Redirection**              |Bridges virtual port I/O streams directly to the physical hardware ports of the host machine.|
|**Simple Console**                     |Basic text-based console for data stream monitoring.                                         |
|**Virtual 7-Segment Display**          |Single and multiplexed 7-segment display arrays for numerical and basic character output.    |
|**Virtual CPU**                        |Emulated processor, microprocessor with custom architectures.                                |
|**Virtual Hexadecimal Display**        |Single and multiplexed hex display arrays mapped to virtual port addresses.                  |
|**Virtual LED Array and Matrix**       |Linear LED bars and dot-matrix displays for visual bit-state and coordinate-based output.    |
|**Virtual Memory (RAM/ROM)**           |Configurable volatile and non-volatile memory blocks with custom sizing and address mapping. |
|**Virtual Pushbutton Array and Matrix**|Linear and matrix-arranged momentary pushbuttons for interactive binary input.               |
|**Virtual Switch Array and Matrix**    |Linear and matrix-arranged toggle switches providing persistent binary data to virtual ports.|

## III. Screenshots

### CoreLAB framework application

![CoreLAB framework application](document/screenshots/corelab_1.png)

### CLIOPort plugin tester application

![CLIOPort plugin tester application](document/screenshots/clioport.png)

### CLMemory plugin tester application

![CLMemory plugin tester application](document/screenshots/clmemory.png)

### CLProcessor plugin tester application

![CLProcessor plugin tester application](document/screenshots/clprocessor_1.png)

![CLProcessor plugin tester application](document/screenshots/clprocessor_2.png)

![CLProcessor plugin tester application](document/screenshots/clprocessor_3.png)

![CLMemory plugin tester application](document/screenshots/clprocessor_4.png)

![CLProcessor plugin tester application](document/screenshots/clprocessor_5.png)

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

CoreLAB uses a simple directory-based project structure. A project directory can
contain all related files—such as optional environment setup scripts, saved state
snapshots, program code, and data streams. The simulation environment can also be
built manually, meaning none of these files are strictly mandatory. This setup
keeps experiments independent while fully supporting the use of external files.

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
way as real hardware devices.

### Debugging Features

CoreLAB provides several built-in diagnostic and debugging tools. Users can halt
execution at breakpoints, execute programs step by step, inspect memory and
register contents, and monitor instruction execution in real time. These features
are especially useful for educational purposes and low-level software
development.

### Scripting and Automation

The program is primarily operated through its own built-in console command line,
though a menu is also available. It features a custom command interpreter and
scripting language. Scripts can be executed directly from the OS shell; when run
this way, the script automatically builds the execution environment and performs
all specified operations. This allows for the efficient automation of repetitive
tasks, tests, and the reproduction of complex hardware configurations.

### State Saving and Restoration

The complete state of a simulation can be saved and restored at any time. This
includes not only memory contents but also the current state of processors,
peripherals, and other objects. As a result, development and debugging sessions
can be paused and resumed without loss of progress.

### Logging and Data Export

Runtime events and execution logs can be saved to files for later analysis.
Memory contents can be exported in binary or Intel HEX format, allowing results
to be used with other development tools or transferred to real hardware.

#### Used filetypes

|extension|type                 |application                    |
|:-------:|:--------------------|:------------------------------|
|*.bin    |General binary file  |CoreLAB, CLProcessor           |
|*.clprj  |CoreLAB project      |CoreLAB                        |
|*.clpst  |CoreLAB plugin status|CLIOPort, CLMemory, CLProcessor|
|*.clsce  |CoreLAB scriptembly  |CoreLAB                        |
|*.clsht  |CoreLAB snapshot     |CoreLAB                        |
|*.hex    |Intel hexa file      |CoreLAB, CLProcessor           |
|*.log    |General log file     |CoreLAB, CLProcessor           |

## VI. Internal registers

|registers|description                |access|
|:-------:|:--------------------------|:----:|
|R0-9     |general register           | R/W  | 
|RA       |work register (accumulator)| R/W  | 
|RB       |work directory             | RO   | 
|RC       |script instruction counter | RO   | 
|RD       |CPU instruction counter    | RO   | 
|RE       |random byte                | RO   | 
|RF       |flags                      | RO   |

**Note:** Flag's 0 bit is ZERO, 1 bit is CARRY.  

## VII. Implemented commands

|instruction  |mode             |use RA|flags|description                                                            |
|:-----------:|:---------------:|:----:|:---:|-----------------------------------------------------------------------|
|**ADD**      |csScript         |Yes   |C, Z |Add value to target in-place.                                          |
|**AND**      |csScript         |Yes   |Z    |Bitwise/logical AND in-place.                                          |
|**ATIO**     |csEveryWhere     |-     |-    |Attach I/O port or device module to bus.                               |
|**ATME**     |csEveryWhere     |-     |-    |Attach memory module to bus.                                           |
|**ATPU**     |csEveryWhere     |-     |-    |Attach processor module to bus.                                        |
|**BIT**      |csScript         |Yes   |Z    |Check the specified bit.                                               |
|**CALL**     |csScript         |-     |-    |Call subroutine.                                                       |
|**CFIO**     |csEveryWhere     |-     |-    |Configure I/O port module.                                             |
|**CFME**     |csEveryWhere     |-     |-    |Configure memory module.                                               |
|**CFPU**     |csEveryWhere     |-     |-    |Configure processor module.                                            |
|**CHWD**     |csEveryWhere     |-     |-    |Change work directory.                                                 |
|**COMP**     |csScript         |Yes   |C, Z |Compare target with value by subtraction.                              |
|**CONV**     |csScript         |Yes   |-    |Convert number in different numeral systems in-place.                  |
|**CRIO**     |csEveryWhere     |-     |-    |Instantiate a I/O port or device module.                               |
|**CRME**     |csEveryWhere     |-     |-    |Instantiate a memory module.                                           |
|**CRPU**     |csEveryWhere     |-     |-    |Instantiate a processor module.                                        |
|**DEC**      |csScript         |Yes   |Z    |Decrement integer target by 1 or by count in-place.                    |
|**DEPO**     |csScript         |Yes   |-    |Deposit a value directly into memory, register or bus address.         |
|**DIIO**     |csEveryWhere     |-     |-    |Disable I/O port or device module.                                     |
|**DIME**     |csEveryWhere     |-     |-    |Disable memory module.                                                 |
|**DIPU**     |csEveryWhere     |-     |-    |Disable processor module.                                              |
|**DSIO**     |csEveryWhere     |-     |-    |Destroy I/O port or device module.                                     |
|**DSME**     |csEveryWhere     |-     |-    |Destroy memory module.                                                 |
|**DSPU**     |csEveryWhere     |-     |-    |Destroy processor module.                                              |
|**DTIO**     |csEveryWhere     |-     |-    |Detach I/O port or device module from bus.                             |
|**DTME**     |csEveryWhere     |-     |-    |Detach memory module from bus.                                         |
|**DTPU**     |csEveryWhere     |-     |-    |Detach processor module from bus.                                      |
|**EDME**     |csInteractiveOnly|-     |-    |Show examine/deposit window.                                           |
|**END**      |csScript         |-     |-    |End of script.                                                         |
|**ENIO**     |csEveryWhere     |-     |-    |Enable I/O port or device module.                                      |
|**ENME**     |csEveryWhere     |-     |-    |Enable memory module.                                                  |
|**ENPU**     |csEveryWhere     |-     |-    |Enable processor module.                                               |
|**EXAM**     |csScript         |Yes   |-    |Examine a value from memory, register or bus address into a variable.  |
|**EXAP**     |csEveryWhere     |-     |-    |Exit from application.                                                 |
|**EXIT**     |csScript         |-     |-    |Terminate the script.                                                  |
|**HELP**     |csScript         |-     |-    |Display general help overview or detailed usage for a specific command.|
|**INC**      |csScript         |Yes   |Z    |Increment integer target by 1 or by count in-place.                    |
|**INRG**     |csScript         |Yes   |Z    |Check if value is between min and max.                                 |
|**IRQ**      |csEveryWhere     |-     |-    |Call interrupt.                                                        |
|**JPEQ/JPZR**|csScript         |-     |-    |Jump to the specified label, based on the result of the previous CMP.  |
|**JPGE**     |csScript         |-     |-    |Jump to the specified label, based on the result of the previous CMP.  |
|**JPGT**     |csScript         |-     |-    |Jump to the specified label, based on the result of the previous CMP.  |
|**JPLE**     |csScript         |-     |-    |Jump to the specified label, based on the result of the previous CMP.  |
|**JPLT**     |csScript         |-     |-    |Jump to the specified label, based on the result of the previous CMP.  |
|**JPNE/JPNZ**|csScript         |-     |-    |Jump to the specified label, based on the result of the previous CMP.  |
|**LDME**     |csEveryWhere     |-     |-    |Load memory content from file.                                         |
|**LDPR**     |csInteractiveOnly|-     |-    |Change to interactive mode and load project from file.                 |
|**LDSC**     |csInteractiveOnly|-     |-    |Change to script mode and load script from file.                       |
|**LDSS**     |csEveryWhere     |-     |-    |Load and restore snapshot.                                             |
|**MUL**      |csScript         |Yes   |C, Z |Multiply target by value in-place.                                     |
|**NMI**      |csEveryWhere     |-     |-    |Call non-maskable interrupt.                                           |
|**NOT**      |csScript         |Yes   |Z    |Bitwise/logical NOT in-place.                                          |
|**NWPR**     |csInteractiveOnly|-     |-    |Change to interactive mode and create new project.                     |
|**NWSC**     |csInteractiveOnly|-     |-    |Change to script mode and create new script.                           |
|**OR**       |csScript         |Yes   |Z    |Bitwise/logical OR in-place.                                           |
|**PRNT**     |csScript         |-     |-    |Write text to console.                                                 |
|**RNIO**     |csEveryWhere     |-     |-    |Rename I/O device panel.                                               |
|**RSAP**     |csEveryWhere     |-     |-    |Restart application.                                                   |
|**RSIO**     |csEveryWhere     |-     |-    |Reset I/O port or device module.                                       |
|**RSME**     |csEveryWhere     |-     |-    |Reset memory module.                                                   |
|**RSPU**     |csEveryWhere     |-     |-    |Reset processor module.                                                |
|**RST**      |csEveryWhere     |-     |-    |Reset all module.                                                      |
|**RTRN**     |csScript         |-     |-    |Return from subroutine.                                                |
|**RUN**      |csEveryWhere     |-     |-    |Run simulation.                                                        |
|**RUSC**     |csInteractiveOnly|-     |-    |Run script.                                                            |
|**SESC**     |csInteractiveOnly|-     |-    |Run script step-by-step.                                               |
|**SHBM**     |csInteractiveOnly|-     |-    |Show BreakPoint Manager window.                                        |
|**SHHV**     |csInteractiveOnly|-     |-    |Show HexViewer window.                                                 |
|**SHIL**     |csInteractiveOnly|-     |-    |Show IntLogger window.                                                 |
|**SHIO**     |csEveryWhere     |-     |-    |Show I/O device panel.                                                 |
|**SHL**      |csScript         |Yes   |C, Z |Shift target bits left by count in-place.                              |
|**SHME**     |csInteractiveOnly|-     |-    |Show Module Explorer window.                                           |
|**SHR**      |csScript         |Yes   |C, Z |Shift target bits right by count in-place.                             |
|**SHRL**     |csInteractiveOnly|-     |-    |Show RunLogger window.                                                 |
|**SHRV**     |csInteractiveOnly|-     |-    |Show RegViewer window.                                                 |
|**SHSC**     |csInteractiveOnly|-     |-    |Show ScriptConsole window.                                             |
|**SHSE**     |csInteractiveOnly|-     |-    |Show ScriptEditor window.                                              |
|**STEP**     |csEveryWhere     |-     |-    |Run simulation step-by-step.                                           |
|**STOP**     |csEveryWhere     |-     |-    |Stop simulation.                                                       |
|**STSC**     |csInteractiveOnly|-     |-    |Stop script.                                                           |
|**SUB**      |csScript         |Yes   |C, Z |Subtract value from target in-place.                                   |
|**SVME**     |csEveryWhere     |-     |-    |Save memory content to file.                                           |
|**SVPR**     |csInteractiveOnly|-     |-    |Save project to file.                                                  |
|**SVSC**     |csInteractiveOnly|-     |-    |Save script to file.                                                   |
|**SVSS**     |csEveryWhere     |-     |-    |Make and save snapshot.                                                |
|**SWAP**     |csScript         |Yes   |-    |Swap the values of two variables.                                      |
|**WAIT**     |csScript         |-     |-    |Wait specified ms.                                                     |
|**XOR**      |csScript         |Yes   |Z    |Bitwise/logical XOR in-place.                                          |
TScriptRuntime
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
 - [GitHub repository](https://github.com/pozsarzs/corelab/tree/CoreLAB8)  
 - [Project webpage on Github](https://pozsarzs.github.io/corelab)  

### Source packages  

|name                                                                                 |version|
|-------------------------------------------------------------------------------------|:-----:|
|[main.zip](https://github.com/pozsarzs/corelab/archive/refs/heads/CoreLAB8.zip)      |latest |
|[corelab-0.1.tar.gz](https://www.pozsarzs.hu/60_myprogcom/package/corelab-0.1.tar.gz)|v0.1   |

### Binaries and installer packages for several OS and architecture

Not all test versions have binary or installation packages.
To download, visit [CoreLAB's webpage](https://www.pozsarzs.hu/60_myprogcom/corelab/).

[^1]: [InpOut32 Github repository](https://github.com/ellysh/InpOut32)
