app.spaces.projects.show = controller => (a,x) => [
  a.h1( `Project ${ controller.params.project_id }` ),
  app.close( controller ),
  app.http( {
    url: `/api/projects/${ controller.params.project_id }`,
    placeholder: app.spinner( `Loading project ${ controller.params.project_id }` ),
    // success: ( projects, el ) => el.$nodes = projects.map(
    //   project => a.div( app.button( {
    //     label: app.icon( 'fa fa-caret-right', project ),
    //     onclick: ( e, el ) => controller.open( project ),
    //   } ) ),
    // ),
  } ),
]
