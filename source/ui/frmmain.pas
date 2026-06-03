{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmmain.pas                                                              | }
{ | Application main form                                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmmain;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus;
type
  { TMainForm }
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    StatusBar1: TStatusBar;
  private
  public
  end;
var
  MainForm: TMainForm;

implementation

{$R *.lfm}

end.
