app.blueprints.show = (router) => (a, x) => [
  app.http({
    url: `/api/blueprints/${router.params.blueprint_id}`,
    placeholder: app.spinner(`Loading blueprint ${router.params.blueprint_id}`),
    success: (blueprint, el) => {
      console.log("loaded a blueprint...", blueprint)
      el.$nodes = a({
        $tag: 'app-blueprint',
        $state: blueprint,
        $nodes: (el, blueprint) => router.nest({
          routes: {
            '/?': app.blueprints.show.summary(blueprint),
            "/edit/?*": app.blueprints.edit(blueprint),
            "/delete": app.blueprints.delete,
            // "/actions*": app.blueprints.actions,
          }
        }),
      })

      // a({
      //   $tag: 'blueprint',
      //   $state: blueprint,
      //   $nodes: (el, state) => [
      //     // app.blueprints.show.title(router, state),
      //     // app.blueprints.show.description(router, state),
      //     // app.blueprints.show.licenses(router, state),
      //     // app.blueprints.show.stages(router, state),
      //     // app.blueprints.show.actions(router, state),
      //     // a.hr, blueprint,
      //   ],
      //   // $update: (el, state) => {
      //   //   setTimeout( el.$render, 200)
      //   //   return false
      //   // }
      // })
    },
  }),
];

app.blueprints.show.summary = blueprint => router => (a,x) => [
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
  })
]
