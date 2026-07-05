{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | clioport.lpr                                                             | }
{ | I/O plug-in tester application                                           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

program clioport;
{$MODE OBJFPC}{$H+}
uses
  CMem, Dialogs, Interfaces, Forms, ModLCLTranslator, SysUtils, StdCtrls, crt,
  frmabout, frmmain;
const
  PRGCOPY = '(C) 2026 Pozsar Zsolt <http://www.pozsarzs.hu>';
  PRGNAME = 'CLIOPort';
  PRGVERS = '0.1';
  PARAMS: array[1..3, 1..3] of string =
    (
    ('-d', '--dir', 'set plugin directory'),
    ('-h', '--help', 'show help'),
    ('-v', '--version', 'show version and build information')
    );
var
  b:      Byte;
  FN:     string;
  OpMode: Byte;

{$R *.res}

resourcestring
  MSG01 = 'CoreLAB I/O plugin tester';
  MSG02 = 'Build date:  ';
  MSG03 = 'Builder:     ';
  MSG04 = 'FPC version: ';
  MSG05 = 'Target OS:   ';
  MSG06 = 'Target CPU:  ';
  MSG07 = 'There are one or more bad arguments in command line.';
  MSG08 = 'Usage';
  MSG09 = '[argument]';
  MSG10 = '[directory]';
  MSG11 = 'arguments:';

// SHOW USAGE
procedure Help(Mode: Boolean);
var
  b: Byte;
  Caption: string;
  Message: string;
begin
  Caption := MSG08;
  Message := MSG07;
  if Mode then Application.MessageBox(PChar(Message), PChar(Caption)) else
  begin
    Message := MSG08 + ':' + #13 + #10;
    Message := Message + ' ' + FN + MSG09 + ' ' + MSG10 + #13 + #10 + #13 + #10;
    Message := Message + MSG11;
    for b := 1 to 3 do
      Message := Message + #13 + #10 + '  ' +
                 PARAMS[b, 1] + ', ' + PARAMS[b, 2] + ': ' + PARAMS[b, 3];
    {$IFDEF UNIX}
      writeln(Message);
    {$ELSE}
      Application.MessageBox(PChar(Message), PChar(Caption));
    {$ENDIF}
  end;
end;

// SHOW VERSION AND BUILD INFORMATION
procedure Version;
var
  Message: string;
  {$IFDEF UNIX}
    Hostname: string = {$I %HOSTNAME%};
    Username: string = {$I %USER%};
  {$ELSE}
    Caption: string;
    Hostname: string = {$I %COMPUTERNAME%};
    Username: string = {$I %USERNAME%};
  {$ENDIF}
begin
  Message := PRGNAME + ' v' + PRGVERS + ' * ' + MSG01 + LineEnding;
  Message := PRGCOPY + LineEnding + LineEnding;
  Message := Message +  MSG02 + {$I %DATE%} + ' ' + {$I %TIME%} + LineEnding;
  if Length(Username) > 0 then
  begin
    if Length(Hostname) > 0
      then Message := Message +  MSG03 + Username + '@' + Hostname + LineEnding
      else Message := Message +  MSG03 + Username + LineEnding;
  end;
  Message := Message +  MSG04 + {$I %FPCVERSION%} + LineEnding;
  Message := Message +  MSG05 + {$I %FPCTARGETOS%} + LineEnding;
  Message := Message +  MSG06 + {$I %FPCTARGETCPU%} + LineEnding;
  {$IFDEF UNIX}
    writeln(Message);
  {$ELSE}
    Caption := fn + ' --version';
    Application.MessageBox(PChar(Message), PChar(Caption));
  {$ENDIF}
end;

begin
  FN := ExtractFilename(ParamStr(0));
  OpMode := 0;
  if ParamCount = 0 then OpMode := 1 else
  begin
    for b := 1 to 3 do
      if ParamStr(1) = PARAMS[b, 1] then OpMode := 10 * b;
    for b := 1 to 3 do
      if ParamStr(1) = PARAMS[b, 2] then OpMode := 10 * b;
  end;
  WriteLn(OpMode);
  case OpMode of
    0: help(True);
    10: begin
          if ParamCount > 1 then
          begin
            frmmain.PluginDirectory := ParamStr(2);
            if not DirectoryExists(frmmain.PluginDirectory, True)
              then frmmain.PluginDirectory := '.';
          end;
          WriteLn(frmmain.PluginDirectory);
        end;
    20: help(False);
    30: version;
  end;
  if (OpMode = 1) or (OpMode = 10) then
  begin
    RequireDerivedFormResource := True;
    Application.Title := MSG01;
    Application.Scaled := True;
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
    Application.CreateForm(TForm2, Form2);
    Application.Run;
  end;
end.
