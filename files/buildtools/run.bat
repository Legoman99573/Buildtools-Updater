@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type %startdir%\..\..\config\gitlocation.txt') do set content= %%i

set version=
for /f "delims=" %%i in ('type %startdir%\..\..\config\version.txt') do set version= %%i

"%content%" --login -i -c "java -jar ""%startdir%\..\..\files\buildtools\BuildTools.jar"" -rev %version% " -o %startdir%\..\..\files\buildtools\BuildTools.jar "

pause
