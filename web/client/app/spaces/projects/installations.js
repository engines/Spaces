app.spaces.projects.installations = controller => (a,x) => [
  controller.routes( {
    '/?': app.spaces.projects.installations.index,
    '/new': app.spaces.projects.installations.new,
  } ),
]
