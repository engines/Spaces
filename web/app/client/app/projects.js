app.blueprints = (router) => (a, x) => [
  app.close(router),
  router.routes({
    "/?": app.blueprints.index,
    "/~new": app.blueprints.new,
    "/:blueprint_id*": app.blueprints.blueprint,
  }),
];
