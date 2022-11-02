
import fetch from 'node-fetch'

// const res = await fetch('https://dog.ceo/api/breeds/list/all');
// const json = await res.json();
// console.log(json);

      var aOrg          = ""
      var aOwner        = "8020data"
//    var aOwner        = "robinmattern"

      var aRepo         = "FRApps_dev03-rick"

      var aURL          = 'https://api.github.com/'
      var aURL          = `https://api.github.com/search/repositories?q=stars:150000..300000`
      var aURL          = `https://api.github.com/users/${ aOwner }/repos{?type,page,per_page,sort}`
      var aURL          = `https://api.github.com/search/issues?q=author:raisedadead repo:freecodecamp/freecodecamp type:issue`

//    var aURL          = `https://api.github.com/orgs/${ aOrg }/repos`

//    var aURL          = `https://api.github.com/search/repositories?q=owner:${ aOwner }`
//    var aURL          = `https://api.github.com/search/repositories?q=private:false&q=stars:150000..300000`
//    var aURL          = `https://api.github.com/search/repositories?q=private:false&q=login+owner:${ aOwner }`

//    var aQry          = 'GitHub Octocat in:readme user:defunkt'
//    var aQry          = `private:false stars:150000..300000`
//        aQry          =  aQry.replace( / /g, '%20' )
//    var aQry          = `private:false&q=stars:150000..300000`
//        aQry          =  encodeURIComponent(  aQry )
      var aQry          = `user:${ aOwner }`
      var aURL          = `https://api.github.com/search/repositories?q=${ aQry }`

//    var aURL          = `https://api.github.com/repos/${ aOwner }/${ aRepo }`
//    var aURL          = `https://api.github.com/repos/${ aOwner }`

//    var aURL          = `https://api.github.com/user/repos`

//     curl -H "Accept: application/vnd.github.v3+json" -H "Authorization: token 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" https://api.github.com/user/repos

       var rWhere  =  /\/F/
       var rWhere  =  /./


      var aAccount      = "robinmattern"
      var aToken        = "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";

      var headers       =
           { "Authorization" : "Token " + aToken
           , "Accept"        : "application/vnd.github.v3+json"
              }

      var payLoad       =
            { title     : "Hey my brand new issue!!!"
              }

      var response      =  await fetch( aURL,
             { method   : "GET"
             , headers  :  headers
//           , body     :  JSON.stringify( payLoad )
               } )

      var mRepos        =  [];
      var pJSON         =  await response.json()
      if (pJSON.total_count) {
      var mRepos        =  pJSON.items
          }

      if (mRepos.length) {
//                         mRepos.map( pRepo => { console.log( pRepo.url + " " + pRepo.updated_at ) } )
      var mRepos        =  mRepos.filter( selRepo ).map( fmtRepo2 )

          console.log( mRepos.join( "\n" ) )
      } else {
          console.log( "pJSON:", pJSON )
          console.log( "  url:", aURL  )
          }
// --------------------------------------------------------------------------------------------------------

function fmtRepo2( pRepo, i ) {

    var aNo        = ( i < 9 ? '&nbsp;&nbsp;' : '' ) + ( i+1 )
    var aNo        = `${ i+1 }`.padStart( 3 )

    var aURL       =  pRepo.url.replace( /.+github.com\//, "" )
        aURL       =       aURL.replace( /repos\//,        "" )

//  var aUpdatedAt =  pRepo.updatedAt
    var aUpdatedAt =  pRepo.updated_at
                   ?  pRepo.updated_at.replace( /T/, ' ' ).substr( 0, 16 )
                   :  ""
//  var aForked    =  pRepo.isFork ? "Y" : "N"
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
