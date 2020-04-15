app.spaces.installations.index = controller => (a,x) => [
  app.http( {
    url: '/api/installations',
    placeholder: app.spinner( 'Loading installations' ),
    success: ( installations, el ) => el.$nodes = installations.map(
      installation => a.div( app.button( {
        label: app.icon( 'fa fa-caret-right', installation ),
        onclick: ( e, el ) => controller.open( installation ),
      } ) ),
    ),
  } ),
]
