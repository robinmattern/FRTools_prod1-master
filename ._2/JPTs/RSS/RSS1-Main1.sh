#!/bin/sh
#   RSS Launcher (Prod Copy)

#       RSS_Scr=RSS1-Main1_v1.5.80923-0800.sh
#       RSS_Scr=RSS1-Main1_v1.5.80925.sh
        RSS_Scr=RSS1-Main1_p1.06.sh

        RSS_Dir=$( dirname "$0" )
        RSS1_Main1=$RSS_Dir/$RSS_Scr

      "$RSS1_Main1" "$@"

