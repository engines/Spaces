app.spaces.projects.delete = controller => (a,x) => [
  a.h2( `Delete` ),
  app.form( {
    url: `/api/projects/${ controller.params.project_id }`,
    method: 'DELETE',
    form: f => [
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `../..` ),
  } ),
]
