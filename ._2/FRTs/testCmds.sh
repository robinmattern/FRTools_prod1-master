#!/bin/bash

# gitr li
# gitr li -b

# gitr li co -b
# gitr li co -b
# gitr li co all  -b
# gitr li co both -b
# gitr li co lo   -b

# gitr li co lo  #-- ok
# gitr li re co  #-- list remotes

# ----------------------------------------------------------------------------
#                                                               $1, $2, $3,  $4,   $5,   $6,  $7,  $8, $9, $10, $11, $12
#                                                               %4s %7s %10s %-10s %-12s %-5s %-5s %s %s %s %s\n"
#                                                               co   co-re   co-re-li   co re li   re   li
#                                                              'co' 'co-re' 'co-re-li' 'co re li' 're' 'li' '' '' '' ''
function doit {

  a=$(   gitr $2 $3 $4 ); a="${a//\' \'/\', \'}"; r="${a//\'/}"

# echo   " $1 $2 $3 $4 $5 --- ${a}"
# echo   " $1 $2 $3 $4 $5 --- ${a:23}"

# echo       "$2 $3 $4 ${a:23}"  | awk '{ printf " gitr %-8s --- %s\n", $1" "$2" "$3, $4, $5 }'
# echo       "$2 $3 $4 ${a:23}"  | awk '{ c = $1" "$2" "$3; $1=""; $2=""; $3=""; printf " gitr %-8s --- %s\n", c, $0 }'
# r="$( echo          "${a:23}"  | awk '{ n = index( $0, "," ); a = substr( $0, 1, n-1 ); $0=substr( $0, n+1 ); printf "%-20s %s\n", a, $0 }' )"
# r="$( echo          "${a:23}"  | awk '{ n = index( $0, "," ); a = substr( $0, 1, n-1 ); $0=substr( $0, n+1 ); printf "%-20s %4s %7s %10s %-10s %-12s %-5s %-5s %-4s %-4s %-4s %s\n", a, $1, $2, $3,  $4,   $5,   $6,  $7,  $8, $9, $10, $11, $12 }' )"

#                                                                  aCmd  Cm1  Cm2  Cmd3  Cmd0  Arg1  Arg2  Arg3 Arg4 Arg5 Arg6 Arg7   Cm1 Cm2 Cmd3 Cmd0 Arg1 Arg2 Arg3 Arg4 Arg5 Arg6 Arg7
# r="$( echo          "${a:23}"  | awk 'BEGIN{ FS="," }; { printf "%-23s %-4s %-8s %-11s %-12s %-11s %-11s %-4s %-4s %-4s %-4s %s\n", $1, $2, $3,  $4,  $5,  $6,  $7,  $8,  $9,  $10, $11, $12, $13 }' )"

#                                                                   1     2    3    4     5    6    7    8     9     10    11   12   13
#                                                                  aCmd  Cm1  Cm2  Cmd3  Cmd0  c1   c2   c3   Arg1  Arg2  Arg3 Arg4 Arg4   aCmd Cm1 Cm2 Cmd3 Cmd0 c1  c2  c3  Arg1 Arg2 Arg3 Arg4 Arg5
  r="$( echo          "${a:23}"  | awk 'BEGIN{ FS="," }; { printf "%-23s %-4s %-8s %-11s %-12s %-8s %-5s %-5s %-10s %-10s %-4s %-4s %s\n", $1,  $2, $3,  $4,  $5, $6, $7, $8,  $9, $10, $11, $12, $13 }' )"
# echo " gitr $2 $3 $4 $5 ${r}"

# a="$( echo "$2 $3 $4" "$5"     | awk '                   printf "%-8s  %-20s\n", $1, $2, $3, $4" "$5" "$6" "$7 }' )"
  a="$( echo "$2-$3-$4-$5"       | awk 'BEGIN{ FS="-" }; { printf "%-8s  %-20s\n", $1" "$2" "$3, $4 }' )"
# a="$( echo "$2 $3 $4" "$5"     | awk '                   printf "%-8s  %-20s\n", $1, $2 }' )"
  echo " gitr ${a} ${r}"
  }
# ------------------------------------------------

function doit1 {
  echo ""
# echo " $1"

# echo " gitr $2 $3 $4"
  a=$(   gitr $2 $3 $4 )
  echo    "$1 $2 $3 $4 ${a:23}" | awk '{ printf " gitr %-8s --- %-14s \"%s\"\n", $1" "$2" "$3, $4, $5 }'

  echo "-----------------------------"
# bash  "/c/home/_0/bin/$1"
  }
