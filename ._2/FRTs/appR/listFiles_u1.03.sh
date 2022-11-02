#!/bin/sh

    aPWD=$(pwd)

#   aDir=$( echo ${aPWD} | awk      '{ sub( /.+\/!_/, "", $0 ); print "!_" $0 }' )      ##.(20515.03.1 RAM)
#   aDir=$( ls -1        | awk '/!/  { sub( /_/,     " ", $0 ); print $1      }' )      ##.(20515.03.1 RAM)
    aDir=$( ls -1        | awk '/!/  {                          print         }' )      # .(20515.03.1 RAM)

#   echo "aDir: '${aDir}'"; #exit
    echo "  - listFiles[1] ${aDir}"; # exit

    cd "${aDir}"                                                                        # .(20515.03.2 RAM)

# ----------------------------------------------------------------------------

if [ -f "files.md" ]; then
    aTS=$( date '+%y%m%d' ); aTS=${aTS:1:5}
    if [ ! -f "files_v${aTS}.md" ]; then  # .(10219.01.1 RAM Don't replace backup for today if it exists)
    cp -p files.md files_v${aTS}.md
    fi; fi
# ----------------------------------------------------------------------------

if [ "${aDir:0:3}" == "!_P" ] || [ "${aDir:0:3}" == "!_p" ]; then

#    cd ..; echo "----------------------"; pwd; echo "----------------------";

#    aPgm=/c/Home/_0/bin/apps.awk
#    aPgm=$( dirname $0 )/listApps.awk                                                                      ##.(20521.02.1)

#    ----------------------------------------------------------------------------------------------         # .(20521.02.1 Beg RAM: Add .awk program as var)

     aListAppsPgm='

BEGIN  { sub( /.+FormR\//, "./", DIR )
         sub( /\/!.+/,      "",  DIR )
         aFmt = " |%17s|%s\n"; aFmt2 = "%-22s | !_%s"  # Was: aFmt = " %12s |%17s|%s\n"
         }

# /!_.+\/.+\.md/ { next }
  /!_55/         { next}

NF > 0 { nSize = substr( $0,  1, 12 )
         aDate = substr( $0, 15, 17 )
         aFile = substr( $0, 34     ) "    "; # print; next

     if (substr(aFile,1,5) == "./   ") { next }

     if (substr(nSize,5,4) == "Size" ) { aFile = sprintf( aFmt2, DIR, "App Description" ); sub( " [|] ", "", aFile ) }

     if (substr(aFile,1,5) == "-----") { gsub( "+", "-",  aFile ); aFile = substr( aFile, 1, 23 ) "|" substr( aFile, 23)
     } else {
         split( aFile, mFile, "!_"   );  aFile = sprintf( aFmt2, mFile[1], mFile[2] )
         }
     if (aLastDir != substr( aFile, 1, 9 ) ) {
     if (NF > 5) { aLine = sprintf( aFmt2, "", "" ); aLastDir = substr( aFile, 1, 9 ); sub( "!_", "", aLine );
         printf aFmt, "",    aLine }
         }
         printf aFmt, aDate, aFile
         }

END    { printf aFmt, "", "", "" }
'
#    ----------------------------------------------------------------------------------------------         # .(20521.02.1 End)

#   echo "aListAppsPgm:"; echo "${aListAppsPgm}"; exit

    aOpts="-r 3 ../ '!_'"
#    rdir  -r 3 ../ '!_'      | awk -v DIR="${aPWD}"         -f ${aPgm}  >apps.md                           ##.(20521.02.2)
     rdir  -r 3 ../ '!_'      | awk -v DIR="${aPWD}"   "${aListAppsPgm}" >apps.md                           # .(20521.02.2)

  else

#    aPgm=$( dirname $0 )/listFiles.awk                                                                     ##.(20521.02.3)

#    ----------------------------------------------------------------------------------------------         # .(20521.02.3 Beg RAM: Add .awk program as var)

     aListFilesPgm='

BEGIN  {  sub( /.+FormR\//, "./", DIR )
          sub( /\/!.+/,      "",  DIR )
          aFmt = "|%12s |%17s|%s\n"
          }

NR == 1 { next  }
NR == 2 { print "|        Size |   Date    Time  | File Names in " DIR; next }
NR == 0 { print "| ----------- |---------------- |----------------------------------------------------------------------------------------------------------"; next }
NR == 3 { print "| ----------- |---------------- |---------------------------------------------------------------------------"; next }
          /!.+\/.+\.md/  { next }
          /!.+\/.+\.txt/ { next }

NF  > 0 { nSize = substr( $0,  1, 12 )
          aDate = substr( $0, 15, 17 )
          aFile = substr( $0, 34     ) "    "; # print; next

      if (substr(aFile,1,5) == "./   ") { next }

      if (substr(nSize,5,4) == "Size" ) { aFile = DIR "/  " substr( $0, 37 ); gsub( /["_SQUOTE;]/,  "", aFile ); gsub( /[*]+/, "*", aFile ) }

      if (substr(aFile,1,5) == "-----") { gsub( "+", "-",  aFile ) }

          printf aFmt, nSize, aDate, aFile
          }

END     { printf aFmt, "", "", "" }
'
#    ----------------------------------------------------------------------------------------------         # .(20521.02.3 End)

          aListFilesPgm="${aListFilesPgm/_SQUOTE;/\'}"
#   echo "aListFilesPgm:"; echo "${aListFilesPgm}"; exit

    aOpts="-r 9 ../ '*'"
#    rdir  -r 9 ../ '*'       | awk -v DIR="${aPWD}"          -f ${aPgm}  >files.md                         ##.(20521.02.4)
     rdir  -r 9 ../ '*'       | awk -v DIR="${aPWD}"   "${aListFilesPgm}" >files.md                         # .(20521.02.4)

    fi
# ----------------------------------------------------------------------------

  echo ""
# echo "done"; exit

# echo "   rdir ${aOpts}      | awk -v DIR='${aPWD}' -f ${aPgm}"

#          rdir ${aOpts}      | awk -v DIR='${aPWD}' -f ${aPgm} >files.md
#          rdir ${aOpts}                                        >files.md
#          rdir ${aOpts}      | awk                  -f ${aPgm} >files.md

# echo "   rdir '../' ${aOpts}"
#          rdir '../' -r 3 '!_'
#
#       $( rdir '../' ${aOpts} ) # no workie, executes result of rdir
#          rdir '../' ${aOpts}   # no workie
#          rdir  ../ -r 3 '!_'   #    workie

# echo "|             |                 |           " >>files.md

# echo ""

# echo "|        Size |  Date    Time   | File Name"
# echo "|  ---------- |---------------- |----------------------------------------------------"

           cat files.md # | awk 'NR > 1'

# ----------------------------------------------------------------------------

if [ ! -f chgs.md ]; then

  echo "| Change No | Comment                                  | Filename     "  >chgs.md
  echo "|-----------|------------------------------------------|--------------" >>chgs.md
  echo "|           |                                          |              " >>chgs.md
  echo "|           |                                          |              " >>chgs.md
  echo "|           |                                          |              " >>chgs.md
    fi
# ----------------------------------------------------------------------------
