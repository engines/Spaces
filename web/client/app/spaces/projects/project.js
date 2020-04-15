app.spaces.projects.project = controller => (a,x) => [
  a.h2( controller.params.project_id ),
  controller.routes( {
    '/?': app.spaces.projects.show,
    '/~delete': app.spaces.projects.delete,
    '/installations*': app.spaces.projects.installations,
  } ),
]
