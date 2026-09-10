{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmclasslist.pas                                                         | }
{ | Class list for instantiate                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmclasslist;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;
type
  { TForm16 }
  TForm16 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    procedure Button5Click(Sender: TObject);
  private
    FPluginList: TStringList;
    FSelectedKey: string;
    FSelectedName: string;
    procedure SetFPluginList(AStringList: TStringList);
  public
    property PluginList: TStringList write SetFPluginList;
    property SelectedKey: string read FSelectedKey;
    property SelectedName: string read FSelectedName;
  end;

var
  Form16: TForm16;

implementation

{$R *.lfm}
{ TForm16 }

// ---- PRIVATE METHODS ----

// LOAD PLUGIN LIST TO LISTBOX
procedure TForm16.SetFPluginList(AStringList: TStringList);
begin
  FPluginList := AStringList;
  ListBox1.Clear;
  ListBox1.Items.Assign(FPluginList);
  if ListBox1.Items.Count > 0
    then Button5.Enabled := True
    else Button5.Enabled := False;
end;

// ---- EVENT HANDLER METHODS ----

// SELECT ITEM
procedure TForm16.Button5Click(Sender: TObject);
begin
  if (ListBox1.ItemIndex > -1) and (Length(Edit1.Text) > 0) then
  begin
    FSelectedKey := ListBox1.Items[ListBox1.ItemIndex];
    FSelectedName := Edit1.Text;
    ModalResult := mrOk;
  end;
end;

end.

