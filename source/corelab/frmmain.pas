{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmmain;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ComCtrls, ActnList, StdCtrls;
type
  { TForm1 }
  TForm1 = class(TForm)
    Separator44: TMenuItem;
    Separator43: TMenuItem;
    Separator42: TMenuItem;
    MExamineDeposit: TAction;
    MSaveMemoryContent: TAction;
    MLoadMemoryContent: TAction;
    Separator41: TMenuItem;
    Separator40: TMenuItem;
    Separator39: TMenuItem;
    Separator38: TMenuItem;
    Separator37: TMenuItem;
    Separator36: TMenuItem;
    Separator35: TMenuItem;
    Separator34: TMenuItem;
    Separator33: TMenuItem;
    Separator32: TMenuItem;
    Separator31: TMenuItem;
    Separator30: TMenuItem;
    Separator23: TMenuItem;
    Separator29: TMenuItem;
    Separator28: TMenuItem;
    Separator27: TMenuItem;
    Separator26: TMenuItem;
    Separator25: TMenuItem;
    SStepScript: TAction;
    CoolBar1: TCoolBar;
    MenuItem71: TMenuItem;
    Panel1: TPanel;
    Splitter1: TSplitter;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    VShowObjectManager: TAction;
    MenuItem62: TMenuItem;
    Separator24: TMenuItem;
    PopupMenu1: TPopupMenu;
    Separator22: TMenuItem;
    VShowHideSystemConsole: TAction;
    ActionList1:              TActionList;
    FExit:                    TAction;
    FLoadWorkspace:           TAction;
    FNewWorkspace:            TAction;
    FRestartApplication:      TAction;
    FSaveWorkspace:           TAction;
    FSaveWorkspaceAs:         TAction;
    FSettings:                TAction;
    FSwitchToInteractiveMode: TAction;
    FSwitchToScriptMode:      TAction;
    HAbout:                   TAction;
    HHelp:                    TAction;
    ImageList1:               TImageList;
    IOAttachToBus:            TAction;
    IOCreate:                 TAction;
    IODestroy:                TAction;
    IODetachFromBus:          TAction;
    IOPorperties:             TAction;
    IOReset:                  TAction;
    MainMenu1:                TMainMenu;
    MAttachToBus:             TAction;
    MCreate:                  TAction;
    MDestroy:                 TAction;
    MDetachFromBus:           TAction;
    Memo1: TMemo;
    MenuItem1:                TMenuItem;
    MenuItem10:               TMenuItem;
    MenuItem11:               TMenuItem;
    MenuItem12:               TMenuItem;
    MenuItem13:               TMenuItem;
    MenuItem14:               TMenuItem;
    MenuItem15:               TMenuItem;
    MenuItem16:               TMenuItem;
    MenuItem17:               TMenuItem;
    MenuItem18:               TMenuItem;
    MenuItem19:               TMenuItem;
    MenuItem2:                TMenuItem;
    MenuItem20:               TMenuItem;
    MenuItem21:               TMenuItem;
    MenuItem22:               TMenuItem;
    MenuItem23:               TMenuItem;
    MenuItem24:               TMenuItem;
    MenuItem25:               TMenuItem;
    MenuItem26:               TMenuItem;
    MenuItem27:               TMenuItem;
    MenuItem28:               TMenuItem;
    MenuItem29:               TMenuItem;
    MenuItem3:                TMenuItem;
    MenuItem30:               TMenuItem;
    MenuItem31:               TMenuItem;
    MenuItem32:               TMenuItem;
    MenuItem33:               TMenuItem;
    MenuItem34:               TMenuItem;
    MenuItem35:               TMenuItem;
    MenuItem36:               TMenuItem;
    MenuItem37:               TMenuItem;
    MenuItem38:               TMenuItem;
    MenuItem39:               TMenuItem;
    MenuItem4:                TMenuItem;
    MenuItem40:               TMenuItem;
    MenuItem41:               TMenuItem;
    MenuItem42:               TMenuItem;
    MenuItem43:               TMenuItem;
    MenuItem44:               TMenuItem;
    MenuItem45:               TMenuItem;
    MenuItem46:               TMenuItem;
    MenuItem47:               TMenuItem;
    MenuItem48:               TMenuItem;
    MenuItem49:               TMenuItem;
    MenuItem5:                TMenuItem;
    MenuItem50:               TMenuItem;
    MenuItem51:               TMenuItem;
    MenuItem52:               TMenuItem;
    MenuItem53:               TMenuItem;
    MenuItem54:               TMenuItem;
    MenuItem55:               TMenuItem;
    MenuItem56:               TMenuItem;
    MenuItem57:               TMenuItem;
    MenuItem58:               TMenuItem;
    MenuItem59:               TMenuItem;
    MenuItem6:                TMenuItem;
    MenuItem60:               TMenuItem;
    MenuItem61:               TMenuItem;
    MenuItem63:               TMenuItem;
    MenuItem64:               TMenuItem;
    MenuItem66:               TMenuItem;
    MenuItem68:               TMenuItem;
    MenuItem69:               TMenuItem;
    MenuItem7:                TMenuItem;
    MenuItem70:               TMenuItem;
    MenuItem8:                TMenuItem;
    MenuItem9:                TMenuItem;
    MProperties:              TAction;
    MReset:                   TAction;
    OClearAllBreakpoints:        TAction;
    OIRQ:                     TAction;
    OMakeSnapshot:            TAction;
    ONMI:                     TAction;
    OResetAll:                TAction;
    ORestoreSnapshot:         TAction;
    ORun:                     TAction;
    OStep:                    TAction;
    OStop:                    TAction;
    OToggleBreakpoint:       TAction;
    PageControl1:             TPageControl;
    PAttachToBus:             TAction;
    PCreate:                  TAction;
    PDestroy:                 TAction;
    PDetachFromBus:           TAction;
    PProperties:              TAction;
    PReset:                   TAction;
    SStopScript:             TAction;
    SClearScriptBuffer:       TAction;
    Separator1:               TMenuItem;
    Separator10:              TMenuItem;
    Separator11:              TMenuItem;
    Separator12:              TMenuItem;
    Separator13:              TMenuItem;
    Separator14:              TMenuItem;
    Separator15:              TMenuItem;
    Separator16:              TMenuItem;
    Separator17:              TMenuItem;
    Separator18:              TMenuItem;
    Separator19:              TMenuItem;
    Separator2:               TMenuItem;
    Separator20:              TMenuItem;
    Separator21:              TMenuItem;
    Separator3:               TMenuItem;
    Separator4:               TMenuItem;
    Separator5:               TMenuItem;
    Separator6:               TMenuItem;
    Separator7:               TMenuItem;
    Separator8:               TMenuItem;
    Separator9:               TMenuItem;
    SLoadScript:              TAction;
    SNewScript:               TAction;
    SRunScript:               TAction;
    SSaveScript:              TAction;
    SSaveScriptAs:            TAction;
    TabSheet1:                TTabSheet;
    TabSheet2:                TTabSheet;
    TabSheet3:                TTabSheet;
    TabSheet4:                TTabSheet;
    TabSheet5:                TTabSheet;
    ToolBar2:                 TToolBar;
    ToolBar3:                 TToolBar;
    ToolBar4:                 TToolBar;
    ToolBar5:                 TToolBar;
    ToolBar6:                 TToolBar;
    ToolButton1:              TToolButton;
    ToolButton2:              TToolButton;
    ToolButton3:              TToolButton;
    ToolButton4:              TToolButton;
    ToolButton5:              TToolButton;
    VMoveResizeIOPanel:       TAction;
    VRenameIOPanel:           TAction;
    VShowBreakpointManager:   TAction;
    VShowHexViewer:           TAction;
    VShowHideIOPanel:         TAction;
    VShowIntLogger:           TAction;
    VShowRegViewer:           TAction;
    VShowRunLogger:           TAction;
    VShowScriptConsole:       TAction;
    VShowScriptEditor:        TAction;
    procedure FormCreate(Sender: TObject);
    procedure HAboutExecute(Sender: TObject);
    procedure HHelpExecute(Sender: TObject);
    procedure ORunExecute(Sender: TObject);
  private
  public
  end;
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



// ----

// HELP/HELP
procedure TForm1.HHelpExecute(Sender: TObject);
begin

end;

procedure TForm1.ORunExecute(Sender: TObject);
begin

end;

// HELP/ABOUT
procedure TForm1.HAboutExecute(Sender: TObject);
begin

end;

// ----


procedure TForm1.FormCreate(Sender: TObject);
begin

end;



end.

