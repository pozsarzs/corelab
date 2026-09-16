{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmmoduleexplorer.pas                                                    | }
{ | Module Explorer form                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmmoduleexplorer;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, EditBtn,
  ExtCtrls, ValEdit, Menus, uconfig, Types, LCLType, core_cpu, core_ioport,
  core_memory, uproperties;
type
  { TForm9 }
  TForm9 = class(TForm)
    EditButton1:      TEditButton;
    MenuItem1:        TMenuItem;
    MenuItem2:        TMenuItem;
    MenuItem3:        TMenuItem;
    MenuItem4:        TMenuItem;
    MenuItem5:        TMenuItem;
    MenuItem6:        TMenuItem;
    MenuItem7:        TMenuItem;
    PopupMenu1:       TPopupMenu;
    Separator1:       TMenuItem;
    Separator2:       TMenuItem;
    Separator3:       TMenuItem;
    Splitter1:        TSplitter;
    TreeView1:        TTreeView;
    ValueListEditor1: TValueListEditor;
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  private
  public
    procedure AddNode(AParentName, ANodeName: string);
    procedure DeleteNode(AParentName, ANodeName: string);
  end;
var
  Form9: TForm9;

resourcestring
  MSG01 = 'Property';
  MSG02 = 'Value';

implementation
uses frmmain;

{$R *.lfm}
{ TForm9 }

// ---- PUBLIC METHODS ----

// ADD NODE TO TREEVIEW
procedure TForm9.AddNode(AParentName, ANodeName: string);
var
  ParentNode: TTreeNode;
begin
  ParentNode := TreeView1.Items.FindNodeWithText(AParentName);
  if ParentNode <> nil then TreeView1.Items.AddChild(ParentNode, ANodeName);
end;

// DELETE NODE FROM TREEVIEW
procedure TForm9.DeleteNode(AParentName, ANodeName: string);
var
  ParentNode, Node: TTreeNode;
begin
  ParentNode := TreeView1.Items.FindNodeWithText(AParentName);
  if ParentNode <> nil then
  begin
    Node := ParentNode.FindNode(ANodename);
    if Node <> nil then Node.Delete;
  end;
end;

// ---- EVENT HANDLER METHODS ----

// FILL PROPERTY TABLE
procedure TForm9.TreeView1Click(Sender: TObject);
var
  Node, ParentNode: TTreeNode;
  MousePos:         TPoint;

  // LOAD FROM I/O PORT MODULE
  procedure LoadIOProperties(Node: TTreeNode);
  var
    PortInfo: TPortInfo;
  begin
    try
      // find instance
      PortInfo := Form1.FPortInstanceDict[Node.Text];
      // load properies
      with ValueListEditor1 do
      begin
        Clear;
        InsertRow(uproperties.IOPropertyInfoArray[0].Name, StrPas(PortInfo.Port.ModName), True);
        InsertRow(uproperties.IOPropertyInfoArray[1].Name, StrPas(PortInfo.Port.Description), True);
        InsertRow(uproperties.IOPropertyInfoArray[2].Name, PortInfo.Port.Version.ToString, True);
        InsertRow(uproperties.IOPropertyInfoArray[3].Name, BoolToStr(PortInfo.Port.Enabled, 'true', 'false'), True);
        InsertRow(uproperties.IOPropertyInfoArray[4].Name, BoolToStr(PortInfo.Port.HasPanel, 'true', 'false'), True);
        InsertRow(uproperties.IOPropertyInfoArray[6].Name, IntToStr(PortInfo.Port.AddressRangeSize), True);
        InsertRow(uproperties.IOPropertyInfoArray[5].Name, IntToHex(PortInfo.Port.BaseAddress, 2), True);
        InsertRow(uproperties.IOPropertyInfoArray[7].Name, IntToHex(PortInfo.Port.IntVector, 2), True);
        InsertRow(uproperties.IOPropertyInfoArray[8].Name, PortInfo.Port.DataInMode.ToString, True);
        InsertRow(uproperties.IOPropertyInfoArray[9].Name, BoolToStr(PortInfo.Port.DataInNegation, True), True);
        InsertRow(uproperties.IOPropertyInfoArray[10].Name, PortInfo.Port.DataInMode.ToString, True);
        InsertRow(uproperties.IOPropertyInfoArray[11].Name, BoolToStr(PortInfo.Port.DataOutNegation, True), True);
        InsertRow(uproperties.IOPropertyInfoArray[12].Name, PortInfo.Port.DataInMode.ToString, True);
        InsertRow(uproperties.IOPropertyInfoArray[13].Name, BoolToStr(PortInfo.Port.SelNegation, True), True);
        InsertRow(uproperties.IOPropertyInfoArray[14].Name, BoolToStr(PortInfo.Port.LatchedOutput, True), True);
        InsertRow(uproperties.IOPropertyInfoArray[15].Name, BoolToStr(PortInfo.Port.ReadBackOutput, True), True);
        InsertRow('Attached to bus', BoolToStr(PortInfo.AttachedToBus, 'true', 'false'), True);
        ValueListEditor1.TopRow := 1;
      end;
    except
    end;
  end;

  // LOAD FROM MEMORY MODULE
  procedure LoadMProperties(Node: TTreeNode);
  var
    MemInfo: TMemInfo;
  begin
    try
      // find instance
      MemInfo := Form1.FMemInstanceDict[Node.Text];
      // load properies
      with ValueListEditor1 do
      begin
        Clear;
        InsertRow(uproperties.MPropertyInfoArray[0].Name, StrPas(MemInfo.Memory.ModName), True);
        InsertRow(uproperties.MPropertyInfoArray[1].Name, StrPas(MemInfo.Memory.Description), True);
        InsertRow(uproperties.MPropertyInfoArray[2].Name, MemInfo.Memory.Version.ToString, True);
        InsertRow(uproperties.MPropertyInfoArray[3].Name, BoolToStr(MemInfo.Memory.Enabled, 'true', 'false'), True);
        InsertRow(uproperties.MPropertyInfoArray[5].Name, IntToStr(MemInfo.Memory.AddressRangeSize), True);
        InsertRow(uproperties.MPropertyInfoArray[4].Name, IntToHex(MemInfo.Memory.BaseAddress, 2), True);
        InsertRow(uproperties.MPropertyInfoArray[6].Name, MemInfo.Memory.MemoryMode.ToString, True);
        InsertRow('Attached to bus', BoolToStr(MemInfo.AttachedToBus, 'true', 'false'), True);
        ValueListEditor1.TopRow := 1;
      end;
    except
    end;
  end;

  // LOAD FROM PROCESSOR MODULE
  procedure LoadPProperties(Node: TTreeNode);
  var
    ProcInfo: TProcInfo;
  begin
    try
      // find instance
      ProcInfo := Form1.FProcInstanceDict[Node.Text];
      // load properies
      with ValueListEditor1 do
      begin
        Clear;
        InsertRow(uproperties.PPropertyInfoArray[0].Name, StrPas(ProcInfo.Processor.ModName), True);
        InsertRow(uproperties.PPropertyInfoArray[1].Name, StrPas(ProcInfo.Processor.Description), True);
        InsertRow(uproperties.PPropertyInfoArray[2].Name, ProcInfo.Processor.Version.ToString, True);
        InsertRow(uproperties.PPropertyInfoArray[3].Name, BoolToStr(ProcInfo.Processor.Enabled, 'true', 'false'), True);
        InsertRow(uproperties.MPropertyInfoArray[5].Name, IntToStr(ProcInfo.Processor.AddressWidth), True);
        InsertRow(uproperties.PPropertyInfoArray[6].Name, ProcInfo.Processor.Architecture.ToString, True);
        InsertRow(uproperties.PPropertyInfoArray[7].Name, ProcInfo.Processor.Endianness.ToString, True);
        InsertRow(uproperties.PPropertyInfoArray[8].Name, BoolToStr(ProcInfo.Processor.HasSeparateIOBus, 'true', 'false'), True);
        InsertRow(uproperties.PPropertyInfoArray[9].Name, IntToHex(ProcInfo.Processor.MaxIOPortAddress, 4), True);
        InsertRow(uproperties.PPropertyInfoArray[10].Name, IntToHex(ProcInfo.Processor.MaxMemAddress, 6), True);
        InsertRow(uproperties.PPropertyInfoArray[11].Name, IntToHex(ProcInfo.Processor.MaxCodeAddress, 6), True);
        InsertRow('Attached to bus', BoolToStr(ProcInfo.AttachedToBus, 'true', 'false'), True);
        ValueListEditor1.TopRow := 1;
      end;
    except
    end;
  end;

begin
  // left click position
  MousePos := TreeView1.ScreenToClient(Mouse.CursorPos);
  Node := TreeView1.GetNodeAt(MousePos.X, MousePos.Y);
  // if it is not a Node then exit
  if not Assigned(Node) then Exit;
  // get node's parent
  ParentNode := Node.Parent;
  // if this node is a parent then exit
  if not Assigned(ParentNode) then Exit;
  // fill table with node-depend data
  case ParentNode.Text of
    'I/O port & device': LoadIOProperties(Node);
    'Memory':            LoadMProperties(Node);
    'Processor':         LoadPProperties(Node);
  end;
end;

// SET AND SHOW POPUP MENU
procedure TForm9.TreeView1ContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Node, ParentNode: TTreeNode;
begin
  TreeView1Click(Sender);
  // right click position
  Node := TreeView1.GetNodeAt(MousePos.X, MousePos.Y);
  // if it is not a Node then exit
  if not Assigned(Node) then
  begin
    Handled := True;
    Exit;
  end;
  // get node's parent
  ParentNode := Node.Parent;
  // if this node is a parent then exit
  if not Assigned(ParentNode) then
  begin
    Handled := True;
    Exit;
  end;
  // set node-depend menu context
  case ParentNode.Text of
    'I/O port & device': begin
                           MenuItem1.Action := Form1.IODestroy;
                           MenuItem2.Action := Form1.IOReset;
                           MenuItem3.Action := Form1.IOEnable;
                           MenuItem4.Action := Form1.IODisable;
                           MenuItem5.Action := Form1.IOAttachToBus;
                           MenuItem6.Action := Form1.IODetachFromBus;
                           MenuItem7.Action := Form1.IOProperties;
                         end;
    'Memory':            begin
                           MenuItem1.Action := Form1.MDestroy;
                           MenuItem2.Action := Form1.MReset;
                           MenuItem3.Action := Form1.MEnable;
                           MenuItem4.Action := Form1.MDisable;
                           MenuItem5.Action := Form1.MAttachToBus;
                           MenuItem6.Action := Form1.MDetachFromBus;
                           MenuItem7.Action := Form1.MProperties;
                         end;
    'Processor':         begin
                           MenuItem1.Action := Form1.PDestroy;
                           MenuItem2.Action := Form1.PReset;
                           MenuItem3.Action := Form1.PEnable;
                           MenuItem4.Action := Form1.PDisable;
                           MenuItem5.Action := Form1.PAttachToBus;
                           MenuItem6.Action := Form1.PDetachFromBus;
                           MenuItem7.Action := Form1.PProperties;
                         end;
    else
      Handled := True;
  end;
  Handled := False;
end;

// SEARCH IN TREEVIEW
procedure TForm9.EditButton1ButtonClick(Sender: TObject);
var
  Node: TTreeNode;
begin
  if Length(EditButton1.Text) > 0 then
  begin
    Node := TreeView1.Items.FindNodeWithText(EditButton1.Text);
    if Node <> nil then Node.Selected := True;
  end;
end;

// CREATE FORM
procedure TForm9.FormCreate(Sender: TObject);
begin
  ValueListEditor1.TitleCaptions.Add(MSG01);
  ValueListEditor1.TitleCaptions.Add(MSG02);
  Visible := uconfig.AppConfig.ModuleExplorerConfig.visible;
end;

// SHOW FORM
procedure TForm9.FormShow(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig.ModuleExplorerConfig do
  begin
    Form9.Top := top;
    Form9.Left := left;
    Form9.Height := height;
    Form9.Width := width;
    TreeView1.Height := splitter;
    ValueListEditor1.ColWidths[0] := column0_width;
  end;
end;

// CLOSE FORM
procedure TForm9.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // store changeable setting
  with uconfig.AppConfig.ModuleExplorerConfig do
  begin
    top := Form9.Top;
    left := Form9.Left;
    height := Form9.Height;
    width := Form9.Width;
    splitter := TreeView1.Height;
    column0_width := ValueListEditor1.ColWidths[0];
  end;
end;

end.

