app.blueprints.show = (router) => (a, x) => [
  app.http({
    url: `/api/blueprints/${router.params.blueprint_id}`,
    placeholder: app.spinner('Loading blueprint'),
    success: (blueprint, el) => {
      console.log("loaded a blueprint...", blueprint)
      el.$nodes = a({
        $tag: 'app-blueprint',
        $state: blueprint,
        $nodes: (el, blueprint) => [
          app.float({
            left: app.button({
              label: app.icon("fa fa-caret-right", "Resolutions"),
              onclick: () => router.open("resolutions"),
            }),
          }),

          a.hr,
          app.blueprints.title(router, blueprint),
          app.blueprints.description(router, blueprint),
          app.blueprints.memory(router, blueprint),
          app.blueprints.schemes(router, blueprint),
          app.blueprints.licenses(router, blueprint),
          app.blueprints.stages(router, blueprint),

          a.hr,
          app.float({
            right: [
              app.button({
                label: app.icon("fa fa-trash", "Delete"),
                onclick: () => router.open("delete"),
                class: "btn btn-outline-danger",
              }),
            ]
          }),


        ],
      })
    },
  }),
];
