app.spaces.projects = controller => (a,x) => [
  app.close( controller ),
  a.h1('Projects'),
  controller.routes( {
    '/?': app.spaces.projects.index,
    '/~new': app.spaces.projects.new,
    '/:project_id*': app.spaces.projects.project,
  } ),
]
