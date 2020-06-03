app.blueprints.installations = (router) => (a, x) => [
  router.routes({
    "/?": app.blueprints.installations.index,
    "/~new": app.blueprints.installations.new,
  }),
];
