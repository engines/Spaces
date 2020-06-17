app.blueprints.sudos.edit = (router, blueprint, stageIndex) => app.blueprints.inplaceform({
  keys: ['stages', stageIndex, 'sudos'],
  router: router,
  object: blueprint.stages[stageIndex],
  form: f => [
    `${stageIndex}. Sudos`,
    f.field({
      key: 'sudos',
      as: 'one',
      vertical: true,
      label: false,
      form: (ff) => [
        ff.field({
          key: 'runtime',
          collection: true,
        }),
        ff.field({
          key: 'install',
          collection: true,
        }),
      ]
    }),
  ],
  close: '../../..'
})
