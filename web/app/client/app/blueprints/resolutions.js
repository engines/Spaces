app.blueprints.resolutions = (router) => (a, x) => [
  a.h5('Resolution'),
  app.http({
    url: `/api/blueprints/${router.params.blueprint_id}/resolution`,
    success: (resolution, el) => el.$nodes = [x.out(resolution)],
  }),
];
