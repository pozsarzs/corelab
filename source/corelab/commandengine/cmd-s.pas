{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-s.pas                                                                | }
{ | Commands of Script menu                                                  | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('NWSC',
                                'Change to script mode and create new script.',
                                csInteractiveOnly,
                                'NWSC',
                                0,
                                @Form1.SNewScriptOperation,
                                False));

RegisterCommand(TCommand.Create('LDSC',
                                'Change to script mode and load script from file.',
                                csInteractiveOnly,
                                'LDSC filename.clsce',
                                1,
                                @Form1.SLoadScriptOperation,
                                False));

RegisterCommand(TCommand.Create('SVSC',
                                'Save script to file.',
                                csInteractiveOnly,
                                'SVSC filename.clsce',
                                1,
                                @Form1.SSaveScriptAsOperation,
                                True));

RegisterCommand(TCommand.Create('RUSC',
                                'Run script.',
                                csInteractiveOnly,
                                'RUN',
                                0,
                                @Form1.SRunScriptOperation,
                                True));

RegisterCommand(TCommand.Create('SESC',
                                'Run script step-by-step.',
                                csInteractiveOnly,
                                'SESC',
                                0,
                                @Form1.SStepScriptOperation,
                                True));

RegisterCommand(TCommand.Create('STSC',
                                'Stop script.',
                                csInteractiveOnly,
                                'STSC',
                                0,
                                @Form1.SStopScriptOperation,
                                True));

