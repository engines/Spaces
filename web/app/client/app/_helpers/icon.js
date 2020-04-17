app.icon = function( klass, text, options={} ) {

  let a = ax.a
  let x = ax.x

  var component = [
    a.span( null, { class: klass } )
  ]

  if ( text ) {
    if ( !options.compact ) component.push( ' ' )
    component.push( text )
  }

  if ( options.reverse ) {
    component.reverse()
  }

  let iconTag = {
    style: { whiteSpace: 'nowrap' },
    ...options.iconTag
  }

  return a['app-icon']( component, iconTag )

}
