@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

if exist %content% (goto boot) else (goto error1)
:boot
cls
@echo Welcome to Buildtools Updater v.0.14-Beta
:start
Set /P "_1=>" || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="update" goto update
If /i "%_1%"=="run" goto run
If /i "%_1%"=="help" goto help
If /i "%_1%"=="plugin" goto plugin
If /i "%_1%"=="bungee" goto bungee
If /i "%_1%"=="exit" goto exit

:update
cls
start "Buildtools Updater v.0.14-Beta | Delete Buildtools.jar" /b %startdir%buildtools\delbt.bat
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
start "Buildtools Updater v.0.14-Beta | Running Buildtools.jar" /wait %startdir%tasks\run.bat
@echo Moving Buildtools Folder back to its original spot
move %startdir%apache-maven-3.2.5 %startdir%\buildtools\
move %startdir%BuildData %startdir%\buildtools\
move %startdir%Bukkit %startdir%\buildtools\
move %startdir%CraftBukkit %startdir%\buildtools\
move %startdir%Spigot %startdir%\buildtools\
move %startdir%work %startdir%\buildtools\

@echo Finished running BuildTools

goto start

:help
cls
start "Buildtools Updater v.v.0.14-Beta | Buildtools Help" /b help.bat
goto start

:plugin
cls
start "Buildtools Updater v.v.0.14-Beta | Buildtools Help" /b plugin.bat
goto start

:bungee
cls
@echo Updating BungeeCord and its modules.
If not exist %startdir%bungee (md bungee)
If not exist %startdir%bungee\modules (md bungee\modules)

If exist bungee\BungeeCord.jar (del /f bungee\BungeeCord.jar)
If exist bungee\modules\cmd_find.jar (del /f bungee\modules\cmd_find.jar)
If exist bungee\modules\cmd_server.jar (del /f bungee\modules\cmd_server.jar)
If exist bungee\modules\cmd_send.jar (del /f bungee\modules\cmd_send.jar)
If exist bungee\modules\cmd_list.jar (del /f bungee\modules\cmd_list.jar)
If exist bungee\modules\cmd_alert.jar (del /f bungee\modules\cmd_alert.jar)
If exist bungee\modules\reconnect_yaml.jar (del /f bungee\modules\reconnect_yaml.jar)

%content% --login -i -c "curl -o bungee/BungeeCord.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/bootstrap/target/BungeeCord.jar"

%content% --login -i -c "curl -o bungee/modules/cmd_alert.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_alert.jar"

%content% --login -i -c "curl -o bungee/modules/cmd_find.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_find.jar"

%content% --login -i -c "curl -o bungee/modules/cmd_list.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_list.jar"

%content% --login -i -c "curl -o bungee/modules/cmd_server.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_server.jar"

%content% --login -i -c "curl -o bungee/modules/cmd_send.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/cmd_send.jar"

%content% --login -i -c "curl -o bungee/modules/reconnect_yaml.jar http://ci.md-5.net/job/BungeeCord/lastBuild/artifact/module/cmd-alert/target/reconnect_yaml.jar"
@echo Updated BungeeCord and all its Modules
goto start

:error1
cls
@echo Error-1 has occured. Goto https://www.spigotmc.org/wiki/buildtools-updater/ to find this error
if exist %startdir%error (goto errorprint1) else (md error)
:errorprint1
echo Link to Git: https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe>error\error-1.txt
cmd /c start https://github.com/git-for-windows/git/releases/download/v2.7.2.windows.1/Git-2.7.2-64-bit.exe

:exit
cls
@echo Thanks for using BuildTools Updater v.0.14-Beta by: Legoman99573
@pause
exit
