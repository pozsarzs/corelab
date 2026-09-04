{ +--------------------------------------------------------------------------+ }
{ | CoreLab v0.1 - Modular Processor Simulation Framework                    | }
{ | Copyright (C) 2026 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | define.pas                                                               | }
{ | Definitions of symbol names                                              | }
{ +--------------------------------------------------------------------------+ }
{ This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE. }

{$MACRO ON}
{$DEFINE COMMENT := #35}
{$DEFINE BASENAME := 'corelab'}
{$DEFINE CONFIGFILE := BASENAME + '.ini'}

// Uncomment following line, if you want to build binary file
// for deb, rpm, tgz package.
// {$DEFINE INSTPKGMAN}

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

{$IFDEF WINDOWS}
  {$DEFINE CALLTYPE := stdcall}
{$ELSE}
  {$DEFINE CALLTYPE := cdecl}
{$ENDIF}

