app.blueprints.description.show = (router, blueprint) => (a,x) => app.blueprints.inplace(
  router,
  blueprint.description ? app.md(blueprint.description) : app.placeholder('No description'),
  'description'
)
