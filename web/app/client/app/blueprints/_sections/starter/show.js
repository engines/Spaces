app.blueprints.starter.show = (router, blueprint, stageIndex) => (a,x) => app.blueprints.inplace(
  router,
  [
    `${stageIndex}. Starter`,
    x.out(blueprint.stages[stageIndex].starter),
  ],
  `stages/${stageIndex}/starter`
)
