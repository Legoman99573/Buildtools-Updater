@echo off

set startdir=%~dp0
set v=0.8 Beta
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
if Exist %startdir%\files\checker.bat (goto next) else (%content% --login -i -c "curl -o checker.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/checker.bat"
move checker.bat %startdir%\files)
goto next

:next
start "Checker" %startdir%\files\checker.bat
goto ready

:ready
start "Buildtools Updater v.%v%" /Max /i %startdir%\files\menu.bat
goto exit

:exit
exit
