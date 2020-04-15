app.spaces.installations.installation = controller => (a,x) => [
  a.h2( controller.params.installation_id ),
  controller.routes( {
    '/?': app.spaces.installations.show,
    '/~delete': app.spaces.installations.delete,
  } ),
]
