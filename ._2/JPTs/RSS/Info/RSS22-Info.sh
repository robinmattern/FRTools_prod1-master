#!/bin/sh
#   RSS Info (Prod Copy)

#       RSS_Scr=RSS22-Info_v0.7.80923.sh
        RSS_Scr=RSS22-Info_p0.08.81014.sh

        RSS_Dir=$( dirname "$0" )
        RSS22_Info=$RSS_Dir/$RSS_Scr

      "$RSS22_Info" "$@"

