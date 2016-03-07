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
if exist config\version.txt (goto last) else (echo 1.9  > version.txt
echo created version.txt
goto last)

:last
exit
