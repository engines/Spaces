app.spaces.blueprints.installations.new = controller => (a,x) => [
  a.h2( 'New installation' ),
  app.form( {
    url: `/api/blueprints/${ controller.params.blueprint_id }/installations`,
    object: { identifier: controller.params.blueprint_id },
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
