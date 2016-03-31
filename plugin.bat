@echo off

set startdir=%~dp0

set content=
for /f "delims=" %%i in ('type config\gitlocation.txt') do set content=%%i

set plugin=
for /f "delims=" %%i in ('type config\plugin.txt') do set plugin=%%i

@echo Welcome to Plugin Fixer.
:again
cls
@echo Edit plugin.txt and press any key to continue
pause

if not exist %startdir%plugin-pending ( @echo Did not find folder: plugin-pending
@echo Generating folder: plugin-pending
md %startdir%plugin-pending
If exist %startdir%plugin-pending (@echo Created folder "plugin-pending" Successfully) else (@echo Failed to create folder "plugin-pending". Make sure you have write access
goto stop)) else (@echo Found folder: plugin-pending) 

if not exist %startdir%plugin-fixed ( @echo Did not find folder: plugin-fixed
@echo Generating folder: plugin-fixed
md %startdir%plugin-fixed
If exist %startdir%..\plugin-fixed (@echo Created folder "plugin-fixed" Successfully) else (@echo Failed to create folder "plugin-fixed". Make sure you have write access
goto stop)) else (@echo Found folder: plugin-fixed) 

if exist %plugin%.jar (
%content% --login -i -c "java -jar %startdir%..\files\buildtos\BuildData/bin/SpecialSource-2.jar map -m buildtools/CraftBukkit/deprecation-mappings.csrg -i plugin-pending/%plugin%.jar -o plugin-fixed/%plugin%-fixed.jar") else (@echo did not find %plugin%.jar in folder /plugin-pending)

@echo Do you want to run this again: (Y, N)
Set /P "_1=" || Set _1=NothingChosen
If "%_1%"=="NothingChosen" goto :stop
If /i "%_1%"=="Y" goto again
If /i "%_1%"=="y" goto again
If /i "%_1%"=="N" goto stop
If /i "%_1%"=="n" goto stop

:stop
exit
