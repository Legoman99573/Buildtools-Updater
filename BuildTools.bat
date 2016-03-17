@echo off

set startdir=%~dp0

set v=
for /f "delims=" %%i in ('type files\btversion.txt') do set v=%%i

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

if exist %startdir%\config\gitlocation.txt (goto boot) else (md config
If exist C:\Program Files\Git\bin\bash.exe ("C:\Program Files\Git\bin\bash.exe" --login -i -c "curl -o config/gitlocation.txt http://thegearmc.com/update/gitlocation.txt"
"C:\Program Files\Git\bin\bash.exe" --login -i -c "curl -o config/version.txt http://thegearmc.com/update/version.txt"
"C:\Program Files\Git\bin\bash.exe" --login -i -c "curl -o config/plugin.txt http://thegearmc.com/update/plugin.txt") else ("C:\Program Files (x86)\Git\bin\bash.exe" --login -i -c "curl -o config/gitlocation.txt http://thegearmc.com/update/gitlocation.txt"
"C:\Program Files (x86)\Git\bin\bash.exe" --login -i -c "curl -o config/version.txt http://thegearmc.com/update/version.txt"
"C:\Program Files (x86)\Git\bin\bash.exe" --login -i -c "curl -o config/plugin.txt http://thegearmc.com/update/plugin.txt")
)
If exist %startdir%files\checker.bat (del /f files\checker.bat
If exist %startdir%files\menu.bat (del /f files\menu.bat)
If exist %startdir%files\plugin.bat (del /f files\plugin.bat)) else (goto boot)

:boot
If exist %content% (@echo This build is in beta and could break important files. Continue: 
Set /P _1=(Y, N) || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :start
If /i "%_1%"=="Y" goto start
If /i "%_1%"=="y" goto start
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:start
cls
If not exist %startdir%files (md %startdir%files) else (@echo Directory already exists)
if exist files\btversion.txt (del /f files\btversion.txt) else (@echo btversion was not found. This can be ignored
%content% --login -i -c "curl -o btversion.txt http://thegearmc.com/update/btversion.txt"
move btversion.txt %startdir%files
if exist %startdir%files\checker-%v%.bat (goto next) else (if exist %startdir%files\checker-%v%.bat (del /f files\checker-*.bat) else (@Echo Couldnt find old version of checker.bat. This can be Ignored)
%content% --login -i -c "curl -o checker-%v%.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/%v%/files/checker.bat"
move checker-%v%.bat %startdir%files)
goto next

:next
start "Buildtools Updater v.%v% | Checker" /wait %startdir%files\checker-%v%.bat
goto next2

:next2
if Exist %startdir%files\menu-%v%.bat (goto ready) else (if exist %startdir%\files\menu-*.bat (del /f files\menu-*.bat) else (@echo couldnt find an old version of menu.bat. This can be ignored.
if exist %startdir%files (@echo files directory was found) else (@echo files directory was not found. Generating directory
md %startdir%files)
%content% --login -i -c "curl -o menu-%v%.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/%v%/files/menu.bat"
move menu-%v%.bat %startdir%files)
goto ready

:ready
start "Buildtools Updater v.%v%" /Max /i %startdir%files\menu-%v%.bat
goto exit) else (@echo bash.exe was not found. Download, or configure gitlocation.txt
Goto error)

:exit
exit

:error
@echo Current location set: %content%
pause
