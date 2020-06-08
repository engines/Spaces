app.resolutions.index = (router) => (a, x) => [
  a.hr,
  app.http({
    url: "/api/resolutions",
    placeholder: app.spinner("Loading resolutions"),
    success: (resolutions, el) =>
      (el.$nodes = resolutions.length
        ? resolutions.map((resolution) =>
            a.div(
              app.button({
                label: app.icon("fa fa-caret-right", resolution),
                onclick: (e, el) => router.open(resolution),
              })
            )
          )
        : a.i("None")),
  }),
];
