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
  ExtCtrls, ValEdit;
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
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;
var
  Form9: TForm9;

implementation

{$R *.lfm}
{ TForm9 }

// ---- EVENT HANDLER METHODS ----

// CREATE FORM
procedure TForm9.FormCreate(Sender: TObject);
begin

end;

// SHOW FORM
procedure TForm9.FormShow(Sender: TObject);
begin

end;

// CLOSE FORM
procedure TForm9.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

end.

