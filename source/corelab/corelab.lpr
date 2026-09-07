{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | corelab.lpr                                                              | }
{ | Processor simulation framework application                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

program corelab;
{$MODE OBJFPC}{$H+}
uses
  CMem, Dialogs, Interfaces, Forms, ModLCLTranslator, SysUtils, StdCtrls,
  lhelpcontrolpkg, crt, frmmain, frmabout, frmrunlogger, frmclasslist,
  frmmodulelist
   // frmscripteditor, frmhexviewer, frmexdepmemory, frmloadsavememory
  ;
const
  PRGCOPY = 'Copyright (C) 2026 Pozsar Zsolt';
  PRGHOME = 'http://www.pozsarzs.hu';
  AUTMAIL = 'pozsarzs@gmail.com';
  PRGNAME = 'CoreLAB';
  PRGVERS = '0.1';
  PARAMS: array[1..4, 1..3] of string =
    (
    ('-h', '--help', 'show help'),
    ('-v', '--version', 'show version and build information'),
    ('-d', '--dir', 'set plugin directory'),
    ('-i', '--ignore-help', 'ignore missing help file or viewer')
    );
var
  AboutLabels: TAboutLabels;
  i:           Byte;
  ExeName:     string;
  IgnoreHelp:  Boolean;
  InvalidArg:  Boolean;
  PluginDir:   string;

{$R *.res}

resourcestring
  MSG01 = 'CoreLAB Processor simulation framework';
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
  if Mode then Message := MSG07 else
  begin
    Message := MSG08 + ':' + #13 + #10;
    Message := Message + ' ' + ExeName + MSG09 + ' ' + MSG10 + #13 + #10 + #13 + #10;
    Message := Message + MSG11;
    for b := 1 to 4 do
      Message := Message + #13 + #10 + '  ' +
                 PARAMS[b, 1] + ', ' + PARAMS[b, 2] + ': ' + PARAMS[b, 3];
  end;
  {$IFDEF UNIX}
    writeln(Message);
  {$ELSE}
    Application.MessageBox(PChar(Message), PChar(Caption));
  {$ENDIF}
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
  Message := PRGCOPY + '<' + PRGHOME + '>' + LineEnding + LineEnding;
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
  // default values
  IgnoreHelp := false;
  PluginDir := '';
  ExeName := ExtractFilename(ParamStr(0));
  // arguments and operation modes
  if ParamCount > 0 then
  begin
    InvalidArg := true;
    for i := 1 to ParamCount do
    begin
      if (ParamStr(i) = PARAMS[1, 1]) or (ParamStr(i) = PARAMS[1, 2]) then
      begin
        // show help and halt
        InvalidArg := false;
        Help(False);
        Halt(0);
      end;
      if (ParamStr(i) = PARAMS[2, 1]) or (ParamStr(i) = PARAMS[2, 2]) then
      begin
        // show help and halt
        InvalidArg := false;
        Version;
        Halt(0);
      end;
      if (ParamStr(i) = PARAMS[3, 1]) or (ParamStr(i) = PARAMS[3, 2]) then
      begin
        if i < ParamCount then
        begin
          // set plugin directory
          InvalidArg := false;
          if DirectoryExists(ParamStr(i + 1), true) then PluginDir := ParamStr(i + 1);
        end;
      end;
      if (ParamStr(i) = PARAMS[4, 1]) or (ParamStr(i) = PARAMS[4, 2]) then
      begin
        // set IgnoreHelp variable
        InvalidArg := false;
        IgnoreHelp := true;
      end;
    end;
    if InvalidArg then
    begin
      // show error message and halt
      Help(True);
      Halt(0);
    end;
  end;
  // start application
  RequireDerivedFormResource := True;
  with AboutLabels do
  begin
    Copyright := PRGCOPY;
    Description := MSG01;
    Email := AUTMAIL;
    Homepage := PRGHOME;
    Name := PRGNAME;
    Version := PRGVERS;
  end;
  with Application do
  begin
    Title:='CoreLAB | Processor simulation framework';
    Scaled:=True;
    Initialize;
    CreateForm(TForm1, Form1);                                      // Main Form
    CreateForm(TForm2, Form2);                                          // About
//    CreateForm(TForm3, Form3);                                    // HexViewer
    CreateForm(TForm4, Form4);                                      // RunLogger
//    CreateForm(TForm5, Form5);                                  // ExDepMemory
//    CreateForm(TForm6, Form6);                                 // ScriptEditor
//    CreateForm(TForm7, Form7);                               // LoadSaveMemory
//    CreateForm(TForm8, Form8);                                    // IntLogger
//    CreateForm(TForm9, Form9);                               // LoadSaveMemory
//    CreateForm(TForm10, Form10);                         // Breakpoint Manager
//    CreateForm(TForm11, Form11);                                  // RegViewer
//    CreateForm(TForm12, Form12);                              // ScriptConsole
//    CreateForm(TForm13, Form13);                    // Rename I/O plugin panel
//    CreateForm(TForm14, Form14);               // Move/resize I/O plugin panel
//    CreateForm(TForm15, Form15);                          // Plugin properties
    CreateForm(TForm16, Form16);                   // Class list for instantiate
    CreateForm(TForm17, Form17);                     // Instantiated module list
  end;
  // set properties
  Form2.AboutLabels := AboutLabels;
  Form1.PluginDirectory := PluginDir;
  Form1.IgnoreHelp := IgnoreHelp;
  // start application
  Application.ProcessMessages;
  Application.Run;
end.
