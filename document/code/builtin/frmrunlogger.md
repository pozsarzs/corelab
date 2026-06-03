# CoreLAB

## Source code

### RunLogger module

**Class:** TRunLogger  
**Type:** visual component  
**File:** `builtin/frmrunlogger.pas`  
**Target:** compiled into main executable  

|Type        |Name                       |Type/return value  |Description                                                                              |
|------------|---------------------------|-------------------|-----------------------------------------------------------------------------------------|
|**Method**  |`constructor Create;`      |`virtual;`         |Initializes the logger interface, internal buffers, and component states.                |
|**Method**  |`procedure Clear;`         |`virtual;`         |Empties the log buffer and clears all items from the visual display.                     |
|**Method**  |`procedure HandleCPUEvent;`|`TCPUEventHandler;`|Callback method registered to the CPU to catch execution cycles and log instruction data.|
|**Method**  |`procedure Hide;`          |`virtual;`         |Hides the visual RunLogger window.                                                       |
|**Method**  |`procedure SaveToFile;`    |`virtual;`         |Exports the current log buffer content into a text file.                                 |
|**Method**  |`procedure Show;`          |`virtual;`         |Displays the visual RunLogger window.                                                    |
|**Method**  |`procedure UpdateUI;`      |`virtual;`         |Refreshes the visual listbox items and status bar panels from the internal buffer.       |
|**Property**|`AutoScroll`               |`boolean`          |If `true`, the visual listbox automatically scrolls down to display the latest log entry.|
|**Property**|`BufferSize`               |`integer`          |Maximum number of allowed lines in the log buffer before older entries are discarded.    |
|**Property**|`Height`                   |`integer`          |The vertical size of the visual logger window in pixels.                                 |
|**Property**|`IsPaused`                 |`boolean`          |Suspends visual interface updates while the underlying simulation continues running.     |
|**Property**|`Left`                     |`integer`          |The horizontal screen coordinate of the visual logger window.                            |
|**Property**|`Top`                      |`integer`          |The vertical screen coordinate of the visual logger window.                              |
|**Property**|`Visible`                  |`boolean`          |Indicates whether the RunLogger GUI window is currently shown on screen.                 |
|**Property**|`Width`                    |`integer`          |The horizontal size of the visual logger window in pixels.                               |
