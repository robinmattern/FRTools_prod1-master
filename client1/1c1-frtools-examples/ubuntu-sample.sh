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
  docr text  "   - Click Login button"
  docr text  "   - In the remote SSH console, remote existing PATH"
  docr code  "     nano ~/.profile"
  docr text  "       Remove '/webs/FRTools/._2/bin': from export PATH="..." in ~/.profile"
  docr text  "       CTRL-X"
  docr text  "   - logout"
  docr text  "   - In Bitvise, Open Terminal"
  docr text  "   - Check the FRTools is not installed"
  docr code  "     rm -R webs/FRTools"
  docr code  "     rm    webs/frtools/*"
  docr code  "     FRTools"

  docr step  "2. Clone FRTools Repository"
  docr code  "   cd /webs"
  docr note  "   git clone https://github.com/robinmattern/FRTools_prod1-master FRTools"

  docr step  "3. Set Path to FRTools scripts"
  docr code  "   cd /webs/FRTools"
  docr code  "   chmod 755 setPath"
  docr code  "   ./setPath"
  docr end


