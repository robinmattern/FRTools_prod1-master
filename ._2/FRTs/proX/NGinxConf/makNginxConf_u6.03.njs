
//----------  ----------------------------------------------------------------------


//--------  -----------------   =  --------------------

            nVer                = '1.3'
        if (getArg( /-v.*/ )) {
            console.log( `\n  * Version ${nVer} - ${ __filename }\n` ); process.exit()
            }

       var  bQuiet              = (typeof( bQuiet         ) != 'undefined') ? bQuiet : 0
       var  aQuiet              =  getArg( /-q[1-4]?/ ).replace( /-q$/, '1' ).replace( /-q/, '' )
            nQuiet              =  bQuiet ? bQuiet : (aQuiet ? aQuiet : 2) * 1
//          console.log( `  aQuiet: '${aQuiet}', nQuiet: ${nQuiet}` ); process.exit()

       var  TheSvr              = 'et218t'
       var  TheSvr              = ''

//          console.log( "process.argv:\n", process.argv );  // process.exit()
//          console.log( `nQuiet: ${nQuiet}, aQuiet: '${aQuiet}'` ); // process.exit()

//--------  -----------------   =  --------------------

//     var  aNgxDir             = 'client/5c-my-react-app/etc-nginx/apps-enabled'
//     var  aNgxPath            = `${ aPrjDir.replace( /[\\/](client|server).*/, '' ) }/${aNgxDir}`
//     var  aNgxPath            = `C:/WEBs/8020/VMs/et218t/webs/nodeapps/FRApps_/prod1-robin/${aNgxDir}`

       var  mArgs               =  process.argv.splice( 2 )
//          console.log( "mArgs:\n", mArgs );  // process.exit()

            setVars( mArgs );   // process.exit()

        if (nQuiet == 1) {         process.exit() }
        if (nQuiet == 4) {

            console.log( "" )
            console.log( `    aProject:  '${aProject}'` )
            console.log( `    aApp:      '${aApp}'`     )
            console.log( `    aDomain:   '${aDomain}'`  )
            console.log( `    nPort:      ${nPort}`  )
            console.log( `    aURI:      '/${aURI}'` )
            console.log( `    aIndx:     '${aIndx}'` );
            console.log( `    aRDir:     '${aRDir}${aBld}'` )
            console.log( `    aSiteCfg:  'sites-available/${aSiteCfg}'` );
            console.log( `    aAppCfg:   'apps-enabled/${aAppCfg}'` );
            console.log( `    aAppLog:   '${aAppLog}_access.log'`   )
            console.log( `    aSiteLog:  '${aSiteLog}_access.log'`  )
            console.log( `    aNgxDir:   '${aNgxDir}'` );
            console.log( `    aIPAddr:   '${aIPAddr}'` )
            process.exit()
            }

//--------  -----------------   =  ---------------------------------------------

//     var  aConf               =  makStaticConf( aURI, aLog, aDir, aIdx )
       var  aAppConf            =  makConf( nPort )
       var  aSiteConf           =  makServer_Conf( )

            bSaved              =  false
        if (nQuiet <= 2) {
       var  bSaved              =  saveFile( `${aNgxDir}/sites-available/${aSiteCfg}`, aSiteConf )
       var  bSaved              =  saveFile( `${aNgxDir}/apps-enabled/${aAppCfg}`,      aAppConf )
            }

