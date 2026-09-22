{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-f.pas                                                                | }
{ | Commands of File menu                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('NWPR',
                                'Change to interactive mode and create new project.',
                                csInteractiveOnly,
                                'NWPR',
                                0,
                                @Form1.FNewProjectOperation,
                                False));

RegisterCommand(TCommand.Create('LDPR',
                                'Change to interactive mode and load project from file.',
                                csInteractiveOnly,
                                'LDPR filename.clprj',
                                1,
                                @Form1.FLoadProjectOperation,
                                False));
                                
RegisterCommand(TCommand.Create('SVPR',
                                'Save project to file.',
                                csInteractiveOnly,
                                'SVPR filename.clprj',
                                1,
                                @Form1.FSaveProjectAsOperation,
                                False));

RegisterCommand(TCommand.Create('CHWD',
                                'Change work directory.',
                                csEveryWhere,
                                'CHWD directory',
                                1,
                                @Form1.FChangeWorkDirectoryOperation,
                                False));

RegisterCommand(TCommand.Create('RSAP',
                                'Restart application.',
                                csEverywhere,
                                'RSAP',
                                0,
                                @Form1.FRestartApplicationOperation,
                                True));

RegisterCommand(TCommand.Create('EXAP',
                                'Exit from application.',
                                csEverywhere,
                                'EXAP',
                                0,
                                @Form1.FExitOperation,
                                True));
