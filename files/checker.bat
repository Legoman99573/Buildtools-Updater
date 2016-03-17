@echo off

set startdir=%~dp0
set v=
for /f "delims=" %%i in ('type files\btversion.txt') do set content=%%i

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

if exist %startdir%\files\buildtools (goto step2) else (md files\buildtools
echo Buildtools will be stored here  > files\buildtools\info.txt
goto step2)

:step2
if exist %startdir%\api (goto step3) else (md api
echo API's will be stored here  > api\info.txt
goto step3)

:config

if Exist %startdir%\files\buildtools\delbt.bat (goto next2) else (%content% --login -i -c "curl -o files/buildtools/delbt.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/0.10.4-Beta/files/buildtools/delbt.bat ")
goto next2

:next2
if Exist %startdir%\files\buildtools\run.bat (goto next3) else (%content% --login -i -c "curl -o files/buildtools/run.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/0.10.4-Beta/files/buildtools/run.bat ")
goto next3

:next3
if Exist %startdir%\files\plugin-%v%.bat (goto exit) else (%content% --login -i -c "curl -o files/buildtools/plugin-%v%.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/0.10.4-Beta/files/plugin.bat ")
goto exit

:exit
exit

