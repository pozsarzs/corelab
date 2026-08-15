# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>

## ISvcAPI from svcapi unit

`ISvcAPI` is the CoreLAB service API interface. It groups common service operations used by the supervisor for CPU, I/O-port and memory components.

The source distinguishes operations implemented by all used classes from operations intended specifically for `TMemory` or `TGIOPort`.

### Interface methods

|name|description|
|---|---|
|`procedure Reset;`|Resets the component. The source specifies this operation as implemented in all used classes.|
|`function LoadState(AStream: TStream): Boolean;`|Loads component state from a stream. The source specifies this operation as implemented in all used classes.|
|`function SaveState(AStream: TStream): Boolean;`|Saves component state to a stream. The source specifies this operation as implemented in all used classes.|
|`procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord);`|Loads a memory block from a stream. The source specifies this operation as implemented only in `TMemory`.|
|`procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord);`|Saves a memory block to a stream. The source specifies this operation as implemented only in `TMemory`.|
|`procedure CreatePanel;`|Creates the component's panel. The source specifies this operation as implemented only in `TGIOPort`.|
|`procedure FreePanel;`|Frees the component's panel. The source specifies this operation as implemented only in `TGIOPort`.|
|`procedure ShowPanel;`|Shows the component's panel. The source specifies this operation as implemented only in `TGIOPort`.|
|`procedure HidePanel;`|Hides the component's panel. The source specifies this operation as implemented only in `TGIOPort`.|
|`procedure RenamePanel(ACaption: PChar);`|Changes the panel caption. The source specifies this operation as implemented only in `TGIOPort`.|
|`function ResizePanel(AWidth, AHeight: Integer): Boolean;`|Changes the panel size. The source specifies this operation as implemented only in `TGIOPort`.|
|`function MovePanel(ALeft, ATop: Integer): Boolean;`|Changes the panel position. The source specifies this operation as implemented only in `TGIOPort`.|

### Interface identifier

`ISvcAPI` is identified by GUID:

`{B6F7E1C4-5B9C-5D7B-9062-9E48C2D92345}`

### Usage

The source comment identifies `ISvcAPI` as the service path from `TSupervisor` to `TCPU`, `TIOPort` and `TMemory`.

`TBus` implements `ISvcAPI` and therefore exposes the service operations at the bus level as well.
