app.blueprints.title.edit = (router, blueprint) => app.blueprints.inplaceform({
  keys: ['title'],
  router: router,
  object: blueprint,
  form: f => [
    f.field({
      key: 'title',
    }),
  ],
})
