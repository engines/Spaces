app.blueprints2.show = (router) => (a, x) => [
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
            '/?': app.blueprints2.show.summary(blueprint),
            "/edit/?*": app.blueprints2.edit(blueprint),
            "/delete": app.blueprints2.delete,
            // "/actions*": app.blueprints2.actions,
          }
        }),
      })

      // a({
      //   $tag: 'blueprint',
      //   $state: blueprint,
      //   $nodes: (el, state) => [
      //     // app.blueprints2.show.title(router, state),
      //     // app.blueprints2.show.description(router, state),
      //     // app.blueprints2.show.licenses(router, state),
      //     // app.blueprints2.show.stages(router, state),
      //     // app.blueprints2.show.actions(router, state),
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
