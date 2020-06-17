app.blueprints2.edit.title = (router, blueprint) => (a, x) => router.nest({
  routes: {
    '/title': router => app.blueprints2.edit.title.edit(router, blueprint),
    '*': router => app.blueprints2.edit.title.show(router, blueprint)
  }
}, {
  transition: false,
})
