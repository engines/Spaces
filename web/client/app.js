let app = (a,x) => [
  app.nav,
  a['div.container'](
    x.http( {
      url: '/api/projects',
      placeholder: app.spinner( 'Loading projects' ),
    } )
  ),

]
