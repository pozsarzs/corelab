{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | ucommon.pas                                                              | }
{ | Common procedures and functions                                          | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

unit ucommon;
{$MODE OBJFPC} {$H+} {$MACRO ON}
interface
uses
  {$IFDEF WINDOWS} Windows, {$ENDIF} SysUtils;
{$IFDEF WINDOWS}
  const
    CSIDL_PROFILE = 40;
    SHGFP_TYPE_CURRENT = 0;
  var
    Buffer: array[0..MAX_PATH] of Char;
{$ENDIF}

function GetLang: string;
function GetExeDir: string;
function GetUserDir: string;
function RemoveSpace(AString: string): string;
function FormatHexValue(AValue: string; ADigit: Byte; var AResult: string): Boolean;

implementation

{$IFDEF WINDOWS}
  function SHGetFolderPath(hwndOwner: HWND; nFolder: Integer; hToken: THandle;
           dwFlags: DWORD; pszPath: LPTSTR): HRESULT; stdcall;
           external 'Shell32.dll' name 'SHGetFolderPathA';

  function GetUserProfile: string;
  begin
    FillChar(Buffer, SizeOf(Buffer), 0);
    ShGetFolderPath(0, CSIDL_PROFILE, 0, SHGFP_TYPE_CURRENT, buffer);
    Result := string(PChar(@buffer));
  end;
{$ENDIF}

// GET SYSTEM LANGUAGE
function GetLang: string;
var
  {$IFDEF WINDOWS}
    Buffer: PChar;
    Size:   Integer;
  {$ENDIF}
  s: string;
begin
  {$IFDEF GO32V2}
    s := GetEnvironmentVariable('LANG');
  {$ELSE}
    {$IFDEF WINDOWS}
      Size := GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Nil, 0);
      GetMem(Buffer, Size);
      try
        GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Buffer, Size);
        s := string(Buffer);
      finally
        FreeMem(Buffer);
      end;
    {$ELSE}
      {$IFDEF UNIX}
        s := GetEnvironmentVariable('LANG');
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF} 
  if Length(s) = 0 then
    s := 'en';
  s := LowerCase(s[1..2]);
  GetLang := s;
end;

// GET DIRECTORY OF THE EXECUTABLE FILE;
function GetExeDir: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

// GET USER'S DIRECTORY
function GetUserDir: string;
begin
  {$IFDEF GO32V2}
    Result := GetExeDir;
  {$ELSE}
    {$IFDEF WINDOWS}
      Result := GetUserProfile + DirectorySeparator;
    {$ELSE}
      {$IFDEF UNIX}
        Result := GetEnvironmentVariable('HOME') + DirectorySeparator;
      {$ELSE}
        {$FATAL Not supported operation system!}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
end;

// REMOVE ALL SPACE
function RemoveSpace(AString: string): string;
var
  b: Byte;
begin
  Result := '';
  for b := 1 to Length(AString) do
    if (AString[b] <> #32) and (AString[b] <> #9)
      then Result := Result + UpCase(AString[b]);
end;

// FORMAT HEXADECIMAL VALUE
function FormatHexValue(AValue: string; ADigit: Byte; var AResult: string): Boolean;
var
  b:     Byte;
  s:     string;
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

end.
