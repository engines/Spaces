app.spaces = controller => (a,x) => [
  controller.routes( {
    '/?': app.spaces.show,
    '/projects*': app.spaces.projects,
    '/installations*': app.spaces.installations,
  }, { home: '/projects' } ),

]
