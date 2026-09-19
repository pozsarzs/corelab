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
  Buttons, breakpointframe, uconfig, ubreakpoint, ucommon;
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
    procedure FormShow(Sender: TObject);
  private
    FBreakpointList: TBreakpointList;
  public
    property BreakpointList: TBreakpointList write FBreakpointList;
  end;
var
  Form10: TForm10;

implementation

{$R *.lfm}

{ TForm10 }

// ---- EVENT HANDLER METHODS ----

// APPLY
procedure TForm10.Button1Click(Sender: TObject);
var
  BPLine:     TFrame1;
  Breakpoint: TBreakpoint;
  i:          Integer;
begin
  if not Assigned(FBreakpointList) then Exit;
  FBreakpointList.Clear;
  for i := 0 to ScrollBox1.ControlCount - 1 do
  begin
    BPLine := ScrollBox1.Controls[i] as TFrame1;
    Breakpoint := TBreakpoint.Create;
    if Length(BPLine.Edit1.Text) > 0 then
    begin
      Breakpoint.Address := StrToDWord('$' + RemoveSpace(BPLine.Edit1.Text));
      Breakpoint.Enabled := BPLine.CheckBox1.Checked;
      FBreakpointList.Add(Breakpoint);
    end;
  end;
  Close;
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
  Close;
end;

// SHOW FORM
procedure TForm10.FormShow(Sender: TObject);
var
  i:      Integer;
  BPLine: TFrame1;
begin
  // retrieve settings
  with uconfig.AppConfig.BPManagerConfig do
  begin
    Form10.Top := top;
    Form10.Left := left;
    Form10.Height := height;
    Form10.Width := width;
  end;
  // clear scrollbox
  while ScrollBox1.ControlCount > 0 do ScrollBox1.Controls[0].Free;
  // make lines
  if not Assigned(FBreakpointList) then Exit else
  begin
    for i := 0 to FBreakpointList.Count - 1 do
    begin
      BPLine := TFrame1.Create(nil);
      BPLine.Edit1.Text := IntToHex(FBreakpointList.Items[i].Address, 6);
      BPLine.CheckBox1.Checked := FBreakpointList.Items[i].Enabled;
      BPLine.Parent := ScrollBox1;
      BPLine.Align := alTop;
    end;
  end;
end;

// CLOSE FORM
procedure TForm10.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
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

