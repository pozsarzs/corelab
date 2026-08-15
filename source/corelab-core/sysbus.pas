{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | sysbus.pas                                                               | }
{ | System bus interface                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit sysbus;
{$MODE OBJFPC}{$H+}
interface
uses
  CMem;
type
  // ISysBus (TCPU -> TIOPort, TMemory)
  ISysBus = interface
    ['{A5E6D0B3-4A8B-4C6A-8F51-8D37B1C81234}']
    // Implemented only in TMemory class
    function ReadMemory(AAddress: DWord): QWord;
    procedure WriteMemory(AAddress: DWord; AValue: QWord);
    // Implemented only in TIOPort class
    function ReadPort(APort: Word): Byte;
    procedure WritePort(APort: Word; AValue: Byte);
  end;

implementation

end.
