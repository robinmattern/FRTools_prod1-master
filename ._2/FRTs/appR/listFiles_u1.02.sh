#!/bin/sh

    aPWD=$(pwd)

#   aDir=$( echo ${aPWD} | awk      '{ sub( /.+\/!_/, "", $0 ); print "!_" $0 }' )      ##.(20515.03.1 RAM)
#   aDir=$( ls -1        | awk '/!/  { sub( /_/,     " ", $0 ); print $1      }' )      ##.(20515.03.1 RAM)
    aDir=$( ls -1        | awk '/!/  {                          print         }' )      # .(20515.03.1 RAM)

#   echo "aDir: '${aDir}'"; #exit
    echo "  - savFiles[1] ${aDir}"

    cd "${aDir}"                                                                        # .(20515.03.2 RAM)
# ----------------------------------------------------------------------------

if [ -f "files.md" ]; then
    aTS=$( date '+%y%m%d' ); aTS=${aTS:1:5}
    if [ ! -f "files_v${aTS}.md" ]; then  # .(10219.01.1 RAM Don't replace backup for today if it exists)
    cp -p files.md files_v${aTS}.md
    fi; fi
# ----------------------------------------------------------------------------

if [ "${aDir:0:3}" == "!_P" ] || [ "${aDir:0:3}" == "!_p" ]; then

#   cd ..; echo "----------------------"; pwd; echo "----------------------";

#   aPgm=/c/Home/_0/bin/apps.awk
    aPgm=$( dirname $0 )/apps.awk
    aOpts="-r 3 ../ '!_'"
     rdir  -r 3 ../ '!_'      | awk -v DIR="${aPWD}" -f ${aPgm} >files.md

  else

    aPgm=$( dirname $0)/files.awk
    aOpts="-r 9 ../ '*'"
     rdir  -r 9 ../ '*'       | awk -v DIR="${aPWD}" -f ${aPgm} >files.md

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

  echo ""
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
