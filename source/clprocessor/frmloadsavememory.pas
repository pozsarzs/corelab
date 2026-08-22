{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmloadsavememory.pas                                                    | }
{ | Load/save parameter setting form                                         | }
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
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  EditBtn, Spin, core_cpu, ucommon;
type
  { TForm7 }
  TForm7 = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button5: TButton;
    EditButton1: TEditButton;
    EditButton2: TEditButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    SpinEdit1: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1EditingDone(Sender: TObject);
    procedure EditButton2ButtonClick(Sender: TObject);
    procedure EditButton2EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FAddressFrom: DWord;                                        // Start address
    FAddressTo: DWord;                                            // End address
    FArchitecture: TArchitecture;     // CPU architecture (arHarvard, arNeumann)
    FBank: byte;                                    // Number of the memory bank
    FDataWidth: byte;                                       // Datawidth in bits
    FDirection: Boolean;                                     // 0: Save, 1: Load
    FMemSize: DWord;                                  // Size of emulated memory
    procedure SetFArchitecture(AArchitecture: TArchitecture);
    procedure SetFMemSize(AMemSize: DWord);
    procedure SetFDirection(ADirection: Boolean);
  public
    property AddressFrom: DWord read FAddressFrom;
    property AddressTo: DWord read FAddressTo;
    property Architecture: TArchitecture read FArchitecture write SetFArchitecture;
    property Bank: byte read FBank;
    property DataWidth: byte read FDataWidth;
    property Direction: Boolean read FDirection write SetFDirection;
    property MemSize: DWord read FMemSize write SetFMemSize;
  end;
var
  Form7: TForm7;

implementation

{$R *.lfm}
{ TForm7 }

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Only hexadecimal values can be entered for address value!';
  MSG03 = 'Memory address too high! (> %s)';
  MSG04 = '&Save';
  MSG05 = '&Load';
  MSG06 = 'Save parameters';
  MSG07 = 'Load parameters';

// ---- PRIVATE METHODS ----

// SET FARCHITECTURE FIELD
procedure TForm7.SetFArchitecture(AArchitecture: TArchitecture);
begin
  FArchitecture := AArchitecture;
  RadioGroup1.Enabled := (FArchitecture = arHarvard);
end;

// SET OPERATION'S DIRECTION
procedure TForm7.SetFDirection(ADirection: Boolean);
begin
  FDirection := ADirection;
  if FDirection then Button5.Caption := MSG05 else Button5.Caption := MSG04;
  if FDirection then Form7.Caption := MSG07 else Form7.Caption := MSG06;
end;

// SET MEMORY SIZE
procedure TForm7.SetFMemSize(AMemSize: DWord);
begin
  if AMemSize > 0 then FMemSize := AMemSize else Exit;
end;

// ---- EVENT HANDLER METHODS ----

// ZEROIZE ADDRESS VALUE
procedure TForm7.EditButton1ButtonClick(Sender: TObject);
var
  s: string;
begin
  s := '';
  FormatHexValue('0', 6, s);
  EditButton1.Text := s;
end;

// ZEROIZE DATA VALUE
procedure TForm7.EditButton2ButtonClick(Sender: TObject);
var
  s: string;
begin
  s := '';
  FormatHexValue('0', 6, s);
  EditButton2.Text := s;
end;

// VALIDATE ADDRESS VALUE
procedure TForm7.EditButton1EditingDone(Sender: TObject);
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
procedure TForm7.EditButton2EditingDone(Sender: TObject);
var
  PrevText, NewText: string;
begin
  PrevText := EditButton2.Text;
  NewText := '';
  if FormatHexValue(EditButton2.Text, 6, NewText)
  then EditButton2.Text := NewText else
  begin
    ShowMessage(MSG01 + MSG02);
    EditButton2.Text := PrevText;
  end;
end;

// CLOSE WITHOUT SET PUBLIC FIELDS
procedure TForm7.Button1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

// SET PUBLIC FIELDS AND CLOSE
procedure TForm7.Button5Click(Sender: TObject);
var
  Swap: DWord;
begin
  // convert and check start address
  FAddressFrom := StrToDWord('$' + RemoveSpace(EditButton1.Text));
  if FAddressFrom > FMemSize - 1 then
  begin
    ShowMessage(MSG01 + Format(MSG03, [IntToStr(FMemSize - 1)]));
    Exit;
  end;
  // convert and check end address
  FAddressTo := StrToDWord('$' + RemoveSpace(EditButton2.Text));
  if FAddressTo > FMemSize - 1 then
  begin
    ShowMessage(MSG01 + Format(MSG03, [IntToStr(FMemSize - 1)]));
    Exit;
  end;
  // value swap if necessary
  if FAddressFrom > FAddressTo then
  begin
    Swap := FAddressTo;
    FAddressTo := FAddressFrom;
    FAddressFrom := Swap;
  end;
  if not RadioGroup1.Enabled then FBank := 0 else FBank := RadioGroup1.ItemIndex;
  FDataWidth := SpinEdit1.Value;
  ModalResult := mrOk;
end;

// ONCREATE
procedure TForm7.FormCreate(Sender: TObject);
begin
  SetFDirection(true);
  SetFArchitecture(arNeumann);
  SetFMemSize(1024);
end;

end.

