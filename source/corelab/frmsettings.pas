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
    Bevel1:       TBevel;
    Bevel10:      TBevel;
    Bevel11:      TBevel;
    Bevel12:      TBevel;
    Bevel2:       TBevel;
    Bevel3:       TBevel;
    Bevel4:       TBevel;
    Bevel5:       TBevel;
    Bevel6:       TBevel;
    Bevel7:       TBevel;
    Bevel8:       TBevel;
    Bevel9:       TBevel;
    Button1:      TButton;
    Button5:      TButton;
    CheckBox1:    TCheckBox;
    CheckBox2:    TCheckBox;
    ColorBox1:    TColorBox;
    ColorBox10:   TColorBox;
    ColorBox11:   TColorBox;
    ColorBox12:   TColorBox;
    ColorBox13:   TColorBox;
    ColorBox14:   TColorBox;
    ColorBox15:   TColorBox;
    ColorBox16:   TColorBox;
    ColorBox17:   TColorBox;
    ColorBox18:   TColorBox;
    ColorBox19:   TColorBox;
    ColorBox2:    TColorBox;
    ColorBox20:   TColorBox;
    ColorBox21:   TColorBox;
    ColorBox22:   TColorBox;
    ColorBox23:   TColorBox;
    ColorBox24:   TColorBox;
    ColorBox25:   TColorBox;
    ColorBox26:   TColorBox;
    ColorBox27:   TColorBox;
    ColorBox28:   TColorBox;
    ColorBox29:   TColorBox;
    ColorBox3:    TColorBox;
    ColorBox30:   TColorBox;
    ColorBox31:   TColorBox;
    ColorBox32:   TColorBox;
    ColorBox33:   TColorBox;
    ColorBox34:   TColorBox;
    ColorBox35:   TColorBox;
    ColorBox4:    TColorBox;
    ColorBox5:    TColorBox;
    ColorBox6:    TColorBox;
    ColorBox7:    TColorBox;
    ColorBox8:    TColorBox;
    ColorBox9:    TColorBox;
    Label1:       TLabel;
    Label10:      TLabel;
    Label11:      TLabel;
    Label12:      TLabel;
    Label13:      TLabel;
    Label14:      TLabel;
    Label15:      TLabel;
    Label16:      TLabel;
    Label17:      TLabel;
    Label18:      TLabel;
    Label19:      TLabel;
    Label2:       TLabel;
    Label20:      TLabel;
    Label21:      TLabel;
    Label22:      TLabel;
    Label23:      TLabel;
    Label24:      TLabel;
    Label25:      TLabel;
    Label26:      TLabel;
    Label27:      TLabel;
    Label28:      TLabel;
    Label29:      TLabel;
    Label3:       TLabel;
    Label30:      TLabel;
    Label31:      TLabel;
    Label32:      TLabel;
    Label33:      TLabel;
    Label34:      TLabel;
    Label35:      TLabel;
    Label4:       TLabel;
    Label5:       TLabel;
    Label6:       TLabel;
    Label7:       TLabel;
    Label8:       TLabel;
    Label9:       TLabel;
    PageControl1: TPageControl;
    TabSheet1:    TTabSheet;
    TabSheet2:    TTabSheet;
    TabSheet3:    TTabSheet;
    TabSheet4:    TTabSheet;
    TabSheet5:    TTabSheet;
    TabSheet6:    TTabSheet;
    TabSheet7:    TTabSheet;
    procedure Button5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
  public
  end;
var
  Form18: TForm18;

implementation

{$R *.lfm}

{ TForm18 }

// ---- EVENT HANDLER METHODS ----

