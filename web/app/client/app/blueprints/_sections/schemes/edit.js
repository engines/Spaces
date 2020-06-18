app.blueprints.schemes.edit = (router, blueprint) => app.blueprints.inplaceform({
  keys: ['schemes'],
  router: router,
  object: blueprint,
  form: f => [
    f.field({
      key: 'schemes',
      as: 'checkboxes',
      selections: ['http', 'https', 'ftp'],
    }),
  ],
})
