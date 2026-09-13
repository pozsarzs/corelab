{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd-p.pas                                                                | }
{ | Commands of Processor menu                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

RegisterCommand(TCommand.Create('CRPU',
                                'Instantiate a processor module.',
                                csEverywhere,
                                'CRPU library instancename',
                                2,
                                @Form1.PCreateOperation));

RegisterCommand(TCommand.Create('DSPU',
                                'Destroy processor module.',
                                csEverywhere,
                                'DSPU instancename',
                                1,
                                @Form1.PDestroyOperation));

RegisterCommand(TCommand.Create('RSPU',
                                'Reset processor module.',
                                csEverywhere,
                                'RSPU instancename',
                                1,
                                @Form1.PResetOperation));

RegisterCommand(TCommand.Create('ENPU',
                                'Enable processor module.',
                                csEverywhere,
                                'ENPU instancename',
                                1,
                                @Form1.PEnableOperation));

RegisterCommand(TCommand.Create('DIPU',
                                'Disable processor module.',
                                csEverywhere,
                                'DIPU instancename',
                                1,
                                @Form1.PDisableOperation));

RegisterCommand(TCommand.Create('ATPU',
                                'Attach processor module to bus.',
                                csEverywhere,
                                'ATPU instancename',
                                1,
                                @Form1.PAttachToBusOperation));

RegisterCommand(TCommand.Create('DTPU',
                                'Detach processor module from bus.',
                                csEverywhere,
                                'DTPU instancename',
                                1,
                                @Form1.PDetachFromBusOperation));
