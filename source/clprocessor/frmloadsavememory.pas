{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmloadsavememory.pas                                                    | }
{ | Examine/deposit form                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmloadsavememory;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;
type
  { TForm7 }
  TForm7 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
  private
    FAddressFrom: DWord;
    FAddressTo: DWord;
    FDataWidth: byte;
    FBank: byte;
  public
    property DataWidth: byte read FDataWidth;
    property AddressFrom: DWord read FAddressFrom;
    property AddressTo: DWord read FAddressTo;
    property Bank: byte read FBank;
  end;

var
  Form7: TForm7;

implementation

{$R *.lfm}

end.

