app.nav = controller => (a,x) => a['p#nav']( [
  app.logo( 24 ),
  'Engines',

  a['div.float-right']( [
    app.button( {
      label: app.icon( 'fa fa-cog' ),
      title: 'Settings',
      onclick: () => controller.open( '/settings' ),
      class: 'btn app-btn app-nav-btn app-nav-btn-settings',
    } ),
    app.button( {
      label: app.icon( 'fa fa-sign-out-alt' ),
      title: 'Log out',
      onclick: () => controller.load( '/logout' ),
      class: 'btn app-btn app-nav-btn',
    } ),
  ] ),

], {
  $update: function() {},
} )
