{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-v.pas                                                                | }
{ | Commands of View menu                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('SHME',
                                'Show Module Explorer window.',
                                [csCommandLine],
                                'SHME',
                                0,
                                @Form1.VShowModuleExplorerOperation,
                                True,
                                [omInteractive]));

RegisterCommand(TCommand.Create('SHBM',
                                'Show BreakPoint Manager window.',
                                [csCommandLine],
                                'SHBM',
                                0,
                                @Form1.VShowBreakPointManagerOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHBL',
                                'Show BusLogger window.',
                                [csCommandLine, csScript],
                                'SHBL',
                                0,
                                @Form1.VShowBusLoggerOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHRL',
                                'Show RunLogger window.',
                                [csCommandLine, csScript],
                                'SHRL',
                                0,
                                @Form1.VShowRunLoggerOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHIL',
                                'Show IntLogger window.',
                                [csCommandLine, csScript],
                                'SHIL',
                                0,
                                @Form1.VShowIntLoggerOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHRV',
                                'Show RegViewer window.',
                                [csCommandLine, csScript],
                                'SHRV instancename',
                                1,
                                @Form1.VShowRegViewerOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHHV',
                                'Show HexViewer window.',
                                [csCommandLine, csScript],
                                'SHHV instancename',
                                1,
                                @Form1.VShowHexViewerOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHSE',
                                'Show ScriptEditor window.',
                                [csCommandLine, csScript],
                                'SHSE',
                                0,
                                @Form1.VShowScriptEditorOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHSC',
                                'Show ScriptConsole window.',
                                [csCommandLine, csScript],
                                'SHSC',
                                0,
                                @Form1.VShowScriptConsoleOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('RNIO',
                                'Rename I/O device panel.',
                                [csCommandLine, csScript],
                                'RNIO instancename caption',
                                2,
                                @Form1.VRenameIOPanelOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SHIO',
                                'Show I/O device panel.',
                                [csCommandLine, csScript],
                                'SHIO instancename',
                                1,
                                @Form1.VShowIOPanelOperation,
                                True,
                                [omInteractive, omScript]));

