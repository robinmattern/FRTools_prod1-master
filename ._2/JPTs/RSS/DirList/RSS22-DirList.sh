#!/bin/sh
#  RSS Dir Lister (Prod Copy)

#       RSS_Scr=RSS22-DirList_v1.2.81007.sh
#       RSS_Scr=RSS22-DirList_v1.2.90315.sh
        RSS_Scr=RSS22-DirList_p1.3.21027.sh

        RSS_Dir=$( dirname "$0" )
        RSS22_DirList=$RSS_Dir/$RSS_Scr

      "$RSS22_DirList" "$@"

