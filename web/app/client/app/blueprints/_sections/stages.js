app.blueprints.stages = (router, blueprint) => (a,x) => [
  a.h5('Stages'),
  (blueprint.stages || []).length ? blueprint.stages.map(
    (stage, i) => app.blueprints.stages.stage(router, blueprint, i)
  ) : app.placeholder('No stages'),
]
