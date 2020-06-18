app.blueprints.blueprint = (router) => (a, x) => [
  app.close(() => router.open('..')),
  a.h1(router.params.blueprint_id),
  router.nest({
    routes: {
      "/delete": app.blueprints.delete,
      "/resolution*": app.blueprints.resolutions,
      "*": app.blueprints.show,
    }
  }),
];
