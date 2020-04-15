app.spaces.installations = controller => (a,x) => [
  controller.routes( {
    '/?': app.spaces.installations.index,
    '/:installation_id/?': app.spaces.installations.show,
  } ),
]
