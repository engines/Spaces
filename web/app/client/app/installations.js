app.installations = (router) => (a, x) => [
  app.close(router),
  a.h2("Installations"),
  router.routes({
    "/?": app.installations.index,
    "/:installation_id*": app.installations.installation,
  }),
];
