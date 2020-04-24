app.spaces.blueprints.installations.index = controller => (a,x) => [
  a.h2( 'Installations' ),
  app.button( {
    label: app.icon( 'fa fa-plus', 'New' ),
    onclick: () => controller.open( '~new' ),
  } ),
  a.hr,
  app.http( {
    url: `/api/blueprints/${ controller.params.blueprint_id }/installations`,
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
