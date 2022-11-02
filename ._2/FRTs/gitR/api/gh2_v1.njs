const execSync = require('child_process').execSync;

    aCmd = 'node -v'
    aCmd = 'gh repo list -L 99 --json url,updatedAt,isFork,owner,parent'

    pStream =  execSync( aCmd );
    aText   =  pStream.toString( )
    rWhere  =  /\/F/
    rWhere  =  /./

    pJSON = JSON.parse( aText )

//  console.log( pJSON  )

    mOut = [ "<body><style> table { border-spacing: 0; border-collapse: collapse; } td { padding: 1px 7px 1px 7px; font-size: 13px; } </style>"
           , ""
           , "| No. | Repository Account/Name                                      | Updated On       | F | Forked From                       "
           , "| --- | ------------------------------------------------------------ | ---------------- | - | ----------------------------------"
             ]

    mOut = [ ...mOut, ...pJSON.filter( selRepo ).map( fmtRepo ) ]

    console.log( mOut.join( "\n" ) )

function fmtRepo( pRepo, i ) {

    var aNo        = ( i < 9 ? '&nbsp;&nbsp;' : '' ) + ( i + 1 )
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


function selRepo( pRepo ) { return pRepo.url.match( rWhere ) != null }

