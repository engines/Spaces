app.spaces.projects.installations.index = controller => (a,x) => [
  a.h2( 'Installations' ),
  app.close( controller ),
  app.button( {
    label: app.icon( 'fa fa-plus', 'New' ),
    onclick: () => controller.open( 'new' ),
  } ),
  app.http( {
    url: `/api/projects/${ controller.params.project_id }/installations`,
    placeholder: app.spinner( 'Loading installations' ),
    success: ( installations, el ) => el.$nodes = installations.length ?
    installations.map(
      installation => a.div( app.button( {
        label: app.icon( 'fa fa-caret-right', installation ),
        onclick: ( e, el ) => controller.open( `/installations/${ installation }` ),
      } ) ),
    ) : a.i( 'None' ),
  } ),
]