//--------  -----------------   =  ---------------------------------------------

        if (nQuiet == 1) {
        if (bSaved == 0) {
            console.log( "" )
            console.log( `\n* Proxy .conf files NOT saved to: '/${aNgxDir}'`)
            process.exit()
            } } //  eif nQuiet = 1

        if (nQuiet == 2) {
            aAppLog1            =  aSvr ? aAppLog : `       ${aAppLog}`
            aURI_               =  aURI ? aURI    : `/`
            console.log( "" )
            console.log( "  Project/App          Domain / URI          Remote App Folder / Log File                    Site / App Config File" )
            console.log( "  -------------------  --------------------  ----------------------------------------------  -----------------------------------------" )
//          console.log( "  FRApps               formr-xxx-01.com      /webs/FRApps/client/5c-my-react-app/build       sites-available/formr-xxx-01.com.conf" )

            console.log( "  " + aProject.padEnd(21) + aDomain.padEnd(22) + `${aRDir}${aBld}`.padEnd(48)        + `sites-available/${aSiteCfg}` )
            console.log( "  " + aApp.padEnd(21)     + aURI_.padEnd(21)   + `${aAppLog1}.access.log`.padEnd(49) + `   apps-enabled/${aAppCfg}`  )
//          process.exit()
            }   //  eif nQuiet = 2

        if (nQuiet == 3) {
            console.log( "" )
//          console.log(   `             for Site .conf file: './sites-available/${aSiteCfg}'` )
            console.log( `  =============================================================================================` )
            console.log(      aSiteConf )
//          console.log( `\n              for App .conf file:  './apps-enabled/${aAppCfg}'` )
            console.log( `  =============================================================================================` )
            console.log(      aAppConf )
            console.log( `  =============================================================================================` )
            }   //  eif nQuiet = 3

        if (bSaved) {
            console.log( `\n  Proxy Config files are saved locally in: '/${aNgxDir}/*'`)                                   // */
            console.log(   `  They will be copied to /etc/nginx/* on your remote server by the FRT Deploy tool.`)  // */
        } else {
            console.log( `\n  Proxy Config files NOT saved in: '/${aNgxDir}/*'`)
            }   //  eif bSaved


