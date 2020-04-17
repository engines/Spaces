app.spaces.installations.delete = controller => (a,x) => [
  a.h2( `Delete` ),
  app.form( {
    url: `/api/installations/${ controller.params.installation_id }`,
    method: 'DELETE',
    form: f => [
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `../..` ),
  } ),
]
