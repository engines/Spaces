app.blueprints.licenses.show = (router, blueprint) => (a,x) => app.blueprints.inplace(
  router,
  (blueprint.licenses && blueprint.licenses.length) ? x.out(blueprint.licenses) : app.placeholder('No licenses'),
  'licenses'
)
