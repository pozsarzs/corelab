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
  Classes, SysUtils, StrUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  core_cpu;
type
  { TForm5 }
  TForm5 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
  private
    FArchitecture: TArchitecture;     // CPU architecture (arHarvard, arNeumann)
    FEndiannes: TEndianness;                      // Bit order (enLittle, enBig)
    FMemSize: integer;                                // Size of emulated memory
    function RemoveSpace(AString: string): string;
    function Mirros(AString: string): string;
    function FormatHexValue(AValue: string; ADigit: Byte; var AResult: string): Boolean;
    procedure SetFArchitecture(AArchitecture: TArchitecture);
    procedure SetFEndianness(AEndianness: TEndianness);
  public
    property Architecture: TArchitecture read FArchitecture write SetFArchitecture;
    property Endianness: TEndianness read FEndianness write SetFEndianness;
    property MemSize: integer read FMemSize write FMemSize;
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
  MSG04 = 'Memory address too high! (> %s Byte)';

// ---- PRIVATE METHODS ----

function TForm5.RemoveSpace(AString: string): string;
var
  b: Byte;
begin
  Result := '';
  for b := 1 to Length(AString) do
    if (AString[b] <> #32) and (AString[b] <> #9) then Result := Result + UpCase(AString[b]);
end;

// FORMAT HEXADECIMAL VALUE
function TForm5.FormatHexValue(AValue: string; ADigit: Byte; var AResult: string): Boolean;
var
  b: Byte;
  s: string;
  Valid: Boolean;
begin
  //
  if Odd(ADigit) then Inc(ADigit);
  // remove space and tabulator
  s := '';
  Valid := true;
  s := RemoveSpace(AValue);
  // check bad characters
  for b := 1 to Length(s) do
    if not (s[b] in ['0'..'9', 'A'..'F']) then Valid := false;
  if Valid then
  begin
    // set length
    if Length(s) > ADigit
      then Delete(s, 1, Length(s) - ADigit)
      else for b := Length(s) to ADigit - 1 do s := '0' + s;
    AResult := '';
    for b := 1 to ADigit do
      if (not Odd(b)) and (b < ADigit)
        then AResult := AResult + s[b] + ' '
        else AResult := AResult + s[b];
  end;
  Result := Valid;
end;

// SET FARCHITECTURE FIELD
procedure TForm5.SetFArchitecture(AArchitecture: TArchitecture);
begin
  FArchitecture := AArchitecture;
  RadioGroup1.Enabled := (FArchitecture = arHarvard);
end;

// SET FENDIANNES FIELD
procedure TForm5.SetFEndiannes(AEndianness: TEndianness);
begin
  FEndianness := AEndianness;
end;

// ---- EVENT HANDLER METHODS ----

// ZEROIZE ADDRESS VALUE
procedure TForm5.Button1Click(Sender: TObject);
var
  s: string;
begin
  FormatHexValue('0', 6, s);
  Edit1.Text := s;
end;

// ZEROIZE DATA VALUE
procedure TForm5.Button2Click(Sender: TObject);
var
  s: string;
begin
  FormatHexValue('0', 16, s);
  Edit2.Text := s;
end;

// GET DATA FROM SPECIFIED MEMORY AND ADDRESS
procedure TForm5.Button3Click(Sender: TObject);
begin
end;

// SET DATA TO SPECIFIED MEMORY AND ADDRESS
procedure TForm5.Button4Click(Sender: TObject);
var
  PrevText, NewText: string;
  Data: QWord;
  Address: DWord;
  MaxAddress: Integer;
begin
  // set highest address
  if RadioGroup1.Enabled
    then MaxAddress := FMemSize - 1
    else MaxAddress := 2 * FMemSize - 1;
  // validate address
  PrevText := Edit1.Text;
  if not FormatHexValue(Edit1.Text, 6, NewText) then
  begin
    ShowMessage(MSG01 + MSG02);
    Edit1.Text := PrevText;
    Exit;
  end else
  begin
    Edit1.Text := NewText;
    // validate data
    PrevText := Edit2.Text;
    if not FormatHexValue(Edit2.Text, 16, NewText) then
    begin
      ShowMessage(MSG01 + MSG03);
      Edit2.Text := PrevText;
      Exit;
    end else
    begin
      Edit2.Text := NewText;
      // convert and storestrings
      Address := StrToDWord('$' + RemoveSpace(Edit1.Text));
      Data := StrToQWord('$' + RemoveSpace(Edit2.Text));
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

// VALIDATE ADDRESS VALUE
procedure TForm5.Edit1EditingDone(Sender: TObject);
var
  PrevText, NewText: string;
begin
  PrevText := Edit1.Text;
  if FormatHexValue(Edit1.Text, 6, NewText)
  then Edit1.Text := NewText else
  begin
    ShowMessage(MSG01 + MSG02);
    Edit1.Text := PrevText;
  end;
end;

// VALIDATE DATA VALUE
procedure TForm5.Edit2EditingDone(Sender: TObject);
var
  PrevText, NewText: string;
begin
  PrevText := Edit2.Text;
  if FormatHexValue(Edit2.Text, 16, NewText)
  then Edit2.Text := NewText else
  begin
    ShowMessage(MSG01 + MSG03);
    Edit2.Text := PrevText;
  end;
end;

end.

