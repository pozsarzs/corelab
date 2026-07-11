@echo off
rem CoreLAB v0.1 - Modular Processor Simulation Framework
rem Copyright (C) 2026 Pozsar Zsolt pozsarzs@gmail.com
rem buildwin32.bat
rem Build program for 32 bit Windows

set buildapp=1
set buildlib=1
set buildlhelp=1

:loop
if "%1"=="" goto :done
if "%1"=="/?" goto :help
if "%1"=="/noapp" set buildapp=0
if "%1"=="/nolib" set buildlib=0
if "%1"=="/nolhelp" set buildlhelp=0
shift
goto :loop
:done

if %buildapp%==0 goto :end
cd corelab
make -f Makefile.w32
cd ..
cd clcpu
make -f Makefile.w32
cd ..
cd clioport
make -f Makefile.w32
cd ..
cd clmemory
make -f Makefile.w32
cd ..

:lib
if %buildlib%==0 goto :end
cd corelab-plugins
make -f Makefile.w32
cd ..

:lhelp
if %buildlhelp%==0 goto :gui
cd lhelp
make -f Makefile.w32
cd ..
goto end

:help
echo Usage: %0 [/?] [/noapp] [/nolib] [/nolhelp]
goto end

:end