// CLOSE FORM WITH BUTTON
procedure TForm18.Button5Click(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig do
  begin
    // BusLogger
    with BusLoggerConfig do
    begin
      operation_color := ColorBox33.Selected;
      device_color := ColorBox27.Selected;
      address_color := ColorBox28.Selected;
      reladdress_color := ColorBox29.Selected;
      data_color := ColorBox35.Selected;
      status_color := ColorBox30.Selected;
      lineselector_color := ColorBox31.Selected;
      bgodd_color := ColorBox32.Selected;
      bgeven_color := ColorBox34.Selected;
    end;
    // HexViewer
    with HexViewerConfig do
    begin
      address_color := ColorBox10.Selected;
      data_color := ColorBox11.Selected;
      lineselector_color := ColorBox12.Selected;
      bgodd_color := ColorBox13.Selected;
      bgeven_color := ColorBox14.Selected;
    end;
    // IntLogger
    with IntLoggerConfig do
    begin
      sender_color := ColorBox18.Selected;
      vector_color := ColorBox19.Selected;
      status_color := ColorBox20.Selected;
      flag_color := ColorBox21.Selected;
      lineselector_color := ColorBox22.Selected;
      bgodd_color := ColorBox23.Selected;
      bgeven_color := ColorBox24.Selected;
    end;
    // RunLogger
    with RunLoggerConfig do
    begin
      instcount_color := ColorBox1.Selected;
      address_color := ColorBox2.Selected;
      opcode_color := ColorBox3.Selected;
      mnemonic_color := ColorBox4.Selected;
      lineselector_color := ColorBox5.Selected;
      bgodd_color := ColorBox6.Selected;
      bgeven_color := ColorBox7.Selected;
    end;
    // ScriptConsole
    with ScriptConsoleConfig do
    begin
      ColorBox25.Selected := font_color;
      ColorBox26.Selected := bg_color;
    end;
    // ScriptEditor
    with ScriptEditorConfig do
    begin
      font_color := ColorBox15.Selected;
      bg_color := ColorBox16.Selected;
      gutterfont_color := ColorBox17.Selected;
      linenumber := CheckBox1.Checked;
      syntax := CheckBox2.Checked;
    end;
    // Settings
    with SettingsConfig do
    begin
      top := Form18.Top;
      left := Form18.Left;
      height := Form18.Height;
      width := Form18.Width;
    end;
    // SysConsole
    with SysConsoleConfig do
    begin
      font_color := ColorBox8.Selected;
      bg_color := ColorBox9.Selected;
    end;
  end;
  ModalResult := mrOk;
end;

// SHOW FORM
procedure TForm18.FormShow(Sender: TObject);
begin
  // store settings
  with uconfig.AppConfig do
  begin
    // BusLogger
    with BusLoggerConfig do
    begin
      ColorBox33.Selected := operation_color;
      ColorBox27.Selected := device_color;
      ColorBox28.Selected := address_color;
      ColorBox29.Selected := reladdress_color;
      ColorBox35.Selected := data_color;
      ColorBox30.Selected := status_color;
      ColorBox31.Selected := lineselector_color;
      ColorBox32.Selected := bgodd_color;
      ColorBox34.Selected := bgeven_color;
    end;
    // HexViewer
    with HexViewerConfig do
    begin
      ColorBox10.Selected := address_color;
      ColorBox11.Selected := data_color;
      ColorBox12.Selected := lineselector_color;
      ColorBox13.Selected := bgodd_color;
      ColorBox14.Selected := bgeven_color;
    end;
    // IntLogger
    with IntLoggerConfig do
    begin
      ColorBox18.Selected := sender_color;
      ColorBox19.Selected := vector_color;
      ColorBox20.Selected := status_color;
      ColorBox21.Selected := flag_color;
      ColorBox22.Selected := lineselector_color;
      ColorBox23.Selected := bgodd_color;
      ColorBox24.Selected := bgeven_color;
    end;
    // RunLogger
    with RunLoggerConfig do
    begin
      ColorBox1.Selected := instcount_color;
      ColorBox2.Selected := address_color;
      ColorBox3.Selected := opcode_color;
      ColorBox4.Selected := mnemonic_color;
      ColorBox5.Selected := lineselector_color;
      ColorBox6.Selected := bgodd_color;
      ColorBox7.Selected := bgeven_color;
    end;
    // ScriptConsole
    with ScriptConsoleConfig do
    begin
      ColorBox25.Selected := font_color;
      ColorBox26.Selected := bg_color;
    end;
    // ScriptEditor
    with ScriptEditorConfig do
    begin
      ColorBox15.Selected := font_color;
      ColorBox16.Selected := bg_color;
      ColorBox17.Selected := gutterfont_color;
      CheckBox1.Checked := linenumber;
      CheckBox2.Checked := syntax;
    end;
    // SysConsole
    with SysConsoleConfig do
    begin
      ColorBox8.Selected := font_color;
      ColorBox9.Selected := bg_color;
    end;
  end;
end;

// FORM CLOSE
procedure TForm18.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // store settings
  with uconfig.AppConfig.SettingsConfig do
  begin
    top := Form18.Top;
    left := Form18.Left;
    height := Form18.Height;
    width := Form18.Width;
  end;
end;

end.

