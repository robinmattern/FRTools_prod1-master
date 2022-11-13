@echo off
: formR Tools Launch Script

  set aCmd="%~dp0..\FRTs\FRT01_Main0.sh"

bash %aCmd% "%*"

