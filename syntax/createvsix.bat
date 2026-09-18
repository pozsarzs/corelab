@echo off

rem Create .vsix file

cd corelab-scriptembly
vsce package
move *.vsix ..
cd ..
