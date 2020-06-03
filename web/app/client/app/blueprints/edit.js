app.blueprints.edit = blueprint => router => (a, x) => [
  a.hr,
  app.blueprints.edit.title(router, blueprint),
  // app.blueprints.edit.description(router, state),
  // app.blueprints.edit.licenses(router, state),
  // app.blueprints.edit.stages(router, state),
  // app.blueprints.edit.actions(router, state),
  // a.hr, blueprint,
];
