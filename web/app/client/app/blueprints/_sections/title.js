app.blueprints.title = (router, blueprint) => (a, x) => router.nest({
  routes: {
    '/title': router => app.blueprints.title.edit(router, blueprint),
    '*': router => app.blueprints.title.show(router, blueprint)
  }
})
