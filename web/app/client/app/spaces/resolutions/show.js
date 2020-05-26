app.spaces.resolutions.show = controller => (a,x) => [
  app.button( {
    label: app.icon( 'fa fa-trash', 'Delete' ),
    onclick: () => controller.open( '~delete' ),
    class: 'btn app-btn-danger'
  } ),
  a.hr,
  app.http( {
    url: `/api/resolutions/${ controller.params.resolution_id }`,
    placeholder: app.spinner( `Loading resolution ${ controller.params.resolution_id }` ),
  } ),
]
