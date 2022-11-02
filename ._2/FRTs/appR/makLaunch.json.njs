
      try {
            mDebuggers = JSON.parse( require( 'fs' ).readFileSync( './launch_debuggers.json' ) )
        } catch(e) {
            console.log( "\n ** Invalid launch_debuggers.json file." )
            process.exit()
            }
// -------------------------------------------------------------------------------------------------------------------------

       var  aLaunch_json = makDebuggers( mDebuggers )
//          console.log(  aLaunch_json )
            savFile( './launch.json', aLaunch_json )
            console.log( `\n    Created new 'launch.json' file with ${mDebuggers.length} debug configurations.` )

// -------  ---------------------------------------------------------------

  function  makDebuggers( mDebuggers ) {
       var  aDebuggers =  mDebuggers.map( makDebugger ).join( '\n' ).replace( /,/, ' ' )
            aDebuggers =  mConfigs( 'root' ) + aDebuggers + `\n          ]  \n       }`
    return  aDebuggers
            }
// -------  ---------------------------------------------------------------

  function  makDebugger( mDebugger ) {
       var  aDebugger =  mConfigs( mDebugger[0] )
            aDebugger =  `        , { ${ aDebugger.substr(11) }             }`
            aDebugger =  aDebugger.replace( /{Name}/, mDebugger[1] )
            aDebugger =  aDebugger.replace( /{Path}/, mDebugger[2] )
    return  aDebugger
            }
// -------------------------------------------------------------------------------------------------------------------------

  function  savFile( aFile, aStr, aExt ) {
            aExt   =  aExt ? aExt : '.json'
       var  pFS    =  require( 'fs' )
       var  aTS    = (new Date).toISOString( ).replace( /[-:]/g, '' )
       var  aTM    = (new Date).toLocaleTimeString( )
       var  aHR    = (aTM.replace( /:.+/, '' ) * 1) + (aTM.match(/PM/) ? 12 : 0) + ''
            aTS = `${ aTS.substr(3,5) }-${aHR.padStart(2, '0') }${ aTS.substr(11,2) }`

       var  aFile2 =  aFile.replace( aExt, `_v${aTS}${aExt}` )
//          console.log( `  Rename file to '${aFile2}'` ); return
            pFS.renameSync( aFile, aFile2 )
            pFS.writeFileSync( aFile, aStr )
            }
// -------  ---------------------------------------------------------------

  function  mConfigs( aType ) {
       var  mConfigs =
       { root :
`    {
      // Use IntelliSense to learn about possible attributes.
      // Hover to view descriptions of existing attributes.
      // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
      "version": "0.2.0",
      "configurations": [
`
       , file :
`           "type"   : "pwa-node"
          , "request": "launch"
          , "name"   : "{Name}"
          , "program": "{Path}"
          , "skipFiles": [ "<node_internals>/**" ]
`
       , vscode :
`           "type"   : "vscode-edge-devtools.debug"
          , "request": "launch"
          , "name"   : "{Name}"
          , "url"    : "{Path}"
          , "webRoot": "\${workspaceFolder}"
`
       , chrome :
`           "type"   : "chrome"
          , "request": "launch"
          , "name"   : "{Name}"
          , "url"    : "{Path}"
          , "webRoot": "\${workspaceFolder}"
`
       , node :
`           "type"   : "node"
          , "request": "launch"
          , "name"   : "{Name}"
          , "cwd"    : "\${workspaceFolder}/{Path}"
          , "runtimeExecutable": "npm"
          , "runtimeArgs": [ "start" ]
          , "skipFiles": [ "<node_internals>/**" ]
`
          }
    return  mConfigs[ aType ]
     }
// -------  ---------------------------------------------------------------

