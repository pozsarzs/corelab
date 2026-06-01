# CoreLAB

## Source code

### CPU abstraction module (`core_cpu.md`)

|Type        |Name                             |Type/return value  |Description                                                                             |
|:----------:|---------------------------------|:-----------------:|----------------------------------------------------------------------------------------|
|**Method**  |`constructor Create;`            |`virtual;`         |Initializes the default execution state of the CPU.                                     |
|**Method**  |`function CheckInterrupts;`      |`boolean;`         |Checks and handles pending interrupts. Returns `true` if an interrupt has been serviced.|
|**Method**  |`function GetCurrentInstruction;`|`string; abstract;`|Returns the textual (mnemonic) representation of the current instruction.               |
|**Method**  |`function GetRegister;`          |`qword; abstract;` |Retrieves the current value of the internal CPU register with the specified name.       |
|**Method**  |`procedure ConnectBus;`          |`virtual;`         |Connects the CPU to the external system bus (`ICPUBus`).                                |
|**Method**  |`procedure IRQ;`                 |`virtual;`         |Signals a maskable interrupt request to the CPU.                                        |
|**Method**  |`procedure NMI;`                 |`virtual;`         |Signals a non-maskable interrupt request to the CPU.                                    |
|**Method**  |`procedure Reset;`               |`abstract;`        |Performs a hardware reset (resets registers and status flags to their default states).  |
|**Method**  |`procedure Run;`                 |`virtual;`         |Places the processor into the running state (`FRunning := true`).                       |
|**Method**  |`procedure SetRegister;`         |`abstract;`        |Sets the value of the internal CPU register with the specified name.                    |
|**Method**  |`procedure Step;`                |`abstract;`        |Executes a single instruction (or micro-step) in the simulation.                        |
|**Method**  |`procedure Stop;`                |`virtual;`         |Stops continuous instruction execution (`FRunning := false`).                           |
|**Property**|`AddressWidth`                   |`byte`             |The width of the CPU address bus in bits.                                               |
|**Property**|`Architecture`                   |`TArchitecture`    |The CPU architecture type (`arHarvad` or `arNeumann`).                                  |
|**Property**|`BitWidth`                       |`byte`             |The primary word size of the processor in bits (e.g., 8, 16, 64).                       |
|**Property**|`Cycles`                         |`qword`            |Total number of clock cycles elapsed since the start of the simulation.                 |
|**Property**|`Endianness`                     |`TEndianness`      |Byte ordering method (`enLittle` or `enBig`).                                           |
|**Property**|`Family`                         |`string`           |The name of the processor family (e.g., "Intel80xx").                                   |
|**Property**|`Halted`                         |`boolean`          |Indicates if the CPU is in a `HALT` (sleep) state.                                      |
|**Property**|`HasSeparateIOBus`               |`boolean`          |`true` if the CPU has a dedicated I/O bus (separate memory mapping and port handling).  |
|**Property**|`Instructions`                   |`qword`            |Cumulative counter of executed instructions.                                            |
|**Property**|`InterruptEnabled`               |`boolean`          |State of the global interrupt enable flag.                                              |
|**Property**|`MaxCodeAddress`                 |`qword`            |The highest program memory address accessible by the CPU.                               |
|**Property**|`MaxIOPortAddress`               |`qword`            |The highest I/O port address accessible by the CPU.                                     |
|**Property**|`MaxMemAddress`                  |`qword`            |The highest data memory address accessible by the CPU.                                  |
|**Property**|`Name`                           |`string`           |The exact model name of the processor (e.g., "Z80").                                    |
|**Property**|`OnEvent`                        |`TCPUEventHandler` |Event handler callback for debugger and trace systems.                                  |
|**Property**|`Running`                        |`boolean`          |The active execution state of the CPU.                                                  |
