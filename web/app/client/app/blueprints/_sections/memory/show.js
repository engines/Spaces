app.blueprints.memory.show = (router, blueprint) => (a,x) => app.blueprints.inplace(
  router,
  blueprint.memory ? `${blueprint.memory}MB` : a['i.error']('No memory'),
  'memory'
)
