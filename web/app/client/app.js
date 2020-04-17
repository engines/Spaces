let app = (a,x) => a['app']( [
    app.modal(),
    a['div.container-fluid'](
      x.router( {
        routes: controller => [
          app.nav( controller ),
          app.spaces.eventsource,
          controller.routes( {
            '/login': app.login,
            '/logout': app.logout,
            '/timeout': app.timeout,
            '/disconnected': app.disconnected,
            '/reconnect': app.reconnect,
            '/restarting': app.restarting,
            '/updating/os': app.updating_os,
            '/updating': app.updating,
            '/settings': app.settings,
            '/?*': app.spaces,
          } ),
        ],
        transition: 'crossfade',
        lazy: true,
        default: controller => a['p.error']( [
          a.pre( `Not found in client routes: ${ controller.path } in ${ controller.scope || 'root' }` ),
          controller,
        ] ),
      } ),
    ),
  ], {
  $on: {
    'appkit.router.load': (e,el) => {
      nav.$update()
    },
    'app.authenticated': (e,el) => {
      el.$('^app app-nav').$setUser( true )
      nav.$reopen()
    },
    'app.unauthenticated': (e,el) => {
      el.$('^app app-nav').$setUser( false )
      el.$('app-spaces-eventsource').$close()
      nav.$load( '/login' )
    },
    'app.timeout': (e,el) => {
      el.$('^app app-nav').$setUser( false )
      el.$('app-spaces-eventsource').$close()
      nav.$load( '/timeout' )
    },
    'app.restarting': (e,el) => {
      el.$('^app app-nav').$setUser( false )
      el.$('app-spaces-eventsource').$close()
      nav.$open( '/restarting' )
    },
    'app.os.updating': (e,el) => {
      el.$('^app app-nav').$setUser( false )
      el.$('app-spaces-eventsource').$close()
      nav.$open( '/updating/os' )
    },
    'app.updating': (e,el) => {
      el.$('^app app-nav').$setUser( false )
      el.$('app-spaces-eventsource').$close()
      nav.$open( '/updating' )
    },
    'app.disconnected': (e,el) => {
      el.$('^app app-nav').$setUser( false )
      el.$('app-spaces-eventsource').$close()
      nav.$load( '/disconnected' )
    },
    'app.reconnected': (e,el) => {
      location.assign( '/' )
    },
    'app.connected': (e,el) => {
      el.$('app-spaces-eventsource').$run()
    },
    'app.spaces.status.update': (e,el) => {
      let update = e.detail
      el.$$( 'app-spaces-state' ).forEach( el => {
        el.$state = { ...el.$state, ...update.status }
      } )
    },
    'app.container.status.update': (e,el) => {
      let update = e.detail
      let selector = `app-container-state[name='${ update.name }']`
      el.$$( selector ).forEach( el => {
        el.$state = { ...el.$state, status: update.status }
      } )
    },

  }
} )
