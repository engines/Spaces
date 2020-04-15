app.spaces.projects = controller => (a,x) => [
  controller.routes( {
    '/?': app.spaces.projects.index,
    '/:project_id': app.spaces.projects.show,
  } ),
]
