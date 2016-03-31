@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

:boot
If exist %content% (goto boot2) else (@echo bash.exe was not found. Download, or configure gitlocation.txt
Goto error)
:boot2
@echo This build is in beta and could break important files. Continue: 
Set /P _1=(Y, N) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="Y" goto start
If /i "%_1%"=="y" goto start
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:start
if Exist menu.bat (goto ready) else (@echo An error has occured. Redownload this script.)
goto ready

:ready
start "Buildtools Updater v.0.14-Beta" /Max /i %startdir%files\menu-%v%.bat
goto exit

:exit
exit

:error
@echo Current invalid location set: %content%
pause
