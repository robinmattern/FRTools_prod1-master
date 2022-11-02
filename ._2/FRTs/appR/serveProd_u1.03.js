  const   Express   =  require( 'express' );

//  var __dirname   =  process.mainModule.path              // folder of first script, can't use const; No trailing /
    var __currdir   =  process.cwd();                       // console.log( `process.cwd(): '${process.cwd()}'` )

      var pApp      =  Express( );
      var aHomePage =  getHomePage()
      var nPort     =  getPort( 5000 ) // 51165

//         console.log( `    nPort: ${nPort}, aHomePage: '${aHomePage}', process.argv[2]: '${process.argv[4]}' ` ); process.exit()
      if ((process.argv[4] || '').match( /-*ver/ )) { console.log( `  FRT RUN PROD Version ${ __filename.replace( /.+_u/, "" ).replace( /.js/, "" ) }` ); process.exit() }

    if (! chkDir( `${ __currdir || '.' }/build` )) { process.exit() }
//--- --- --------  =  ------------------------------------------------- --- ---

      if (aHomePage > '') {

     pApp.get( "/", ( req, res ) => {
          res.send(   "<h1>Welcome to FormR ...<h1>" );
          });
          }
//    --- --------  =  ------------------------------------------------- ---

     pApp.use( "/" + aHomePage, Express.static( `${ __currdir }/build` ) );             // .(20406.13.1 RAM Was __dirname)

//    --- --------  =  ------------------------------------------------- ---

     pApp.use(       sndError_InvalidRoute  )                                           // .(10124.01.4 RAM Finally, send error if all routes fail)

     pApp.listen( nPort, ( ) => {
                       console.log( `  Serving build/index.html at: http://localhost:${nPort}${ aHomePage ? `/${aHomePage}` : '' }` );
                       console.log( "    Press CTRL-C to stop serving the React app located in ./build.\n" )
          });
//    --- --------  =  ------------------------------------------------- ---

     process.on( 'uncaughtException', function( pErr ) {
          if (pErr.code == 'EADDRINUSE') { console.log( ` ** Port ${nPort} is in use.  You can reset PROD_PORT in file, '.env'` ) }
            else {                         console.log( `*** Express Error ${pErr.errno}: ${pErr.code}` ) }
          process.exit(1);
          } );
//    --- --------  =  ------------------------------------------------- ---

function  sndError_InvalidRoute( req, res ) {                                           // .(10124.01.5 RAM Beg: Write sendError_InvalidRoute)
     var  aURL     =  req.originalUrl || ''
     var  aMethod  =  req.method;
     var  aMsg     = `Invalid route: ${aMethod} ${aURL}`;
          res.status(404).send( `  * Server error 404: ${aMsg}` );                      // .(10210.06.1 RAM Get it right).(10227.08.2 Hard code server.js[91])
                   console.log( `  * Server error 404: ${aMsg}` )
          } // eof sendError_InvalidRoute                                               // .(10124.01.5 RAM End)

function  getPort( nDefaultPort ) {
      var nPort     =  isNaN( process.argv[2] ) == false ? process.argv[2] : process.env.PORT
          nPort     =  nPort ? nPort : getVar( '.env', 'PROD_PORT' )
          nPort     =  nPort ? nPort : nDefaultPort
      if (nPort > '') { return nPort }
                       prtErr( "getPort[1]     ** var, Port, NOT FOUND" )
          process.exit()
          }

function  getHomePage() {
          __currdir =  __currdir.match( /client|server/) ? __currdir : ''  // .(20406.12.1 RAM Blank if not in client or server app ??? )
     var  aHomePage =  getVar( 'package.json', 'homepage' )
          aHomePage =  aHomePage ? aHomePage :  getVar( '.env', 'HOMEPAGE' )
//        aHomePage =  aHomePage ? aHomePage :__currdir.replace( /.+(client|server)[0-9]*[\\/]([0-9]*[cs]-)*/, "" )  // remove 5c- from app name
//        aHomePage =  aHomePage ? aHomePage :__currdir.replace( /.+(client|server)[0-9]*[\\/]*/             , "" );
      if (aHomePage > '') { return aHomePage }
                       prtErr( "  * Var, Homepage, is not set in package.json. Using ''", 0 )
//                     prtErr( "getHomePage[1] ** Var, Homepage, NOT FOUND. Using ''", 0 )
          return ''
//        process.exit()
          }

function  getVar( aFile, aVar ) {
    var   pFS       =  require( 'fs' );
    var   rVar      =  new RegExp( `${aVar}[" ]*[:=]` , 'i' ), aVars = ''
//        console.log(`getVar[1]   aFile: '${__currdir}/${aFile}', aVar: '${aVar}'` )
    try { aVars     =  pFS.readFileSync(  `${__currdir || '.' }/${aFile}`, 'ASCII' ) || '' }   // // .(20406.12.2 RAM Add '.' if MT)
      catch(e) {       prtErr( `getVar[2]       * File, '${__currdir}/${aFile}', NOT FOUND` ) };
      if (aVars == "") { return "" }
     var  mVars     =  aVars.replace( /\r\n/g, '\n' ).split( '\n' ).filter( aVar => { return aVar.match( rVar ) } )
//        console.log(`getVar[3]  mVars[0]: '${ mVars[0] }', aFile: '${aFile}', aVar: '${aVar}'` )
  return  mVars[0]  ?  mVars[0].replace( rVar, "" ).replace( /["=,: ]/g, "" ).replace( /^[\\/]/, "" ) : ""
          }
//        --------  =  ------------------------------------------------- ---

async function chkDir( aDir ) {
    var   pFS       =  require( 'fs/promises' ), mDir = [];
    try { mDir      =  await pFS.readdir( aDir ) }
      catch(e) {       prtErr( `chkDir[1]     *** Folder, '${ aDir }', NOT FOUND` ) };
   return mDir ? 1 : 0
          }

function prtErr(aMsg, bQuiet) {
         bQuiet = (typeof( bQuiet ) != 'undefined') ? bQuiet : 1
     if (bQuiet == 0) { console.log( aMsg ) }
         }
