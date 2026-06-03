{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmrunlogger.pas                                                         | }
{ | Run logger modul                                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmrunlogger;
{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, ActnList;
type
  { TRunLogger }
  TRunLogger = class(TForm)
    ActionList1: TActionList;
    ImageList1: TImageList;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    PopupMenu1: TPopupMenu;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
  private
  public
    constructor Create;
    procedure Clear;` | `virtual;` | Empties the log buffer and clears all items from the visual display. |
    | **Method** | `procedure CopyToClipboard;` | `virtual;` | Copies the raw text of the currently selected log lines to the system clipboard. |
    | **Method** | `procedure HandleCPUEvent;` | `TCPUEventHandler;` | Callback method registered to the CPU to catch execution cycles and log instruction data. |
    | **Method** | `procedure Hide;` | `virtual;` | Hides the visual RunLogger window. Can be triggered via command line interface (CLI). |
    | **Method** | `procedure SaveToFile;` | `virtual;` | Exports the current log buffer content into a text or log file. |
    | **Method** | `procedure Show;` | `virtual;` | Displays the visual RunLogger window. Can be triggered via command line interface (CLI). |
    | **Method** | `procedure UpdateUI;` | `virtual;` | Refreshes the visual listbox items and status bar panels from the internal buffer. |
    | **Property** | `AutoScroll` | `boolean` | If `true`, the visual listbox automatically scrolls down to display the latest log entry. |
    | **Property** | `BufferSize` | `integer` | Maximum number of allowed lines in the log buffer before older entries are discarded. |
    | **Property** | `Height` | `integer` | The vertical size of the visual logger window in pixels. |
    | **Property** | `IsPaused` | `boolean` | Suspends visual interface updates while the underlying simulation continues running. |
    | **Property** | `Left` | `integer` | The horizontal screen coordinate of the visual logger window. |
    | **Property** | `Top` | `integer` | The vertical screen coordinate of the visual logger window. |
    | **Property** | `Visible` | `boolean` | Indicates whether the RunLogger GUI window is currently shown on screen. |
    | **Property** | `Width` | `integer` | The horizontal size of the visual logger window in pixels. |
  end;
var
  RunLogger: TRunLogger;

implementation

{$R *.lfm}

end.

