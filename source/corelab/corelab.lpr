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
  frmmodulelist, frmsettings, frmexdepmemory, frmloadsavememory, frmhexviewer,
  frmscripteditor, frmscriptconsole, frmintlogger, frmcaption,
  frmmoduleexplorer, commandengine, uconfig, ucommon, uintelhex, uplugin,
  uproject, usysconsole, uproperties, frmbpmanager, frmregviewer, frmproperties;
const
  PRGCOPY = 'Copyright (C) 2026 Pozsar Zsolt';
  PRGHOME = 'http://www.pozsarzs.hu';
  AUTMAIL = 'pozsarzs@gmail.com';
  PRGNAME = 'CoreLAB';
  PRGVERS = '0.1';
  PARAMS: array[1..7, 1..3] of string =
    (
    ('-h', '--help', 'show help'),
    ('-v', '--version', 'show version and build information'),
    ('-d', '--dir', 'set plugin directory'),
    ('-i', '--ignore-help', 'ignore missing help file or viewer'),
    ('-s', '--script', 'switch to script mode, optionally load [filename]'),
    ('-r', '--run', 'run loaded script immediately'),
    ('-p', '--project', 'switch to project mode, optionally load [project]')
    );
var
  AboutLabels:   TAboutLabels;
  ExeName:       string;
  i:             Integer;
  IgnoreHelp:    Boolean;
  IsProjectMode: Boolean;
  IsScriptMode:  Boolean;
  PluginDir:     string;
  ProjectFile:   string;
  RunScript:     Boolean;
  ScriptFile:    string;

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
  MSG09 = ' [argument]';
  MSG10 = ' [directory|file]';
  MSG11 = 'arguments:';

// SHOW USAGE
procedure Help(Mode: Boolean);
var
  b:       Byte;
  Caption: string;
  Message: string;
begin
  Caption := MSG08;
  if Mode then Message := MSG07 else
  begin
    Message := MSG08 + ':' + #13 + #10;
    Message := Message + ' ' + ExeName + MSG09 + ' ' + MSG10 + #13 + #10 + #13 + #10;
    Message := Message + MSG11;
    for b := Low(PARAMS) to High(PARAMS) do
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
    Caption := ExeName + ' --version';
    Application.MessageBox(PChar(Message), PChar(Caption));
  {$ENDIF}
end;

begin
  // default values
  ExeName := ExtractFilename(ParamStr(0));
  IgnoreHelp := False;
  IsProjectMode := False;
  IsScriptMode := False;
  PluginDir := '';
  ProjectFile := '';
  RunScript := False;
  ScriptFile := '';

  // arguments and operation modes
  if ParamCount > 0 then
  begin
    i := 1;
    while i <= ParamCount do
    begin
      if (ParamStr(i) = PARAMS[1, 1]) or (ParamStr(i) = PARAMS[1, 2]) then
      begin
        Help(False);
        Halt(0);
      end else
        if (ParamStr(i) = PARAMS[2, 1]) or (ParamStr(i) = PARAMS[2, 2]) then
        begin
          Version;
          Halt(0);
        end else
        if (ParamStr(i) = PARAMS[3, 1]) or (ParamStr(i) = PARAMS[3, 2]) then
        begin
          if i < ParamCount then
          begin
            Inc(i);
            if DirectoryExists(ParamStr(i), True) then PluginDir := ParamStr(i);
          end;
        end else
          if (ParamStr(i) = PARAMS[4, 1]) or (ParamStr(i) = PARAMS[4, 2]) then
          begin
            IgnoreHelp := True;
          end else
            if (ParamStr(i) = PARAMS[5, 1]) or (ParamStr(i) = PARAMS[5, 2]) then
            begin
              IsScriptMode := True;
              if (i < ParamCount) and (Copy(ParamStr(i + 1), 1, 1) <> '-') then
              begin
                Inc(i);
                ScriptFile := ParamStr(i);
              end;
            end else
              if (ParamStr(i) = PARAMS[6, 1]) or (ParamStr(i) = PARAMS[6, 2]) then
              begin
                RunScript := True;
              end else
                if (ParamStr(i) = PARAMS[7, 1]) or (ParamStr(i) = PARAMS[7, 2]) then
                begin
                  IsProjectMode := True;
                  if (i < ParamCount) and (Copy(ParamStr(i + 1), 1, 1) <> '-') then
                  begin
                    Inc(i);
                    ProjectFile := ParamStr(i);
                  end;
                end else
                begin
                  Help(True);
                  Halt(0);
                end;
                Inc(i);
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
    CreateForm(TForm3, Form3);                                      // HexViewer
    CreateForm(TForm4, Form4);                                      // RunLogger
    CreateForm(TForm5, Form5);                                    // ExDepMemory
    CreateForm(TForm6, Form6);                                   // ScriptEditor
    CreateForm(TForm7, Form7);                                 // LoadSaveMemory
    CreateForm(TForm8, Form8);                                      // IntLogger
    CreateForm(TForm9, Form9);                                // Module Explorer
    CreateForm(TForm10, Form10);                           // Breakpoint Manager
    CreateForm(TForm11, Form11);                                    // RegViewer
    CreateForm(TForm12, Form12);                                // ScriptConsole
    CreateForm(TForm13, Form13);                      // Rename I/O plugin panel
    CreateForm(TForm15, Form15);                            // Module properties
    CreateForm(TForm16, Form16);                   // Class list for instantiate
    CreateForm(TForm17, Form17);                     // Instantiated module list
    CreateForm(TForm18, Form18);                                     // Settings
  end;
  // set properties
  Form2.AboutLabels := AboutLabels;
  Form1.PluginDirectory := PluginDir;
  Form1.IgnoreHelp := IgnoreHelp;
  if IsScriptMode then
  begin
    Form1.StartupScript := ScriptFile;
    Form1.AutoRunScript := RunScript;
    Form1.SetScriptMode;
  end
  else if IsProjectMode then
  begin
    Form1.StartupProject := ProjectFile;
    Form1.SetProjectMode;
  end;
  // start application
  Application.ProcessMessages;
  Application.Run;
end.

