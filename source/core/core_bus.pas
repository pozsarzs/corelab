{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | core_bus.pas                                                             | }
{ | System bus abstraction module                                            | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit core_bus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, core_cpu, core_memory, core_ioport;

type
  { Rendszerbusz absztrakt ősosztálya.
    Ez a komponens köti össze a CPU-t a memóriákkal és az I/O perifériákkal.
    Megvalósítja az ICPUBus interfészt, amin keresztül a CPU eléri a külvilágot. }
  TBus = class(TInterfacedObject, ICPUBus)
  protected
    FCodeMemory: TMemory;                       { Csatlakoztatott programmemória modul }
    FDataMemory: TMemory;                       { Csatlakoztatott adatmemória modul }
    FIOPorts: TIOPort;                          { Csatlakoztatott I/O port vezérlő }
  public
    constructor Create; virtual;
    
    { --- ICPUBus interfész megvalósítása (A CPU felőli oldal) --- }
    
    { Adatmemória olvasása globális cím alapján }
    function  MemRead(Address: uint64): byte; virtual;
    { Adatmemória írása globális cím alapján }
    procedure MemWrite(Address: uint64; Value: byte); virtual;
    
    { Programmemória olvasása (Harvard architektúra vagy külön kód-lekérés esetén) }
    function  CodeRead(Address: uint64): byte; virtual;
    { Programmemória írása (pl. önmódosító kód vagy monitor program általi betöltés) }
    procedure CodeWrite(Address: uint64; Value: byte); virtual;
    
    { I/O port olvasása perifériacím alapján }
    function  IORead(Port: uint64): byte; virtual;
    { I/O port írása perifériacím alapján }
    procedure IOWrite(Port: uint64; Value: byte); virtual;

    { --- Keretrendszer felőli konfigurációs metódusok (A host oldala) --- }
    
    { Egységes memória csatlakoztatása (Neumann-architektúra esetén) }
    procedure AttachMemory(AMemory: TMemory); virtual;
    { Különálló programmemória csatlakoztatása (Harvard-architektúra esetén) }
    procedure AttachCodeMemory(AMemory: TMemory); virtual;
    { Különálló adatmemória csatlakoztatása (Harvard-architektúra esetén) }
    procedure AttachDataMemory(AMemory: TMemory); virtual;
    { I/O port vezérlő hardver csatlakoztatása }
    procedure AttachIOPorts(APorts: TIOPort); virtual;
    
    { A buszra kötött összes hardverkomponens alaphelyzetbe állítása }
    procedure Reset; virtual;

    { Publikus jellemzők a konfiguráció lekérdezéséhez }
    property CodeMemory: TMemory read FCodeMemory;
    property DataMemory: TMemory read FDataMemory;
    property IOPorts: TIOPort read FIOPorts;
  end;

implementation

constructor TBus.Create;
begin
  inherited Create;
  FCodeMemory := nil;
  FDataMemory := nil;
  FIOPorts := nil;
end;

function TBus.MemRead(Address: uint64): byte;
begin
  if Assigned(FDataMemory) then
    Result := FDataMemory.ReadByte(Address)
  else
    Result := $FF; { Lebegő busz alapértelmezett értéke, ha nincs hardver a címen }
end;

procedure TBus.MemWrite(Address: uint64; Value: byte);
begin
  if Assigned(FDataMemory) then
    FDataMemory.WriteByte(Address, Value);
end;

function TBus.CodeRead(Address: uint64): byte;
begin
  if Assigned(FCodeMemory) then
    Result := FCodeMemory.ReadByte(Address)
  else
    Result := $FF;
end;

procedure TBus.CodeWrite(Address: uint64; Value: byte);
begin
  if Assigned(FCodeMemory) then
    FCodeMemory.WriteByte(Address, Value);
end;

function TBus.IORead(Port: uint64): byte;
begin
  if Assigned(FIOPorts) then
    Result := FIOPorts.ReadPort(Port)
  else
    Result := $FF;
end;

procedure TBus.IOWrite(Port: uint64; Value: byte);
begin
  if Assigned(FIOPorts) then
    FIOPorts.WritePort(Port, Value);
end;

procedure TBus.AttachMemory(AMemory: TMemory);
begin
  { Neumann-architektúra esetén a kód- és az adattér ugyanarra a fizikai egységre mutat }
  FCodeMemory := AMemory;
  FDataMemory := AMemory;
end;

procedure TBus.AttachCodeMemory(AMemory: TMemory);
begin
  FCodeMemory := AMemory;
end;

procedure TBus.AttachDataMemory(AMemory: TMemory);
begin
  FDataMemory := AMemory;
end;

procedure TBus.AttachIOPorts(APorts: TIOPort);
begin
  FIOPorts := APorts;
end;

procedure TBus.Reset;
begin
  { Programmemória resetelése }
  if Assigned(FCodeMemory) then FCodeMemory.Reset;
  
  { Védelem: Ha a kód- és adatmemória ugyanaz az objektumpéldány (Neumann), 
    akkor nem hívjuk meg kétszer a Reset-et ugyanazon a területen. }
  if Assigned(FDataMemory) and (FDataMemory <> FCodeMemory) then 
    FDataMemory.Reset;
    
  { Perifériák resetelése }
  if Assigned(FIOPorts) then FIOPorts.Reset;
end;

end.
