{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmrunlogger.pas                                                         | }
{ | Run logger modul                                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmrunlogger;
{$mode ObjFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  StdCtrls, ActnList, ExtCtrls, core_cpu;
type
  { TRunLogger }
  TRunLogger = class(TForm)
    ActionList1: TActionList;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Separator2: TMenuItem;
    Separator1: TMenuItem;
    PopupMenu1: TPopupMenu;
    ToolBar1: TToolBar;
    Timer1: TTimer;
    TStringList1: TStringList;
  private
  public
    FAutoScroll: boolean;
    FIsPaused: boolean;
//    constructor Create(AOwner: TComponent); override;
    procedure Clear;
//    procedure HandleCPUEvent;
    function SaveToFile(FileName: string): boolean;
    procedure UpdateUI;
    property AutoScroll: boolean read FAutoScroll;
    property IsPaused: boolean read FIsPaused;
  end;
var
  RunLogger: TRunLogger;

implementation
uses frmmain;
{$R *.lfm}

procedure TRunLogger.Clear;
begin
end;

//procedure TRunLogger.HandleCPUEvent(Sender: TObject; EventType: TCPUEventType);
//begin
  //if EventType = evInstructionExecuted then
  //begin
    // Csak ekkor kérjük le a nehéz stringet, így nem lassul a CPU mag feleslegesen
    //LogLine(TCPU(Sender).GetCurrentInstruction);
  //end;
//end;

function TRunLogger.SaveToFile(FileName: string): boolean;
begin
end;

procedure TRunLogger.UpdateUI;
begin
end;

end.

