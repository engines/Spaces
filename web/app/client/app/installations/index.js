app.installations.index = (router) => (a, x) => [
  a.hr,
  app.http({
    url: "/api/installations",
    placeholder: app.spinner("Loading installations"),
    success: (installations, el) =>
      (el.$nodes = installations.length
        ? installations.map((installation) =>
            a.div(
              app.button({
                label: app.icon("fa fa-caret-right", installation),
                onclick: (e, el) => router.open(installation),
              })
            )
          )
        : a.i("None")),
  }),
];
