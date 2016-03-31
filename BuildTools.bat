@echo off

set startdir=%~dp0
set v=0.14 Beta
set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content= %%i

:boot
@echo This build is a beta, and could break important files. Continue: 
Set /P _1=(Y, N) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="Y" goto start
If /i "%_1%"=="y" goto start
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:start
if Exist checker.bat (goto next) else (@echo Missing file checker.bat. Please redownload this script.
goto exit)
goto next

:next
start "Checker" checker.bat
goto ready

:ready
if Exist menu.bat (goto next2) else (@echo Missing file menu.bat. Please redownload this script.
goto exit)
:next2
start "Buildtools Updater v.%v%" /Max /i %startdir%menu.bat
goto exit

:exit
@pause
exit
