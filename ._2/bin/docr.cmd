@echo off
: formR Tools Launch Script

     set aDir=%~dp0
     set aCmd=%aDir%..\FRTs\FRT30_docR0.sh

:echo  "%aCmd%" %*
 bash  "%aCmd%" %*
