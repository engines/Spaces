app.spaces.blueprints.show = controller => (a,x) => [
  app.button( {
    label: app.icon( 'fa fa-trash', 'Delete' ),
    onclick: () => controller.open( '~delete' ),
    class: 'btn app-btn-danger'
  } ),
  app.button( {
    label: app.icon( 'fa fa-caret-right', 'Installations' ),
    onclick: () => controller.open( 'installations' ),
  } ),
  app.http( {
    url: `/api/blueprints/${ controller.params.blueprint_id }`,
    placeholder: app.spinner( `Loading blueprint ${ controller.params.blueprint_id }` ),
    // success: (blueprint, el) => el.$nodes = [ app.report({
    //   object: blueprint,
    //   report: r => [
    //     r.field({ key: 'title'}),
    //     r.field({ key: 'description'}),
    //     r.field({ key: 'memory_usage'}),
    //     r.field({ key: 'protocol'}),
    //     r.field({ key: 'licenses'}),
    //     r.field({ key: 'sudos'}),
    //     r.field({ key: 'packages'}),
    //     r.field({ key: 'framework'}),
    //     r.field({ key: 'repositories'}),
    //     r.field({ key: 'os_packages'}),
    //     r.field({ key: 'modules'}),
    //     r.field({ key: 'bindings'}),
    //     r.field({ key: 'environment'}),
    //     r.field({ key: 'file_permissions'}),
    //     r.field({ key: 'replacements'}),
    //     r.field({ key: 'workers'}),
    //     r.field({ key: 'schedules'}),
    //     r.field({ key: 'actions'}),
    //     r.field({ key: 'descriptor'}),
    //     blueprint
    //   ],
    // }) ],
  } ),
]
