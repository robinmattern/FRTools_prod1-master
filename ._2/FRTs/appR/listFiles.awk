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

      if (substr(nSize,5,4) == "Size" ) { aFile = DIR "/  " substr( $0, 37 ); gsub( /["']/,  "", aFile ); gsub( /[*]+/, "*", aFile ) }

      if (substr(aFile,1,5) == "-----") { gsub( "+", "-",  aFile ) }

          printf aFmt, nSize, aDate, aFile
          }

END     { printf aFmt, "", "", "" }

