app.blueprints.stages.stage = (router, blueprint, stageIndex) => [
  'Stage', stageIndex,
  app.blueprints.starter(router, blueprint, stageIndex),
  app.blueprints.sudos(router, blueprint, stageIndex),
  blueprint.stages[stageIndex],
]
