{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmbpmanager.pas                                                         | }
{ | Breakpoint Manager form                                                  | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmbpmanager;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, breakpointframe, uconfig;
type
  { TForm10 }
  TForm10 = class(TForm)
    Bevel1:     TBevel;
    Button1:    TButton;
    Button2:    TButton;
    Button3: TButton;
    ScrollBox1: TScrollBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  Form10: TForm10;

implementation

{$R *.lfm}
{ TForm10 }

// ---- EVENT HANDLER METHODS ----

// APPLY
procedure TForm10.Button1Click(Sender: TObject);
begin
  {...}
end;

// ADD NEW LINE
procedure TForm10.Button2Click(Sender: TObject);
var
  BPLine: TFrame1;
begin
  BPLine := TFrame1.Create(nil);
  BPLine.Parent := ScrollBox1;
  BPLine.Align := alTop;
end;

// CLOSE
procedure TForm10.Button3Click(Sender: TObject);
begin
  {...}
end;

// CREATE FORM
procedure TForm10.FormCreate(Sender: TObject);
begin
  {...}
end;

// SHOW FORM
procedure TForm10.FormShow(Sender: TObject);
begin
  // retrieve settings
  with uconfig.AppConfig.BPManagerConfig do
  begin
    Form10.Top := top;
    Form10.Left := left;
    Form10.Height := height;
    Form10.Width := width;
  end;
  {...}
end;

// CLOSE FORM
procedure TForm10.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  {...}
  // store settings
  with uconfig.AppConfig.BPManagerConfig do
  begin
    top := Form10.Top;
    left := Form10.Left;
    height := Form10.Height;
    width := Form10.Width;
  end;
end;

end.

