app.blueprints.edit.actions = (router, blueprint) => (a, x) => [
  app.blueprints.edit.editable({
    router: router,
    division: 'actions',
    blueprint: blueprint,
    form: (f) => [
      f.field({
        key: 'actions',
        as: 'table',
        singular: 'action',
        collection: true,
        draggable: true,
        addable: true,
        deletable: true,
        form: ff => [
          ff.field({
            key: 'name',
            label: false,
            required: true,
            pattern: '^[a-z0-9\_\-]+$',
          }),
          // ff.field({
            //   key: 'return',
            //   as: 'select',
            //   selections: [
              //     'text',
              //     'json',
              //     'stream',
              //   ],
              // }),
        ],
      }),
    ],
    report: (r) => [
      r.field({
        label: 'Actions',
        as: 'listgroup',
        value: (r.object.actions || []).map( action => [
          a['pre.float-left.pt-1.m-0'](action.name),
          a['div.float-right'](
            r.button({
              buttonTag: {
                class: 'btn btn-sm m-n1',
              },
              label: app.icon('fa fa-arrow-right'),
              onclick: (e,el) => {
                e.stopPropagation()
                router.open(`/blueprints/${router.params.blueprint_id}/~action-edit`, {action_name: action.name})
              }
            }),
          ),
        ]),
      }),
    ],
  }),

  // app.blueprints.edit.action(router, blueprint),

  // router.routes({
  //   '/~action-edit': (router) => ,
  //   '*': null
  // }, {
  //   lazy: false,
  // }),

]

app.blueprints.edit.action = (router, blueprint) => (a, x) => {

  let path = `/blueprints/${router.params.blueprint_id}`;
  // let action = `/~${options.division}-edit`;
  let routes = {};

  routes['/~action-edit'] = (router) => app.inplaceform({
    path: path,
    method: 'POST',
    router: router,
    object: {
      blueprint: blueprint,
      division: 'actions',

    },
    success: (blueprint,el) => {
      el = el.$('^blueprint')
      el.$state = blueprint
      options.router.open(`/blueprints/${options.router.params.blueprint_id}`)
    },
    form: f => [
      f.field({
        key: 'blueprint',
        vertical: true,
        label: false,
        as: 'one',
        form: options.form,
      }),
      f.field({
        key: 'division',
        as: 'input/hidden',
      }),
    ],
  });
  routes['*'] = null;

  return a.p(options.router.nest({routes: routes}));
}
