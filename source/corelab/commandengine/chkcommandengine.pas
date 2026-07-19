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

{ Note:
    The TestActionList and TestActionHandler instances represent the main
    program's connection to the scripting engine. They are not part of this. }

program chkcommandengine;
uses
  Interfaces, ActnList, command, commandengine, commandregistry, cmd_test;
type
  // Action handler class
  TActionHandler = class
  public
    procedure DoActionExecute(Sender: TObject);
  end;
var
  Cmd:               string;
  ExitCode:          Integer;
  i:                 Byte;
  TestAction:        TAction;
  TestActionHandler: TActionHandler;
  TestActionList:    TActionList;
  TestEngine:        TCommandEngine;
  TestRegistry:      TCommandRegistry;
const
  MyActions: array[0..1, 0..2] of string = (('actStart', 'actStop', 'actStatus'),
                                           ('Start', 'Stop', 'Status'));

// DO SELECTED ACTION
procedure TActionHandler.DoActionExecute(Sender: TObject);
begin
  if Sender is TAction then
    writeln('Action: ', TAction(Sender).Name, ' [', TAction(Sender).Caption, ']');
end;

begin
  writeln('CoreLAB - TCommandEngine class checker');
  writeln('Enter ''bye'' to exit');
  
  // Create and fill external TActionList instance
  TestActionList := TActionList.Create(nil);
  TestActionHandler := TActionHandler.Create; 
  for i := 0 to 2 do
  begin
    TestAction := TAction.Create(TestActionList);
    TestAction.ActionList := TestActionList;
    TestAction.Name := MyActions[0, i];
    TestAction.Caption := MyActions[1, i];
    TestAction.OnExecute := @TestActionHandler.DoActionExecute;
  end;

  // Create TCommandRegistry instance and registering command classes
  TestRegistry := TCommandRegistry.Create;
  with TestRegistry do
  begin
    RegisterCommand('teststart', TCmd_teststart);
    RegisterCommand('teststop',  TCmd_teststop);
    RegisterCommand('teststatus', TCmd_teststatus);
    RegisterCommand('bye', TCmd_bye);
  end;

  // Create and set TCommandEngine instance
  TestEngine := TCommandEngine.Create;
  with TestEngine do
  begin
    RunningMode := csInteractiveOnly;
    TestEngine.ActionList := TestActionList;
    TestEngine.Registry := TestRegistry;
  end;
  
  // Doing main operation
  with TestEngine do
    repeat
      write('> ');
      readln(cmd);
      ExitCode := ExecuteLine(cmd);
      writeln('(Exitcode: ', ExitCode, ')');
    until TestEngine.ExitRequested;

  // Destroy all instances
  TestActionHandler.Free;
  TestActionList.Free;
  TestRegistry.Free;
  TestEngine.Free;
end.