# ------------------------------------------------

function getCmd( ) {
#        doit  $1   $2   $3   $4   $5    # no workie
         doit "$1" "$2" "$3" "$4" "$5"

   if [ "$6" != "" ]; then
         b=""; if [ "$6" == "-1" ]; then b="-b"; fi
         echo ""; echo " -- again --"
              "$1" "$2" "$3" "$4" ${b}
         fi
         }

function getCmd1( ) {
                                              a=""
  if [ "$2" == "" ] && [ "${a}" == "" ]; then a=$( gitr $1       ); fi
  if [ "$3" == "" ] && [ "${a}" == "" ]; then a=$( gitr $1 $2    ); fi
  if                   [ "${a}" == "" ]; then a=$( gitr $1 $2 $3 ); fi

  echo    "$1 $2 $3 $4 ${a:23}" | awk '{ printf " gitr %-8s --- %s\n", $1" "$2" "$3, $4, $5 }'
# echo       "$2 $3 $4 ${a:23}" | awk '{ printf " gitr %-8s --- %s\n", $1" "$2" "$3, $4, $5 }'
  echo       "${a}"             | awk '{ c = $1" "$2" "$3; $1=""; $2=""; $3=""; printf " gitr %-8s --- %s\n", c, $0 }'
  }
# ------------------------------------------------

function doem1( ) {

  echo ""
  echo " gitr command   Should be             is                      Cmd1   Cmd2     Cmd3        Cmd0         c1       c2    c3    Arg1        Arg2     " # Arg3 Arg4 Arg5"
  echo " -------------  -------------------  ----------------------   ----  -------  ----------  ----------   -------- ----- ----- ---------- ---------- " # ---- ---- ----"
# echo " gitr co re li  List Remote Commits  'Count All Commits'      'co'  'co-re'  'co-re-li'  'co re li'   're'     'li'  ''    ''          ''            ''   ''   ''  "

# doit  gitr co "" ""  "Add Commit"
# doit  gitr co li ""  "List Commits"
# doit  gitr co re li  "List Remote Commits"
# exit

  doit  gitr co "" ""  "Add Commit"
  doit  gitr co li ""  "List Commits"
  doit  gitr co li re  "List Remote Commits"

  doit  gitr co re ""  "Count Remote Commits"
  doit  gitr co re li  "List Remote Commits"

  doit  gitr li re ""  "List Remote"
  doit  gitr li re co  "List Remote Commits"

  doit  gitr li co ""  "List Commits"
  doit  gitr li co re  "List Remote Commits"

  doit  gitr re co ""  "Count Remote Commits"
  doit  gitr re co li  "List Remote Commits"

  doit  gitr re li ""  "List Remotes"
  doit  gitr re li co  "List Remote Commits"
  }
# ------------------------------------------------


