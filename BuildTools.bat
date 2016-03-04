@echo off

rem configure here

set startdir=%~dp0
set bashdir="C:\ProgramFiles\Git\bin\bash.exe"
set buildtoolsname=BuildTools
set buildtoolsver=lastBuild
set serverversion=
set version=spigot-1.9
set name=spigot
set directory= 
set variables=/v /y

rem Do not edit file below this line
set v=0.6 Beta
set contributor=Legoman99573

Echo Warning: You are using a beta version of this script. This script can possibly break causing buildtools not to launch correctly. Use at your own risk.
pause

If exist %startdir%\dependency (goto 1) else (mkdir %startdir%\dependency
Echo Created directory
goto 1)
:1
If exist %startdir%\api (goto 2) else (mkdir %startdir%\api
Echo Created folder api
goto 2)
If exist %startdir%\pluginfixed (goto start) else (mkdir %startdir%\pluginfixed
Echo Created folder pluginfixed
goto startup)
:startup
color 2
Echo Welcome to BuildTools Updater v.%v%
goto help
:help
color 3
echo ==========================================================================
Echo Here is a list of commands:
Echo clean          -cleans out buildtools directory out
Echo run            -runs buildtools program
Echo update         -updates Buildtools
Echo help           -Opens this message
Echo cp <directory> -copies and pastes to server directory. Must use full path.
Echo changes        -Shows Changelogs
Echo exit           -stops this script
echo ==========================================================================
color 7
goto start
:start
goto noselect
:noselect
Set /P _menu=> || Set _menu=NothingChosen
If "%_menu%"=="NothingChosen" goto :menu_nothing
If /i "%_menu%"=="clean" goto clean
If /i "%_menu%"=="run" if [%serverversion%] NEQ [] (GOTO runbt) else (echo an error has occured while preforming subcommand || goto start)
If /i "%_menu%"=="apipull" goto apirun
If /i "&_menu%"=="cp"=="%directory%" goto copy
If /u "_menu%"=="help" goto help
if /i "%_menu%"=="update" goto update

:menu_nothing
goto noselect

:clean
rd /S /Q dependency\BuildData || echo deleted folder: dependency\BuildData || rd /S /Q dependency\apache-maven-3.2.5 || echo deleted folder: dependency\apache-maven-3.2.5 || rd /S /Q dependency\Bukkit || echo deleted folder: Bukkit || rd /S /Q dependency\CraftBukkit || echo deleted folder: CraftBukkit || rd /S /Q dependency\Spigot || echo deleted folder: Spigot || rd /S /Q dependency\Work || echo deleted folder: Work || del /f dependency\craftbukkit-*.jar || del /f dependency\spigot-*.jar || echo Deleted Craftbukkit and Spigot jars || del /f dependency\BuildTools.log
goto start

:update
IF EXIST dependency\%buildtoolsname%.jar (del /f dependency\%buildtoolsname%.jar
goto step2) ELSE (Echo You dont have %buildtoolsname%.jar in your directory, you may ignore this :D
goto step2)

:step2
IF EXIST %bashdir% (%bashdir% --login -i -c "curl -o dependency\%buildtoolsname%.jar https://hub.spigotmc.org/jenkins/job/BuildTools/%buildtoolsver%/artifact/target/BuildTools.jar " || Echo %buildtoolsname%.jar was sucessfully added || goto start) ELSE (echo You dont have Git, or you misconfigured the "bashdir" setting || echo you can download Git at http://msysgit.github.io/ || goto start)

:runbt
IF EXIST \dependency\%buildtoolsname%.jar (%bashdir% --login -i -c "java -jar ""%startdir%\dependency\%buildtoolsname%.jar""  -rev %serverversion%" " || Echo Finished... || goto start) ELSE (Echo You dont have %buildtoolsname%.jar in your directory. || Echo use command start <version> || goto start)

rem Must create folder API for it to work
:apirun
IF EXIST %startdir%\api (copy dependency\Spigot\Spigot-API\target\*.jar api\ || echo Sucessfully copied API to folder || goto start) else (echo Must create folder %apifolder% || echo creating folder %apifolder% for you :D || mkdir \%apifolder% || goto :apirun)

:copy

IF EXIST \dependency\%version%.jar (rename dependency\%version%.jar %name%.jar
Echo Successfully renamed %version%.jar to %name%.jar
goto step-2) ELSE (Echo Failed to rename %version%.jar to %name%.jar
Echo Edit this batch file and change the "version" value to the version in your folder
goto start)

:step-2
echo attempting to copy %name%.jar to %directory%
IF EXIST dependency\%name%.jar (copy dependency\%name%.jar %directory% %variables%
Echo Successfully copied to the destination %directory%
Echo Renaming batch file back to its original state
goto step-3) ELSE (Echo There was an error during the process. There shouldn't have been changes while running.
goto start)

:step-3
rem This is to rename a file you named back, so the batch wont break
IF EXIST \dependency\%name%.jar (rename \dependency\%name%.jar %version%.jar
Echo Renamed Back to version%.jar
goto start) ELSE (echo There was an error during the process. There shouldn't have been changes while running.
goto start)

:changes
color 2
echo -------------------------Changelog:-------------------------
Changes made in %v%
echo Added changelog comand
echo Set buildtoolsver to lastBuild by default
echo Trying to improve subcommands
echo All buildtools files will be extracted in Dependency folder
echo -------------------------Changelog:-------------------------
color 7
goto start

:exit
color 4
echo ----------------------------Stopping Script:---------------------------
echo Thanks for using Buildtools Updater v.%v% by: Legoman99573
color 2
echo -------------------------Contrubutors:------------------------
echo %contributor%
pause
