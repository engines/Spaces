app.resolutions.resolution = (router) => (a, x) => [
  a.h1(router.params.resolution_id),
  router.nest({
    routes: {
      "/?": app.resolutions.show,
      "/delete": app.resolutions.delete,
    }
  }),
];
