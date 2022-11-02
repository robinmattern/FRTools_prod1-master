
//  var   execSync      =  require( 'child_process' ).execSync;
 import { execSync   }     from     'child_process'
 import   fetch            from     'node-fetch'
 import   pFS              from     'fs'

//    var res           =  await fetch('https://dog.ceo/api/breeds/list/all');
//    var json          =  await res.json();
//        console.log(json);

      var aOrg          = ""
      var aOwner        = "8020data"
      var aOwner        = "robinmattern"

      var nSortPos      =  19
      var bSort         =  true

//        -------------------------------------------------------------------------

      var aRepo         = "FRApps_dev03-rick"

      var aURL          = 'https://api.github.com/'
      var aURL          = `https://api.github.com/search/repositories?q=stars:150000..300000`
      var aURL          = `https://api.github.com/users/${ aOwner }/repos{?type,page,per_page,sort}`
      var aURL          = `https://api.github.com/users/${ aOwner }/repos`
//    var aURL          = `https://api.github.com/search/issues?q=author:raisedadead repo:freecodecamp/freecodecamp type:issue`

//    var aURL          = `https://api.github.com/orgs/${ aOrg }/repos`

//    var aURL          = `https://api.github.com/search/repositories?q=owner:${ aOwner }`
//    var aURL          = `https://api.github.com/search/repositories?q=private:false&q=stars:150000..300000`
//    var aURL          = `https://api.github.com/search/repositories?q=private:false&q=login+owner:${ aOwner }`

//    var aQry          = 'GitHub Octocat in:readme user:defunkt'
//    var aQry          = `private:false stars:150000..300000`
//        aQry          =  aQry.replace( / /g, '%20' )
//    var aQry          = `private:false&q=stars:150000..300000`
//        aQry          =  encodeURIComponent( aQry )
      var aQry          = `user:${ aOwner }`
//    var aURL          = `https://api.github.com/search/repositories?q=${ aQry }`

//    var aURL          = `https://api.github.com/repos/${ aOwner }/${ aRepo }`
//    var aURL          = `https://api.github.com/repos/${ aOwner }`

      var aURL          = `https://api.github.com/user/repos`
//    var aURL          = `https://api.github.com/search/repositories?q=user:robinmattern fork:true`
//    var aURL          = `https://api.github.com/search/repositories?q=fork:true`

//        curl -H "Accept: application/vnd.github.v3+json" -H "Authorization: token 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" https://api.github.com/user/repos

//        -------------------------------------------------------------------------

//    var rWhere  =  /\/F/
//    var rWhere  =  /./

      var pCreds        =
           { "Account"  : "robinmattern"
           , "Token"    : "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"
              }
      var payLoad       =
            { title     : "Hey my brand new issue!!!"
              }

//                      [ [ `https://api.github.com/search/repositories?q=user:robinmattern`, /\/F/    ]
      var mURLs         =
                        [   `https://api.github.com/search/repositories?q=user:robinmattern`
                        ,   `https://api.github.com/search/repositories?q=user:8020data`
                        ,   `https://api.github.com/search/repositories?q=user:blueNSX`
//                      , [ `https://api.github.com/users/robinmattern/repos`               , selRepo2 ]
                        ,   `https://api.github.com/user/repos`
                           ]

//        console.log( "mURLs:", mURLs )
//    var mURLs         =[ aURL ]
//    var mRepos        = await getRepos( aURL, rWhere, pCreds )

//    var aCmd          = ''
      var aCmd          = `gh repo list -L 99 --json url,updatedAt,isFork,owner,parent`

//    --- -------------------------------------------------------------------------------------------

//        -------------------------------------------------------------------------
      var mRepos        =[ ], i
     for (i = 0; i < mURLs.length; i++) {

//    if (typeof( aURL[i] ) == 'object' ) {
      if (mURLs[i].constructor === Array) {
      var aURL          =  mURLs[i][0]
      var rWhere        =  mURLs[i][1]
      } else {
      var aURL          =  mURLs[i]
      var rWhere        =  /./
          }
//        ----------------------------------------------------

          console.log(    "\ngetRepos[1] aURL:   ", aURL   )
          console.log(      "            rWhere: ", rWhere )
//        console.log(      "            pCreds: ", pCreds )
//        console.log(     await getRepos( aURL, rWhere, pCreds ) )

          mRepos        =[ ...mRepos, ...await getRepos( aURL, rWhere, pCreds ) ]
          }
//        -------------------------------------------------------------------------

      if (aCmd) {
      var pResponse     =  execSync( aCmd );   // aka pStream
      var aBody         =  pResponse.toString( )
      var pJSON         =  JSON.parse( aBody )
          console.log(    "\ngetRepos[2] aCmd:   ", aCmd   )
//        console.log(     pJSON.map( getRepo2 ).filter( selRepo2 ) )

          mRepos        =[ ...mRepos, ...pJSON.map( getRepo2 ).filter( selRepo2 )  ]
          }
