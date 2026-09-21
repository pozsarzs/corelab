{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | frmrdwrioport.pas                                                        | }
{ | Examine/deposit form                                                     | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit frmrdwrioport;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, core_ioport,
  frmexdepmemory, ucommon;
type
  { TForm51 }
  TForm51 = class(TForm5)
    procedure Button3Click(Sender: TObject); override;
    procedure Button4Click(Sender: TObject); override;
  private
    FPortInstance: TIOPort;
    procedure SetPortInstance(APortInstance: TIOPort);
  public
    property PortInstance: TIOPort write SetPortInstance;
  end;
var
  Form51: TForm51;

implementation

resourcestring
  MSG01 = 'ERROR: ';
  MSG02 = 'Only hexadecimal values can be entered for address value.';
  MSG03 = 'Only hexadecimal values can be entered for data value.';
  MSG06 = 'Port address too high. (> %s)';
  MSG07 = 'Cannot open I/O port module.';

{$R *.lfm}

{ TForm19 }

// ----  PRIVATE METHODS ----

procedure TForm51.SetPortInstance(APortInstance: TIOPort);
begin
  if Assigned(APortInstance) then FPortInstance := APortInstance else
  begin
    ShowMessage(MSG01 + MSG07);
  end;
end;

// ---- EVENT HANDLER METHODS ----

// READ DATA FROM PORT
procedure TForm51.Button3Click(Sender: TObject);
begin
end;

// WRITE DATA TO PORT
procedure TForm51.Button4Click(Sender: TObject);
var
  Address, BaseAddress, MaxAddress: DWord;
  Data:                             Byte;
  PrevText, NewText:                string;
begin
  BaseAddress := FPortInstance.BaseAddress;
  MaxAddress := FPortInstance.AddressRangeSize - 1;
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
      if Address > BaseAddress + MaxAddress then
      begin
        ShowMessage(MSG01 + Format(MSG06, [MaxAddress.ToString]));
        Exit;
      end else FPortInstance.WritePort(Address, Data);
    end;
  end;
end;

end.
