app.engines = (router) => (a, x) => [
  app.close(router),
  router.nest({
    routes: {
      "/?": app.engines.index,
      "/~new": app.engines.new,
      "/:engine_id*": app.engines.engine,
    }
  }),
];
