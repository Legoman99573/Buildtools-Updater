@echo off

set startdir=%~dp0
set v=
for /f "delims=" %%i in ('type files\btversion.txt') do set v= %%i

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
If /i "%_1%"=="plugin" goto plugin
If /i "%_1%"=="exit" goto exit

:update
cls
start "Buildtools Updater v.%v% | Delete Buildtools.jar" /b %startdir%buildtools\delbt.bat
%content% --login -i -c "curl -o files/buildtools/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastBuild/artifact/target/BuildTools.jar"
if exist %startdir%buildtools\BuildTools.jar (@echo Updated BuildTools) else (@echo An error has occured. Make sure folder has write access)
goto start

:run
cls
@echo getting Buildtools Ready
if exist %startdir%\buildtools\apache-maven-3.2.5 (move %startdir%\buildtools\apache-maven-3.2.5 %startdir%..\) else (echo Folder "apache-maven-3.2.5" doesnt exist may be ignored)
if exist %startdir%\buildtools\BuildData (move %startdir%\buildtools\BuildData %startdir%..\) else (echo Folder "BuildData" doesnt exist may be ignored)
if exist %startdir%\buildtools\Bukkit (move %startdir%\buildtools\Bukkit %startdir%..\) else (echo Folder "Bukkit" doesnt exist may be ignored)
if exist %startdir%\buildtools\CraftBukkit (move %startdir%\buildtools\CraftBukkit %startdir%..\) else (echo "Folder" CraftBukkit doesnt exist may be ignored)
if exist %startdir%\buildtools\Spigot (move %startdir%\buildtools\Spigot %startdir%..\) else (echo Folder "Spigot" doesnt exist may be ignored)
if exist %startdir%\buildtools\work (move %startdir%\buildtools\work %startdir%..\) else (echo Folder "work" doesnt exist may be ignored)

@echo running BuildTools :)
start "Buildtools Updater v.%v% | Running Buildtools.jar" /wait %startdir%buildtools\run2.bat
@echo Moving Buildtools Folder back to its original spot
move %startdir%..\apache-maven-3.2.5 %startdir%\buildtools\
move %startdir%..\BuildData %startdir%\buildtools\
move %startdir%..\Bukkit %startdir%\buildtools\
move %startdir%..\CraftBukkit %startdir%\buildtools\
move %startdir%..\Spigot %startdir%\buildtools\
move %startdir%..\work %startdir%\buildtools\

@echo Finished running BuildTools

goto start

:help
cls
start "Buildtools Updater v.%v% | Buildtools Help" /b ..\files\help-%v%.bat
goto start

:plugin
cls
start "Buildtools Updater v.%v% | Buildtools Help" /wait ..\files\plugin-%v%.bat
goto start

:error1
cls
@echo Error-1 has occured. Goto https://www.spigotmc.org/wiki/buildtools-updater/ to find this error
if exist %startdir%\error (goto errorprint1) else (md error)
:errorprint1
echo Link to Git: https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe  > error\error-1.txt
cmd /c start https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe

:exit
cls
@echo Thanks for using BuildTools Updater v.%v% by: Legoman99573
@pause
exit
