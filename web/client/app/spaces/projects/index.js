app.spaces.projects.index = controller => (a,x) => [
  app.button( {
    label: app.icon( 'fa fa-plus', 'New' ),
    onclick: () => controller.open( '~new' ),
  } ),
  app.http( {
    url: '/api/projects',
    placeholder: app.spinner( 'Loading projects' ),
    success: ( projects, el ) => el.$nodes = projects.map(
      project => a.div( app.button( {
        label: app.icon( 'fa fa-caret-right', project ),
        onclick: ( e, el ) => controller.open( project ),
      } ) ),
    ),
  } ),
]
