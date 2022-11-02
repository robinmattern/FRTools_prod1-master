#!/bin/bash

  aFind="webs";  aFind="/${aFind}/?"
  aDir=$( pwd | awk '{ nPos = match( tolower($0), "'${aFind}'", a ); print a[0] }' )

  echo "aDir: '${aDir}', aFind: ${aFind}"

