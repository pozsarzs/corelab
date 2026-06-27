# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## Components

|name          |description                          |
|--------------|-------------------------------------|
|display_til302|TIL302 display (class TDisplayTIL302)|
|display_til311|TIL311 display (class TDisplayTIL311)|

## Plugins

|name    |description                                                 |
|--------|------------------------------------------------------------|
|cpu_*   |Virtual CPU, uP and MCU devices (class TCPU implementations)|
|ioport_*|Virtual I/O devices (class TIOPort implementations)         |
|memory_*|Virtual memory devices (class TMemory implementations)      |
