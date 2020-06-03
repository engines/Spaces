app.blueprints.new = (router) => (a, x) => [
  a.h2("New"),
  app.form({
    url: "/api/blueprints",
    scope: "blueprint",
    form: (f) => [
      f.field({
        key: "identifier",
      }),
      f.buttons(router),
    ],
    success: (identifier) => router.open(`/blueprints/${identifier}`),
  }),
];
