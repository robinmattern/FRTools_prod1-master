@echo off
: formR Tools Launch Script

     set aDir=%~dp0
     set aCmd=%aDir%..\FRTs\FRT01_Main0.sh

:echo  "%aCmd%" %*
 bash  "%aCmd%" %*
