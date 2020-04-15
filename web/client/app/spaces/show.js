app.spaces.show = controller => (a,x) => [
  a.h1('Spaces'),
  a.div( app.button( {
    label: app.icon( 'fa fa-caret-right', 'Projects' ),
    onclick: ( e, el ) => controller.open( 'projects' ),
  } ) ),
]
