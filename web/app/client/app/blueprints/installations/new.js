app.blueprints.installations.new = (router) => (a, x) => [
  a.h2("New installation"),
  app.form({
    url: `/api/blueprints/${router.params.blueprint_id}/installations`,
    object: { identifier: router.params.blueprint_id },
    scope: "installation",
    form: (f) => [
      f.field({
        key: "identifier",
      }),
      f.buttons(router),
    ],
    success: (identifier) => router.open(`/installations/${identifier}`),
  }),
];
