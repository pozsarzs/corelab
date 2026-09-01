{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmexdepmemory.pas                                                       | }
{ | Examine/deposit form                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmexdepmemory;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  EditBtn, core_cpu, ucommon;
type
  { TForm5 }
  TForm5 = class(TForm)
    Bevel1:      TBevel;
    Button3:     TButton;
    Button4:     TButton;
    Button5:     TButton;
    EditButton1: TEditButton;
    EditButton2: TEditButton;
    Label1:      TLabel;
    Label2:      TLabel;
    RadioGroup1: TRadioGroup;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1EditingDone(Sender: TObject);
    procedure EditButton2ButtonClick(Sender: TObject);
    procedure EditButton2EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FArchitecture: TArchitecture;     // CPU architecture (arHarvard, arNeumann)
    FMemSize:      DWord;                             // Size of emulated memory
  protected
    procedure SetFArchitecture(AArchitecture: TArchitecture);
  public
    property Architecture: TArchitecture read FArchitecture write SetFArchitecture;
    property MemSize: DWord read FMemSize write FMemSize;
  end;
var
  Form5: TForm5;

implementation
uses frmmain;

{$R *.lfm}
{ TForm5 }

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Only hexadecimal values can be entered for address value!';
  MSG03 = 'Only hexadecimal values can be entered for data value!';
  MSG04 = 'Memory address too high! (> %s)';

// ---- PRIVATE METHODS ----

// SET FARCHITECTURE FIELD
procedure TForm5.SetFArchitecture(AArchitecture: TArchitecture);
begin
  FArchitecture := AArchitecture;
  RadioGroup1.Enabled := (FArchitecture = arHarvard);
end;

// ---- EVENT HANDLER METHODS ----

// ZEROIZE ADDRESS VALUE
procedure TForm5.EditButton1ButtonClick(Sender: TObject);
var
  s: string;
begin
  s := '';
  FormatHexValue('0', 6, s);
  EditButton1.Text := s;
end;

// ZEROIZE DATA VALUE
procedure TForm5.EditButton2ButtonClick(Sender: TObject);
var
  s: string;
begin
  s := '';
  FormatHexValue('0', 2, s);
  EditButton2.Text := s;
end;

// VALIDATE ADDRESS VALUE
procedure TForm5.EditButton1EditingDone(Sender: TObject);
var
  PrevText, NewText: string;
begin
  PrevText := EditButton1.Text;
  NewText := '';
  if FormatHexValue(EditButton1.Text, 6, NewText)
  then EditButton1.Text := NewText else
  begin
    ShowMessage(MSG01 + MSG02);
    EditButton1.Text := PrevText;
  end;
end;

// VALIDATE DATA VALUE
procedure TForm5.EditButton2EditingDone(Sender: TObject);
var
  PrevText, NewText: string;
begin
  PrevText := EditButton2.Text;
  NewText := '';
  if FormatHexValue(EditButton2.Text, 2, NewText)
  then EditButton2.Text := NewText else
  begin
    ShowMessage(MSG01 + MSG03);
    EditButton2.Text := PrevText;
  end;
end;

// GET DATA FROM SPECIFIED MEMORY AND ADDRESS
procedure TForm5.Button3Click(Sender: TObject);
var
  Address, MaxAddress: DWord;
  Data:                Byte;
  PrevText, NewText:   string;
begin
  // set highest address
  MaxAddress := FMemSize - 1;
  // validate address
  PrevText := EditButton1.Text;
  NewText := '';
  if not FormatHexValue(EditButton1.Text, 6, NewText) then
  begin
    ShowMessage(MSG01 + MSG02);
    EditButton1.Text := PrevText;
    Exit;
  end else
  begin
    EditButton1.Text := NewText;
    // convert and store strings
    Address := StrToDWord('$' + RemoveSpace(EditButton1.Text));
    if Address > MaxAddress then
    begin
      ShowMessage(MSG01 + Format(MSG04, [MaxAddress.ToString]));
      Exit;
    end;
    if RadioGroup1.Enabled
      then Data := Form1.GetMemoryCell(RadioGroup1.ItemIndex, Address)
      else Data := Form1.GetMemoryCell(0, Address);
    if FormatHexValue(IntToHex(Data, 2), 2, NewText)
      then EditButton2.Text := NewText
      else EditButton2ButtonClick(Sender);
  end;
end;

// SET DATA TO SPECIFIED MEMORY AND ADDRESS
procedure TForm5.Button4Click(Sender: TObject);
var
  Address, MaxAddress: DWord;
  Data:                Byte;
  PrevText, NewText:   string;
begin
  // set highest address
  MaxAddress := FMemSize - 1;
  // validate address
  PrevText := EditButton1.Text;
  NewText := '';
  if not FormatHexValue(EditButton1.Text, 6, NewText) then
  begin
    ShowMessage(MSG01 + MSG02);
    EditButton1.Text := PrevText;
    Exit;
  end else
  begin
    EditButton1.Text := NewText;
    // validate data
    PrevText := EditButton2.Text;
    if not FormatHexValue(EditButton2.Text, 2, NewText) then
    begin
      ShowMessage(MSG01 + MSG03);
      EditButton2.Text := PrevText;
      Exit;
    end else
    begin
      EditButton2.Text := NewText;
      // convert and store strings
      Address := StrToDWord('$' + RemoveSpace(EditButton1.Text));
      Data := StrToInt('$' + RemoveSpace(EditButton2.Text));
      if Address > MaxAddress then
      begin
        ShowMessage(MSG01 + Format(MSG04, [MaxAddress.ToString]));
        Exit;
      end;
      if RadioGroup1.Enabled
        then Form1.SetMemoryCell(RadioGroup1.ItemIndex, Address, Data)
        else Form1.SetMemoryCell(0, Address, Data);
    end;
  end;
end;

// CLOSE
procedure TForm5.Button5Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

// ONCREATE
procedure TForm5.FormCreate(Sender: TObject);
begin
  SetFArchitecture(arNeumann);
  FMemSize := 1024;
end;

end.

