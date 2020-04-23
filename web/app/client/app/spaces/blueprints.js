app.spaces.blueprints = controller => (a,x) => [
  app.close( controller ),
  a.h1('Blueprints'),
  controller.routes( {
    '/?': app.spaces.blueprints.index,
    '/~new': app.spaces.blueprints.new,
    '/:blueprint_id*': app.spaces.blueprints.blueprint,
  } ),
]
