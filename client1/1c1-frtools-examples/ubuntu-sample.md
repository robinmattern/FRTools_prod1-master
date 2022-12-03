## FRTools Ubuntu Install Script
 1. Login to Remote Ubuntu Server
    - Open Bitvise Profile .tlp file
    - Click the Login button
    - Open New terminal console
    - In the remote terminal console, remove existing PATH
  ` # nano /root/.profile `
        Remove /webs/FRTools/._2/bin: from export PATH=$PATH:... in /root/.profile
        CTRL-X
  ` # logout `
    - In Bitvise, Open New terminal console
    - Check the FRTools is not installed
  ` # frtools `
    - Remove the FRTools if present
  ` # rm -R webs/FRTools `
  ` # rm    webs/frtools/* `
 2. Clone the FRTools Repository
  ` # cd /webs `
  ` # git clone https://github.com/robinmattern/FRTools_prod1-master FRTools `
 3. Set the Path to the FRTools scripts
  ` # cd /webs/FRTools `
  ` # chmod 755 setPath `
  ` # ./setPath `
  ` # ./setPath -doit `
    $ logout
    - In Bitvise, Open New terminal console
    - Check that the FRTools scripts are installed
  ` # FRTools `
 4. Get new version of FRTools
  ` # cd /webs/FRTools `
  ` # gitr pull  `
  ` # gitr pull -hard `
            
