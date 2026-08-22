{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmcaption.pas                                                           | }
{ | Set panel caption form                                                   | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmcaption;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Spin;
type
  { TForm3 }
  TForm3 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
  private
    function GetCaption: string;
    procedure SetCaption(Title: string);
  public
    property PanelCaption: string read GetCaption write SetCaption;
  end;
var
  Form3: TForm3;

implementation

{$R *.lfm}

// ---- PRIVATE METHODS ----

// GET VALUES
function TForm3.GetCaption: string;
begin
  Result := Edit1.Text;
end;

// SET VALUE
procedure TForm3.SetCaption(Title: string);
begin
  Edit1.Text := Title;
end;

// ---- EVENT HANDLER METHODS ----

// EDITINGDONE EVENT
procedure TForm3.Edit1EditingDone(Sender: TObject);
begin
  Button1.Click;
end;

// CLOSE WITH CANCEL
procedure TForm3.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

// CLOSE WITH OK
procedure TForm3.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

end.

