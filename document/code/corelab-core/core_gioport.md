# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>

## TGIOPort from core_gioport unit

`TGIOPort` is an abstract graphical I/O-port base class derived from `TIOPort`. It adds a Lazarus `TForm`-based panel and provides common panel lifetime, visibility, caption, position, size, and state persistence functionality.

Derived classes must implement `CreatePanel`.

### Private fields

|name |type |description|
|-----|-----|-----------|
|`SPanelCaption`|`String`|Internal storage for the panel caption|

### Protected fields

|name |type |description |initial value|
|-----|-----|-------------|-------------|
|`FPanelForm`|`TForm`|Graphical panel form|`nil`|
|`FPanelCaption`|`PChar`|Panel caption|`MyIO`|
|`FPanelHeight`|`Integer`|Panel height|`0`|
|`FPanelLeft`|`Integer`|Panel left position|`0`|
|`FPanelTop`|`Integer`|Panel top position|`0`|
|`FPanelWidth`|`Integer`|Panel width|`0`|

### Public methods

|name |flags|description|
|-----|:---:|-----------|
|`constructor Create;`|Or|Initialize panel caption, position, and size|
|`destructor Destroy;`| |Free the panel and destroy the object|
|`procedure CreatePanel;`|Ab,Vi|Create the implementation-specific GUI panel|
|`procedure FreePanel;`|Vi|Free the panel form if it exists|
|`procedure ShowPanel;`|Vi|Show the panel if it exists|
|`procedure HidePanel;`|Vi|Hide the panel if it exists|
|`procedure RenamePanel(ACaption: PChar);`|Vi|Change the stored caption and the form caption|
|`function MovePanel(ALeft, ATop: Integer): Boolean;`|Vi|Set panel position when both coordinates are non-negative|
|`function ResizePanel(AWidth, AHeight: Integer): Boolean;`|Vi|Set panel size when both dimensions are non-negative|
|`function LoadState(AStream: TStream): Boolean;`|Or|Load inherited I/O-port state and panel caption, size, and position|
|`function SaveState(AStream: TStream): Boolean;`|Or|Save inherited I/O-port state and panel caption, size, and position|

### Public properties

|name |type |access|description|
|-----|-----|:----:|-----------|
|`PanelCaption`|`PChar`|Re|Current panel caption|
|`PanelHeight`|`Integer`|Re|Current panel height|
|`PanelLeft`|`Integer`|Re|Current panel left position|
|`PanelTop`|`Integer`|Re|Current panel top position|
|`PanelWidth`|`Integer`|Re|Current panel width|

### Panel operation details

`MovePanel` and `ResizePanel` always update the stored position or size when the supplied values are non-negative. They return `true` only when an existing panel form is actually updated; otherwise they return `false`.

`RenamePanel` updates the internal string and `FPanelCaption`. If a panel exists, its caption is also updated and the form is invalidated and refreshed.

`FreePanel` is also called by the destructor.

### State persistence

The state extends the inherited `TIOPort` state. The panel caption is stored as a one-byte length followed by the caption characters, followed by height, left, top, and width as their native `Integer` values.

When loading, the panel is renamed, resized, and moved using the restored values.
