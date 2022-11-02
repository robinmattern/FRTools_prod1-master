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
