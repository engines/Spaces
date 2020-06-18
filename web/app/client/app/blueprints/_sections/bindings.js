app.blueprints.bindings = (router, blueprint) => (a,x) => [
  a.h5('Bindings'),
  (blueprint.bindings || []).length ? blueprint.bindings.map(
    (binding, i) => app.blueprints.bindings.binding(router, blueprint, i)
  ) : app.placeholder('No bindings'),
]
