app.spaces.projects.installations.new = controller => (a,x) => [
  a.h2( 'New installation' ),
  app.form( {
    url: `/api/projects/${ controller.params.project_id }/installations`,
    object: { identifier: controller.params.project_id },
    scope: 'installation',
    form: f => [
      f.field( {
        key: 'identifier',
      } ),
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `/installations/${ identifier }` ),
  } ),
]
