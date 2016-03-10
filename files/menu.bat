@echo off

set startdir=%~dp0
set v=0.7 Beta

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content= %%i

if exist %content% (goto boot) else (goto error1)
:boot
@echo Welcome to Buildtools Updater v.%v% 
:start
Set /P "_1=>" || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="update" goto update
If /i "%_1%"=="run" goto run
If /i "%_1%"=="help" goto help
If /i "%_1%"=="exit" goto exit

:update
start "Buildtools Updater v.%v% | Delete Buildtools.jar" /b %startdir%\..\buildtools\delbt.bat
%content% --login -i -c "curl -o buildtools/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
@echo Updated BuildTools
goto start

:run
@echo running BuildTools :)
start "Buildtools Updater v.%v% | Run BuildTools.jar" /i /wait /SEPARATE %startdir%buildtools\run.bat
@echo Finished running BuildTools
goto start

:help
start "Buildtools Updater v.%v% | Buildtools Help" help.bat
goto start

:error1
@echo Error-1 has occured. Goto https://www.spigotmc.org/wiki/buildtools-updater/ to find this error
if exist %startdir%\error (goto errorprint1) else (md error)
:errorprint1
echo Link to Git: https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe  > error\error-1.txt

:exit
@echo Thanks for using BuildTools Updater v.%v% by: Legoman99573
@pause
exit
