app.spaces.resolutions.resolution = controller => (a,x) => [
  a.h2( controller.params.resolution_id ),
  controller.routes( {
    '/?': app.spaces.resolutions.show,
    '/~delete': app.spaces.resolutions.delete,
  } ),
]
