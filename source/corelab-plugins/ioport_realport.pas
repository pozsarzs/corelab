{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ioport_realport.pas                                                      | }
{ | RealPort device implementation module                                    | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

library ioport_realport;
{$MODE OBJFPC}{$H+}
{$I DEFINE.PAS}
uses
  CMem, Classes, SysUtils, {$IFDEF UNIX} Ports, {$ENDIF}
  {$IFDEF WINDOWS} Windows, {$ENDIF} core_ioport;
type
  {$IFDEF WINDOWS}
    TInp32 = function(Address: SmallInt): SmallInt; stdcall;
    TOut32 = procedure(Address: SmallInt; Data: SmallInt); stdcall;
  {$ENDIF}
  // RealPort device class
  TREALPort = class(TIOPort)
  private
  {$IFDEF WINDOWS}
    InpOut32: THandle;
    Inp32:    TInp32;
    Out32:    TOut32;
  {$ENDIF}
    function LoadIODLL(ALibDir: string): Boolean;
    function UnLoadIODLL: Boolean;
  protected
    function ReadByteFromIOPort(AAddress: Word; var AData: Byte): Boolean;
    function WriteByteToIOPort(AAddress: Word; AData: Byte): Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Reset; override;
    function ReadPort(APort: Word): Byte; override;
    procedure WritePort(APort: Word; AValue: Byte); override;
  end;

{$IFDEF UNIX}
  function IOPerm(from: Cardinal; num: Cardinal; turn_on: Integer): Integer;
           cdecl; external 'libc';
{$ENDIF}

// ---- PRIVATE METHODS ----

// LOAD 'INPOUT32.DLL'
function TREALPort.LoadIODLL(ALibDir: string): Boolean;
{$IFDEF WINDOWS}
  {$IFDEF WIN64}
    const IODLL: string = 'inpoutx64.dll';
  {$ELSE}
    const IODLL: string = 'inpout32.dll';
  {$ENDIF}
  var DLLWithPath: string;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
    Result := true;
    DLLWithPath := ALibDir + DirectorySeparator + IODLL;
    if not FileExists(DLLWithPath) then DLLWithPath := IODLL;
    try
      InpOut32 := LoadLibrary(PChar(DLLWithPath));
      if (InpOut32 <> 0) then
      begin

        // ORIGINAL: void _stdcall Out32(short PortAddress, short data);
        Inp32 := TInp32(GetProcAddress(Inpout32, 'inp32'));
        if (@Inp32 = nil) then Result := False;

        // ORIGINAL: short _stdcall Inp32(short PortAddress);
        Out32 := TOut32(GetProcAddress(Inpout32, 'out32'));
        if (@Out32 = Nil) then Result := False;

      end else Result := false;
    except
      Result := false;
    end;
  {$ELSE}
    Result := false;
  {$ENDIF}
end;

// UNLOAD 'INPOUT32.DLL'
function TREALPort.UnLoadIODLL: Boolean;
begin
  {$IFDEF WINDOWS}
    Result := true;
    try
      FreeLibrary(Inpout32);
      Inpout32 := 0;
    except
      Result := false;
    end;
  {$ELSE}
    Result := false;
  {$ENDIF}
end;

// ---- PROTECTED METHODS ----

// READ A BYTE FROM I/O PORT
function TREALPort.ReadByteFromIOPort(AAddress: Word; var AData: Byte): Boolean;
begin
  Result := true;
  try
    {$IFDEF UNIX}
      IOPerm(AAddress, 1, 1);
      AData := Port[AAddress];
    {$ENDIF}
    {$IFDEF WINDOWS}
      AData := Byte(Inp32(SmallInt(AAddress)));
    {$ENDIF}
  except
    Result := false;
  end;
end;

// WRITE A BYTE TO I/O PORT
function TREALPort.WriteByteToIOPort(AAddress: Word; AData: Byte): Boolean;
begin
  Result := true;
  try
    {$IFDEF UNIX}
      IOPerm(AAddress, 1, 1);
      Port[AAddress] := AData;
    {$ENDIF}
    {$IFDEF WINDOWS}
      Out32(SmallInt(AAddress), SmallInt(AData));
    {$ENDIF}
  except
    Result := false;
  end;
end;

// ---- PUBLIC METHODS ----
  
// CREATE TREALPORT INSTANCE
constructor TREALPort.Create;
begin
  inherited Create;
  FModname := 'Real I/O port';
  FDescription := 'Redirect to a real I/O port.';
  FHasPanel := false;
  LoadIODLL('');
end;

// DESTROY TREALPORT INSTANCE
destructor TREALPort.Destroy;
begin
  UnLoadIODLL;
  inherited Destroy;
end;

// RESET VIRTUAL PORT
procedure TREALPort.Reset;
begin
end;

// READ VIRTUAL PORT
function TREALPort.ReadPort(APort: Word): Byte;
var
  LData: Byte;
begin
  LData := $FF;
  ReadByteFromIOPort(APort, LData);
  Result := LData;
end;

// WRITE VIRTUAL PORT
procedure TREALPort.WritePort(APort: Word; AValue: Byte);
begin
  WriteByteToIOPort(APort, AValue);
end;

// ---- EXPORTABLE FUNCTIONS AND PROCEDURES ----

function CreatePort: TIOPort; CALLTYPE; export;
begin
  Result := TREALPort.Create;
end;

procedure DestroyPort(APort: TIOPort); CALLTYPE; export;
begin
  if Assigned(APort) then APort.Free;
end;

procedure SetIntHandler(APort: TIOPort; AIntProc: TInterruptCallback; AIntVect: Byte); CALLTYPE; export;
begin
  if Assigned(APort) then
  begin
    APort.OnInterrupt := AIntProc;
    APort.IntVector := AIntVect;
  end;
end;

function LoadState(APort: TIOPort; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.LoadState(AStream)
    else Result := false;
end;

function SaveState(APort: TIOPort; AStream: TStream): Boolean; CALLTYPE; export;
begin
  if Assigned(APort)
    then Result := APort.SaveState(AStream)
    else Result := false;
end;

// ---- EXPORTED FUNCTIONS AND PROCEDURES ----

exports CreatePort name 'ioport_create';
exports DestroyPort name 'ioport_destroy';
exports SetIntHandler name 'ioport_setinthandler';
exports LoadState name 'ioport_loadstate';
exports SaveState name 'ioport_savestate';

begin
end.
