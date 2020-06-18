app.blueprints = (router) => (a, x) => [
  router.nest({
    routes: {
      "/?": app.blueprints.index,
      "/~new": app.blueprints.new,
      "/:blueprint_id*": app.blueprints.blueprint,
    }
  }),
];
