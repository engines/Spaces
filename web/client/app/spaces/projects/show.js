app.spaces.projects.show = controller => (a,x) => [
  app.close( controller ),
  app.button( {
    label: app.icon( 'fa fa-caret-right', 'Installations' ),
    onclick: () => controller.open( 'installations' ),
  } ),
  app.http( {
    url: `/api/projects/${ controller.params.project_id }`,
    placeholder: app.spinner( `Loading project ${ controller.params.project_id }` ),
  } ),
]
