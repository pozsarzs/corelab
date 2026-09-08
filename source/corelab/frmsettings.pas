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

unit frmsettings;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, ColorBox, uconfig;
type
  { TForm18 }
  TForm18 = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Button1: TButton;
    Button5: TButton;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    ColorBox5: TColorBox;
    ColorBox6: TColorBox;
    ColorBox7: TColorBox;
    ColorBox8: TColorBox;
    ColorBox9: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button5Click(Sender: TObject);
  private
    FAppConfig: TAppConfig;
  public
    procedure SetFAppConfig(AAppConfig: TAppConfig);
    property AppConfig: TAppConfig read FAppConfig write SetFAppConfig;
  end;

var
  Form18: TForm18;

implementation

{$R *.lfm}
{ TForm18 }

// ---- PRIVATE METHODS ----

// SET APPCONFIG FIELD
procedure TForm18.SetFAppConfig(AAppConfig: TAppConfig);
begin
  FAppConfig := AAppConfig;
  with FAppConfig do
  begin
    ColorBox1.Selected := runlogger_instcount_color;
    ColorBox2.Selected := runlogger_address_color;
    ColorBox3.Selected := runlogger_opcode_color;
    ColorBox4.Selected := runlogger_mnemonic_color;
    ColorBox5.Selected := runlogger_lineselector_color;
    ColorBox6.Selected := runlogger_bgcolor_odd;
    ColorBox7.Selected := runlogger_bgcolor_even;
    ColorBox8.Selected := sysconsole_font_color;
    ColorBox9.Selected := sysconsole_bg_color;
  end;
end;

// ---- EVENT HANDLER METHODS ----

procedure TForm18.Button5Click(Sender: TObject);
begin
  with FAppConfig do
  begin
    runlogger_instcount_color := ColorBox1.Selected;
    runlogger_address_color := ColorBox1.Selected;
    runlogger_opcode_color := ColorBox2.Selected;
    runlogger_mnemonic_color := ColorBox3.Selected;
    runlogger_lineselector_color := ColorBox4.Selected;
    runlogger_bgcolor_odd := ColorBox5.Selected;
    runlogger_bgcolor_even := ColorBox6.Selected;
    sysconsole_font_color := ColorBox8.Selected;
    sysconsole_bg_color := ColorBox9.Selected;
  end;
  ModalResult := mrOk;
end;


end.

