app.spaces.blueprints.resolutions.new = controller => (a,x) => [
  a.h2( 'New resolution' ),
  app.form( {
    url: `/api/blueprints/${ controller.params.blueprint_id }/resolutions`,
    object: { identifier: controller.params.blueprint_id },
    scope: 'resolution',
    form: f => [
      f.field( {
        key: 'identifier',
      } ),
      f.buttons( controller ),
    ],
    success: identifier => controller.open( `/resolutions/${ identifier }` ),
  } ),
]
