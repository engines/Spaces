app.blueprints2.show.summary = blueprint => router => (a,x) => [
  app.float({
    left: app.button({
      label: app.icon("fa fa-caret-right", "Resolutions"),
      onclick: () => router.open("resolutions"),
    }),
    right: [
      app.button({
        label: app.icon("fa fa-edit", "Edit"),
        onclick: () => router.open("edit"),
        class: "btn btn-outline-primary",
      }), '',
      app.button({
        label: app.icon("fa fa-trash", "Delete"),
        onclick: () => router.open("delete"),
        class: "btn btn-outline-danger",
      }),
    ]
  }),
  a.br,
  a['.well']( [
    a.h1(blueprint.title),
    a.p(app.md(blueprint.description)),
  ], {
    $on: {
      'click: edit blueprint': () => router.open('edit')
    }
  }),
  app.button({
    label: app.icon("fa fa-edit", "Edit"),
    onclick: () => router.open("edit"),
    class: "btn btn-outline-primary",
  }), ''
];
