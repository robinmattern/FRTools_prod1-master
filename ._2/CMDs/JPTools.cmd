@echo off
: JScriptWare Power Tools Launch Script

     set aDir=%~dp0
     set aCmd=%aDir%jptools

:echo  "%aCmd%" %*
 bash  "%aCmd%" %*
