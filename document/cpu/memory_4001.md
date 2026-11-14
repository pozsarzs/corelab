# CoreLAB

## Intel 4001 ROM

### Technical Parameters

|Parameter               |Specification                                      |
|------------------------|---------------------------------------------------|
|**Release year**        |1971                                               |
|**Technology**          |PMOS                                               |
|**Memory type**         |Mask-programmable ROM                              |
|**Memory capacity**     |2,048 bits (256 × 8-bit words)                     |
|**I/O port**            |4 configurable I/O lines                           |
|**Data bus**            |4-bit, multiplexed                                 |
|**Chip selection**      |4-bit chip number; metal-mask option               |
|**Package**             |16-pin DIP                                         |
|**System compatibility**|Intel MCS-4 / MCS-40                               |
|**Timing signals**      |φ1, φ2 and SYNC, supplied by the system            |
|**Main purpose**        |Program and data-table storage, plus peripheral I/O|

### Description

The Intel 4001 is a mask-programmable ROM designed for the MCS-4 microcomputer system. It stores 256 eight-bit words, providing 2 KB (2,048 bits) of program code or data tables.

In addition to the ROM array, the chip contains a four-line I/O port with associated control logic. Each I/O line can be configured by metal-mask option as an input or output; direct or inverted operation can also be selected. The 4001 communicates with the processor through the system's four-bit multiplexed data bus.

The ROM is selected by a chip number encoded in the metal mask. Up to 16 different 4001 chip numbers can be addressed in the standard arrangement. The device is housed in a 16-pin DIP package and uses the two-phase clock and synchronization signals of the MCS-4 system.
