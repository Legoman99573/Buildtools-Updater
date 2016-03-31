@echo off

set startdir=%~dp0.
set v=
for /f "delims=" %%i in ('type files\btversion.txt') do set content=%%i
set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

if exist %startdir%\files\buildtools (goto step2) else (md files\buildtools
echo Buildtools will be stored here>files\buildtools\info.txt
goto step2)

:step2
if exist %startdir%\api (goto step3) else (md api
echo API's will be stored here>api\info.txt
goto step3)

:step3
if exist %startdir%\config (goto config) else (md config
echo 1.9>config\version.txt
echo C:\Program Files\Git\bin\bash.exe>config\gitlocation.txt
goto config)

:config

if Exist tasks/delbt.bat (goto next2) else (%content% --login -i -c "curl -o tasks/delbt.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/tasks/delbt.bat")
goto next2

:next2
if Exist tasks/run.bat (goto next3) else (%content% --login -i -c "curl -o tasks/run.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/tasks/run.bat")
goto next3

:next3
if Exist pluginfixer.bat (goto exit) else (%content% --login -i -c "curl -o pluginfixer.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/pluginfixer.bat")


:exit
exit
