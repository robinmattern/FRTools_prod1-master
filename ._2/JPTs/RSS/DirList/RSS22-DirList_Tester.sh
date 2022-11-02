#!/bin/sh
#  RSS Dir Lister (Test Copy)

        RSS_Scr=RSS22-DirList_v1.2.81007.sh

        RSS_Dir=$( dirname "$0" )
        RSS22_DirList=$RSS_Dir/$RSS_Scr

#echo "$RSS22_DirList" source
      "$RSS22_DirList" source

#     "$RSS22_DirList" "$@"
