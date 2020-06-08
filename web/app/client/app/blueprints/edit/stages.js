app.blueprints.edit.stages = (router, blueprint) => (a, x) => {

  let path = `/blueprints/${router.params.blueprint_id}/stages`;
  let routes = {};

  routes['/stages/?'] = (router) => app.inplaceform({
    path: path,
    method: 'POST',
    router: router,
    object: {
      stages: blueprint.stages,
    },
    success:  (blueprint,el) => {
      blueprint_el = el.$('^blueprint')
      router.open(`/blueprints/${router.params.blueprint_id}`)
      blueprint_el.$state = blueprint
    },
    form: f => [
      f.field({
        key: 'stages',
        singular: 'stage',
        as: 'many',
        addable: true,
        draggable: true,
        deletable: true,
        form: f => [
          a.h3(`Stage ${f.index + 1}`),
        ],
      }),
    ],
  });

  routes['*'] = (router) => a.div( app.report({
    object: blueprint,
    report: r => [
      // r.object,
      r.field({
        key: 'stages',
        label: "Stages",
        as: 'many',
        report: rr => [
          rr.field({
            // as: 'listgroup',
            vertical: true,
            value: Object.keys(rr.object),
          }),
          // value: (r.stages || []).map( stage => [x.out(Object.keys(stage))]),

        ],
      }),
    ],
  }), {
    style: { cursor: 'pointer' },
    $on: {
      click: () => router.open(path),
    }
  });

  return a.p(router.nest({routes: routes}));
}
