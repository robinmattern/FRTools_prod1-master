
  const btnRepos         = document.getElementById("btnRepos")
  const btnIssues        = document.getElementById("btnIssues")
  const btnIssuesPrivate = document.getElementById("btnIssuesPrivate")
  const btnCreateIssue   = document.getElementById("btnCreateIssue")
  const btnCommits       = document.getElementById("btnCommits")
  const divResult        = document.getElementById("divResult")

        btnRepos.addEventListener(          "click", getRepos)
        btnIssues.addEventListener(         "click", getIssues)
        btnCommits.addEventListener(        "click", e => getCommits( ) )
        btnIssuesPrivate.addEventListener(  "click", e => getIssuesPrivate( ) )
        btnCreateIssue.addEventListener(    "click", e => createIssues( ) )

// -------------------------------------------------------------------------------

     async  function getRepos() {
            clear();
      const url       = "https://api.github.com/search/repositories?q=stars:150000..300000"
      const response  =  await fetch(url)
      const result    =  await response.json()

            result.items.forEach( i => {

      const anchor              =  document.createElement( "a" )
            anchor.href         =  i.html_url;
            anchor.textContent  =  i.full_name;
            divResult.appendChild( anchor )
            divResult.appendChild( document.createElement( "br" ) )
            } )
        }
// -------------------------------------------------------------------------------

     async  function createIssues() {
            clear();
      const url         = "https://api.github.com/repos/husseintest/sandboxpublic/issues"
      const token       = "YOUR_TOKEN_HERE";
      const headers = {
           "Authorization" : `Token ${token}`
            }

      const payLoad = {
            title: "Hey my brand new issue!!!"
            }
      const response = await fetch(url, {
            method: "POST",
            headers: headers,
            body: JSON.stringify(payLoad)
            })
      const result = await response.json()

      const i = result;

      const anchor              =  document.createElement( "a" )
            anchor.href         =  i.html_url;
            anchor.textContent  =  i.title;

            divResult.appendChild( anchor)
            divResult.appendChild( document.createElement( "br" ) )
        }
// -------------------------------------------------------------------------------

     async  function getIssues() {
            clear();
      const url       = "https://api.github.com/search/issues?q=author:raisedadead repo:freecodecamp/freecodecamp type:issue"
      const response  =  await fetch(url)
      const result    =  await response.json()

            result.items.forEach( i => {

      const anchor              =  document.createElement( "a" )
            anchor.href         =  i.html_url;
            anchor.textContent  =  i.title;

            divResult.appendChild( anchor)
            divResult.appendChild( document.createElement( "br" ))
            })
        }
// -------------------------------------------------------------------------------

     async  function getIssuesPrivate( ) {
            clear();
      const username = "YOUR_USER_NAME"
      const password = "YOUR_PASSWORD"

      const headers = {
           "Authorization" : `Basic ${btoa(`${username}:${password}`)}`
            }

      const url      = "https://api.github.com/search/issues?q=repo:husseintest/sandboxprivate type:issue"
      const response =  await fetch(url, {
           "method"  : "GET",
           "headers" :  headers
            })
      const result   =  await response.json()

            result.items.forEach(i=>{

      const anchor              =  document.createElement( "a" )
            anchor.href         =  i.html_url;
            anchor.textContent  =  i.title;

            divResult.appendChild( anchor)
            divResult.appendChild( document.createElement("br") )
            } )
        }
// -------------------------------------------------------------------------------

     async  function getCommits( url="https://api.github.com/search/commits?q=repo:freecodecamp/freecodecamp author-date:2019-03-01..2019-03-31" ) {
            clear();

      const headers = {
           "Accept" : "application/vnd.github.cloak-preview"
            }
      const response =  await fetch( url, {
           "method"  : "GET",
           "headers" :  headers
            })

        //"<https://api.github.com/search/commits?q=repo%3Afreecodecamp%2Ffreecodecamp+author-date%3A2019-03-01..2019-03-31&page=2>; rel="next", <https://api.github.com/search/commits?q=repo%3Afreecodecamp%2Ffreecodecamp+author-date%3A2019-03-01..2019-03-31&page=27>; rel="last""

      const link    =  response.headers.get("link")
      const links   =  link.split(",")

      const urls    =  links.map( a => {
           return   {  url   :  a.split(";")[0].replace(">","").replace("<",""),
                       title :  a.split(";")[1]
                       }
            } )
      const result  =  await response.json()

            result.items.forEach(i=>{
      const img                 =  document.createElement("img")
            img.src             =  i.author.avatar_url;
            img.style.width     = "32px"
            img.style.height    = "32px"
      const anchor = document.createElement("a")
            anchor.href         =  i.html_url;
            anchor.textContent  =  i.commit.message.substr(0,120) + "...";

            divResult.appendChild( img )
            divResult.appendChild( anchor )
            divResult.appendChild( document.createElement( "br" ))
            })
            urls.forEach(u => {
      const btn = document.createElement("button")
            btn.textContent = u.title;
            btn.addEventListener("click", e=> getCommits(u.url))
            divResult.appendChild(btn);
            })
        }
// -------------------------------------------------------------------------------

    function clear(){
        while( divResult.firstChild ) {
               divResult.removeChild(divResult.firstChild)
    }   }
// -------------------------------------------------------------------------------

