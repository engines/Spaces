app.spaces.blueprints.resolutions = controller => (a,x) => [
  controller.routes( {
    '/?': app.spaces.blueprints.resolutions.index,
    '/~new': app.spaces.blueprints.resolutions.new,
  } ),
]
