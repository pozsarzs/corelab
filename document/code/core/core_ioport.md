# CoreLAB

## Documentation

### I/O port abstraction module (`core_ioport.md`)

|Type        |Name                  |Type/return value         |Description                                                                                    |
|:----------:|----------------------|:------------------------:|-----------------------------------------------------------------------------------------------|
|**Method**  |`constructor Create;` |`virtual;`                |Sets the port range size, calculates the relative maximum, and sets default access permissions.|
|**Method**  |`function ReadPort;`  |`byte; virtual; abstract;`|Reads the current value of the specified relative port or internal peripheral register.        |
|**Method**  |`procedure Reset;`    |`virtual; abstract;`      |Resets the internal state and registers of the peripheral.                                     |
|**Method**  |`procedure WritePort;`|`virtual; abstract;`      |Writes data to the specified relative peripheral port or control register.                     |
|**Property**|`MaxRelAddress`       |`qword`                   |The highest valid internal relative port address of the I/O block.                             |
|**Property**|`ReadOnly`            |`boolean`                 |If `true`, the I/O port group operates as input-only, and write operations are disabled.       |
|**Property**|`Size`                |`qword`                   |The number of ports/registers allocated by the peripheral.                                     |
