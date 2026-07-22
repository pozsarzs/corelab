@echo off

rem Create .vsix file

cd corelab-script
vsce package
move *.vsix ..
cd ..
