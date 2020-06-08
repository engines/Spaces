app.resolutions.delete = (router) => (a, x) => [
  a.h2(`Delete`),
  app.form({
    url: `/api/resolutions/${router.params.resolution_id}`,
    method: "DELETE",
    form: (f) => [f.buttons(router)],
    success: (identifier) => router.open(`../..`),
  }),
];
