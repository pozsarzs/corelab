{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | srvbus.pas                                                               | }
{ | Service bus module                                                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit srvbus;
{$MODE OBJFPC}{$H+}
interface
uses
  CMem, Classes, core_cpu, core_memory, core_ioport;
type
  // SrvBus (TSupervisor -> TCPU and other device classes)
  ISrvBus = interface
    ['{B6F7E1C4-5B9C-5D7B-9062-9E48C2D92345}']
    // All device
    procedure Reset;
    function LoadState(AStream: TStream): Boolean;
    function SaveState(AStream: TStream): Boolean;
    // Only memory device
    procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord);
    procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord);
    // Only with GUI panel
    procedure CreatePanel;
    procedure FreePanel;
    procedure ShowPanel;
    procedure HidePanel;
    procedure RenamePanel(ACaption: PChar);
    function ResizePanel(AWidth, AHeight: Integer): Boolean;
    function MovePanel(ALeft, ATop: Integer): Boolean;
  end;

implementation

end.
