@echo off
: formR Tools Launch Script

  set aCmd="%~dp0FRTools"

: echo %aCmd% "%*"
  bash %aCmd% "%*"

