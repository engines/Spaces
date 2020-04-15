app.spaces.projects.project = controller => (a,x) => [
  a.h1( `Project ${ controller.params.project_id }` ),
  controller.routes( {
    '/?': app.spaces.projects.show,
    '/installations*': app.spaces.projects.installations,
  } ),
]
