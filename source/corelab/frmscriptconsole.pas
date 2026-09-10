{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmscriptconsole.pas                                                     | }
{ | ScriptConsole form                                                       | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmscriptconsole;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  usysconsole, uconfig;
type
  { TForm12 }
  TForm12 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Memo1:      TSysConsole;
    FBGColor:   TColor;
    FFontColor: TColor;
  public
    procedure ClearContent;
    procedure RefreshColors;
    procedure WriteMessage(const AText: string);
  end;
var
  Form12: TForm12;

implementation

{$R *.lfm}

// ---- PUBLIC METHODS ----

// REFRESH COLORS
procedure TForm12.RefreshColors;
begin
  with uconfig.AppConfig.ScriptConsoleConfig do
  begin
    Form12.FBGColor := bg_color;
    Form12.FFontColor := font_color;
    Memo1.Invalidate;
  end;
end;

// CLEAR CONSOLE
procedure TForm12.ClearContent;
begin
  Memo1.Clear;
end;

// WRITE MESSAGE TO CONSOLE
procedure TForm12.WriteMessage(const AText: string);
begin
  Memo1.Lines.Add(AText);
  Memo1.SelStart := Length(Memo1.Text);
end;

// ---- EVENT HANDLER METHODS ----

// CLEAR CONSOLE
procedure TForm12.Button2Click(Sender: TObject);
begin
  ClearContent
end;

// CLOSE FORM
procedure TForm12.Button1Click(Sender: TObject);
begin
  Close;
end;

//CREATE FORM
procedure TForm12.FormCreate(Sender: TObject);
begin
  Memo1 := TSysConsole.Create(Self);
  with Memo1 do
  begin
    Parent := Form12;
    BorderSpacing.Around:=8;
    Align := alTop;
    ReadOnly := True;
    Anchors := [akBottom];
    AnchorSide[akBottom].Control := Bevel1;
    AnchorSide[akBottom].Side := asrTop;
  end;
end;

// SHOW FORM
procedure TForm12.FormShow(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig.ScriptConsoleConfig do
  begin
    Form12.Top := top;
    Form12.Left := left;
    Form12.Height := height;
    Form12.Width := width;
  end;
  RefreshColors;
end;

// CLOSE FORM
procedure TForm12.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  // store settings
  with uconfig.AppConfig.ScriptConsoleConfig do
  begin
    top := Form12.Top;
    left := Form12.Left;
    height := Form12.Height;
    width := Form12.Width;
  end;
end;

end.

