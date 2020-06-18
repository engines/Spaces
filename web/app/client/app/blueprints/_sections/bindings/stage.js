app.blueprints.bindings.binding = (router, blueprint, bindingIndex) => [
  'Stage', bindingIndex,
  app.blueprints.starter(router, blueprint, bindingIndex),
  app.blueprints.sudos(router, blueprint, bindingIndex),
  blueprint.bindings[bindingIndex],
]
