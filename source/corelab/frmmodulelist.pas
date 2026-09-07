{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmmodulelist.pas                                                        | }
{ | Instantiated module list                                                 | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmmodulelist;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;
type
  { TForm17 }
  TForm17 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button5: TButton;
    Label2: TLabel;
    ListBox1: TListBox;
    procedure Button5Click(Sender: TObject);
  private
    FModuleList: TStringList;
    FSelectedKey: string;
    procedure SetOKButtonCaption(ACaption: string);
    procedure SetFModuleList(AStringList: TStringList);
  public
    property ModuleList: TStringList write SetFModuleList;
    property SelectedKey: string read FSelectedKey;
    property OKButtonCaption: string write SetOKButtonCaption;
  end;

var
  Form17: TForm17;

implementation

// ---- PRIVATE METHODS ----

// SET OK BUTTON CAPTION
procedure TForm17.SetOKButtonCaption(ACaption: string);
begin
  Button5.Caption := ACaption;
end;

// LOAD PLUGIN LIST TO LISTBOX
procedure TForm17.SetFModuleList(AStringList: TStringList);
begin
  FModuleList := AStringList;
  ListBox1.Clear;
  ListBox1.Items.Assign(FModuleList);
  if ListBox1.Items.Count > 0
    then Button5.Enabled := True
    else Button5.Enabled := False;
end;

// ---- EVENT HANDLER METHODS ----

// SELECT ITEM
procedure TForm17.Button5Click(Sender: TObject);
begin
  if ListBox1.ItemIndex > -1 then
  begin
    FSelectedKey := ListBox1.Items[ListBox1.ItemIndex];
    ModalResult := mrOk;
  end;
end;

{$R *.lfm}

end.

