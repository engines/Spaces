app.installations.installation = (router) => (a, x) => [
  a.h1(router.params.installation_id),
  router.routes({
    "/?": app.installations.show,
    "/delete": app.installations.delete,
  }),
];
