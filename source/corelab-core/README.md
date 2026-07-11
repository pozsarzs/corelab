# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Base classes

|filename        |base, parent     |class   |description                                   |
|----------------|-----------------|--------|----------------------------------------------|
|core_cpu.pas    |                 |TCPU    |Processor abstraction module                  |
|core_display.pas|                 |TDisplay|Display abstraction module                    |
|core_gioport.pas|TIOPort          |TGIOPort|Graphical I/O port (device) abstraction module|
|core_ioport.pas |                 |TIOPort |I/O port (device) abstraction module          |
|core_memory.pas |                 |TMemory |RAM/ROM abstraction module                    |
|core_srvbus.pas |TInterfacedObject|TSrvBus |Service bus abstraction module                |
|core_sysbus.pas |TInterfacedObject|TSysBus |System bus abstraction module                 |
