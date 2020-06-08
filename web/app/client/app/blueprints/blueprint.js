app.blueprints.blueprint = (router) => (a, x) => [
  a.h1(router.params.blueprint_id),
  router.nest({
    routes: {
      "/resolutions*": app.blueprints.resolutions,
      "*": app.blueprints.show,
    }
  }),
];
