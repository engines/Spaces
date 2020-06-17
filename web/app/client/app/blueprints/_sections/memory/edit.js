app.blueprints.memory.edit = (router, blueprint) => app.blueprints.inplaceform({
  keys: ['memory'],
  router: router,
  object: blueprint,
  form: f => [
    f.field({
      key: 'memory',
      label: 'Memory MB',
      type: 'number'
    }),
  ],
})
