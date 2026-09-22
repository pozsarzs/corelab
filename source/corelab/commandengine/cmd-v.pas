{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-v.pas                                                                | }
{ | Commands of View menu                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('SHME',
                                'Show Module Explorer window.',
                                csInteractiveOnly,
                                'SHME',
                                0,
                                @Form1.VShowModuleExplorerOperation,
                                True));

RegisterCommand(TCommand.Create('SHBM',
                                'Show BreakPoint Manager window.',
                                csInteractiveOnly,
                                'SHBM',
                                0,
                                @Form1.VShowBreakPointManagerOperation,
                                True));

RegisterCommand(TCommand.Create('SHBL',
                                'Show BusLogger window.',
                                csInteractiveOnly,
                                'SHBL',
                                0,
                                @Form1.VShowBusLoggerOperation,
                                True));

RegisterCommand(TCommand.Create('SHRL',
                                'Show RunLogger window.',
                                csInteractiveOnly,
                                'SHRL',
                                0,
                                @Form1.VShowRunLoggerOperation,
                                True));

RegisterCommand(TCommand.Create('SHIL',
                                'Show IntLogger window.',
                                csInteractiveOnly,
                                'SHIL',
                                0,
                                @Form1.VShowIntLoggerOperation,
                                True));

RegisterCommand(TCommand.Create('SHRV',
                                'Show RegViewer window.',
                                csInteractiveOnly,
                                'SHRV instancename',
                                1,
                                @Form1.VShowRegViewerOperation,
                                True));

RegisterCommand(TCommand.Create('SHHV',
                                'Show HexViewer window.',
                                csInteractiveOnly,
                                'SHHV instancename',
                                1,
                                @Form1.VShowHexViewerOperation,
                                True));

RegisterCommand(TCommand.Create('SHSE',
                                'Show ScriptEditor window.',
                                csInteractiveOnly,
                                'SHSE',
                                0,
                                @Form1.VShowScriptEditorOperation,
                                True));

RegisterCommand(TCommand.Create('SHSC',
                                'Show ScriptConsole window.',
                                csInteractiveOnly,
                                'SHSC',
                                0,
                                @Form1.VShowScriptConsoleOperation,
                                True));

RegisterCommand(TCommand.Create('RNIO',
                                'Rename I/O device panel.',
                                csEveryWhere,
                                'RNIO instancename caption',
                                2,
                                @Form1.VRenameIOPanelOperation,
                                True));

RegisterCommand(TCommand.Create('SHIO',
                                'Show I/O device panel.',
                                csEveryWhere,
                                'SHIO instancename',
                                1,
                                @Form1.VShowIOPanelOperation,
                                True));

