app.blueprints.delete = (router) => (a, x) => [
  a.h3(`Delete?`),
  app.form({
    url: `/api/blueprinting/${router.params.blueprint_id}`,
    method: "DELETE",
    form: (f) => [f.buttons({router: router})],
    success: () => router.open(`../..`),
  }),
];
