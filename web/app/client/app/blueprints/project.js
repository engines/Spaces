app.blueprints.blueprint = (router) => (a, x) => [
  a.h1(router.params.blueprint_id),
  router.routes({
    "/installations*": app.blueprints.installations,
    "*": app.blueprints.show,
  }),
];
