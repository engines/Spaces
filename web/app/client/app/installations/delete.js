app.installations.delete = (router) => (a, x) => [
  a.h2(`Delete`),
  app.form({
    url: `/api/installations/${router.params.installation_id}`,
    method: "DELETE",
    form: (f) => [f.buttons(router)],
    success: (identifier) => router.open(`../..`),
  }),
];
