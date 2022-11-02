BEGIN { } 

   /top -/     { nUpTime = $5  }
   /Tasks:/    { nTasks  = $2  }
   /wa,/       { nWA     = $10 }
   /KiB Mem:/  { nTotMem = $3 
                 nUsdMem = $7
                 }
				
   $1 == "PID" { printf " Uptime: %6s  Tasks:%4d,  zCPU: %5s,  MemFree: %7d\n", nUpTime, nTasks, nWA, nUsdMem  
#	             print "      PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND"
		         }

#  /^[ 0-9]/   { if ($5 > 0 || NR < 15 ) { print "    " $0 } }  
   /^[ 0-9]/   {               print "    " $0   }  
	
	NR == 40   { exit } 
	
				
				
   
   
   
      