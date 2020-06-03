app.spaces.resolutions.delete = controller => (a,x) => [
  a.h2( `Delete` ),
  app.form( {
    url: `/api/resolutions/${ controller.params.resolution_id }`,
    method: 'DELETE',
    form: f => [
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `../..` ),
  } ),
]
