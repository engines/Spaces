app.spaces.blueprints.installations = controller => (a,x) => [
  controller.routes( {
    '/?': app.spaces.blueprints.installations.index,
    '/~new': app.spaces.blueprints.installations.new,
  } ),
]
