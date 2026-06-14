@echo off
rem CoreLAB v0.1 - Modular Processor Simulation Framework
rem Copyright (C) 2026 Pozsar Zsolt pozsarzs@gmail.com
rem buildwin64.bat
rem Build program for 64 bit Windows

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
make -f Makefile.w64
cd ..

:lib
if %buildlib%==0 goto :end
cd corelab-plugins\cpu
make -f Makefile.w64
cd ..\..
cd corelab-plugins\ioport
make -f Makefile.w64
cd ..\..
cd corelab-plugins\memory
make -f Makefile.w64
cd ..\..

:lhelp
if %buildlhelp%==0 goto :gui
cd lhelp
make -f Makefile.w64
cd ..
goto end

:help
echo Usage: %0 [/?] [/noapp] [/nolib] [/nolhelp]
goto end

:end
