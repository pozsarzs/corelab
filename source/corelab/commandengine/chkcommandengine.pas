{ +--------------------------------------------------------------------------+ }
{ | CoreLAB v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | chkcommandengine.pas                                                     | }
{ | TCommandEngine class checker                                             | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

program chkcommandengine;
uses
  Interfaces, commandengine;
var
  TestEngine: TCommandEngine;
  Cmd:        string;
  ExitCode:   integer;
begin
  writeln('CoreLAB - TCommandEngine class checker');
  writeln('Enter ''bye'' to exit');
  TestEngine := TCommandEngine.Create;
  with TestEngine do
  begin
    repeat
      write('> ');
      readln(cmd);
      ExitCode := ExecuteLine(cmd);
      writeln('(Exitcode: ', ExitCode, ')');
    until LowerCase(cmd) = 'bye';
    Free;
  end;
end.
