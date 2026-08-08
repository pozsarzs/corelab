# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TIOPort from core_ioport unit

`TIOPort` is an abstract base class for I/O-port device implementations. It defines common address-range, data-line decoding, interrupt, state-persistence, and module-identification properties. Concrete devices must implement reset, port read, and port write operations.

### Related types

|name |type |description|
|-----|-----|-----------|
|`TLineMode`|enumeration|Data-line decoding mode: `lmDirect` or `lmBCD`|
|`TInterruptCallback`|procedure type|Interrupt callback receiving the source port and interrupt vector|
|`TSemanticVersion`|record|Major, minor, and patch version information|

### Type helpers

|name |description|
|-----|------------|
|`TLineModeHelper.ToString`|Converts a line mode to its enumeration name|
|`TLineModeHelper.FromString`|Converts an enumeration name to `TLineMode`|
|`TSemanticVersionHelper.ToString`|Formats a version as `Major.Minor.Patch`|
|`TSemanticVersionHelper.Compare`|Compares two semantic versions; returns `-1`, `0`, or `1`|

### Protected fields

|name |type |description |initial value|
|-----|-----|-------------|-------------|
|`FAddressRangeSize`|`Word`|Address range size|`1`|
|`FDataInMode`|`TLineMode`|Input data-line decoding mode|`lmBCD`|
|`FDataInNegation`|`Boolean`|Input data-bit negation|`false`|
|`FDataOutMode`|`TLineMode`|Output data-line decoding mode|`lmBCD`|
|`FDataOutNegation`|`Boolean`|Output data-bit negation|`false`|
|`FDescription`|`PChar`|Short description|not initialized here|
|`FEnabled`|`Boolean`|Enable the port without detaching it from the bus|`false`|
|`FHasPanel`|`Boolean`|Indicates whether the implementation has a GUI panel|`false`|
|`FInstanceID`|`Integer`|Module instance ID|`-1`|
|`FIntVector`|`Byte`|Interrupt vector|`0`|
|`FLatchedOutput`|`Boolean`|Indicates latched output capability/state|`false`|
|`FModname`|`PChar`|Module name|`MyIO`|
|`FOnInterrupt`|`TInterruptCallback`|Interrupt callback|`nil`|
|`FReadBackOutput`|`Boolean`|Indicates output read-back capability|`false`|
|`FSelMode`|`TLineMode`|Selector-line decoding mode|`lmBCD`|
|`FSelNegation`|`Boolean`|Selector-bit negation|`false`|
|`FVersion`|`TSemanticVersion`|Module version|`0.1.0`|

### Protected methods

|name |flags|description|
|-----|:---:|-----------|
|`procedure RequestInterrupt;`|Vi|Call the interrupt callback with the configured vector when the port is enabled|

`RequestInterrupt` performs no action unless `Enabled` is `true` and an interrupt callback is assigned.

### Public methods

|name |flags|description|
|-----|:---:|-----------|
|`constructor Create;`|Vi|Initialize common I/O-port settings|
|`destructor Destroy;`|Or|Destroy the I/O-port object|
|`procedure Reset;`|Ab,Vi|Reset the concrete I/O device; implementation is supplied by a derived class|
|`function ReadPort(APort: Word): Byte;`|Ab,Vi|Read a byte from a concrete I/O port|
|`procedure WritePort(APort: Word; AValue: Byte);`|Ab,Vi|Write a byte to a concrete I/O port|
|`function LoadState(AStream: TStream): Boolean;`|Vi|Load common I/O-port state from a stream|
|`function SaveState(AStream: TStream): Boolean;`|Vi|Save common I/O-port state when the instance has a valid instance ID|

### Public properties

|name |type |access|description|
|-----|-----|:----:|-----------|
|`AddressRangeSize`|`Word`|Re|Address range size|
|`DataInMode`|`TLineMode`|Re/Wr|Input data-line decoding mode|
|`DataInNegation`|`Boolean`|Re/Wr|Input data-bit negation|
|`DataOutMode`|`TLineMode`|Re/Wr|Output data-line decoding mode|
|`DataOutNegation`|`Boolean`|Re/Wr|Output data-bit negation|
|`Description`|`PChar`|Re|Short description|
|`Enabled`|`Boolean`|Re/Wr|Enable the port|
|`HasPanel`|`Boolean`|Re|Whether the implementation has a GUI panel|
|`IntVector`|`Byte`|Re/Wr|Interrupt vector|
|`InstanceID`|`Integer`|Re/Wr|Module instance ID|
|`LatchedOutput`|`Boolean`|Re|Latched-output property|
|`ModName`|`PChar`|Re|Module name|
|`OnInterrupt`|`TInterruptCallback`|Re/Wr|Interrupt callback|
|`ReadBackOutput`|`Boolean`|Re|Output read-back property|
|`SelMode`|`TLineMode`|Re/Wr|Selector-line decoding mode|
|`SelNegation`|`Boolean`|Re/Wr|Selector-bit negation|
|`Version`|`TSemanticVersion`|Re|Module version|

### State persistence

`LoadState` restores `Enabled`, the input and output line modes and negations, selector mode and negation, and the interrupt vector.

`SaveState` writes the same fields only when `InstanceID > -1`. The interrupt callback is deliberately not saved and must be assigned again by the application.
