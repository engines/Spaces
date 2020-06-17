app.blueprints.description = (router, blueprint) => (a, x) => router.nest({
  routes: {
    '/description': router => app.blueprints.description.edit(router, blueprint),
    '*': router => app.blueprints.description.show(router, blueprint)
  }
})
