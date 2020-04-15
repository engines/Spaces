app.close = ( controller, options={} ) => (a,x) => a['div.float-right'](
  app.button( {
    label: app.icon( 'fa fa-times', 'Close' ),
    onclick: () => controller.open( options.path || '..', controller.query, controller.anchor ),
  } )
)