//        -------------------------------------------------------------------------

      if (mRepos.length) {
//        mRepos        =  mRepos.map( fmtRepo2 )
//        console.log( mRepos.join( "\n" ) )

      var doSort = function( a, b ) { return getRepoName( a, 0 ) > getRepoName( b, 0 ) ? 1 : -1 }   // if a is before b, return negative
//    var doSort = function( a, b ) { console.log( getRepoName( a, 0 ) ) }                          // if a is before b, return negative
          doSort = bSort ? doSort : ( a, b ) => { return 0 }                                                       // if b is before a, return positive

//        ----------------------------------------------------

    //var mOut = [ "<body><style> table { border-spacing: 0; border-collapse: collapse; } td { padding: 1px 7px 1px 7px; font-size: 13px; } </style>"
      var mOut = [ "<body><style> table { border-spacing: 0; border-collapse: collapse; }"
                 , "                 td { padding: 1px 7px 1px 7px; font-size: 13px; }"
                 , "     td:first-child { text-align: right; } </style>"
                 , ""
                 , "| No. | Repository Account/Name                                      | Updated On       | F | P | Forked From                       "
                 , "| --- | ------------------------------------------------------------ | ---------------- | - | - | ----------------------------------"
                   ]
          mOut  = [ ...mOut, ...mRepos.sort( doSort ).map( fmtRepo2 ) ]

//        console.log( mOut.join( "\n" ) )

      var aFileName = `fr101_Repos_v${ (new Date).toISOString().replace( /-/g, '' ).substr( 3, 5) }.md`

          pFS.writeFileSync( aFileName, mOut.join( "\n" ) )

          console.log( `\ngetRepos[3] Listed ${ mOut.length } Repo Names to file: ${ aFileName }` )

      } else {
          console.log( "Nothing found" )
          }
//        -------------------------------------------------------------------------

// --------------------------------------------------------------------------------

async function getRepos( aURL, rWhere, pCreds, pPostObj) {

      var headers       = pCreds ?
           { "Authorization" : "Token " + pCreds.Token
           , "Accept"        : "application/vnd.github.v3+json"
              }              : { }

      var pOptions      =
             { method   : "GET"
             , headers  :  headers
//           , body     :  JSON.stringify( ppayLoad )
               }

      if (pPostObj) {
          pOptions.body = JSON.stringify( pPostObj ) // aka payload
          }
          aURL          =  aURL.replace( /{Account}/, pCreds ? pCreds.Account : '' )

      var pResponse     =  await fetch( aURL, pOptions)

      var mRepos        =  [];
      var pJSON         =  await pResponse.json()

      if (pJSON.total_count) {
      var mRepos        =  pJSON.items
          }

      if (pJSON[0] && pJSON[0].full_name) {
      var mRepos        =  pJSON
          }
//        console.log( mRepos ); return
      if (mRepos.length) {
//                         mRepos.map( pRepo => { console.log( pRepo.url + " " + pRepo.updated_at ) } )
//    var mRepos        =  mRepos.filter( selRepo1 ).map( fmtRepo2 )
//    var mRepos        =  mRepos.filter( selRepo1 )
      if (typeof( rWhere ) != 'function') {
      var mRepos        =  mRepos.filter( selRepo1 )
      } else {
//        console.log(    "rWhere:", rWhere )
      var mRepos        =  mRepos.filter( rWhere )
          }
//        console.log( "aURL:    ", aURL )
//        console.log( "mRepos:  ", mRepos.join( "\n" ) )
//        console.log(              mRepos )
      } else {
          console.log( "getRepos Failed" )
          console.log( "  pJSON: ", pJSON )
          console.log( "    url: ", aURL  )
          }
   return mRepos
          }
// --------------------------------------------------------------------------------------------------------

 function getRepo2( pRepo, i ) {
          pRepo.updated_at  =  pRepo.updatedAt
          pRepo.fork        =  pRepo.isFork
          pRepo.parent      =  pRepo.parent
   return pRepo
          }
// --------------------------------------------------------------------------------

 function getRepoName(  pRepo, bFill ) {
      var aURL       =  pRepo.url.replace( /.+github.com\//, "" )
          aURL       =       aURL.replace( /repos\//,        "" )
          aURL       =  '                      '.substr( 0, nSortPos - aURL.indexOf( '/' ) ) + aURL
   return bFill      ?  aURL : aURL.substr( nSortPos + 1 ).toLowerCase()
          }
// --------------------------------------------------------------------------------

 function fmtRepo2( pRepo, i ) {

      var aNo        = ( i < 9 ? '&nbsp;&nbsp;' : '' ) + ( i+1 )
      var aNo        = `${ i+1 }`.padStart( 3 )

      var aRepoName  =  getRepoName( pRepo, 1 )

//    var aUpdatedAt =  pRepo.updatedAt
      var aUpdatedAt =  pRepo.updated_at
                     ?  pRepo.updated_at.replace( /T/, ' ' ).substr( 0, 16 )
                     :  ""
//    var aForked    =  pRepo.isFork  ? "Y" : "N"
      var aForked    =  pRepo.fork    ? "Y" : "N"
      var aPublic    =  pRepo.private ? "N" : "Y"
//    var aOwner     =  pRepo.owner.login
      var aUpstream  = (pRepo.parent)
                     ?  pRepo.parent.owner.login + '/' + pRepo.parent.name
                     : ''
      var aStr = `|${ aNo }. | ${ aRepoName.padEnd( 60 ) } | ${ aUpdatedAt.padEnd( 16 ) } | ${aForked} | ${aPublic} | ${ aUpstream.padEnd( 20 ) } `
   return aStr
          }
// --------------------------------------------------------------------------------------------------------

  function  selRepo1( pRepo ) { return pRepo.url.match( rWhere ) != null }
//function  selRepo2( pRepo ) { return pRepo.forks > 0 }
  function  selRepo2( pRepo ) { return pRepo.fork == 1 }

// --------------------------------------------------------------------------------------------------------
