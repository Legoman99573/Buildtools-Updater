@echo off

set startdir=%~dp0

del /f %startdir%\..\buildtools\BuildTools.jar
@echo Updating Buildtools.jar ;)

exit
