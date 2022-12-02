#!/bin/bash

function docr() {
  echo $2
  }
if [ "$( which docr )" != "" ]; then erase docr; fi

  docr set pause off
# docr set pause on

  docr start "FRTools Ubuntu Install Script"

  docr step  "1. Login to Remote Ubuntu Server"
  docr text  "   - Open Bitvise Profile .tlp file"
  docr text  "   - Click the Login button"
  docr text  "   - Open New terminal console"
  docr text  "   - In the remote terminal console, remove existing PATH"
  docr code  "   $ nano /root/.profile"
  docr text  "       Remove "/webs/FRTools/._2/bin:" from export PATH="$PATH:..." in /root/.profile"
  docr text  "       CTRL-X"
  docr code  "   $ logout "
  docr text  "   - In Bitvise, Open New terminal console"
  docr text  "   - Check the FRTools is not installed"
  docr code  "   $ frtools"
  docr text  "   - Remove the FRTools if present"
  docr code  "   $ rm -R webs/FRTools"
  docr code  "   $ rm    webs/frtools/*"

  docr step  "2. Clone the FRTools Repository"
  docr code  "   $ cd /webs"
  docr note  "   $ git clone https://github.com/robinmattern/FRTools_prod1-master FRTools"

  docr step  "3. Set the Path to the FRTools scripts"
  docr code  "   $ cd /webs/FRTools"
  docr code  "   $ chmod 755 setPath"
  docr code  "   $ ./setPath"
  docr code  "   $ ./setPath -doit"
  docr text  "   $ logout"
  docr text  "   - In Bitvise, Open New terminal console"
  docr text  "   - Check that the FRTools scripts are installed"
  docr code  "   $ FRTools"

  docr step  "4. Get new version of FRTools"
  docr code  "   $ cd /webs/FRTools"
  docr code  "   $ gitr pull "
  docr code  "   $ gitr pull -hard"

  docr end


