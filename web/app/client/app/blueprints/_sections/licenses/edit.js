app.blueprints.licenses.edit = (router, blueprint) => app.blueprints.inplaceform({
  keys: ['licenses'],
  router: router,
  object: blueprint,
  form: f => [
    f.field({
      key: 'licenses',
      as: 'many',
      addable: true,
      draggable: true,
      deletable: true,      
      form: (f) => [
        f.field({
          key: 'label',
          required: true,
        }),
        f.field({
          key: 'url',
          required: true,
          as: 'input/url',
        }),
      ]
    }),
  ],
})
