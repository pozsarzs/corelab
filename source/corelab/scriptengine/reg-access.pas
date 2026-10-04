{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | reg-access.pas                                                           | }
{ | Data access commands                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{ RDIO WRIO RDME WRME LDRG SWAP }

RegisterCommand(TCommand.Create('RDIO',
                                'Read a value from I/O port and store in register RA.',
                                [csScript],
                                'RDIO address',
                                1,
                                @CmdRDIO,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('WRIO',
                                'Read a value from register RA and write to I/O port',
                                [csScript],
                                'WRIO address',
                                1,
                                @CmdWRIO,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('RDME',
                                'Read a value from memory and store in register RA.',
                                [csScript],
                                'RDME address',
                                1,
                                @CmdRDME,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('WRME',
                                'Read a value from register RA and store in memory',
                                [csScript],
                                'WRME address',
                                1,
                                @CmdWRME,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('LDRG',
                                'Load a value to specified register.',
                                [csScript],
                                'LDRG register|value',
                                1,
                                @CmdLDRG,
                                True,
                                [omScript]));

RegisterCommand(TCommand.Create('SWAP',
                                'Swap the values of two registers.',
                                [csScript],
                                'SWAP register register',
                                2,
                                @CmdSWAP,
                                True,
                                [omScript]));

