app.blueprints.description.edit = (router, blueprint) => app.blueprints.inplaceform({
  keys: ['description'],
  router: router,
  object: blueprint,
  form: f => [
    f.field({
      key: 'description',
      as: "markdown",
    }),
  ],
})
