app.blueprints.memory.show = (router, blueprint) => (a,x) => app.blueprints.inplace(
  router,
  blueprint.memory ? `${blueprint.memory}MB` : app.placeholder('No memory'),
  'memory'
)
