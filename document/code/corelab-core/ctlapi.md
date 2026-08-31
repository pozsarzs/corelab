# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## ICtlAPI from ctlapi unit

`ICtlAPI` is the CoreLAB control API interface. It defines the operations used
by the supervisor to control a CPU, including register access, execution control,
instruction inspection and interrupt handling.

The source explicitly states that this interface is implemented only in the
`TCPU` class.

### Interface methods

|name                                                         |description                                                   |
|-------------------------------------------------------------|--------------------------------------------------------------|
|`procedure SetRegister(const RegName: PChar; AValue: QWord);`|Sets the value of the CPU register identified by `RegName`.   |
|`function GetRegister(const RegName: PChar): QWord;`         |Returns the value of the CPU register identified by `RegName`.|
|`procedure Reset;`                                           |Resets the CPU.                                               |
|`procedure Run;`                                             |Starts CPU execution.                                         |
|`procedure Step;`                                            |Executes a single CPU step.                                   |
|`procedure Stop;`                                            |Stops CPU execution.                                          |
|`function GetCurrentInstruction: PChar;`                     |Returns the current instruction representation.               |
|`procedure IRQ;`                                             |Requests an interrupt request.                                |
|`procedure NMI;`                                             |Requests a non-maskable interrupt.                            |
|`function CheckInterrupts: Boolean;`                         |Checks whether interrupts require processing.                 |

### Interface identifier

`ICtlAPI` is identified by GUID:

`{D7A29B3C-1F5E-46A8-B2C4-9D3E8F5A7B1C}`

### Usage

The interface is intended as the control path from `TSupervisor` to `TCPU`.

`TBus` also implements this interface so that the bus can expose the same
control operations at the system level.
