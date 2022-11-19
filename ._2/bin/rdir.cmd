@echo off
: Robin's Rdir Command Script

     set aDir=%~dp0
     set aCmd=%aDir%..\JPTs\RSS\RSS01_Main1.sh

:echo  "%aCmd%" dir %*
 bash  "%aCmd%" dir %*
