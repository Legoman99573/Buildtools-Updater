@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

if exist %startdir%tasks (goto step2) else (goto exit)

:step2
if exist %startdir%api (goto step3) else (goto exit)

:step3
if exist %startdir%config (goto config) else (goto exit)

:config

if Exist tasks/delbt.bat (goto next2) else (goto exit)
goto next2

:next2
if Exist tasks/run.bat (goto next3) else (goto exit)
goto next3

:next3
if Exist tasks/pluginfixer.bat (goto exit) else (goto exit)

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
