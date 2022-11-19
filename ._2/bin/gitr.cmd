@echo off
: formR gitR Command Script

     set aDir=%~dp0
     set aCmd=%aDir%..\FRTs\gitR\FRT22_gitR1.sh

:echo  "%aCmd%" %*
 bash  "%aCmd%" %*
