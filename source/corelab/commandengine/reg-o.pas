{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-o.pas                                                                | }
{ | Commands of Operation menu                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('RUN',
                                'Run simulation.',
                                [csCommandLine, csScript],
                                'RUN',
                                0,
                                @Form1.ORunOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('STEP',
                                'Run simulation step-by-step.',
                                [csCommandLine, csScript],
                                'STEP',
                                0,
                                @Form1.OStepOperation,
                                False,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('STOP',
                                'Stop simulation.',
                                [csCommandLine, csScript],
                                'STOP',
                                0,
                                @Form1.OStopOperation,
                                True,
                                [omInteractive, omScript]));

RegisterCommand(TCommand.Create('NMI',
                                'Call non-maskable interrupt.',
                                [csCommandLine],
                                'NMI',
                                0,
                                @Form1.ONMIOperation,
                                False,
                                [omInteractive]));

RegisterCommand(TCommand.Create('RST',
                                'Reset all module.',
                                [csCommandLine, csScript],
                                'RST',
                                0,
                                @Form1.OResetAllOperation,
                                False,
                                [omInteractive]));

{RegisterCommand(TCommand.Create('SVSS',
                                'Make and save snapshot.',
                                [csCommandLine],
                                'SVSS',
                                0,
                                @Form1.OMakeSnapshotOperation,
                                False,
                                [omInteractive]));

RegisterCommand(TCommand.Create('LDSS',
                                'Load and restore snapshot.',
                                [csCommandLine],
                                'LDSS',
                                0,
                                @Form1.ORestoreSnapshotOperation,
                                False,
                                [omInteractive]));}

