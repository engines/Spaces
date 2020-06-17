app.blueprints2.blueprint = (router) => (a, x) => [
  a.h1(router.params.blueprint_id),
  router.nest({
    routes: {
      "/resolutions*": app.blueprints2.resolutions,
      "*": app.blueprints2.show,
    }
  }),
];
