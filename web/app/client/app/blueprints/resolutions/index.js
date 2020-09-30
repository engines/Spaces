app.blueprints.resolutions.index = (router) => (a, x) => [
  a.h2("Resolving"),
  app.button({
    label: app.icon("fa fa-plus", "New"),
    onclick: () => router.open("~new"),
  }),
  a.hr,
  app.http({
    url: `/api/blueprinting/${router.params.blueprint_id}/resolving`,
    placeholder: app.spinner("Loading resolutions"),
    success: (resolutions, el) =>
      (el.$nodes = resolutions.length
        ? resolutions.map((resolution) =>
            a.div(
              app.button({
                label: app.icon("fa fa-caret-right", resolution),
                onclick: (e, el) =>
                  router.open(`/resolving/${resolution}`),
              })
            )
          )
        : app.placeholder("None")),
  }),
];
