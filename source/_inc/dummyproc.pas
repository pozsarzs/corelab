{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | dummyproc.pas                                                            | }
{ | Dummy function and procedures to replace missing exported ones           | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }
	

procedure LoadFromStream(AStream: TStream; AAddress, ACount: DWord); CALLTYPE;
begin
end;

procedure SaveToStream(AStream: TStream; AAddress, ACount: DWord); CALLTYPE;
begin
end;

procedure CreatePanel; CALLTYPE;
begin
end;

procedure FreePanel; CALLTYPE;
begin
end;

procedure ShowPanel; CALLTYPE;
begin
end;

procedure HidePanel; CALLTYPE;
begin
end;

procedure RenamePanel(ACaption: PChar); CALLTYPE;
begin
end;

function MovePanel(ALeft, ATop: Integer): Boolean; CALLTYPE;
begin
  Result := false;
end;

function ResizePanel(AWidth, AHeight: Integer): Boolean; CALLTYPE;
begin
  Result := false;
end;

function ReadMemory(AAddress: DWord): QWord; CALLTYPE;
begin
  Result := 0;
end;

procedure WriteMemory(AAddress: DWord; AValue: QWord); CALLTYPE;
begin
end;

function ReadPort(APort: Word): Byte; CALLTYPE;
begin
  Result := 0;
end;

procedure WritePort(APort: Word; AValue: Byte); CALLTYPE;
begin
end;
