

   console.log( (new Date).toISOString() )

   console.log( `fr101_Repos_v${ (new Date).toISOString().replace( /-/g, '' ).substr( 3, 5) }.md` )