//--------  -----------------   =  --------------------

  function  setVars( mArgs ) {
//          console.log( "mArgs:\n", mArgs );  //process.exit()

            aProject  =  mArgs[0].replace( /\/.+/, "" )
            aDomain   =  mArgs[1]
            aHomePage =  mArgs[2]
            nPort     = (mArgs[3] || '0' )* 1
            aNgxDir   =  mArgs[4]
            aQuiet    =  mArgs[5]
            aBld      = '/build'
            aApp      =  mArgs[0].replace( /.+\//, "" )
            aSvr      =  TheSvr
            aIndx     = 'index.html'
            aIPAddr   = '45.76.252.191'

            aURI      = `${ aHomePage == 'none' ? '/' : aHomePage }`
            aURI      =  aURI.replace( /^\//, "")                  // .(20411.06.1)

            aRDir     =    `/webs/${aProject}/client/${aApp}`
            aAppLog   = (`${aSvr ? `${aSvr}_` : ''}${aProject}_${aApp}`).toLowerCase()
            aAppCfg   =  `${aSvr ? `${aSvr}.` : ''}${aDomain}${ aURI == '/' ? '.root' : '.' + aURI.replace( /\//g, '.' ) }.conf`
            aSiteLog  = (`${aSvr ? `${aSvr}_` : ''}${aProject}`).toLowerCase()
            aSiteCfg  =  `${aSvr ? `${aSvr}.` : ''}${aDomain}.conf`
            }
//--------  -----------------   =  --------------------

  function  makConf( nPort ) {

//          setVars( aPrj )

        if (nPort == 0) { return makStatic_Conf()  }
        if (nPort != 0) { return makNodeApp_Conf() }
            }
//--------  -----------------   =  --------------------

//function  makStatic_Conf( aURI, aLog, aRDir, aIdx ) {
//function  makStatic_Conf( aPrj ) {
  function  makStatic_Conf( ) {

       var  aStr = `
    set $file    "apps-enabled/${aAppCfg}";

#   ------------  -------------------------------------

#   location ~    /${aURI}  {
    location      /${aURI}  {

      access_log  /var/log/nginx/${aAppLog}_access.log;
      error_log   /var/log/nginx/${aAppLog}_error.log;

      alias       ${aRDir}${aBld};
      index       ${aIndx};

      set $block3 "/${aURI}";
      set $path3  "$document_root $uri $args";
      }
#   ------------  -------------------------------------
    `
    return  aStr
  }
//--------  -----------------   =  --------------------

  function  makNodeApp_Conf( ) {

       var  aStr = `
    set $file    "apps-enabled/${aAppCfg}";

#   ------------  -------------------------------------

#   location ~    /${aURI}  {
    location      /${aURI}  {

      access_log  /var/log/nginx/${aAppLog}_access.log;
      error_log   /var/log/nginx/${aAppLog}_error.log;

      proxy_set_header  Host $host;
      proxy_set_header  X-Real-IP         $remote_addr;
      proxy_set_header  X-Forwarded-Proto $scheme;
      proxy_set_header  X-Forwarded-For   $remote_addr;
      proxy_set_header  X-Forwarded-Host  $remote_addr;

      set $block3 "/${aURI}";
      set $path3  "$document_root $uri $args";

      rewrite    ^/${aURI}(.*)$  /  break;
      proxy_pass   http://localhost:${nPort};
      }
#   ------------  -------------------------------------
    `
    return  aStr
  }
//--------  -----------------   =  --------------------

  function  makServer_Conf() {

       var  aStr = `
    set $file    "sites-available/${aSiteCfg}";

  # --------------  -----------------------------------------------------

    server {

      listen        80;
      listen        [::]:80;

#   ------------  -------------------------------------

#   server_name   ${aIPAddr};
    server_name   ${aDomain};

#   ------------  -------------------------------------

    set $debug    0;
#   error_log     /var/log/nginx/_debug.log  debug;
#   include       /etc/nginx/apps-enabled/_debug.conf;

#   ------------  -------------------------------------

    include       /etc/nginx/apps-enabled/*${aDomain}*.conf;

#   ------------  -------------------------------------
    }
# --------------  -----------------------------------------------------
    `
    return  aStr
  }
//--------  -----------------   =  --------------------------------------------------  */

/*
    set $debug    0;
#   error_log     /var/log/nginx/debug.log  debug;
#   set $file    "${aDomain}.conf";
#   include       /etc/nginx/apps-enabled/_debug.conf;
*/
  function  getArg( rArg ) {
//     var  rArg   = new RegExp( aArg + "[0-9]*" )
       var  aFound = ""
//          console.log( `  Looking for: '${ rArg }'` )
            process.argv.map( isArg )
     return aFound
   function isArg(  aArg, i ) {
//          console.log( `  Searching in: '${ aArg }'` )
        var mFound = aArg.match( rArg )
//          console.log( `  Found:\n`, mFound )
        if (mFound) {
//          delete process.argv[ i ]  // works, but process.argv.length doesn't change
//          process.argv = process.argv.splice( i, 1)  // return removed items
                           process.argv.splice( i, 1)
            aFound = mFound[0]
//          console.log( `  Found ${i}: '${aFound}'` )
        }   }   }
//--------  -----------------   =  --------------------

  function  readFile( aFile ) {
       var  pFS = require( 'fs' )
      try { aFile = aFile.match( /^(\/[a-zA-Z]|[a-zA-Z]:)/) ? aFile : `${ __dirname }/${aFile}`
    return  pFS.readFileSync( aFile, 'ASCII' )
      } catch(e) {
    return '' }
            }
//--------  -----------------   =  --------------------

  function  saveFile( aFile, aText ) {
//     var  pFS = import(  'fs' )
       var  pFS = require( 'fs' )
      try { aFile = aFile.match( /^(\/[a-zA-Z]|[a-zA-Z]:)/) ? aFile : `${ __dirname }/${aFile}`
            pFS.writeFileSync( aFile, aText )
    return  true
      } catch(e) {
            console.log( ` ** Unable to write to file: '${aFile}'` ) }
    return  false
            }
//--------  -----------------   =  --------------------

//     ---  -----------------   =  --------------------------
//----------  ----------------------------------------------------------------------
