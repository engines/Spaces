app.spaces = router => (a,x) => a( {
  $init: function(el) {
    // debugger
    el.$nodes = [
      app.http( {
        url: [
          // '/api/spaces/status',
          // '/api/engine_builder/status',
          // '/api/spaces/spaces_user/settings',
          // '/api/spaces/config/hostname',
          // '/api/spaces/version/ident',
          // '/api/spaces/version/base_os',
        ],
        success: ( [
          status,
          // installer,
          // settings,
          // hostname,
          // version,
          // os
        ] ) => {

          el.$send( 'app.connected' )

          let spaces = {
            // ...status,
            // ...installer,
            // ...settings,
            // hostname: hostname,
            // version: version,
            // os: os,
          }

          if ( spaces.is_rebooting ) {
            el.$send( 'app.restarting' )
          } else if ( spaces.is_base_system_updating ) {
            el.$send( 'app.os.updating' )
          } else if ( spaces.is_updating ) {
            el.$send( 'app.updating' )
          }

          el.$nodes = [ app.spaces.show( router, spaces ) ]

        },
        placeholder: a['div.text-center.mt-4']( app.spinner( 'Loading spaces' ) )
      } )
    ]
  },
} ),
