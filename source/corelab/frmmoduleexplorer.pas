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
  ExtCtrls, ValEdit, uconfig;
type
  { TForm9 }
  TForm9 = class(TForm)
    EditButton1: TEditButton;
    PageControl1: TPageControl;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TreeView1: TTreeView;
    ValueListEditor1: TValueListEditor;
    ValueListEditor2: TValueListEditor;
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    procedure AddNode(AParentName, ANodeName: string);
    procedure DeleteNode(AParentName, ANodeName: string);
  end;
var
  Form9: TForm9;

implementation

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
  end;
end;

end.

