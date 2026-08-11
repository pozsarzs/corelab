# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Base classes

|filename        |base, parent     |class   |description                                   |
|----------------|-----------------|--------|----------------------------------------------|
|core_bus.pas    |TInterfacedObject|TBus    |System and service bus module                 |
|core_cpu.pas    |                 |TCPU    |Processor abstraction module                  |
|core_display.pas|                 |TDisplay|Display abstraction module                    |
|core_gioport.pas|TIOPort          |TGIOPort|Graphical I/O port (device) abstraction module|
|core_ioport.pas |                 |TIOPort |I/O port (device) abstraction module          |
|core_led.pas    |                 |TLED    |LED abstraction module                        |
|core_memory.pas |                 |TMemory |RAM/ROM abstraction module                    |
