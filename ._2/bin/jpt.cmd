@echo off
: JScriptWare Power Tools Launch Script

  set aCmd="%~dp0..\JPTs\JPT00_Main0.sh"

  bash %aCmd% "%*"
  