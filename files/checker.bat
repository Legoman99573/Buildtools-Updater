@echo off

set startdir=%~dp0
set v=0.8 Beta
set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content= %%i

:boot
@echo This build is a beta, and could break important files. Continue: 
Set /P _1=(Y, N) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :setup
If /i "%_1%"=="Y" goto setup
If /i "%_1%"=="y" goto setup
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:setup
cls
if exist %startdir%\config (goto launch) else (md config
echo 1.9  > config\version.txt
echo C:\Program Files\Git\bin\bash.exe  > config\gitlocation.txt
goto launch)

:launch
if exist %startdir%\files\buildtools (goto step2) else (md files\buildtools
echo Buildtools will be stored here  > files\buildtools\info.txt
goto step2)

:step2
if exist %startdir%\api (goto start) else (md api
echo API's will be stored here  > api\info.txt
goto start)


:start
cls
if Exist %startdir%\files\checker.bat (goto next) else (md %startdir%\files
%content% --login -i -c "curl -o checker.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/checker.bat"
move checker.bat %startdir%\files)
goto next

:next
start "Buildtools Updater v.%v% | Checker" /wait %startdir%\files\checker.bat
goto next2

:next2
if Exist %startdir%\files\menu.bat (goto ready) else (md %startdir%\files
%content% --login -i -c "curl -o menu.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/menu.bat"
move menu.bat %startdir%\files)
goto ready

:ready
start "Buildtools Updater v.%v%" /Max /i %startdir%\files\menu.bat
goto exit

:exit
exit
