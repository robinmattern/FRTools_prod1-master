
    var execSync = require('child_process').execSync;

    var aOwner="robinmattern"
//  var aOwner="8020data"

    var aAccount="robinmattern"
    var aToken="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"

    var aURL=`https://api.github.com/user`    // profile
//  var aURL=`https://api.github.com/repos`
//  var aURL=`https://api.github.com/users/${ aOwner }/repos`
//  var aURL=`https://api.github.com/orgs/${ aOwner }/repos`

    var aCmd = `node -v`
        aCmd = `gh repo list -L 99 --json url,updatedAt,isFork,owner,parent`
//      aCmd = `curl -s -u ${aAccount}:${aToken} ${ aURL }`

    var rWhere  =  /\/F/
    var rWhere  =  /./

//      console.log( "aCmd: ", aCmd )

    var pResponse =  execSync( aCmd );   // aka pStream
    var aBody     =  pResponse.toString( )
    var pJSON     =  JSON.parse( aBody )

    //  console.log( "aText", aText  )
    //  console.log( "pJSON", pJSON  )

    //  mOut = [ "<body><style> table { border-spacing: 0; border-collapse: collapse; } td { padding: 1px 7px 1px 7px; font-size: 13px; } </style>"
        mOut = [ "<body><style> table { border-spacing: 0; border-collapse: collapse; }"
               , "                 td { padding: 1px 7px 1px 7px; font-size: 13px; }"
               , "     td:first-child { text-align: right; } </style>"
               , ""
               , "| No. | Repository Account/Name                                      | Updated On       | F | Forked From                       "
               , "| --- | ------------------------------------------------------------ | ---------------- | - | ----------------------------------"
                 ]

    if (pJSON && pJSON.map) {
        mOut = [ ...mOut, ...pJSON.filter( selRepo ).map( fmtRepo1 ) ]

        console.log( mOut.join( "\n" ) )
    } else {
        console.log( "aResponse:", aBody )
        }

// --------------------------------------------------------------------------------------------------------

function fmtRepo1( pRepo, i ) {

//  var aNo        = ( i < 9 ? '&nbsp;&nbsp;' : '' ) + ( i + 1 )
    var aNo        = `${i}`.padStart( 3 )
    var aURL       =  pRepo.url.substr(19)
    var aUpdatedAt =  pRepo.updatedAt.replace( /T/, ' ' ).substr( 0, 16 )
    var aForked    =  pRepo.isFork ? "Y" : "N"
//  var aOwner     =  pRepo.owner.login
    var aUpstream  = (pRepo.parent)
                   ?  pRepo.parent.owner.login + '/' + pRepo.parent.name
                   : ''
    var aStr = `|${ aNo }. | ${ aURL.padEnd( 60 ) } | ${ aUpdatedAt.padEnd( 16 ) } | ${aForked} | ${ aUpstream.padEnd( 20 ) } `
 return aStr
        }
// --------------------------------------------------------------------------------------------------------


function fmtRepo2( pRepo, i ) {

//  var aNo        = ( i < 9 ? '&nbsp;&nbsp;' : '' ) + ( i + 1 )
    var aNo        = `${i}`.padStart( 3 )
    var aURL       =  pRepo.url.substr(19)
    var aUpdatedAt =  pRepo.updated_at.replace( /T/, ' ' ).substr( 0, 16 )
    var aForked    =  pRepo.fork ? "Y" : "N"
//  var aOwner     =  pRepo.owner.login
    var aUpstream  = (pRepo.parent)
                   ?  pRepo.parent.owner.login + '/' + pRepo.parent.name
                   : ''
    var aStr = `|${ aNo }. | ${ aURL.padEnd( 60 ) } | ${ aUpdatedAt.padEnd( 16 ) } | ${aForked} | ${ aUpstream.padEnd( 20 ) } `
 return aStr
        }
// --------------------------------------------------------------------------------------------------------

function selRepo( pRepo ) { return pRepo.url.match( rWhere ) != null }

// --------------------------------------------------------------------------------------------------------
