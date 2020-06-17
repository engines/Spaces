app.resolutions = (router) => (a, x) => [
  app.close(router),
  a.h2("Resolutions"),
  router.nest({
    routes: {
      "/?": app.resolutions.index,
      "/:resolution_id*": app.resolutions.resolution,
    }
  }),
];
