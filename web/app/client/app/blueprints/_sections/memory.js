app.blueprints.memory = (router, blueprint) => (a, x) => router.nest({
  routes: {
    '/memory': router => app.blueprints.memory.edit(router, blueprint),
    '*': router => app.blueprints.memory.show(router, blueprint)
  }
})
