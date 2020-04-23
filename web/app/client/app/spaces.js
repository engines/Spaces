app.spaces = controller => (a, x) => [
  controller.routes({
    '/?': app.spaces.show,
    '/blueprints*': app.spaces.blueprints,
    '/installations*': app.spaces.installations,
  }),
]
