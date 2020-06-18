app.blueprints.starter.edit = (router, blueprint, stageIndex) => app.blueprints.inplaceform({
  keys: ['stages', stageIndex, 'starter'],
  router: router,
  object: blueprint.stages[stageIndex],
  form: f => [
    `${stageIndex}. Starter`,
    f.field({
      key: 'starter',
      as: 'one',
      vertical: true,
      label: false,
      form: (ff) => [
        ff.field({
          key: 'image',
        }),
        ff.field({
          key: 'tag',
        }),
      ]
    }),
  ],
  close: '../../..'
})
