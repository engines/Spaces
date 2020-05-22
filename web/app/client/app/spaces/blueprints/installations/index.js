app.spaces.blueprints.resolutions.index = controller => (a,x) => [
  a.h2( 'Resolutions' ),
  app.button( {
    label: app.icon( 'fa fa-plus', 'New' ),
    onclick: () => controller.open( '~new' ),
  } ),
  a.hr,
  app.http( {
    url: `/api/blueprints/${ controller.params.blueprint_id }/resolutions`,
    placeholder: app.spinner( 'Loading resolutions' ),
    success: ( resolutions, el ) => el.$nodes = resolutions.length ?
    resolutions.map(
      resolution => a.div( app.button( {
        label: app.icon( 'fa fa-caret-right', resolution ),
        onclick: ( e, el ) => controller.open( `/resolutions/${ resolution }` ),
      } ) ),
    ) : a.i( 'None' ),
  } ),
]
