#!/bin/sh
#   RSS File Lister (Test Copy)

        RSS_Scr=RSS21-FileList_v1.5.80923.sh

        RSS_Dir=$( dirname "$( realpath "$0" )" )
        RSS21_FileList=$RSS_Dir/$RSS_Scr

#  $( "$RSS_Dir/$RSS_Scr" )

#  $( "$( dirname "$( realpath "$0" )" )/$RSS_Scr" )

#echo "$RSS21_FileList" source
      "$RSS21_FileList" source

#     "$RSS21_FileList" "$@"

