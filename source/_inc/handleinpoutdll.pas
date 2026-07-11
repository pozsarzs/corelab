{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | dll.pas                                                                  | }
{ | DLL handler procedures and functions                                     | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// LOAD 'inpout32.dll'
function LoadInpout32dll: Boolean;
{$IFDEF WINDOWS}
  var
    LibDir: string;
  const
    {$IFDEF WIN32}
      Filename: string = 'inpout32.dll';
    {$ENDIF}
    {$IFDEF WIN64}
      Filename: string = 'inpoutx64.dll';
    {$ENDIF}
{$ENDIF}
begin
  Result := True;
  {$IFDEF WINDOWS}
    LibDir := 'library' + SLASH + 'inpout32' + SLASH;
    if FileExists(LibDir + Filename)
      then Inpout32 := LoadLibrary(PChar(LibDir + Filename))
      else Inpout32 := LoadLibrary(PChar(Filename));
    if (Inpout32 <> 0) then
    begin
     Inp32 := TInp32(GetProcAddress(Inpout32, 'inp32'));
     if (@inp32 = nil) then Result := False;
     Out32 := TOut32(GetProcAddress(Inpout32, 'out32'));
     if (@Out32 = Nil) then Result := False;
   end
   else Result := False;
  {$ELSE}
    Result := False;
  {$ENDIF}
end;

// UNLOAD 'inpout32.dll'
procedure unloadinpout32dll;
begin
  {$IFDEF WINDOWS}
    FreeLibrary(Inpout32);
  {$ENDIF}
end;
