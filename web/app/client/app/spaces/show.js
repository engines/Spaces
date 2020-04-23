app.spaces.show = controller => (a,x) => [
  a.h1('Spaces'),
  [
    'blueprints',
    'installations',
  ].map( space => a.div( app.button( {
    label: app.icon( 'fa fa-caret-right', app.labelize( space ) ),
    onclick: ( e, el ) => controller.open( space ),
  } ) ) ),
]
