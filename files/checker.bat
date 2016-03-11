@echo off

%content% --login -i -c "curl -o menu.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/menu.bat"
move menu.bat %startdir%\files)

%content% --login -i -c "curl -o delbt.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/buildtools/delbt.bat"
move delbt.bat %startdir%\files\buildtools

%content% --login -i -c "curl -o run.bat https://raw.githubusercontent.com/Legoman99573/Buildtools-Updater/master/files/buildtools/run.bat"
move run.bat %startdir%\files\buildtools

exit
