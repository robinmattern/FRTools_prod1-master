#!/bin/sh
#  RSS File Lister (Prod Copy)

#       RSS_Scr=RSS21-FileList_v1.5.80923.sh
#       RSS_Scr=RSS21-FileList_v1.5.81005.sh
#       RSS_Scr=RSS21-FileList_v1.5.90401.sh
#       RSS_Scr=RSS21-FileList_v1.6.10707.sh
#       RSS_Scr=RSS21-FileList_v1.7.10826.sh
#       RSS_Scr=RSS21-FileList_v1.7.10923.sh
        RSS_Scr=RSS21-FileList_v1.7.11010.sh

        RSS_Dir=$( dirname "$0" )
        RSS21_FileList=$RSS_Dir/$RSS_Scr

      "$RSS21_FileList" "$@"

