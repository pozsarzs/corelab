{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | define.pas                                                               | }
{ | Application project file                                                 | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{$MACRO ON}

{$DEFINE BASENAME := lowercase(PRGNAME)}
{$DEFINE COMMENT := #35}

// Uncomment following line, if you want to build binary file
// for deb, rpm, tgz package.
// {$DEFINE INSTPKGMAN}

{$IFDEF GO32V2}
  {$DEFINE SHEBANG := '@corelab -r %0' + #13 + #10 + '@goto :eof'}
  {$DEFINE LABELEOF := ':eof'}
{$ELSE}
  {$IFDEF BSD}
    {$DEFINE SHEBANG := '#!/usr/local/bin/corelab -r'}
  {$ELSE}
    {$IFDEF LINUX}
      {$IFDEF INSTPKGMAN}
        {$DEFINE SHEBANG := '#!/usr/bin/corelab -r'}
      {$ELSE}
        {$DEFINE SHEBANG := '#!/usr/local/bin/corelab -r'}
      {$ENDIF}
    {$ELSE}
      {$IFDEF WINDOWS}
        {$DEFINE SHEBANG := '@corelab -r %0' + #13 + #10 + '@goto :eof'}
        {$DEFINE LABELEOF := ':eof'}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF UNIX}
  {$DEFINE DIR_LOCK := '/var/lock'}
{$ENDIF}

{$IFDEF UNIX}
  {$DEFINE BROWSER := 'xdg-open'}
{$ENDIF}
{$IFDEF WINDOWS}
  {$DEFINE BROWSER := 'rundll32.exe url.dll,FileProtocolHandler'}
{$ENDIF}

{$IFDEF WINDOWS}
  {$DEFINE CALLTYPE := stdcall}
{$ELSE}
  {$DEFINE CALLTYPE := cdecl}
{$ENDIF}

