#!/bin/bash

function isDir( ) {

  aFind="repos";     bChildOk=0;   bRootOnly=0
  aFind="$1";        bChildOk=$3;  bRootOnly=$2

  aChild=""; if [ "${bChildOk}"  == "1" ]; then aChild="/.+"; fi # aFind="/${aFind}(${aChild})?"
  aRoot="?"; if [ "${bRootOnly}" == "1" ]; then aRoot="$"; fi
# aDir=$( pwd | awk '{ nPos = match( tolower($0), "'${  aFind  }'", a ); print a[0] }' )
  aDir=$( pwd | awk '{ nPos = match( tolower($0), "'"/${aFind}(${aChild})${aRoot}"'", a ); print a[0] }' )
# echo              '{ nPos = match( tolower($0), "'"/${aFind}(${aChild})${aRoot}"'", a ); print a[0] }'

  echo ${aDir}
  }
# --------------------------------------------------------------

  cd dotenv/dotenv-esm

  echo "isDir( 'repos'     ): $( isDir 'repos'     )"
  echo "isDir( 'repos' 0   ): $( isDir 'repos' 0   )"
  echo "isDir( 'repos' 0 0 ): $( isDir 'repos' 0 0 )"
  echo "isDir( 'repos' 0 1 ): $( isDir 'repos' 0 1 )  # RootOnly"
  echo "isDir( 'repos' 1   ): $( isDir 'repos' 1   )  # ChildOK"
  echo "isDir( 'repos' 1 0 ): $( isDir 'repos' 1 0 )  # ChildOK"
  echo "isDir( 'repos' 1 1 ): $( isDir 'repos' 1 1 )  # ChildOK & RootOnly"

# C:\Repos
# -----------------------------------------------
# isDir( 'repos'     ): /repos
# isDir( 'repos' 0   ): /repos
# isDir( 'repos' 0 0 ): /repos
# isDir( 'repos' 0 1 ): /repos  # RootOnly
# isDir( 'repos' 1   ): /repos  # ChildOK
# isDir( 'repos' 1 0 ): /repos  # ChildOK
# isDir( 'repos' 1 1 ):         # ChildOK & RootOnly

# C:\Repos\dotenv
# -----------------------------------------------
# isDir( 'repos'     ): /repos
# isDir( 'repos' 0   ): /repos
# isDir( 'repos' 0 0 ): /repos
# isDir( 'repos' 0 1 ):                # RootOnly
# isDir( 'repos' 1   ): /repos/dotenv  # ChildOK
# isDir( 'repos' 1 0 ): /repos/dotenv  # ChildOK
# isDir( 'repos' 1 1 ): /repos/dotenv  # ChildOK & RootOnly

# C:\Repos\dotenv\dotenv-esm
# -----------------------------------------------
# isDir( 'repos'     ): /repos
# isDir( 'repos' 0   ): /repos
# isDir( 'repos' 0 0 ): /repos
# isDir( 'repos' 0 1 ):                           # RootOnly
# isDir( 'repos' 1   ): /repos/dotenv/dotenv-esm  # ChildOK
# isDir( 'repos' 1 0 ): /repos/dotenv/dotenv-esm  # ChildOK
# isDir( 'repos' 1 1 ): /repos/dotenv/dotenv-esm  # ChildOK & RootOnly
