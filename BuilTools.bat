@echo off

rem configure here

set startdir=%~dp0
set bashdir="C:\ProgramFiles\Git\bin\bash.exe"
set buildtoolsname=BuildTools
set buildtoolsver=
set serverversion=1.9
set apifolder=api

set version=spigot-1.9
set name=spigot
set directory= 
set variables=/v /y
rem Do not edit file below this line

Echo Warning: You are using a beta version of this script. This script can possibly break causing buildtools not to launch correctly. Use at your own risk.
pause

If exist dependency (goto 1) else (mkdir dependency
Echo Created directory
goto 1)
:1
If exist %apifolder% (goto 2) else (mkdir %apifolder%
Echo Created folder %apifolder%
goto 2)
If exist pluginfixed (goto start) else (mkdir pluginfixed
Echo Created folder pluginfixed
goto start)

:start

Echo Welcome to BuildTools Updater v.0.1 Beta
Echo Here is a list of commands:
Echo clean -cleans out buildtools directory out
Echo run -runs buildtools program
Echo update <version#> -updates buildtools. lastSuccesssfulBuild will use latest from Jenkins side of buildtools.
Echo cp <directory> -copies and pastes to server directory. Must use full path.
Echo exit -stops this script

Set /P _menu=> || Set _menu=NothingChosen
If "%_menu%"=="NothingChosen" goto :menu_nothing
If /i "%_menu%"=="clean" goto clean
If /i "%_menu%"=="run" goto start
If /i "%_menu%"=="apipull" goto apirun
If /i "&_menu%"=="cp"=="%directory%" goto copy
if /i "%_menu%"=="update"=="%buildtoolsver%" goto update

:menu_nothing
goto start

:clean
rd /S /Q BuildData
rd /S /Q apache-maven-3.2.5
rd /S /Q Bukkit
rd /S /Q CraftBukkit
rd /S /Q Spigot
rd /S /Q Work
del /f craftbukkit-*.jar
del /f spigot-*.jar
del /f BuildTools.log
goto start

:update
IF EXIST %buildtoolsname%.jar (del /f %buildtoolsname%.jar
goto step2) ELSE (Echo You dont have %buildtoolsname%.jar in your directory, you may ignore this :D
goto step2)

:step2
IF EXIST %bashdir% (%bashdir% --login -i -c "curl -o %buildtoolsname%.jar https://hub.spigotmc.org/jenkins/job/BuildTools/%buildtoolsver%/artifact/target/BuildTools.jar "
Echo %buildtoolsname%.jar was sucessfully added
goto start) ELSE (echo You dont have Git, or you misconfigured the "bashdir" setting
echo you can download Git at http://msysgit.github.io/
goto start)

:run
IF EXIST %buildtoolsname%.jar (%bashdir% --login -i -c "java -jar ""%startdir%\%buildtoolsname%.jar""  -rev %serverversion%" "
Echo Finished...
goto start) ELSE (Echo You dont have %buildtoolsname%.jar in your directory.
Echo use command start <version>
goto start)

rem Must create folder API for it to work
:apirun
IF EXIST %apifolder%\ (copy Spigot\Spigot-API\target\*.jar %apifolder%\
echo Sucessfully copied API to folder
goto start) else
(echo Must create folder %apifolder%
echo creating folder %apifolder% for you :D
mkdir %apifolder%
goto :apirun)

@echo off

:copy
IF EXIST %version%.jar (rename %version%.jar %name%.jar
Echo Successfully renamed %version%.jar to %name%.jar
goto step2) ELSE (Echo Failed to rename %version%.jar to %name%.jar
Echo Edit this batch file and change the "version" value to the version in your folder
goto start)

IF EXIST %version%.jar (rename %version%.jar %name%.jar
Echo Successfully renamed %version%.jar to %name%.jar
goto step2) ELSE (Echo Failed to rename %version%.jar to %name%.jar
Echo Edit this batch file and change the "version" value to the version in your folder
goto start)

:step2
echo attempting to copy %name%.jar to %directory%
IF EXIST %name%.jar (copy %name%.jar %directory% %variables%
Echo Successfully copied to the destination %directory%
Echo Renaming batch file back to its original state
goto step3) ELSE (Echo There was an error during the process. There shouldn't have been changes while running.
goto start)

:step3
rem This is to rename a file you named back, so the batch wont break
IF EXIST %name%.jar (rename %name%.jar %version%.jar
Echo Renamed Back to version%.jar
goto start) ELSE (echo There was an error during the process. There shouldn't have been changes while running.
goto start)

:exit
Thanks for using this script modified by Legoman99573
Exit
