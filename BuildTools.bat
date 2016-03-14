@echo off

set startdir=%~dp0
set v=
for /f "delims=" %%i in ('type files\btversion.txt') do set v= %%i

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content= %%i

:boot
@echo This build is in beta and could break important files. Continue: 
Set /P _1=(Y, N) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="Y" goto start
If /i "%_1%"=="y" goto start
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:start
cls
if Exist %startdir%\files\checker-%v%.bat (goto next) else (del /f files\checker-*.txt
md %startdir%\files
%content% --login -i -c "curl -o checker-%v%.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/checker.bat"
move checker.bat %startdir%\files)
goto next

:next
start "Buildtools Updater v.%v% | Checker" /wait %startdir%\files\checker-%v%.bat
goto next2

:next2
if Exist %startdir%\files\menu-%v%.bat (goto ready) else (md %startdir%\files
%content% --login -i -c "curl -o menu-%v%.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/menu.bat"
move menu.bat %startdir%\files)
goto ready

:ready
start "Buildtools Updater v.%v%" /Max /i %startdir%\files\menu-%v%.bat
goto exit

:exit
exit
