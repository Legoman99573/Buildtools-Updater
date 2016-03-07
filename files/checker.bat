@echo off

set startdir=%~dp0

if exist \dependency (goto step2) else (md dependency)

:step2
if exist \api (goto step3) else (md api)

:step3
if exist \config (goto config) else (md config
echo 1.9  > config\version.txt
echo created version.txt)

:config
if exist config\version.txt (goto config2) else (echo 1.9  > config\version.txt
echo created version.txt
goto config2)
:config2
if exist config\gitlocation.txt (goto last) else (echo C:\Program Files\Git\bin\bash.exe  > config\gitlocation.txt
echo created gitlocation.txt
goto last)

:last
exit
