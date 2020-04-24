app.spaces.blueprints.new = controller => (a,x) => [
  a.h2( 'New' ),
  app.form( {
    url: '/api/blueprints',
    scope: 'blueprint',
    form: f => [
      f.field( {
        key: 'identifier',
      } ),
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `/blueprints/${ identifier }` ),
  } ),
]
