@echo off
pushd %~dp0\..\
call vendor\premake\premake5.exe vs2015
popd
PAUSE