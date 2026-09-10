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
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Button1: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ColorBox1: TColorBox;
    ColorBox10: TColorBox;
    ColorBox11: TColorBox;
    ColorBox12: TColorBox;
    ColorBox13: TColorBox;
    ColorBox14: TColorBox;
    ColorBox15: TColorBox;
    ColorBox16: TColorBox;
    ColorBox17: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    ColorBox4: TColorBox;
    ColorBox5: TColorBox;
    ColorBox6: TColorBox;
    ColorBox7: TColorBox;
    ColorBox8: TColorBox;
    ColorBox9: TColorBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
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
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
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
    // Breakpoint Manager
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
    // Module Manager
    // Plugin properties
    // RegViewer
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
    // Breakpoint Manager
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
    // Module Manager
    // Plugin properties
    // RegViewer
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
  // Settings
  with uconfig.AppConfig.SettingsConfig do
  begin
    Form18.Top := top;
    Form18.Left := left;
    Form18.Height := height;
    Form18.Width := width;
  end;
end;


end.

