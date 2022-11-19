@echo off
: JScriptWare Power Tools Launch Script

     set aDir=%~dp0
     set aCmd=%aDir%..\JPTs\JPT00_Main0.sh

:echo  "%aCmd%" %*
 bash  "%aCmd%" %*
