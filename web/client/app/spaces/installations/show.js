app.spaces.installations.show = controller => (a,x) => [
  a.h1( `Installation ${ controller.params.installation_id }` ),
  app.close( controller ),
  app.http( {
    url: `/api/installations/${ controller.params.installation_id }`,
    placeholder: app.spinner( `Loading installation ${ controller.params.installation_id }` ),
  } ),
]
