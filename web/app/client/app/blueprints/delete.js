app.blueprints.delete = (router) => (a, x) => [
  a.h2(`Delete`),
  app.form({
    url: `/api/blueprints/${router.params.blueprint_id}`,
    method: "DELETE",
    form: (f) => [f.buttons(router)],
    success: (identifier) => router.open(`../..`),
  }),
];
