app.blueprints.schemes.show = (router, blueprint) => (a,x) => app.blueprints.inplace(
  router,
  (blueprint.schemes && blueprint.schemes.length) ? blueprint.schemes : app.placeholder('No schemes'),
  'schemes'
)
