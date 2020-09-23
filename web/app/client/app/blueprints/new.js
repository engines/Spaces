app.blueprints.new = (router) => (a, x) => [
  a.h2("New"),
  app.form({
    url: "/api/blueprinting",
    scope: "blueprint",
    form: (f) => [
      f.field({
        key: "identifier",
      }),
      f.buttons({router: router}),
    ],
    success: (identifier) => router.open(`../${identifier}`),
  }),
];
