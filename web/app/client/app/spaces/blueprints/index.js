app.spaces.blueprints.index = controller => (a,x) => [
  app.button( {
    label: app.icon( 'fa fa-plus', 'New' ),
    onclick: () => controller.open( '~new' ),
  } ),
  app.http( {
    url: '/api/blueprints',
    placeholder: app.spinner( 'Loading blueprints' ),
    success: ( blueprints, el ) => el.$nodes = blueprints.map(
      blueprint => a.div( app.button( {
        label: app.icon( 'fa fa-caret-right', blueprint ),
        onclick: ( e, el ) => controller.open( blueprint ),
      } ) ),
    ),
  } ),
]
