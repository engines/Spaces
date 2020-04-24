app.spaces.blueprints.blueprint = controller => (a,x) => [
  a.h2( controller.params.blueprint_id ),
  controller.routes( {
    '/?': app.spaces.blueprints.show,
    '/~delete': app.spaces.blueprints.delete,
    '/installations*': app.spaces.blueprints.installations,
  } ),
]
