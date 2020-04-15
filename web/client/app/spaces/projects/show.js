app.spaces.projects.show = controller => (a,x) => [
  a.h1( `Project ${ controller.params.project_id }` ),
  app.close( controller ),
  app.http( {
    url: `/api/projects/${ controller.params.project_id }`,
    placeholder: app.spinner( `Loading project ${ controller.params.project_id }` ),
  } ),
]
