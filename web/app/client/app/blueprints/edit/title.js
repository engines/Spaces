app.blueprints.edit.title = (router, blueprint) => (a, x) => router.routes({
  '/title': router => app.blueprints.edit.title.edit(router, blueprint),
  '*': router => app.blueprints.edit.title.show(router, blueprint)
}, {
  transition: false,
})
