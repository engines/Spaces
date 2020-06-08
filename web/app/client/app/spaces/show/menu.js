app.spaces.show.menu = (router,spaces) => (a, x) => [
  ["blueprints", "resolutions"].map((space) =>
    a.div(
      app.button({
        label: app.icon("fa fa-caret-right", app.labelize(space)),
        onclick: (e, el) => router.open(`/${space}`),
      })
    )
  ),
];
