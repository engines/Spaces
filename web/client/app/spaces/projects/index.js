app.spaces.projects.index = controller => (a,x) => [
  a.h1('Projects'),
  app.close( controller ),
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
