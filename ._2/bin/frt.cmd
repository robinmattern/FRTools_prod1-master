@echo off
: formR Tools Launch Script

  set aCmd="%~dp0..\FRTs\FRT00_Main0.sh"

  bash %aCmd% "%*"

