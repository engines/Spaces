app.spaces.installations = controller => (a,x) => [
  app.close( controller ),
  a.h1('Installations'),
  controller.routes( {
    '/?': app.spaces.installations.index,
    '/:installation_id*': app.spaces.installations.installation,
  } ),
]
