app.close = ( controller, path='..' ) => (a,x) => a['div.clearfix'](
  a['div.float-right'](
    app.button( {
      label: app.icon( 'fa fa-times', 'Close' ),
      onclick: () => controller.open( path, controller.query, controller.anchor ),
    } )
  )
)
