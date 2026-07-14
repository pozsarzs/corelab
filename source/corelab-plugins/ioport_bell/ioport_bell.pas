{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_bell.pas                                                          | }
{ | BELL device implementation module                                        | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_bell;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, SysUtils, core_ioport;
type
  // BELL device class
  TBELLPort = class(TIOPort)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function ReadPort(Port: Byte): Byte; override;
    procedure WritePort(Port: Byte; Value: Byte); override;
    procedure Reset;  override;
  end;
  
// CREATE TBELLPORT INSTANCE
constructor TBELLPort.Create;
begin
  inherited Create;
  FModname := 'BELL device';
  FDescription := 'It rings at a value greater than zero.';
  FHasPanel := false;
  Reset;
end;

// DESTROY TBELLPORT INSTANCE
destructor TBELLPort.Destroy;
begin
  inherited Destroy;
end;

// READ VIRTUAL PORT
function TBELLPort.ReadPort(Port: Byte): Byte;
begin
  if FEnabled and (Port = 0) then Result := $00 else Result := $FF;
end;

// WRITE VIRTUAL PORT
procedure TBELLPort.WritePort(Port: Byte; Value: Byte);
begin
  if FEnabled and (Port = 0)  then
    if Value > 0 then Beep;
end;

// RESET VIRTUAL PORT
procedure TBELLPort.Reset;
begin
end;

// EXPORTABLE FUNCTIONS AND PROCEDURES
function CreatePort: TIOPort; cdecl; export;
begin
  result := TBELLPort.Create;
end;

procedure DestroyPort(Port: TIOPort); cdecl; export;
begin
  if Assigned(Port) then Port.Free;
end;

// EXPORTED FUNCTIONS AND PROCEDURES
exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';

begin
end.
