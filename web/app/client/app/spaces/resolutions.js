app.spaces.resolutions = controller => (a,x) => [
  app.close( controller ),
  a.h1('Resolutions'),
  controller.routes( {
    '/?': app.spaces.resolutions.index,
    '/:resolution_id*': app.spaces.resolutions.resolution,
  } ),
]
