# CoreLAB

## Intel 4002 RAM

### Technical Parameters

|Parameter               |Specification                                                                 |
|------------------------|------------------------------------------------------------------------------|
|**Release year**        |1971                                                                          |
|**Process technology**  |P-channel silicon-gate PMOS                                                   |
|**Memory type**         |RAM with internal refresh circuitry                                           |
|**Memory capacity**     |320 bits (4 × 20 × 4-bit characters)                                          |
|**Memory organization** |4 registers; each contains 16 main-memory and 4 status characters             |
|**Output port**         |4-bit, buffered output port (O0–O3)                                           |
|**Data bus**            |4-bit, bidirectional and multiplexed                                          |
|**Chip selection**      |4002-1 / 4002-2 metal options and P0 pin; 4 chip numbers per selected RAM bank|
|**Package**             |16-pin DIP                                                                    |
|**System compatibility**|Intel MCS-4 / MCS-40                                                          |
|**Timing signals**      |φ1, φ2 and SYNC, supplied by the system                                       |
|**Power supply**        |VDD = −15 V relative to VSS                                                   |
|**Main purpose**        |Data storage and peripheral output                                            |

### Description

The Intel 4002 is a 320-bit RAM designed for the MCS-4 microcomputer system. The memory is organized as four registers, each containing twenty 4-bit characters: sixteen main-memory characters and four status characters. The main-memory characters are addressed through an SRC instruction, while the status characters are selected by the OPA field of an I/O or RAM instruction.

In addition to the RAM array, the 4002 contains a four-bit output port with buffered output lines O0–O3. Data written from the processor is held by the output registers, so the output remains stable after the port has been loaded. The port is used to transfer data from the CPU to external devices; it is an output-only port.

The device communicates with the processor through the system's four-bit bidirectional, multiplexed data bus. Its internal refresh circuitry maintains the RAM cell data. Two metal-mask versions, 4002-1 and 4002-2, together with the external P0 pin, provide four chip-selection combinations within the selected RAM bank. The 4002 is housed in a 16-pin DIP package and uses the system's two-phase clock and SYNC signal.
