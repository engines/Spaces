app.blueprints.sudos.show = (router, blueprint, stageIndex) => (a,x) => app.blueprints.inplace(
  router,
  [
    `${stageIndex}. Sudos`,
    x.out(blueprint.stages[stageIndex].sudos),
  ],
  `stages/${stageIndex}/sudos`
)
