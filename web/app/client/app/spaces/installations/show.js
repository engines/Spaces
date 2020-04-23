app.spaces.installations.show = controller => (a,x) => [
  app.button( {
    label: app.icon( 'fa fa-trash', 'Delete' ),
    onclick: () => controller.open( '~delete' ),
    class: 'btn app-btn-danger'
  } ),
  a.hr,
  app.http( {
    url: `/api/installations/${ controller.params.installation_id }`,
    placeholder: app.spinner( `Loading installation ${ controller.params.installation_id }` ),
  } ),
]