function doem2( ) {

  echo  ""
  echo  ""
# echo  " gitr command   Should be             is                      Cmd1   Cmd2     Cmd3        Cmd0         Arg1        Arg2       Arg3 Arg4 Arg5 Arg6"
# echo  " -------------  -------------------  ----------------------   ----  -------  ----------  ----------   ----------- ----------- ---- ---- ---- ----"
  echo  " gitr command   Should be             is                      Cmd1   Cmd2     Cmd3        Cmd0         c1       c2    c3    Arg1        Arg2     " # Arg3 Arg4 Arg5"
  echo  " -------------  -------------------  ----------------------   ----  -------  ----------  ----------   -------- ----- ----- ---------- ---------- " # ---- ---- ----"

# getCmd "gitr" "in"    ""   ""   "Init";
# getCmd "gitr" "ad"  "co" ""     "Add Commit"
# getCmd "gitr" "li"  "co" "al"   "List All Commits"

# getCmd "gitr" "fe"    ""   ""   "Fetch"      #1;
# getCmd "gitr" "fe"    "al" ""   "Fetch All"  #1;
# getCmd "gitr" "fetch" ""   ""   "Fetch"      #1;
# exit

  getCmd "gitr" "in"    ""   ""   "Init";

  getCmd "gitr" "push"  ""   ""   "Push";
  getCmd "gitr" "pull"  ""   ""   "Pull";

  getCmd "gitr" "fe"    "al" ""   "Fetch All";
  getCmd "gitr" "fe"    ""   ""   "Fetch";
  getCmd "gitr" "fetch" ""   ""   "Fetch";

  getCmd "gitr" "co"   ""  ""     "Add Commit"
  getCmd "gitr" "ad"  "co" ""     "Add Commit"

  getCmd "gitr" "ad"  "re" ""     "Add Remote"
  getCmd "gitr" "ad"  "br" ""     "Add Branch"

  getCmd "gitr" "cr"  "re" ""     "Create Remote"

  getCmd "gitr" "li"  "re" "al"   "List All Remotes"
  getCmd "gitr" "li"  "re" ""     "List Remotes"

  getCmd "gitr" "rm"  "re" ""     "Remove Remote"
  getCmd "gitr" "de"  "re" ""     "Remove Remote"
  getCmd "gitr" "re"  "re" ""     "Rename Remote"

  getCmd "gitr" "ch"  "br" ""     "Checkout Branch"
  getCmd "gitr" "ch"  ""   ""     "Checkout Branch"

  getCmd "gitr" "li"  "va" ""     "List Vars"
  getCmd "gitr" "se"  "va" ""     "Set Var"

  getCmd "gitr" "li"  "co" "al"   "List All Commits"
  getCmd "gitr" "li"  "co" "lo"   "List Local Commits"
  getCmd "gitr" "li"  "co" ""     "List Local Commits"
  getCmd "gitr" "li"  "co" "re"   "List Remote Commits"

  getCmd "gitr" "li"  "br" "al"   "List All Branches"
  getCmd "gitr" "li"  "lo" "br"   "List Local Branches"
  getCmd "gitr" "li"  "br" ""     "List Local Branches"
  getCmd "gitr" "li"  "re" "br"   "List Remote Branches"

  getCmd "gitr" "li"  "co" "br"   "List Branch Commits"

  getCmd "gitr" "co"  "co" "al"   "Count All Commits"
  getCmd "gitr" "co"  "co" "lo"   "Count Local Commits"
  getCmd "gitr" "co"  "co" ""     "Count Local Commits"
  getCmd "gitr" "co"  "co" "re"   "Count Remote Commits"
# getCmd "gitr" "co"  "re" ""     "Count Remote Commits"

  }
# ----------------------------------------------------------------------------



function doem3( ) {

  echo  ""
  echo  " gitr command   Should be             is                      Cmd1   Cmd2     Cmd3        Cmd0         c1       c2    c3    Arg1        Arg2     " # Arg3 Arg4 Arg5"
  echo  " -------------  -------------------  ----------------------   ----  -------  ----------  ----------   -------- ----- ----- ---------- ---------- " # ---- ---- ----"

# getCmd "gitr" "in"    ""   ""   "Init";
# getCmd "gitr" "ad"  "co" ""     "Add Commit"
# getCmd "gitr" "li"  "co" "al"   "List All Commits"

# getCmd "gitr" "fe"    ""   ""   "Fetch"      #1;
# getCmd "gitr" "fe"    "al" ""   "Fetch All"  #1;
# getCmd "gitr" "fetch" ""   ""   "Fetch"      #1;

#                                  Should be                   is
#                                 --------------------        ----------------------
# getCmd "gitr" "li"  "br" "al"   "List All Branches"    # -1 # 'List Remote Branches'
# getCmd "gitr" "li"  "lo" "br"   "List Local Branches"  # -1 # 'List Local Commits'
# getCmd "gitr" "li"  "re" "br"   "List remote Branches" # -1 # 'List Remote Branches'
# getCmd "gitr" "li"  "br" ""     "List Local Branches"  # -1 # 'List Local Branches'
  getCmd "gitr" "co"  "co" ""     "Count Local Commits"    -1
# getCmd "gitr" "co"  "re" ""     "Count Remote Commits"   -1


# exit
  }

# doem1
  doem2
# doem3


# - JPFns[352]  aArg1: 'li', aCmd1:  'li',
# - JPFns[394]      Checking aCmd2b: 'li-br'    == 'li-br'    or 're-br'    or 'br-li'    or 'br-re'
#                                                   li-re-br      li-br-re      re-br-li      re-br-li
# - JPFns[395]      Checking aCmd3:  'li-br-al' == 'li-re-br' or 'li-br-re' or 're-br-li' or 're-li-br'  or 'br-li-re' or 'br-re-li'
#                                                                 li-br-al
# - JPFns[394]      Checking aCmd2b: 'li-br'    == 'li-br'    or 're-br'    or 'br-li'    or 'br-re'
