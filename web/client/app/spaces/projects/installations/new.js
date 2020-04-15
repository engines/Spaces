app.spaces.projects.installations.new = controller => (a,x) => [
  a.h2( 'New installation' ),
  app.form( {
    object: { identifier: controller.params.project_id },
    url: `/api/projects/${ controller.params.project_id }/installations`,
    form: f => [
      f.field( {
        key: 'identifier',
      } ),
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `/installations/${ identifier }` ),
  } ),
]
