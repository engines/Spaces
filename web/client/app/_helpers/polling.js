app.polling = ( route, success, options={} ) => (a,x) => a['app-polling']( null, {
  $init: function() { this.$check() },
  $wait: function() { this.$nodes = [ app.polling.wait() ] },
  $check: function() { this.$nodes = [ app.polling.check( route, success, options ) ] }
} )
