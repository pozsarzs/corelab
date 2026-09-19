{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmsizepos.pas                                                           | }
{ | Set panel size and position form                                         | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmsizepos;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Spin;
type
  { TForm4 }
  TForm4 = class(TForm)
    Bevel1:    TBevel;
    Button1:   TButton;
    Button2:   TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1:    TLabel;
    Label2:    TLabel;
    Label3:    TLabel;
    Label4:    TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function GetHeightValue: integer;
    function GetLeftValue: integer;
    function GetTopValue: integer;
    function GetWidthValue: integer;
    procedure SetHeightValue(Value: integer);
    procedure SetLeftValue(Value: integer);
    procedure SetTopValue(Value: integer);
    procedure SetWidthValue(Value: integer);
  public
    property PanelLeft: integer read GetLeftValue write SetLeftValue;
    property PanelHeight: integer read GetHeightValue write SetHeightValue;
    property PanelTop: integer read GetTopValue write SetTopValue;
    property PanelWidth: integer read GetWidthValue write SetWidthValue;
  end;
var
  Form4: TForm4;

implementation

{$R *.lfm}
{ TForm4 }

// -- PRIVATE METHODS ---

// CLOSE WITH CANCEL
procedure TForm4.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

// CLOSE WITH OK
procedure TForm4.Button1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

// GET VALUES
function TForm4.GetHeightValue: integer;
begin
  Result := SpinEdit1.Value;
end;

function TForm4.GetWidthValue: integer;
begin
  Result := SpinEdit2.Value;
end;

function TForm4.GetLeftValue: integer;
begin
  Result := SpinEdit3.Value;
end;

function TForm4.GetTopValue: integer;
begin
  Result := SpinEdit4.Value;
end;

// SET VALUES
procedure TForm4.SetHeightValue(Value: integer);
begin
  SpinEdit1.Value := Value;
end;

procedure TForm4.SetWidthValue(Value: integer);
begin
  SpinEdit2.Value := Value;
end;

procedure TForm4.SetLeftValue(Value: integer);
begin
  SpinEdit3.Value := Value;
end;

procedure TForm4.SetTopValue(Value: integer);
begin
  SpinEdit4.Value := Value;
end;

end.
