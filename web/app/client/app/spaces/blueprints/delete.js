app.spaces.blueprints.delete = controller => (a,x) => [
  a.h2( `Delete` ),
  app.form( {
    url: `/api/blueprints/${ controller.params.blueprint_id }`,
    method: 'DELETE',
    form: f => [
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `../..` ),
  } ),
]
