app.blueprints = (router) => (a, x) => [
  app.close(router),
  router.nest({
    routes: {
      "/?": app.blueprints.index,
      "/~new": app.blueprints.new,
      "/:blueprint_id*": app.blueprints.blueprint,
    }
  }),
];
