app.blueprints.title.show = (router, blueprint) => (a,x) => app.blueprints.inplace(
  router,
  blueprint.title ? a.h1(blueprint.title) : app.placeholder('No title'),
  'title'
)
