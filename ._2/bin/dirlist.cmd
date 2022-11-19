@echo off
: Robin's DirList Command Script

     set aDir=%~dp0
     set aCmd=%aDir%..\JPTs\RSS\RSS01_Main1.sh

:echo  "%aCmd%" dirlist %*
 bash  "%aCmd%" dirlist %*