@echo off

if exist %startdir%\files\buildtools (goto step2) else (md files\buildtools
echo Buildtools will be stored here  > files\buildtools\info.txt
goto step2)

:step2
if exist %startdir%\api (goto step3) else (md api
echo API's will be stored here  > api\info.txt
goto step3)

:step3
if exist %startdir%\config (goto config) else (md config
echo 1.9  > config\version.txt
echo C:\Program Files\Git\bin\bash.exe  > config\gitlocation.txt
goto config)

:config

if Exist %startdir%\files\menu.bat (goto next) else (%content% --login -i -c "curl -o menu.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/menu.bat"
move menu.bat %startdir%\files)
goto next

:next
if Exist %startdir%\files\buildtools\delbt.bat (goto next2) else (%content% --login -i -c "curl -o delbt.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/buildtools/delbt.bat"
move delbt.bat %startdir%\files\buildtools)
goto next2

:next2
if Exist %startdir%\files\buildtools\run.bat (goto exit) else (%content% --login -i -c "curl -o run.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/buildtools/run.bat"
move run.bat %startdir%\files\buildtools)


:exit
exit
