{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-f.pas                                                                | }
{ | Commands of File menu                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('NWPR',
                                'Change to interactive mode and create new project.',
                                [csCommandLine],
                                'NWPR',
                                0,
                                @Form1.FNewProjectOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('LDPR',
                                'Change to interactive mode and load project from file.',
                                [csCommandLine],
                                'LDPR filename.clprj',
                                1,
                                @Form1.FLoadProjectOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('SVPR',
                                'Save project to file.',
                                [csCommandLine],
                                'SVPR filename.clprj',
                                1,
                                @Form1.FSaveProjectAsOperation,
                                False,
                                [omInteractive]));

RegisterCommand(TCommand.Create('CHWD',
                                'Change work directory.',
                                [csCommandLine, csScript],
                                'CHWD directory',
                                1,
                                @Form1.FChangeWorkDirectoryOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('RSAP',
                                'Restart application.',
                                [csCommandLine, csScript],
                                'RSAP',
                                0,
                                @Form1.FRestartApplicationOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('EXAP',
                                'Exit from application.',
                                [csCommandLine, csScript],
                                'EXAP',
                                0,
                                @Form1.FExitOperation,
                                True,
                                [omInteractive, omScript]));

