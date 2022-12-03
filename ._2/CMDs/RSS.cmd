@echo off
: Robin's Shell Scripts Launch Script

     set aDir=%~dp0
     set aCmd=%aDir%..\JPTs\RSS\RSS01_Main1.sh

:echo  "%aCmd%" %*
 bash  "%aCmd%" %*
