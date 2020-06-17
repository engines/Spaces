app.blueprints.schemes = (router, blueprint) => (a, x) => router.nest({
  routes: {
    '/schemes': router => app.blueprints.schemes.edit(router, blueprint),
    '*': router => app.blueprints.schemes.show(router, blueprint)
  }
})
