app.blueprints.resolutions = (router) => (a, x) => [
  router.nest({
    routes: {
      "/?": app.blueprints.resolutions.index,
      "/~new": app.blueprints.resolutions.new,
    }
  }),
];
