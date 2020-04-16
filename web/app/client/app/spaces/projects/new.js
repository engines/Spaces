app.spaces.projects.new = controller => (a,x) => [
  a.h2( 'New' ),
  app.form( {
    url: '/api/projects',
    scope: 'project',
    form: f => [
      f.field( {
        key: 'identifier',
      } ),
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `/projects/${ identifier }` ),
  } ),
]