/*





       {
          "type": "node",
          "request": "launch",
          "name": "server/3s-rauth 50253",
          "cwd": "${workspaceFolder}\\server\\3s-rauth",
          "runtimeExecutable": "npm",
          "runtimeArgs": [ "run-script", "server" ],
          "skipFiles": [ "<node_internals>/**" ],
           },

    {
       "type": "node",
       "request": "launch",
       "name": "{Name}1c-react-empty 51161",
       "cwd": "${workspaceFolder}\\client\\1c-react-empty",
       "runtimeExecutable": "npm",
       "runtimeArgs": [ "start" ],
       "skipFiles": [ "<node_internals>/**" ],
        },



    {
       "type": "node",
       "request": "launch",
       "name": "1c-react-empty 51161",
       "cwd": "${workspaceFolder}\\client\\1c-react-empty",
       "runtimeExecutable": "npm",
       "runtimeArgs": [ "start" ],
       "skipFiles": [ "<node_internals>/**" ],
        },
    {
       "type": "node",
       "request": "launch",
       "name": "2c-react-button",
       "cwd": "${workspaceFolder}\\client\\2c-react-button",
       "runtimeExecutable": "npm",
       "runtimeArgs": [ "start" ],
       "skipFiles": [ "<node_internals>/**" ],
        },
    {
       "type": "node",
       "request": "launch",
       "name": "3c-react-no-api 51163",
       "cwd": "${workspaceFolder}\\client\\3c-react-no-api",
       "runtimeExecutable": "npm",
       "runtimeArgs": [ "start" ],
       "skipFiles": [ "<node_internals>/**" ],
        },
    {
       "type": "node",
       "request": "launch",
       "name": "4c-react-wi-api 51164",
       "cwd": "${workspaceFolder}\\client\\4c-react-wi-api",
       "runtimeExecutable": "npm",
       "runtimeArgs": [ "start" ],
       "skipFiles": [ "<node_internals>/**" ],
        },
    {
       "type": "node",
       "request": "launch",
       "name": "4s-react-wi-api 51114",
       "cwd": "${workspaceFolder}\\server\\4s-react-wi-api",
       "runtimeExecutable": "npm",
       "runtimeArgs": [ "start" ],
       "skipFiles": [ "<node_internals>/**" ],
        }
    {
       "type": "node",
       "request": "launch",
       "name": "5c-my-react-app 51165",
       "cwd": "${workspaceFolder}\\client\\5c-my-react-app",
       "runtimeExecutable": "npm",
       "runtimeArgs": [ "start" ],
       "skipFiles": [ "<node_internals>/**" ],
        },





      {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [

          {
            "type": "pwa-node",
            "request": "launch",
            "name": "Debug Current JS File",
            "skipFiles": [ "<node_internals>/**" ],
            "program": "${file}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug Chrome Port 5500",
            "url": "http://localhost:5500",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug Chrome Port 3000",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "vscode-edge-devtools.debug",
            "request": "launch",
            "name": "Debug Edge Port 3000",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}"
             }





      {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [

          {
            "type": "pwa-node",
            "request": "launch",
            "name": "Launch current file",
            "skipFiles": [ "<node_internals>/**" ],
            "program": "${file}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug expanding-cards",
            "url": "http://localhost:5500/client/0c-html-widgets/expanding-cards/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug 0c-m03_css-nav-toolbar",
            "url": "http://localhost:5500/client/0c-css-samples/m03-Diving-Deeper-into-CSS/3c_toolbar-app/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug 1c-u3_html-custom-app",
            "url": "http://localhost:5500/client/1c-html-custom-app/index_u3.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
      <<<<<<< HEAD
            "name": "Debug 1c1_html-custom-app",
            "url": "http://localhost:5500/client1/01c1-html-custom-app/src/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug 03c1_js-nav-toolbar",
            "url": "http://localhost:5500/client1/03c1_js-nav-toolbar/src/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug 04c1_js-nav-sidebar",
            "url": "http://localhost:5500/client1/04c1_js-nav-sidebar/src/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug 05c1_js-responsive-menubar",
            "url": "http://localhost:5500/client1/05c1_js-responsive-menubar/src/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug Chrome Port 5500",
            "url": "http://localhost:5500",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug Chrome Port 3000",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "vscode-edge-devtools.debug",
            "request": "launch",
            "name": "Debug Edge Port 3000",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}"
             }
      =======
            "name": "Debug 1c1_u4-html-custom-app",
            "url": "http://localhost:5500/client1/01c1-html-custom-app/index_u4.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug m03-3c_toolbar-app",
            "url": "http://localhost:5500/client/0c-css-samples/m03-Diving-Deeper-into-CSS/3c_toolbar-app/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug 04c1_html-nav-toolbar",
            "url": "http://localhost:5500/client1/04c1_html-nav-toolbar/src/index.html",
            "webRoot": "${workspaceFolder}"
             },
          {
            "type": "chrome",
            "request": "launch",
            "name": "Debug 04c2_react-nav-toolbar",
            "url": "http://localhost:3000",
            "webRoot": "${workspaceFolder}"
             }
      >>>>>>> 1678179b1f28656c6c2bc932dbfb6b94c8278a86
        ]
}


*/