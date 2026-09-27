@echo off

rem CoreLAB v0.1 - Modular Processor Simulation Framework
rem Copyright (C) 2026 Pozsar Zsolt (pozsarzs@gmail.com)
rem createvsix.bat
rem Create .vsix file

cd corelab-scriptembly
vsce package
move *.vsix ..
cd ..
