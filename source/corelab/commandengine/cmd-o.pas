{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-o.pas                                                                | }
{ | Commands of Operation menu                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('RUN',
                                'Run simulation.',
                                csEverywhere,
                                'RUN',
                                0,
                                @Form1.ORunOperation,
                                False));

RegisterCommand(TCommand.Create('STEP',
                                'Run simulation step-by-step.',
                                csEverywhere,
                                'STEP',
                                0,
                                @Form1.OStepOperation,
                                False));

RegisterCommand(TCommand.Create('STOP',
                                'Stop simulation.',
                                csEverywhere,
                                'STOP',
                                0,
                                @Form1.OStopOperation,
                                True));

RegisterCommand(TCommand.Create('NMI',
                                'Call non-maskable interrupt.',
                                csEverywhere,
                                'NMI',
                                0,
                                @Form1.ONMIOperation,
                                True));

RegisterCommand(TCommand.Create('RST',
                                'Reset all module.',
                                csEverywhere,
                                'RST',
                                0,
                                @Form1.OResetAllOperation,
                                False));

RegisterCommand(TCommand.Create('SVSS',
                                'Make and save snapshot.',
                                csEverywhere,
                                'SVSS',
                                0,
                                @Form1.OMakeSnapshotOperation,
                                True));

RegisterCommand(TCommand.Create('LDSS',
                                'Load and restore snapshot.',
                                csEverywhere,
                                'LDSS',
                                0,
                                @Form1.ORestoreSnapshotOperation,
                                False));
