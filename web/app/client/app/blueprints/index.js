app.blueprints.index = (router) => (a, x) => [
  app.button({
    label: app.icon("fa fa-plus", "New"),
    onclick: () => router.open("~new"),
  }),
  a.hr,
  app.http({
    url: "/api/blueprinting",
    placeholder: app.spinner("Loading blueprints"),
    success: (blueprints, el) =>
      (el.$nodes = blueprints.length
        ? blueprints.map((blueprint) =>
            a.div(
              app.button({
                label: app.icon("fa fa-caret-right", blueprint),
                onclick: (e, el) => router.open(blueprint),
              })
            )
          )
        : app.placeholder('None')
      ),
  }),
];
