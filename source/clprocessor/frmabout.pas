{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmabout.pas                                                             | }
{ | About form                                                               | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmabout;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, LCLIntf, Forms, Controls, StdCtrls, Graphics, Dialogs,
  ExtCtrls, ComCtrls;
type
  { TForm2 }
  TAboutLabels = record
    Copyright:   string[31];
    Description: string[31];
    Email:       string[31];
    Homepage:    string[31];
    Name:        string[31];
    Version:     string[31];
  end;
  TForm2 = class(TForm)
    Bevel1:  TBevel;
    Bevel2: TBevel;
    Button1: TButton;
    Image1:  TImage;
    Label1:  TLabel;
    Label2:  TLabel;
    Label3:  TLabel;
    Label4:  TLabel;
    Label5:  TLabel;
    Label6:  TLabel;
    Label7:  TLabel;
    Label8:  TLabel;
    procedure Label5Click(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label8MouseEnter(Sender: TObject);
    procedure Label8MouseLeave(Sender: TObject);
  private
  public
    procedure SetAboutLabels(Labels: TAboutLabels);
  end;
var
  Form2: TForm2;

implementation

resourcestring
  MSG01 = 'Cannot open URL.';

{$R *.lfm}

{ TForm2 }

// ---- PUBLIC METHODS ----

// SET LABELS
procedure TForm2.SetAboutLabels(Labels: TAboutLabels);
begin
  with Labels do
  begin
    Label1.Caption := Name;
    Label2.Caption := 'v' + Version;
    Label3.Caption := Description;
    Label4.Caption := Copyright;
    Label5.Caption := Homepage;
    Label8.Caption := Email;
  end;
end;

// ---- EVENT HANDLER METHODS ----

// UNDERLINING LINKS
procedure TForm2.Label5MouseEnter(Sender: TObject);
begin
  Label5.Font.Underline := True;
end;

procedure TForm2.Label5MouseLeave(Sender: TObject);
begin
  Label5.Font.Underline := False;
end;

procedure TForm2.Label8MouseEnter(Sender: TObject);
begin
  Label8.Font.Underline := True;
end;

procedure TForm2.Label8MouseLeave(Sender: TObject);
begin
  Label8.Font.Underline := False;
end;

// OPEN BROWSER
procedure TForm2.Label5Click(Sender: TObject);
begin
  if Length(Label8.Caption) > 0 then
    if not OpenURL(Label5.Caption) then ShowMessage(MSG01);
end;

procedure TForm2.Label8Click(Sender: TObject);
begin
  if Length(Label8.Caption) > 0 then
    if not OpenURL('mailto:' + Label8.Caption) then ShowMessage(MSG01);
end;

end.

