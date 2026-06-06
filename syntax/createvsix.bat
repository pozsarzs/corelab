@echo off
rem create vsix file

cd corelab-script
vsce package
move *.vsix ..
cd ..
