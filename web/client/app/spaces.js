app.spaces = controller => (a,x) => [
  controller.routes( {
    '/?': app.spaces.show,
    '/projects*': app.spaces.projects
  }, { home: '/projects' } ),

]
