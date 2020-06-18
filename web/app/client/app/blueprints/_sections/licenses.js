app.blueprints.licenses = (router, blueprint) => (a, x) => router.nest({
  routes: {
    '/licenses': router => app.blueprints.licenses.edit(router, blueprint),
    '*': router => app.blueprints.licenses.show(router, blueprint)
  }
})
