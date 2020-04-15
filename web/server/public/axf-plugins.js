'use strict'
ax.extension.
check = function( options ) {

  let a = ax.a
  let x = ax.x

  let inputId = x.lib.object.dig( options, [ 'inputTag', 'id'] ) ||
                x.lib.uuid.generate()

  let inputTagOptions = {
    type: options.type || 'checkbox',
    name: options.name,
    value: options.checked === '' ? '' : options.checked || 'on',
    required: options.required,
    onclick: options.readonly ? 'return false' : 'return true',
    checked: options.value ? 'checked' : undefined,
    ...options.inputTag,
    id: inputId
  }

  let labelTagOptions = {
    for: inputId,
    ...options.labelTag,
  }

  return a['|appkit-check']( [
    a.input( null, inputTagOptions ),
    a.label( options.label || '', labelTagOptions ),
  ], options.checkTag )

}

ax.extension.transition = {}

ax.extension.report = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let shims = [ this.report.shim(), ...( options.shims || [] ) ]

  let r = this.report.factory( {
    shims: shims,
    scope: options.scope,
    params: options.params,
    object: options.object,
  } )

  return r.report( {
    report: options.report,
    reportTag: options.reportTag,
  } )

}

ax.extension.appkit = {}

ax.extension.lib = {}

ax.extension.form = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let shims = [ this.form.shim(), ...( options.shims || [] ) ]

  let f = this.form.factory( {
    shims: shims,
    scope: options.scope,
    params: options.params,
    object: options.object,
  } )

  return f.form( options )

}

ax.extension.cycle = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let period = options.period || 500
  let collection = options.collection || '⣯⣟⡿⢿⣻⣽⣾⣷'

  let max = collection.length - 1

  let cycleTag = {
    $state: 0,
    $nodes: (el,i) => collection[i],
    $init: function() {
      let target = this
      let cycle = function() {
        setTimeout( function() {
          if ( target.$state === max ) {
            target.$state = 0
          } else {
            target.$state++
          }
          cycle()
        }, period )
      }
      cycle()
    },
    ...options.cycleTag
  }

  return a['|appkit-cycle']( null, cycleTag )

}

ax.extension.router = ( options={} ) => ( a,x ) => {

  let config = {
    scope: options.scope || '',
    default: options.default,
    home: options.home,
    lazy: options.lazy,
    transition: options.transition
  }

  let routes = options.routes || {}

  if ( options.home ) {
    if ( window.location.pathname.match( /^$|^\/$/ ) ) {
      window.history.replaceState( {}, 'Home', options.home )
    }
  }

  let routerTag = {

    id: options.id,

    $init: (el) => {

      const pop = () => el.$go()
      window.addEventListener( 'popstate', pop )
      el.$send( 'appkit.router.load', { detail: el.$location() } )

    },

    $nodes: function() {

      let controller = x.router.controller ( {
        router: [ this ],
        ...config,
      } )( this.$location() )

      if ( ax.is.function( routes ) ) {
        return routes( controller )
      } else {
        return controller.routes( routes )
      }

    },

    $go: function() {

      let location = this.$location()
      this.$load(
        location.path, location.query, location.anchor
      )

    },

    $open: function( path, query, anchor ) {

      if ( path[0] != '/' ) {
        path = config.scope + ( path ? `/${ path }` : '' )
      }

      this.$locate( path, query, anchor )

      this.$send( 'appkit.router.open', { detail: {
        path: path,
        query: query,
        anchor: anchor
      } } )

    },

    $locate: function( path, query, anchor ) {

      path = path || '/'
// debugger
//       // compact double dots /../ in path
//       let match = path.match( /(^\/$|(\/\b\w+\b)(?!\/\.\.)|\/$)/g ) || []
//       path = match.join('')
// debugger
      query = x.lib.query.from.object( query )
      path = ( path || '/' ) + ( query ? '?' + query : '' ) + ( anchor ? '#' + anchor : '' )

      history.pushState( { urlPath: path },'', path )
      let event = new PopStateEvent( 'popstate', { urlPath: path } )
      dispatchEvent( event )

    },

    $location: function() {
      let location = window.location

      return {
        path: location.pathname,
        query: x.lib.query.to.object(
          location.search.slice(1)
        ),
        anchor: location.hash.slice(1)
      }

    },

    $load: function( path, query, anchor ) {

      let routes = x.lib.unnested( this, '|appkit-router-routes' )

      routes.forEach( (r) => {
        r.$load( path, query, anchor )
      } )

      this.$send( 'appkit.router.load', { detail: {
        path: path,
        query: query,
        anchor: anchor,
      } } )

    },

    ...options.routerTag

  }

  return a['|appkit-router']( null, routerTag )

}

// ax.extension.router =
// ( routes, options={} ) =>
// ( a,x ) => {
//
//   let config = {
//     scope: options.scope || '',
//     default: options.default,
//     home: options.home,
//   }
//
//   if ( options.home ) {
//     if ( window.location.pathname.match( /^$|^\/$/ ) ) {
//       window.history.replaceState( {}, 'Home', options.home )
//     }
//   }
//
//   let routerTag = {
//
//     id: options.id,
//
//     $init: (el) => {
//
//       const pop = () => el.$go()
//       window.addEventListener( 'popstate', pop )
//       el.$send( 'appkit.router.load', { detail: el.$location() } )
//
//     },
//
//     $nodes: function() {
//
//       if ( ax.is.function( routes ) ) {
//
//         let controller = x.router.controller ( {
//           router: [ this ],
//           ...config,
//         } )( this.$location() )
//
//         return routes( controller )
//
//       } else {
//
//         return routes
//
//       }
//
//     },
//
//     $config: config,
//
//     $go: function() {
//
//       let location = this.$location()
//       this.$load(
//         location.path, location.query, location.anchor
//       )
//
//     },
//
//     $open: function( path, query, anchor ) {
//
//       if ( path[0] != '/' ) {
//         path = config.scope + ( path ? `/${ path }` : '' )
//       }
//
//       this.$locate( path, query, anchor )
//
//       this.$send( 'appkit.router.open', { detail: {
//         path: path,
//         query: query,
//         anchor: anchor
//       } } )
//
//     },
//
//     $locate: function( path, query, anchor ) {
//
//       path = path || '/'
//
//       // compact double dots /../ in path
//       let match = path.match( /(^\/$|(\/\b\w+\b)(?!\/\.\.)|\/$)/g ) || []
//       path = match.join('')
//
//       query = x.lib.query.from.object( query )
//       path = ( path || '/' ) + ( query ? '?' + query : '' ) + ( anchor ? '#' + anchor : '' )
//
//       history.pushState( { urlPath: path },'', path )
//       let event = new PopStateEvent( 'popstate', { urlPath: path } )
//       dispatchEvent( event )
//
//     },
//
//     $location: function() {
//       let location = window.location
//
//       return {
//         // href: `${ location.pathname }${ location.search }${ location.hash }`,
//         path: location.pathname,
//         query: x.lib.query.to.object(
//           location.search.slice(1)
//         ),
//         anchor: location.hash.slice(1)
//       }
//
//     },
//
//     $load: function( path, query, anchor ) {
//
//       let routes = x.lib.unnested( this, '|appkit-router-routes' )
//
//       routes.forEach( (r) => {
//         r.$load( path, query, anchor )
//       } )
//
//       this.$send( 'appkit.router.load', { detail: {
//         path: path,
//         query: query,
//         anchor: anchor,
//       } } )
//
//     },
//
//     ...options.routerTag
//
//   }
//
//   return a['|appkit-router']( null, routerTag )
//
// }

// ax.extension.httpOld = function( options={} ) {
//
//   let a = ax.a
//   let x = ax.x
//
//   let url = options.url
//   let success = options.success
//   let error = options.error
//
//   // ax.is.not.array( url )
//
//
//   let customCallbacks = options.when || {}
//
//   let responseCallback = function( response, el ) {
//
//     let callback
//     let status = response.status
//
//     if ( status >= 200 && status < 300 ) {
//       callback = success || defaultCallback( 'success' )
//     } else {
//       callback = error || defaultCallback( 'error' )
//     }
//
//     callback.bind(el)( response, el )
//
//   }
//
//   let defaultCallback = ( type ) => ( response, el ) => {
//
//     let contentType = response.headers.get('content-type')
//
//     if ( contentType ) {
//
//       contentType = contentType.split(';')[0]
//
//       let contentHandler = customCallbacks[ contentType ]
//
//       if ( contentHandler ) {
//         contentHandler.bind(el)( response, el )
//       } else {
//         let target = options.target || el
//         target.$nodes = a[`|appkit-http-response.${ type }`]( null, componentFor( contentType, response ) )
//       }
//
//     }
//
//   }
//
//   let componentFor = function( contentType, response ) {
//
//     if ( contentType == 'application/json' ) {
//       return { $init: (el) => response.json().then( result => el.$nodes = ax.factory.object( result ) ) }
//     } else if ( contentType == 'text/html' ) {
//       return { $init: (el) => response.text().then( result => el.$html = result ) }
//     } else if ( contentType == 'text/plain' ) {
//       return { $init: (el) => response.text().then( result => el.$nodes = a.pre( result ) ) }
//     } else {
//       return { $init: (el) => response.text().then( result => el.$text = result ) }
//     }
//
//   }
//
//   return a['|appkit-http']( options.placeholder || null, {
//     $init: (el) => {
//
//       if ( options.query ) {
//         let query = x.lib.query.from.object( options.query )
//         url = `${ url }?${ query }`
//       }
//
//       el.$send( 'axf.appkit.http.start' )
//       fetch( url, {
//         method: options.method,
//         headers: options.headers,
//         body: options.body,
//         ...options.fetch,
//       } )
//       .then( response => {
//
//         if ( response.status >= 200 && response.status < 300 ) {
//           el.$send( 'axf.appkit.http.success' )
//         } else {
//           el.$send( 'axf.appkit.http.error' )
//         }
//
//         let statusCallback = customCallbacks[ response.status ]
//
//         if ( statusCallback ) {
//           statusCallback.bind(el)( response, el )
//         } else {
//           responseCallback( response, el )
//         }
//
//       } ).catch( error => {
//
//         console.error( 'Ax appkit http error.', error.message )
//         if ( options.catch ) options.catch( error, el )
//
//       } ).finally( () => {
//
//         // el is ususally removed from DOM by callback,
//         // so get parent for sending complete event
//         let parent = el.$('^')
//         if( options.complete ) {
//           options.complete.bind(parent)(parent)
//         }
//         // Parent sometimes removed too, such as when user navigates away before complate.
//         if ( parent ) parent.$send( 'axf.appkit.http.complete' )
//
//       } )
//
//     }
//   }, options.httpTag )
//
// }

ax.extension.time = function( options={} ) {

  const a = ax.a

  let timeTag = Object.assign(
    {
      $init: function() {
        this.$tock()
        setInterval( this.$tock, 1000)
      },
      $tock: function() {
        this.$text = ( new Date ).toLocaleTimeString()
      }
    },
    options.timeTag
  )

  return a.time( null, timeTag )

}

ax.extension.table = function ( contents, options={} ) {

  let a = ax.a
  // let x. = ax.x

  // let table = this

  let component = []

  let trTag = function( i, row ) {
    if ( ax.is.function( options.trTag ) ) {
      return options.trTag( i, row )
    } else {
      return options.trTag
    }
  }

  let thTag = function( i, j, content ) {
    if ( ax.is.function( options.thTag ) ) {
      return options.thTag( i, j, content )
    } else {
      return options.thTag
    }
  }

  let tdTag = function( i, j, content ) {
    if ( ax.is.function( options.tdTag ) ) {
      return options.tdTag( i, j, content )
    } else {
      return options.tdTag
    }
  }

  let headers
  if ( options.headers == false ) {
    headers = { rows: [], cols: [] }
  } else if ( options.headers == true || !options.headers ) {
    headers = { rows: [ 0 ], cols: [] }
  } else {
    headers = {
      rows: options.headers.rows || [],
      cols: options.headers.cols || []
    }
  }

  let tableCellFor = function( i, j, content ) {
    if ( headers.rows.includes( i ) ) {
      let attributes = {
        scope: col,
        ...thTag( i, j, content )
      }
      return ax.a.th( content, attributes )
    } else if ( headers.cols.includes( j ) ) {
      let attributes = {
        scope: row,
        ...thTag( i, j, content )
      }
      return ax.a.th( content, attributes )
    } else {
      return ax.a.td( content, tdTag( i, j, content ) )
    }
  }

  contents.map( function( row, i ) {
    component.push(
      ax.a.tr(
        row.map( function( content, j) {
          return tableCellFor( i, j, content )
        } ),
        trTag( i, row ) )
    )
  } )

  // let tableTag = options.tableTag

  return a.table( component, options.tableTag )

}

ax.extension.http = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let singleRequest
  let urls = options.url
  // let success = options.success
  // let error = options.error

  if ( ax.is.not.array( urls ) ) {
    singleRequest = true
    urls = [ urls ]
  }
// if ( options.target ) debugger
  let customCallbacks = options.when || {}

  let responsesSuccess = function( responses, el ) {

    el.$send( 'axf.appkit.http.success' )

    if ( options.success ) {
      Promise.all(
        responses.map( response => contentPromiseFor( response ) )
      ).then( responses => {

        if ( singleRequest ) {
          options.success.bind(el)( responses[0], el )
        } else {
          options.success.bind(el)( responses, el )
        }

      } )

    } else {

      el.$nodes = responses.map(
        response => a[`|appkit-http-response.success`]( null, {
          $init: el => defaultContent( response, el )
        } )
      )

    }

  }

  let responseError = ( response, el ) => {

    el.$send( 'axf.appkit.http.error' )

    if ( options.error ) {
      options.error.bind(el)( response, el )
    } else {
      el.$nodes = a[`|appkit-http-response.error`]( null, {
        $init: el => defaultContent( response, el )
      } )
    }

  }

  let defaultContent = ( response, el ) => {

    let contentType = response.headers.get('content-type')

    if ( contentType ) {

      contentType = contentType.split(';')[0]

      let contentHandler = customCallbacks[ contentType ]

      if ( contentHandler ) {
        contentHandler.bind(el)( response, el )
      } else {
        el.$nodes = a( { $init: componentFor( contentType, response ) } )
      }

    }

  }

  let contentPromiseFor = response => {

    let contentType = response.headers.get('content-type')

    if ( contentType ) {
      contentType = contentType.split(';')[0]
      if ( contentType == 'application/json' ) {
        return response.json()
      } else {
        return response.text()
      }
    } else {
      return null
    }
  }

  let componentFor = ( contentType, response ) => {

    if ( contentType == 'application/json' ) {
      return (el) => contentPromiseFor( response ).
        then( content => el.$nodes = content )
    } else if ( contentType == 'text/html' ) {
      return (el) => contentPromiseFor( response ).
        then( content => el.$html = content )
    } else if ( contentType == 'text/plain' ) {
      return (el) => contentPromiseFor( response ).
        then( content => el.$nodes = a.pre( content ) )
    } else {
      return (el) => contentPromiseFor( response ).
        then( content => el.$text = content )
    }

  }

  return a['|appkit-http']( options.placeholder || null, {
    $init: (el) => {

      el.$send( 'axf.appkit.http.start' )

      let optionFor = ( key, i ) => {
        if ( ax.is.array( options[key] ) ) {
          return options[key][i]
        } else {
          return options[key]
        }
      }

      Promise.all(
        urls.map( ( url, i ) => {

          let query = optionFor( 'query', i )

          if ( query ) {
            url = `${ url }?${ x.lib.query.from.object( query ) }`
          }

          return fetch( url, {
            method: optionFor( 'method', i ),
            headers: optionFor( 'headers', i ),
            body: optionFor( 'body', i ),
            ...optionFor( 'fetch', i ),
          } )
        } )
      ).then( responses => {

        let hadError

        for ( let i in responses ) {

          let response = responses[i]

          if ( response.status < 200 || response.status >= 300 ) {

            let statusErrorCallback = customCallbacks[ response.status ]

            if ( statusErrorCallback ) {
              statusErrorCallback.bind(el)( response, el )
            } else {
              responseError( response, el )
            }

            console.warn( `Received HTTP status ${ response.status } when fetching ${ optionFor( 'method', i ) || 'GET' } ${ response.url }.` )

            hadError = true
            break // Exit promise on first error.

          }
        }

        if ( !hadError ) responsesSuccess( responses, el )

      } ).catch( error => {

        console.error( 'Ax appkit http error.', error.message, el )
        if ( options.catch ) options.catch( error, el )

      } ).finally( () => {

        // el is ususally removed from DOM by callback,
        // so get parent for sending complete event and calling complete fn.
        let parent = el.$('^')
        if( options.complete ) {
          options.complete.bind(parent)(parent)
        }
        // Parent sometimes removed too, by complete fn,
        // or when router navigates away.
        if ( parent ) parent.$send( 'axf.appkit.http.complete' )

      } )

    }
  }, options.httpTag )

}

ax.extension.output = function( value, options={} ) {

  let a = ax.a
  let x = ax.x

  let component

  if ( value ) {
    if ( options.parse ) {
      if( ax.is.string( value ) ) {
        try {
          component = x.output.element( JSON.parse( value ) )
        }
        catch (error) {
          component = a['.error']( `⚠ ${ error.message }` )
        }
      } else {
        component = a['.error']( `⚠ Not a string.` )
      }
    } else {
      component = x.output.element( value )
    }
  } else {
    component = a.span( options.placeholder || 'None', { class: 'placeholder' } )
  }


  return a['|appkit-output'](
    component,
    options.outputTag
  )

}

ax.extension.button = function( options = {} ) {

  let a = ax.a

  let handler = options.onclick || ( () => {} )

  let label = a['appkit-button-label']( options.label || '', { style: { pointerEvents: 'none' } } )

  let confirmation

  if ( ax.is.string( options.confirm ) ) {
    confirmation = () => confirm( options.confirm )
  } else if ( ax.is.function( options.confirm ) ) {
    confirmation = ( el ) => confirm( options.confirm( el ) )
  } else if ( options.confirm ) {
    confirmation = () => confirm( 'Are you sure?' )
  } else {
    confirmation = () => true
  }

  let buttonTag = {

    // id: options.id,
    // class: options.class,
    type: options.type || 'button',
    name: options.name,
    value: options.value,
    // disabled: options.disabled,
    // style: options.style,
    // title: options.title,

    ...options.buttonTag,

    $on: {
      'click: button onclick': function(e) {
        confirmation( this ) && handler.bind( this )( e, this, this.$state )
      },
      ...( options.buttonTag || {} ).$on,
    },


  }

  return a.button( label, buttonTag )

}

ax.extension.router.controller = ( config ) => ( location ) => {

    config = { ...config }

    config.scope = config.scope || ''
    config.match = config.match  || {}
    config.splat = config.splat || []
    config.slash = config.slash || ''

    return {
      path: location.path,
      query: location.query,
      anchor: location.anchor,
      scope: config.scope,
      match: config.match ,
      splat: config.splat,
      slash: config.slash,
      params: {
        ...config.match,
        ...location.query,
      },
      loaded: () => config.router[0].$loaded,
      routes: ax.x.router.controller.routes( config, location ),
      load: ax.x.router.controller.load( config ),
      open: ax.x.router.controller.open( config ),
      reopen: ax.x.router.controller.reopen( config ),
    }

}

ax.extension.form.object = function( data ) {

  let x = ax.x

  let result = {}

  for( let entry of data.entries() ) {
    let name = entry[0]
    let value = entry[1]
    let keys = x.lib.name.dismantle( name )
    x.lib.object.assign( result, keys, value )
  }

 return result

}

ax.extension.form.shim = function() {

  return {

    input: f => options => this.factory.input( options ),
    select: f => options => this.factory.select( options ),
    textarea: f => options => this.factory.textarea( options ),
    checkbox: f => options => this.factory.checkbox( options ),
    checkboxes: f => options => this.factory.checkboxes( options ),
    radios: f => options => this.factory.radios( options ),
    button: f => options => this.factory.button( options ),
    form: f => options => this.factory.form( f, options ),
    submit: f => options => this.factory.submit( f, options ),
    cancel: f => options => this.factory.cancel( f, options ),

  }

}

ax.extension.form.factory = function( options ) {

  return new function() {

    let proxy = function( factory, base={}, shim={} ) {

      return new Proxy( base, {
        get: ( target, property ) => {
          let object = target[property]
          if ( ax.is.function( shim[property] ) ) {
            return shim[property]( factory.target, object )
          } else if ( ax.is.object( shim[property] ) ) {
            return proxy( factory, object, shim[property] )
          } else {
            return object
          }
        },
      } )

    }

    let shims = options.shims || []

    this.target = {
      shims: shims,
      scope: options.scope || '',
      params: options.params || {},
      object: options.object || {},
    }

    for ( let i in shims ) {
      this.target = proxy( this, this.target, shims[i] )
    }

    return this.target

  }

}

ax.extension.report.shim = function() {

  return {

    report: r => options => this.factory.report( r, options ),
    button: r => options => this.factory.button( options ),
    checkbox: r => options => this.factory.checkbox( options ),
    checkboxes: r => options => this.factory.checkboxes( options ),
    output: r => options => this.factory.output( options ),
    radios: r => options => this.factory.radios( options ),
    select: r => options => this.factory.select( options ),
    string: r => options => this.factory.string( options ),
    text: r => options => this.factory.text( options ),

  }

}

ax.extension.report.factory = function( options ) {

  return new function() {

    let proxy = function( factory, base={}, shim={} ) {

      return new Proxy( base, {
        get: ( target, property ) => {
          let object = target[property]
          if ( ax.is.function( shim[property] ) ) {
            return shim[property]( factory.target, object )
          } else if ( ax.is.object( shim[property] ) ) {
            return proxy( factory, object, shim[property] )
          } else {
            return object
          }
        },
      } )

    }

    let shims = options.shims || []

    this.target = {
      shims: shims,
      scope: options.scope || '',
      params: options.params || {},
      object: options.object || {},
    }

    for ( let i in shims ) {
      this.target = proxy( this, this.target, shims[i] )
    }

    return this.target

  }

}

ax.extension.transition.
crossfade = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let duration = ( options.duration || 500 ) / 2

  return a['div|appkit-transition']( null, {
    $init: function () {
      let component = options.initial
      this.style.display = 'none'
      if( component ) {
        this.$in( component )
      }
    },
    $in: function( component ) {
      this.$nodes = component
      x.lib.animate.fade.in( this, {
        duration: duration,
      } )
    },
    $to: function( component ) {
      if ( this.style.display === 'none' ) {
        this.$in( component )
      } else {
        x.lib.animate.fade.out( this, {
          duration: duration,
          complete: () => this.$in( component )
        } )
      }

    },
    ...options.transitionTag
  } )

}

ax.extension.transition.
fadein = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let duration = ( options.duration || 500 ) / 2
  let component = options.initial

  return a['|appkit-transition']( null, {
    $init: function () {
      this.style.display = 'none'
      if( component ) {
        this.$content = component
        this.$in()
      }
    },
    $in: function () {

      this.$nodes = this.$content
      x.lib.animate.fade.in( this, {
        duration: duration,
      } )
    },
    $to: function( component ) {

      component = ax.factory( component )
      this.$content = component
      this.$in()

    },
  } )

}

ax.extension.output.element = function( value ) {

  let a = ax.a
  let x = ax.x

  if ( ax.is.array( value ) ) {
    return a.ol( value.map(
      ( element ) => a.li( x.output.element( element ) )
    ) )
  } else if ( ax.is.null( value ) ) {
    return a['|appkit-output-null']( null )
  } else if ( ax.is.function( value ) ) {
    return a['|appkit-output-function']( `𝑓 ${ value }` )
  } else if ( ax.is.object( value ) ) {
    return a.ul(
      Object.keys( value ).map( ( key ) => {
        return a.li( [
          a.label( key ), ' ',
          x.output.element( value[ key ] )
        ] )
      } )
    )
  } else if ( ax.is.number( value ) ) {
    return a['|appkit-output-number']( value )
  } else if ( ax.is.boolean( value ) ) {
    return a['|appkit-output-boolean']( value )
  } else {
    return a['|appkit-output-text']( value )
  }

}

ax.extension.lib.text = {}

ax.extension.lib.uuid = {}

ax.extension.lib.object = {}

ax.extension.lib.compact = function( value ) {

  let compact = ax.x.lib.compact

  if ( ax.is.array( value ) ) {
    return compact.array( value )
  } else if ( ax.is.object( value ) ) {
    return compact.object( value )
  } else if ( [ '', undefined, null ].includes( value ) ) {
    return null
  } else {
    return value
  }

}

ax.extension.lib.coerce = {}

ax.extension.lib.name = {}

ax.extension.lib.form = {}

ax.extension.lib.query = {}

ax.extension.lib.element = {}

ax.extension.lib.animate = {}

ax.extension.lib.array = {}

ax.extension.lib.
unnested = function( el, tag ) {

  let controls = el.$$(tag).$$
  let result = []

  controls.forEach( function( el1, i ) {
    let nested
    controls.forEach( function( el2 ) {
      if ( !el1.isSameNode( el2 ) && el2.contains( el1 ) ) {
        nested = true
      }
    } )
    if ( !nested ) {
      result.push(el1)
    }
  } )

  return result

}

ax.extension.lib.tabable = function( element ) {
  if ( element.tabIndex >= 0 && ax.x.lib.element.visible( element ) ) {
    // // if ( !element.$ ) debugger
    // // use .closest to find element, rather than .$('^'), because element may
    // // not have been created by ax and won't have the Traversal Tool.
    // let dependent = element.closest('|appkit-form-field |appkit-form-field-dependent')
    // if ( dependent ) {
    //   return dependent.$match()
    // } else {
      return true
    // }
  } else {
    return false
  }
}

ax.extension.router.controller.
load = (config) => function( locator=null, query={}, anchor=null ) {

  let path = window.location.pathname

  if ( locator ) {
    if ( locator[0] == '/' ) {
      path = locator
    } else {
      if ( path.match( /\/$/ ) ) {
        path = `${ path }${ locator }`
      } else {
        path = `${ path }/${ locator }`
      }
    }
  }

  config.router[0].$load( path, query, anchor )

}

ax.extension.router.controller.
reopen = config => () => config.router[0].$go()

ax.extension.router.controller.
open = config => function( locator=null, query={}, anchor=null ) {

  if ( locator ) {

    let path = window.location.pathname

    if ( locator[0] == '/' ) {
      path = locator
    } else if ( locator ) {
      if ( path.match( /\/$/ ) ) {
        path = `${ path }${ locator }`
      } else {
        path = `${ path }/${ locator }`
      }
    }

    config.router[0].$open( path, query, anchor )

  } else {

    config.router[0].$go()

  }

}

ax.extension.router.controller.
routes = ( config, startLocation ) => function( routes, options={} ) {

  let a = ax.a
  let x = ax.x

  config = { ...config }

  config.default = options.default || config.default
  config.routes = routes

  let init
  let component
  let matched
  let transition = ax.x.router.controller.routes.transition( ax.is.undefined( options.transition ) ? config.transition : options.transition )
  let view = ax.x.router.controller.routes.view( config )

  let lazy = ax.is.undefined( options.lazy ) ? config.lazy : options.lazy

  if ( transition ) {
    init = function() {
      let locatedView = view( this, startLocation )
      this.$matched = locatedView.matched
      this.$scope = locatedView.scope
      this.$('|appkit-transition').$to( locatedView.component )
    }
    component = [ transition ]
  } else {
    component = function() {
      let locatedView = view( this, startLocation )
      this.$matched = locatedView.matched
      this.$scope = locatedView.scope
      return locatedView.component
    }

  }

  let routesTag = {
    id: options.id,
    $init: init,
    $nodes: component,

    $reload: function() {
      this.$matched = false
      this.$('^|appkit-router').$go()
    },

    $load: function( path, query, anchor ) {

      let toLocation = {
        path: path,
        query: query,
        anchor: anchor
      }

      let locatedView = view( this, toLocation )

      if (
        lazy &&
        this.$scope == locatedView.scope &&
        locatedView.matched &&
        this.$matched
      ) {

        let location = toLocation
        let routes = x.lib.unnested( this, '|appkit-router-routes' )

        routes.forEach( (r) => {
          r.$load( location.path, location.query, location.anchor )
        } )

      } else {

        this.$scope = locatedView.scope

        if ( transition ) {
          this.$('|appkit-transition').$to( locatedView.component )
        } else {
          this.$nodes = locatedView.component
        }

        this.$matched = locatedView.matched

      }

    },

    ...options.routesTag

  }

  return a['|appkit-router-routes'](
    null, routesTag
  )

}

ax.extension.form.factory.
checkboxes = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let value = x.lib.form.collection.value( options.value )
  let selections = x.lib.form.selections( options.selections )

  return a['appkit-form-checkboxes'](
    selections.map( selection => {

      let label = selection.label

      if ( selection.disabled == 'hr' ) {
        label = '—————'
      } else if ( selection.disabled == 'br' ) {
        label =  ''
      }

      return x.check( {
        name: options.name,
        value: value.includes( selection.value ) ? selection.value : '',
        label: label,
        checked: selection.value,
        readonly: options.readonly,
        inputTag: {
          ...( ( options.disabled || selection.disabled ) ? { disabled: 'disabled' } : {} ),
          ...options.inputTag
        },
        labelTag: options.labelTag,
        checkTag: options.checkTag,
      } )

    } ),
    options.checkboxesTag
  )

}

ax.extension.form.factory.
textarea = function( options={} ) {

  let a = ax.a

  let value = options.value || ''

  let textareaTagOptions = {
    name: options.name,
    required: options.required,
    readonly: options.readonly,
    placeholder: options.placeholder,
    ...options.textareaTag
  }

  return a['|appkit-form-textarea-wrapper'](
    a.textarea( value, textareaTagOptions ),
    options.wrapperTag
  )

}

ax.extension.form.factory.
cancel = ( f, options={} ) => {

  let label = options.label || '✖️ Cancel'

  let onclick = options.onclick || ( () => console.warn(
    'Form cancel button does not have an onclick handler.'
  ) )

  let buttonOptions = {
    label: label,
    name: options.name,
    value: options.value,
    onclick: onclick,
    to: options.to,
    title: options.title,
    buttonTag: options.buttonTag,
    ...options.button
  }

  return f.button( buttonOptions )

}

ax.extension.form.factory.
input = function( options={} ) {

  let a = ax.a
  let x = ax.x
// if ( options.name = 'beer' ) debugger

  let datalist = null
  let datalistId

  if ( options.datalist ) {
    datalistId = x.lib.uuid.generate()
    datalist = a.datalist( options.datalist.map( item => a.option( null, {
      value: item,
    } ) ), { id: datalistId } )
  }

  let inputTagOptions = {
    name: options.name,
    value: options.value,
    type: options.type,
    required: options.required,
    readonly: options.readonly,
    pattern: options.pattern,
    minlength: options.minlength,
    maxlength: options.maxlength,
    min: options.min,
    max: options.max,
    step: options.step,
    placeholder: options.placeholder,
    autocomplete: options.autocomplete,
    multiple: options.multiple,
    list: datalistId,
    ...options.inputTag,
  }

  return a['|appkit-form-input-wrapper'](
    [
      a.input( null, inputTagOptions ),
      datalist,
    ],
    options.wrapperTag
  )

}

ax.extension.form.factory.
checkbox = function( options={} ) {

  let a = ax.a
  let x = ax.x

  return a['|appkit-report-checkbox'](
    x.check( {
      name: options.name,
      value: options.value,
      type: options.type,
      label: options.label,
      checked: options.checked,
      required: options.required,
      readonly: options.readonly,
      inputTag: options.inputTag,
      labelTag: options.labelTag,
      checkTag: options.checkTag,
    } ),
    options.checkboxTag,
  )

}

ax.extension.form.factory.
submit = ( f, options={} ) => {

  let label = options.label === false ? '' : options.label || '✔ Submit'

  let buttonOptions = {
    label: label,
    type: 'submit',
    name: options.name,
    value: options.value,
    onclick: options.onclick,
    // to: options.to,
    title: options.title,
    buttonTag: options.buttonTag,
    ...options.button
  }

  return f.button( buttonOptions )

}

ax.extension.form.factory.
form = ( f, options={} ) => {

  let a = ax.a
  let x = ax.x

  let form = options.form || ( () => null )

  let formTagOptions = {
    method: options.method || 'POST',
    action: options.url || options.action,
    $formData: function() {
      return new FormData( this )
    },
    $data: function() {
      return x.lib.form.data.objectify( this.$formData() )
    },
    ...options.formTag
  }

  return a.form( form(f), formTagOptions )

}

ax.extension.form.factory.
radios = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let value = options.value || ''

  let selections = x.lib.form.selections( options.selections )

  // if ( options.placeholder ) {
  //   selections.unshift( { value: '', label: options.placeholder } )
  // }

  return a['|appkit-form-radios'](
    selections.map( selection => {

      let label = selection.label

      if ( selection.disabled == 'hr' ) {
        label = '—————'
      } else if ( selection.disabled == 'br' ) {
        label =  ''
      }

      return x.check( {
        type: 'radio',
        name: options.name,
        value: value == selection.value ? true : false,
        label: label,
        checked: selection.value,
        required: options.required,
        readonly: options.readonly,
        inputTag: {
          ...( ( options.disabled || selection.disabled ) ? { disabled: 'disabled' } : {} ),
          ...options.inputTag
        },
        labelTag: options.labelTag,
        checkTag: options.checkTag,
      } )

    } ),
    options.radiosTag
  )

}

ax.extension.form.factory.
select = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let applyPlaceholder = el => {
    let selected = el.$$('option')[ el.selectedIndex ]
    if ( selected.classList.contains('placeholder') ) {
      el.classList.add('placeholder')
    } else {
      el.classList.remove('placeholder')
    }
  }

  let selectTagOptions = {
    name: options.name,
    value: options.value,
    required: options.required,
    readonly: options.readonly,
    multiple: options.multiple,
    ...options.selectTag,
    $init: el => applyPlaceholder(el),
    $on: {
      'change: update placeholder styling': (e,el) => applyPlaceholder(el),
      ...( options.selectTag || {} ).$on,
    }
  }

  return a['|appkit-form-select-wrapper'](
    a.select( this.select.options( options ), selectTagOptions ),
    options.wrapperTag
  )

}

ax.extension.form.factory.
button = function( options={} ) {

  let x = ax.x

  return x.button( options )

}

ax.extension.report.factory.
checkboxes = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let value = x.lib.form.collection.value( options.value )
  let selections = x.lib.form.selections( options.selections )

  return a['|appkit-report-checkboxes'](
    selections.map( selection => {

      let label = selection.label

      if ( selection.disabled == 'hr' ) {
        label = '—————'
      } else if ( selection.disabled == 'br' ) {
        label =  ''
      }

      return x.check( {
        ...options,
        name: `${ options.name }[]`,
        value: value.includes( selection.value ) ? selection.value : '',
        label: label,
        checked: selection.value,
        readonly: 'readonly',
        inputTag: {
          tabindex: -1,
          disabled: 'disabled',
          ...options.inputTag
        },
      } )

    } ),
    options.checkboxesTag
  )

}

ax.extension.report.factory.
text = function( options={} ) {

  let a = ax.a

  let component

  if ( options.value ) {
    component = options.value
  } else {
    component = a.span( options.placeholder || 'None', { class: 'placeholder' } )
  }

  return a['|appkit-report-text']( component, options.textTag )

}

ax.extension.report.factory.
report = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let report = options.report || ( () => null )

  let reportTagOptions = {
    ...options.reportTag
  }

  return a['|appkit-report']( report(r), reportTagOptions )

}

ax.extension.report.factory.
checkbox = function( options={} ) {

  let a = ax.a
  let x = ax.x

  return a['|appkit-report-checkbox'](
    x.check( {
      ...options,
      inputTag: {
        tabindex: -1,
        disabled: 'disabled',
        ...options.inputTag,
      },
      ...options.checkbox,
      readonly: 'readonly',
    } ),
    options.checkboxTag,
  )

}

ax.extension.report.factory.
radios = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let value = options.value || ''

  let selections = x.lib.form.selections( options.selections )

  return a['|appkit-report-radios'](
    selections.map( selection => {

      let label = selection.label

      if ( selection.disabled == 'hr' ) {
        label = '—————'
      } else if ( selection.disabled == 'br' ) {
        label =  ''
      }

      return x.check( {
        type: 'radio',
        name: options.name,
        value: value == selection.value ? selection.value : '',
        label: label,
        checked: selection.value,
        required: options.required,
        tabindex: -1,
        readonly: 'readonly',
        inputTag: {
          tabindex: -1,
          disabled: 'disabled',
          ...options.inputTag
        },
        labelTag: options.labelTag,
        checkTag: options.checkTag,
      } )

    } ),
    options.radiosTag
  )

}

ax.extension.report.factory.
string = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let value = options.value || ''

  let component

  if ( options.value ) {
    component = options.value.toString()
  } else {
    component = a.span( options.placeholder || 'None', { class: 'placeholder' } )
  }

  return a['|appkit-report-string']( component, options.stringTag )

}

ax.extension.report.factory.
output = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    x.output( options.value, {
      parse: options.parse,
      outputTag: options.outputTag,
    } ),
    controlTagOptions
  )

}

ax.extension.report.factory.
select = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let value = x.lib.form.collection.value( options.value )
  let selections = x.lib.form.selections( options.selections || {} )

  let label = []

  if ( ax.is.not.array( value ) ) {
    value = [ value ]
  }

  for ( let selected of value ) {
    let found = selections.find( selection => selection.value === selected )
    if ( found ) {
      label.push( found.label )
    }
  }
  label = label.join( ', ' )

  let selectTagOptions = {
    name: options.name,
    ...options.selectTag,
  }

  if ( label.length == 0 ) {
    label = a.span( options.placeholder || 'None', { class: 'placeholder' } )
  }

  return a['|appkit-report-select']( label, selectTagOptions )

}

ax.extension.report.factory.
button = function( options={} ) {

  let x = ax.x

  return x.button( options )

}

ax.extension.lib.element.visible = function ( element ) {

  return !!(
    element.offsetWidth ||
    element.offsetHeight ||
    element.getClientRects().length
  )
}

ax.extension.lib.form.collection = {}

ax.extension.lib.form.data = {}

ax.extension.lib.form.selections = function( selections ) {

  if ( ax.is.array( selections ) ) {
    selections = selections.map( function(selection) {
      if ( ax.is.array( selection ) ) {
        return { value: selection[0], label: selection[1], disabled: selection[2] }
      } else if ( ax.is.object( selection ) ) {
        return { value: selection.value, label: selection.label, disabled: selection.disabled }
      } else {
        return { value: selection, label: selection }
      }
    } )
  } else {
    selections = Object.keys( selections || {} ).map(function( key ) {
      let label = selections[key]
      return { value: key , label: label }
    } )
  }

  return selections

}

ax.extension.lib.query.from ={}

ax.extension.lib.query.to = {}

ax.extension.lib.text.humanize = function(string='') {
  return string.toString().replace(/_/g, ' ' );
};

ax.extension.lib.text.labelize = function(string='') {
  return this.capitalize( this.humanize( string ) );
};

ax.extension.lib.text.capitalize = function(string='') {
  return string.toString().charAt(0).toUpperCase() + string.slice(1);
};

ax.extension.lib.name.dismantle = string => ( string.
  match( /\w+|\[\w*\]|\[\.\.\]/g ) || [] ).
  map( part => part.replace( /\[|\]/g, '' ) )

ax.extension.lib.uuid.generate = function() {

  return '00000000-0000-4000-0000-000000000000'.replace(
    /0/g,
    c => ( c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
  )

}

ax.extension.lib.animate.fade = {}

ax.extension.lib.object.dig = function( object, keys=[], defaultValue=null ) {

  let result = object

  for (let key in keys) {
    if ( result  == null ) {
      return defaultValue
    } else {
      result = result [ keys[key] ] || null
    }
  }

  return result || defaultValue

}

ax.extension.lib.object.assign = function(object, keys, value) {

  let key = keys[0]
  let depth = keys.length

  if (depth === 1) {
    // Assign the value if no nesting.

    if (key === '') {
      object.push(value)
    } else {
      object[key] = value
    }

  } else {
    // Assign nested value

    // Look ahead to next key
    let next = keys[1]

    if (key === '') {
      // Build a collection
      let index = object.length - 1
      let current = object[index]
      if ( ax.is.object(current) &&
        ( depth > 2 || ax.is.undefined( current[next] ) )
      ) {
        // Add to current item
        key = index
      } else {
        // Start building next item
        key = index + 1
      }
    }

    // Create empty object if needed
    if ( ax.is.undefined( object[key] ) ) {
      if (next === '') {
        object[key] = []
      } else {
        object[key] = {}
      }
    }

    // Do next layer of nesting
    this.assign(object[key], keys.slice(1), value)
  }

}

// ax.extension.lib.object.
// sort = function( object, options={} ) {
//
//   let result = {}
//
//   Object.keys(object).sort().forEach(function(key) {
//     result[key] = object[key]
//   })
//
//   return result
//
// }

// ax.extension.lib.object.group = function( collection, key ) {
//
//   return collection.reduce(function(result, item) {
//
//     ( result[ item[key] ] = result[ item[key] ] || [] ).push( item )
//
//     return result
//
//   }, {} )
//
// }

ax.extension.lib.coerce.number = function( value ) {
  return Number( value ) || 0
}

ax.extension.lib.coerce.boolean = function( value ) {
  value = value || false
  let string = value.toString().toLowerCase()
  return value &&
    string !== 'false' &&
    string !== 'off' &&
    string !== '0'
}

ax.extension.lib.coerce.string = function( value ) {
  return ax.is.undefined( value ) ? '' : String( value )
}

ax.extension.lib.tabable.previous = function( element ) {

  let elements = Array.from( document.querySelectorAll( '*' ) )

  let index = elements.indexOf( element )
  let count = elements.length
  let target
  let tabable

  let i = index
  do {
    i--
    if ( i === 0 ) i = count - 1
    if ( i === index ) return element
    target = elements[ i ]
    tabable = this( target )
  } while ( !tabable );

  return target

}

ax.extension.lib.tabable.next = function( element ) {

  let elements = Array.from( document.querySelectorAll( '*' ) )

  // start search at last child element
  element = Array.from( element.querySelectorAll( '*' ) ).slice(-1)[0] || element

  let index = elements.indexOf( element )
  let count = elements.length
  let target
  let tabable

  let i = index
  do {
    i++
    if ( i === count ) i = 0
    if ( i === index ) return element
    target = elements[ i ]
    tabable = this( target )
  } while ( !tabable );

  return target

}

ax.extension.lib.compact.object = function( object ) {

  for (const key in object) {
    object[key] = this( object[key] )
    if (
      object[key] === null ||
      ( ax.is.object( object[key] ) && Object.keys( object[key] ).length === 0 ) ||
      ( ax.is.array( object[key] ) && object[key].length === 0 )
    ) delete object[key]
  }

  return object

}

ax.extension.lib.compact.array = function( array ) {

  return array.
    map( value => this( value ) ).
    filter( value => value != null )

}

ax.extension.router.controller.routes.
view = ( config ) => ( routesElement, location ) => {

  let scope = config.scope || ''
  let scopedpath = location.path.slice( scope.length )
  let match = config.match || {}
  let splat = config.splat || []
  let lazy = config.lazy
  let defaultContent = config.default
  let transition = config.transition
  let component
  let slash
  let matched

  let routesKeys = Object.keys( config.routes )

  for ( let i in routesKeys ) {

    let routesKey = routesKeys[i]

    matched = ax.x.router.controller.routes.matcher(
      routesKey,
      scopedpath,
    )

    if ( matched ) {

      component = config.routes[routesKey]
      splat = [
        ...splat,
        ...matched.splat,
      ]
      match = {
        ...match,
        ...matched.params,
      }
      slash = matched.slash
      scope = `${ scope }${ matched.scope }`.replace( /\/$/, '' )

      break

    }

  }

  if (!matched) {

    component = ax.is.undefined( config.default ) ?
    controller => {
      let message = `'${ scopedpath }' not found`
      let el = config.router[ config.router.length - 1 ]
      console.warn( message, controller, config.router )
      return (a,x) => a['.error']( message )
    } :
    config.default

  }

  if ( ax.is.function( component ) ) {
    let controller = ax.x.router.controller( {
      router: [ ...config.router, routesElement ],
      scope: scope,
      match: match,
      splat: splat,
      slash: slash,
      lazy: lazy,
      default: defaultContent,
      transition: transition,
    } )( location )
    component = ax.a['|appkit-router-view'](
      component( controller ),
      {
        $init: function() {
          if ( location.anchor ) {
            let anchored = document.getElementById( location.anchor )
            if ( !anchored ) console.warn( `Appkit router view cannot find #${ location.anchor }` )
            if ( anchored ) anchored.scrollIntoView()
          }
        }
      }
    )

  }

  return {
    matched: !!matched,
    component: component,
    scope: scope,
  }

}

ax.extension.router.controller.routes.
transition = ( transition ) => {

  if( ax.is.string( transition ) ) {
    return ax.x.transition[ transition ]()
  } else if( ax.is.array( transition ) ) {
    let name = transition[0]
    let options = transition[1]
    return ax.x.transition[ name ]( options )
  } else {
    return transition
  }

}

ax.extension.router.controller.routes.
regexp = ( route ) => {

  let routeRegexp = route.
    replace( /\*$/, '&&catchall&&' ).
    replace( /\*/g, '&&wildcard&&' ).
    replace( /\/\?/, '&&slash&&' )

  let captures = routeRegexp.match(/(:\w+|&&wildcard&&|&&catchall&&|&&slash&&)/g) || []
  let paramKeys = []

  captures.forEach( function( capture ) {
    let paramKey
    let pattern
    if ( capture === '&&wildcard&&' ) {
      paramKey = '*'
      pattern = '([^\\/|^\\.]*)'
    } else if ( capture === '&&catchall&&' ) {
      paramKey = '**'
      pattern = '(.*)'
    } else if ( capture === '&&slash&&' ) {
      paramKey = '?'
      pattern = '(\\/?)'
    } else {
      paramKey = capture.slice(1)
      pattern = '([^\\/|^\\.]*)'
    }
    paramKeys.push( paramKey )
    routeRegexp = routeRegexp.replace( capture, pattern )
  } )

  routeRegexp = '^' + routeRegexp + '$'

  return {
    string: routeRegexp,
    keys: paramKeys,
  }

}

ax.extension.router.controller.routes.
matcher = ( routesKey, scopedpath ) => {

  let params = {}
  let splat = []
  let slash

  let regexp = ax.x.router.controller.routes.regexp( routesKey )
  let routeRegex = new RegExp( regexp.string )
  let match = scopedpath.match( routeRegex )

  if ( match ) {

    let paramKeys = regexp.keys
    let remove = 0

    paramKeys.forEach( function( paramKey, i ) {

      let matched = match[ i + 1 ]

      if ( paramKey === '*' ) {
        splat.push( matched )
      } else if ( paramKey == '**' ) {
        remove = remove + matched.length
        splat.push( matched )
      } else if ( paramKey == '?' ) {
        remove = remove + matched.length
        slash = matched
      } else {
        params[paramKey] = matched
      }

    } )

    let keep = scopedpath.length - remove
    let scope = scopedpath.substring( 0, keep )

    return {
      params: params,
      splat: splat,
      slash: slash,
      scope: scope
    }

  } else {

    return null

  }

}

// ax.extension.form.factory.input.
// datalist = function( options ) {
//
//   let a = ax.a
//
//   let datalist = options.datalist.map( item => a.option( null, {
//     value: item,
//   } ) )
//
//   return a.datalist( datalist, )
//
// }

ax.extension.form.factory.select.
options = function( options ) {

  let a = ax.a
  let x = ax.x

  let selections = x.lib.form.selections( options.selections )

  if ( options.placeholder ) {
    selections.unshift( { value: '', label: options.placeholder, class: 'placeholder', } )
  }

  return selections.map( function ( selection ) {

    let optionsTagOptions = {
      ...options.optionTag,
      ...selection.optionTag
    }

    if ( selection.disabled == 'hr' ) {

      return a.option( '—————', {
        value: selection.value,
        disabled: 'disabled',
        ...optionsTagOptions
      } )

    } else if ( selection.disabled == 'br' ) {

      return a.option( '', {
        value: selection.value,
        disabled: 'disabled',
        ...optionsTagOptions
      } )

    } else {

      let value = options.value
      let selected

      if ( ax.is.array( value ) ) {
        selected = value.some( function( value ) { return value == selection.value } )
      } else {
        selected = value == selection.value
      }

      return a.option( selection.label, {
        value: selection.value,
        selected: selected || undefined,
        disabled: selection.disabled,
        class: selection.class,
        ...optionsTagOptions
      } )

    }


  } )

}

ax.extension.lib.form.collection.value = function( value ) {

  if ( ax.is.array( value ) ) {
    return value
  } else if ( value ) {
    return [ value ]
  } else {
    return []
  }

}

ax.extension.lib.form.data.objectify = function( data ) {

  let object = {}
  let lib = ax.extension.lib

  for (var pair of data.entries() ) {
    lib.object.assign( object, lib.name.dismantle( pair[0] ), pair[1] )
  }

  return object

}

ax.extension.lib.query.from.
object = function( object, options={} ) {

  var queryString = []
  var property

  for (property in object) {
    if (object.hasOwnProperty(property)) {
      var k = options.prefix ? options.prefix + '[' + property + ']' : property,
        v = object[property]
      queryString.push((v !== null && ax.is.object( v )) ?
        this.object( v, { prefix: k } ) :
        encodeURIComponent(k) + '=' + encodeURIComponent(v))
    }
  }
  return queryString.join('&')

}

ax.extension.lib.query.to.
object = function( queryString ) {

  var result = {}

  if ( queryString ) {
    queryString.split('&').map( function( pair ) {
      pair = pair.split('=')
      result[ pair[0] ] = decodeURIComponent( pair[1] )
    } )
  }

  return result

}

ax.extension.lib.animate.fade.out = function( el, options={} ) {

  let step = 50 / ( options.duration || 250 )
  el.style.opacity = 1

  let complete = () => {
    el.style.display = "none"
    el.style.opacity = 0
    if ( options.complete ) options.complete( el )
  }

  let fade = function () {
    if ( ( el.style.opacity -= step ) <= 0 ) {
      complete()
    } else {
      setTimeout( fade, 50 )
    }
  }

  fade()

}

ax.extension.lib.animate.fade.in = function( el, options={} ) {

  let step = 50 / ( options.duration || 250 )

  el.style.opacity = 0
  el.style.display = options.display || "block"

  let complete = () => {
    el.style.opacity = 1
    if ( options.complete ) options.complete( el )
  }

  let fade = function () {
    if  ( ( el.style.opacity = parseFloat( el.style.opacity ) + step ) >= 1 ) {
      complete()
    } else {
      setTimeout( fade, 50 )
    }
  }

  fade()

}

ax.extension.lib.animate.fade.toggle = function( el, options={} ) {

  if ( el.style.display === 'none' ) {
    this.in( el, options )
  } else {
    this.out( el, options )
  }

}

ax.extension.bootstrap = {}

ax.extension.bootstrap.report = {}

ax.css( {
  '|appkit-form-collection-item-body': {
    width: 'calc( 100% - 120px)',
  }
} )

ax.extension.bootstrap.form = {}

ax.extension.bootstrap.form.shim = function() {

  return {

    field: ( f, target ) => {

      return ( options={} ) => {

      let layout = options.layout || f.params.layout || 'horizontal'

      let fieldTagClass,
          headerTagClass,
          bodyTagClass

      if (
          options.as == 'one' || options.control == 'one' ||
          options.as == 'many' || options.control == 'many' ||
          options.as == 'table' || options.control == 'table' ||
          options.as == 'nest' || options.control == 'nest'
          ) {
        fieldTagClass = 'mb-0'
      } else if (
          options.as == 'input/hidden' || options.type == 'hidden'
          ) {
        fieldTagClass = 'd-none'
      } else {
        fieldTagClass = 'mb-2'
      }

      if ( layout == 'vertical' ) {
        headerTagClass = ''
        bodyTagClass = ''
      } else {
        fieldTagClass = fieldTagClass + ' form-row'
        headerTagClass = 'd-inline-block align-top mt-2 col-sm-4'
        bodyTagClass = 'd-inline-block col-sm-8'
      }

      return target( {
        ...options,
        fieldTag: {
          class: fieldTagClass,
          ...options.fieldTag,
        },
        headerTag: {
          class: headerTagClass,
          ...options.headerTag,
        },
        labelTag: {
          class: 'mb-0',
        },
        bodyTag: {
          class: bodyTagClass,
          ...options.bodyTag,
        },
        hintTag: {
          class: 'form-text text-muted',
          ...options.hintTag,
        },

      } )

    } },

    fieldset: ( f, target ) => ( options={} ) => {

      let layout = options.layout || f.params.layout || 'horizontal'

      let fieldsetTagClass,
          headerTagClass,
          bodyTagClass

      if ( layout == 'vertical' ) {
        fieldsetTagClass = ''
        headerTagClass = ''
        bodyTagClass = ''
      } else {
        fieldsetTagClass = 'mb-0 form-row'
        headerTagClass = 'd-inline-block align-top mt-2 col-sm-4'
        bodyTagClass = 'd-inline-block col-sm-8'
      }

      return target( {
        ...options,
        fieldsetTag: {
          class: fieldsetTagClass,
          ...options.fieldTag,
        },
        headerTag: {
          class: headerTagClass,
          ...options.headerTag,
        },
        bodyTag: {
          class: bodyTagClass,
          ...options.bodyTag,
        },
        hintTag: {
          class: 'form-text text-muted',
          ...options.hintTag,
        },

      } )

    },

    button: ( f, target ) => ( options={} ) => target( {
      ...options,
      buttonTag: {
        class: 'btn btn-secondary',
        ...options.buttonTag,
      },
    } ),

    checkbox: ( f, target ) => ( options={} ) => target( {
      ...options,
      checkTag: {
        class: `custom-control custom-checkbox ml-1`,
        ...options.checkTag,
      },
      inputTag: {
        class: 'custom-control-input',
        ...options.inputTag,
      },
      labelTag: {
        class: 'custom-control-label',
        ...options.labelTag,
      },
      checkboxTag: {
        class: 'd-block p-2',
        ...options.checkboxTag,
      }
    } ),

    checkboxes: ( f, target ) => ( options={} ) => target( {
      ...options,
      checkTag: {
        class: 'custom-control custom-checkbox ml-1',
        ...options.checkTag,
      },
      inputTag: {
        class: 'custom-control-input',
        ...options.inputTag,
      },
      labelTag: {
        class: 'custom-control-label',
        ...options.labelTag,
      },
      checkboxesTag: {
        class: 'd-block p-2',
        ...options.checkboxesTag,
      }
    } ),

    radios: ( f, target ) => ( options={} ) => target( {
      ...options,
      checkTag: {
        class: 'custom-control custom-radio ml-1',
        ...options.checkTag,
      },
      inputTag: {
        class: 'custom-control-input',
        ...options.inputTag,
      },
      labelTag: {
        class: 'custom-control-label',
        ...options.labelTag,
      },
      radiosTag: {
        class: 'd-block p-2',
        ...options.radiosTag,
      }
    } ),

    input: ( f, target ) => ( options={} ) => target( {
      ...options,
      inputTag: {
        class: 'form-control',
        ...options.inputTag,
      },
    } ),

    select: ( f, target ) => ( options={} ) => target( {
      ...options,
      selectTag: {
        class: 'custom-select',
        ...options.selectTag,
      },
    } ),

    textarea: ( f, target ) => ( options={} ) => target( {
      ...options,
      textareaTag: {
        class: 'form-control',
        ...options.textareaTag,
      },
    } ),

    control: ( f, target ) => ( options={} ) => {

      if ( options.collection ) {
        return target( {
          ...options,
          itemsTag: {
            class: 'mb-1 d-block',
            ...options.itemsTag
          },
          itemTag: {
            class: 'clearfix d-block mb-1',
            ...options.itemTag
          },
          itemHeaderTag: {
            class: 'd-inline-block float-right',
            ...options.itemHeaderTag
          },
          itemButtonsTag: {
            class: 'btn-group',
            ...options.itemButtonsTag
          },
          itemBodyTag: {
            class: 'd-inline-block float-left',
            ...options.itemBodyTag,
          },
          footerTag: {
            class: 'mb-1 d-block',
            ...options.footerTag
          },
          sortButtonsTag: {
            class: 'float-right',
            ...options.sortButtonsTag
          },
          sortOffButton: {
            ...options.sortOffButton,
            buttonTag: {
              class: 'btn btn-warning',
              ...( options.sortOffButton || {} ).buttonTag,
            },
          },
        } )
      } else{
        return target( options )
      }

    },

    controls: {
      table: ( f, target ) => ( options={} ) => target( {
        ...options,
        tableTag: {
          class: 'table table-sm table-borderless mb-1',
          ...options.tableTag,
        },
        itemButtonsTag: {
          class: 'btn-group float-right',
          ...options.itemButtonsTag,
        },
        footerTag: {
          class: 'mb-1 d-block',
          ...options.footerTag
        },
        sortButtonsTag: {
          class: 'float-right',
          ...options.sortButtonsTag
        },
        sortOffButton: {
          ...options.sortOffButton,
          buttonTag: {
            class: 'btn btn-warning',
            ...( options.sortOffButton || {} ).buttonTag,
          },
        },
      } ),
      many: ( f, target ) => ( options={} ) => target( {
        ...options,
        itemsTag: {
          class: 'mb-1 d-block',
          ...options.itemsTag
        },
        itemHeaderTag: {
          class: 'clearfix',
          ...options.itemHeaderTag
        },
        itemButtonsTag: {
          class: 'btn-group float-right mb-2',
          ...options.itemButtonsTag
        },
        footerTag: {
          class: 'mb-1 d-block',
          ...options.footerTag
        },
        sortButtonsTag: {
          class: 'float-right',
          ...options.sortButtonsTag
        },
        sortOffButton: {
          ...options.sortOffButton,
          buttonTag: {
            class: 'btn btn-warning',
            ...( options.sortOffButton || {} ).buttonTag,
          },
        },
      } ),
      selectinput: ( f, target ) => ( options={} ) => target( {
        ...options,
        input: {
          ...options.input,
          inputTag: {
            class: 'form-control mt-1',
            ...( options.input || {} ) .inputTag,
          }
        }

      } ),
    },

    submit: ( f, target ) => ( options={} ) => target( {
      ...options,
      buttonTag: {
        class: 'btn btn-primary',
        ...options.buttonTag,
      },
    } ),

  }

}

ax.extension.bootstrap.report.shim = function() {

  return {

    field: ( r, target ) => ( options={} ) => {

      let layout = options.layout || r.params.layout || 'horizontal'

      let fieldTagClass,
          headerTagClass,
          bodyTagClass

      if ( layout == 'vertical' ) {
        fieldTagClass = 'form-group'
        headerTagClass = ''
        bodyTagClass = ''
      } else {
        fieldTagClass = 'mb-1 form-group form-row'
        headerTagClass = 'd-inline-block align-top mt-2 col-sm-4'
        bodyTagClass = 'd-inline-block col-sm-8'
      }

      return target( {
        ...options,
        fieldTag: {
          class: fieldTagClass,
          ...options.fieldTag,
        },
        headerTag: {
          class: headerTagClass,
          ...options.headerTag,
        },
        labelTag: {
          class: 'mb-0',
        },
        bodyTag: {
          class: bodyTagClass,
          ...options.bodyTag,
        },
        hintTag: {
          class: 'form-text text-muted',
          ...options.hintTag,
        },
      } )

    },

    button: ( r, target ) => ( options={} ) => target( {
      ...options,
      buttonTag: {
        class: 'btn btn-secondary',
        ...options.buttonTag,
      },
    } ),

    checkbox: ( r, target ) => ( options={} ) => target( {
      ...options,
      checkTag: {
        class: `custom-control custom-checkbox ml-1`,
        ...options.checkTag,
      },
      inputTag: {
        class: 'custom-control-input',
        ...options.inputTag,
      },
      labelTag: {
        class: 'custom-control-label',
        ...options.labelTag,
      },
      checkboxTag: {
        class: 'd-block p-2',
        ...options.checkboxTag,
      }
    } ),

    checkboxes: ( r, target ) => ( options={} ) => target( {
      ...options,
      checkTag: {
        class: 'custom-control custom-checkbox ml-1',
        ...options.checkTag,
      },
      inputTag: {
        class: 'custom-control-input',
        ...options.inputTag,
      },
      labelTag: {
        class: 'custom-control-label',
        ...options.labelTag,
      },
      checkboxesTag: {
        class: 'd-block p-2',
        ...options.checkboxesTag,
      }
    } ),

    radios: ( r, target ) => ( options={} ) => target( {
      ...options,
      checkTag: {
        class: 'custom-control custom-radio ml-1',
        ...options.checkTag,
      },
      inputTag: {
        class: 'custom-control-input',
        ...options.inputTag,
      },
      labelTag: {
        class: 'custom-control-label',
        ...options.labelTag,
      },
      radiosTag: {
        class: 'd-block p-2',
        ...options.radiosTag,
      }
    } ),

    string: ( r, target ) => ( options={} ) => target( {
      ...options,
      stringTag: {
        class: 'form-control text-dark bg-white p-2',
        ...options.stringTag,
      },
    } ),

    select: ( r, target ) => ( options={} ) => target( {
      ...options,
      selectTag: {
        class: 'form-control text-dark h-100',
        ...options.selectTag,
      },
    } ),

    text: ( r, target ) => ( options={} ) => target( {
      ...options,
      textTag: {
        class: 'form-control text-dark bg-white h-100',
        ...options.textTag,
      },
    } ),

    output: ( r, target ) => ( options={} ) => target( {
      ...options,
      outputTag: {
        class: 'form-control text-dark bg-white h-100',
        ...options.outputTag,
      },
    } ),

    controls: {

      boolean: ( r, target ) => ( options={} ) => target( {
        ...options,
        booleanTag: {
          class:  'form-control text-dark',
          ...options.booleanTag,
        },
      } ),

      json: ( r, target ) => ( options={} ) => target( {
        ...options,
        jsonTag: {
          class: 'form-control text-dark h-100',
          ...options.jsonTag,
        },
      } ),

      preformatted: ( r, target ) => ( options={} ) => target( {
        ...options,
        preformattedTag: {
          class: 'form-control text-dark bg-white h-100',
          ...options.preformattedTag,
        },
      } ),

      password: ( r, target ) => ( options={} ) => target( {
        ...options,
        passwordTag: {
          class: 'form-control text-dark bg-white',
          ...options.passwordTag,
        },
      } ),

      color: ( r, target ) => ( options={} ) => target( {
        ...options,
        colorTag: {
          class: 'form-control text-dark',
          ...options.colorTag,
        },
      } ),

      datetime: ( r, target ) => ( options={} ) => target( {
        ...options,
        datetimeTag: {
          class: 'form-control text-dark',
          ...options.datetimeTag,
        },
      } ),

      number: ( r, target ) => ( options={} ) => target( {
        ...options,
        numberTag: {
          class: 'form-control text-dark',
          ...options.numberTag,
        },
      } ),

      tel: ( r, target ) => ( options={} ) => target( {
        ...options,
        telTag: {
          class: 'form-control text-dark',
          ...options.telTag,
        },
      } ),

      email: ( r, target ) => ( options={} ) => target( {
        ...options,
        emailTag: {
          class: 'form-control text-dark',
          ...options.emailTag,
        },
      } ),

      country: ( r, target ) => ( options={} ) => target( {
        ...options,
        countryTag: {
          class: 'form-control text-dark',
          ...options.countryTag,
        },
      } ),

      language: ( r, target ) => ( options={} ) => target( {
        ...options,
        languageTag: {
          class: 'form-control text-dark',
          ...options.languageTag,
        },
      } ),

      timezone: ( r, target ) => ( options={} ) => target( {
        ...options,
        timezoneTag: {
          class: 'form-control text-dark',
          ...options.timezoneTag,
        },
      } ),

      url: ( r, target ) => ( options={} ) => target( {
        ...options,
        urlTag: {
          class: 'form-control text-dark',
          ...options.urlTag,
        },
      } ),



      table: ( r, target ) => ( options={} ) => target( {
        ...options,
        tableTag: {
          class: 'table table-sm table-borderless mb-0',
          ...options.tableTag,
        },
        itemButtonsTag: {
          class: 'btn-group float-right',
          ...options.itemButtonsTag,
        },
        sortButtonsTag: {
          class: 'float-right',
          ...options.sortButtonsTag
        },
        sortOffButton: {
          ...options.sortOffButton,
          buttonTag: {
            class: 'btn btn-warning',
            ...( options.sortOffButton || {} ).buttonTag,
          },
        },
        sortOnButton: {
          ...options.sortOnButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.sortOnButton || {} ).buttonTag,
          },
        },
        addButton: {
          ...options.addButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.addButton || {} ).buttonTag,
          },
        },
        upButton: {
          ...options.upButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.upButton || {} ).buttonTag,
          },
        },
        downButton: {
          ...options.downButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.downButton || {} ).buttonTag,
          },
        },
        removeButton: {
          ...options.removeButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.removeButton || {} ).buttonTag,
          },
        },

      } ),
      many: ( r, target ) => ( options={} ) => target( {
        ...options,
        itemHeaderTag: {
          class: 'clearfix',
          ...options.itemHeaderTag
        },
        itemButtonsTag: {
          class: 'btn-group float-right mb-2',
          ...options.itemButtonsTag
        },
        sortButtonsTag: {
          class: 'float-right',
          ...options.sortButtonsTag
        },
        sortOffButton: {
          ...options.sortOffButton,
          buttonTag: {
            class: 'btn btn-warning',
            ...( options.sortOffButton || {} ).buttonTag,
          },
        },
        sortOnButton: {
          ...options.sortOnButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.sortOnButton || {} ).buttonTag,
          },
        },
        addButton: {
          ...options.addButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.addButton || {} ).buttonTag,
          },
        },
        upButton: {
          ...options.upButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.upButton || {} ).buttonTag,
          },
        },
        downButton: {
          ...options.downButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.downButton || {} ).buttonTag,
          },
        },
        removeButton: {
          ...options.removeButton,
          buttonTag: {
            class: 'btn btn-outline-primary',
            ...( options.removeButton || {} ).buttonTag,
          },
        },

      } ),

    },

    submit: ( r, target ) => ( options={} ) => target( {
      ...options,
      buttonTag: {
        class: 'btn btn-primary',
        ...options.buttonTag,
      },
    } ),

  }

}

ax.extension.form.field = {}

ax.extension.report.field = {}

ax.extension.form.field.shim = function() {

  return {
    button: ( f, target ) => ( options={} ) => target( {
      ...options,
      buttonTag: {
        $disable: function() {
          this.disabled = 'disabled'
        },
        $enable: function() {
          this.removeAttribute( 'disabled' )
        },
        ...options.buttonTag
      },
    } ),
    field: ( f, target ) => ( options={} ) => this.shim.field( f, options ),
    fieldset: ( f, target ) => ( options={} ) => this.shim.fieldset( f, options ),
    label: ( f, target ) => ( options={} ) => this.shim.label( options ),
    help: ( f, target ) => ( options={} ) => this.shim.help( options ),
    helpbutton: ( f, target ) => ( options={} ) => this.shim.helpbutton( options ),
    hint: ( f, target ) => ( options={} ) => this.shim.hint( options ),
    control: ( f, target ) => ( options={} ) => this.shim.control( f, options ),
    controls: {
      input: ( f, target ) => ( options={} ) => this.shim.controls.input( f, options ),
      select: ( f, target ) => ( options={} ) => this.shim.controls.select( f, options ),
      textarea: ( f, target ) => ( options={} ) => this.shim.controls.textarea( f, options ),
      checkbox: ( f, target ) => ( options={} ) => this.shim.controls.checkbox( f, options ),
      checkboxes: ( f, target ) => ( options={} ) => this.shim.controls.checkboxes( f, options ),
      radios: ( f, target ) => ( options={} ) => this.shim.controls.radios( f, options ),
    }

  }

}

ax.extension.report.field.shim = function() {

  return {
    field: ( r, target ) => ( options={} ) => this.shim.field( r, options ),
    label: ( r, target ) => ( options={} ) => this.shim.label( options ),
    help: ( r, target ) => ( options={} ) => this.shim.help( options ),
    helpbutton: ( r, target ) => ( options={} ) => this.shim.helpbutton( options ),
    hint: ( r, target ) => ( options={} ) => this.shim.hint( options ),
    control: ( r, target ) => ( options={} ) => this.shim.control( r, options ),
    controls: {
      checkbox: ( r, target ) => ( options={} ) => this.shim.controls.checkbox( r, options ),
      checkboxes: ( r, target ) => ( options={} ) => this.shim.controls.checkboxes( r, options ),
      string: ( r, target ) => ( options={} ) => this.shim.controls.string( r, options ),
      select: ( r, target ) => ( options={} ) => this.shim.controls.select( r, options ),
      radios: ( r, target ) => ( options={} ) => this.shim.controls.radios( r, options ),
      text: ( r, target ) => ( options={} ) => this.shim.controls.text( r, options ),
      output: ( r, target ) => ( options={} ) => this.shim.controls.output( r, options ),

      // boolean: ( r, target ) => ( options={} ) => this.shim.controls.boolean( r, options ),
      // multiselect: ( r, target ) => ( options={} ) => this.shim.controls.multiselect( r, options ),
      // number: ( r, target ) => ( options={} ) => this.shim.controls.select( r, options ),
      // preformatted: ( r, target ) => ( options={} ) => this.shim.controls.preformatted( r, options ),
      // markdown: ( r, target ) => ( options={} ) => this.shim.controls.markdown( r, options ),
      // checkbox: ( r, target ) => ( options={} ) => this.shim.controls.checkbox( r, options ),
    }

  }

}

ax.extension.form.field.shim.
control = function( f, options={} ) {

  let a = ax.a
  let x = ax.x

  let as = ( options.as || '' ).split( '/' )
  let control = options.control || as[0] || 'input'
  let type = options.type || as[1]

  let controlFn = f.controls[control]
  if ( !controlFn ) ax.throw( `Form field factory does not support control '${ control }'.` )

  let key = options.key || ''

  options.name = options.name || ( f.scope ?
    `${ f.scope }[${ key }]` :
    key )

  let object = f.object || {}
  if ( ax.is.not.undefined( object[key] ) ) {
    options.value = object[key]
  }

  let controlOptions = {
    ...options,
    type: type,
    ...options[control]
  }

  if ( options.collection ) {
    return x.form.field.shim.field.collection( f, controlFn, controlOptions )
  } else {
    return controlFn( controlOptions )
  }

}

ax.extension.form.field.shim.
label = function( options={} ) {

  let a = ax.a
  let x = ax.x
  let lib = x.lib

  // if ( ax.is.boolean( options.label ) && !options.label ) return null

  let label = options.label || lib.text.labelize( options.key )
  let component = a.label( label, options.labelTag )

  let labelWrapperTag = {

    ...options.labelWrapperTag,

    $on: {
      'click: focus on input': function() {
        let target = this.$( '^|appkit-form-field |appkit-form-control' )
        target.$focus()
      },
      ...( options.labelWrapperTag || {} ).$on,
    },

  }

  return a['|appkit-form-field-label-wrapper']( component, labelWrapperTag )

}

ax.extension.form.field.shim.
field = function( f, options={} ) {

  let a = ax.a
  let x = ax.x

  if ( options.as == 'input/hidden' || options.type == 'hidden' ) {
    options.label = options.label || false
  }

  return a['div|appkit-form-field']( [
    this.field.header( f, options ),
    a['|appkit-form-field-body']( [
      f.help( options ),
      f.control( {
        ...options,
        // Controls don't normally need labels. Checkbox is exception.
        // Label for checkbox needs to be specified in options.checkbox.
        // options.label and options.labelTag consumed by this.field.header()
        label: null,
        labelTag: null,
      } ),
      f.hint( options ),
    ], options.bodyTag ),
  ], options.fieldTag )

}

ax.extension.form.field.shim.
help = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let help = options.help

  return help ? a['|appkit-form-field-help-wrapper'](
    a['|appkit-form-field-help']( help, {
      $toggle: function () {
        x.lib.animate.fade.toggle( this )
      },
      ...options.helpTag,
      style: {
        display: 'none',
        ...( options.helpTag || {} ).style,
      }
    } ),
    {
      ...options.helpWrapper,
      style: {
        display: 'block',
        ...( options.helpWrapper || {} ).style,
      }
    }
  ) : null

}

ax.extension.form.field.shim.controls = {}

ax.extension.form.field.shim.
fieldset = function( f, options={} ) {

  let a = ax.a
  let x = ax.x

  let fieldsetTagOptions = {
    ...options.fieldsetTag,
    style: {
      display: 'block',
      ...( options.fieldsetTag || {} ).style
    }
  }

  let control = a['|appkit-form-control']( [
    options.legend ? a.legend( options.legend, options.legendTag ) : null,
    options.body || null,
  ], {
    $controls: function() {
      return x.lib.unnested( this, '|appkit-form-control' )
    },
    $buttons: function() {
      return this.$$('button').$$
    },
    $disable: function() {
      let controls = [ ...this.$controls(), ...this.$buttons() ]
      for ( let i in controls ) {
        controls[i].$disable && controls[i].$disable()
      }
    },
    $enable: function() {
      let controls = [ ...this.$controls(), ...this.$buttons() ]
      for ( let i in controls ) {
        controls[i].$enable && controls[i].$enable()
      }
    },
    $focus: function() {
      let first = this.$controls()[0]
      if ( first ) first.$focus()
    },
  } )

  options.label = options.label ? options.label : false

  return a['fieldset|appkit-form-fieldset']( [
    this.field.header( f, options ),
    a['|appkit-form-field-body']( [
      f.help( options ),
      control,
      f.hint( options ),
    ], options.bodyTag ),
  ], fieldsetTagOptions )

}

ax.extension.form.field.shim.
hint = function( options={} ) {

  let a = ax.a

  let hint = options.hint

  return hint ? a.small( a['|appkit-form-field-hint']( hint, options.hintTag ) ) : null

}

ax.extension.form.field.shim.
helpbutton = function( options={} ) {

  let a = ax.a
  let x = ax.x

  return a['|appkit-form-field-helpbutton']( null, {
    $state: false,
    $nodes: ( el, show ) => {
      return a['|appkit-form-field-helpbutton-text'](
        el.show ? ' ❓ ✖ ' : ' ❓ '
      )
    },
    ...options.helpbuttonTag,
    $on: {
      'click: toggle help': function() {
        this.$state = !this.$state
        this.$('^|appkit-form-field', '|appkit-form-field-help').$toggle()
      },
      ...( options.helpbuttonTag || [] ).$on,
    },
    style: {
      cursor: 'help',
      ...( options.helpbuttonTag || {} ).style,
    }
  } )

}

ax.extension.report.field.shim.
control = function( r, options={} ) {

  let a = ax.a
  let x = ax.x

  let as = ( options.as || '' ).split( '/' )
  let control = options.control || as[0] || 'string'
  let type = options.type || as[1]

  let controlFn = r.controls[control]
  if ( !controlFn ) ax.throw( `Report field factory does not support control '${ control }'.` )

  let key = options.key || ''

  options.name = options.name || ( r.scope ?
    `${ r.scope }[${ key }]` :
    key )

  let object = r.object || {}

  if ( ax.is.not.undefined( object[key] ) ) {
    options.value = object[key]
  }

  let controlOptions = {
    ...options,
    type: type,
    ...options[control]
  }

  return controlFn( controlOptions )

}

ax.extension.report.field.shim.
label = function( options={} ) {

  let a = ax.a
  let x = ax.x
  let lib = x.lib

  if ( ax.is.boolean( options.label ) && !options.label ) return null

  let label = options.label || lib.text.labelize( options.key )
  let component = a.label( label, options.labelTag )

  let labelWrapperTag = {

    ...options.labelWrapperTag,

    $on: {
      'click: focus on output': function() {
        let target = this.$( '^|appkit-report-field |appkit-report-control' )
        target.$focus()
      },
      ...( options.labelWrapperTag || {} ).$on,
    },

  }

  return a['|appkit-report-field-label-wrapper']( component, labelWrapperTag )

}

ax.extension.report.field.shim.
field = function( r, options={} ) {

  let a = ax.a
  let x = ax.x

  let fieldTagOptions = {
    ...options.fieldTag,
    style: {
      display: 'block',
      ...( options.fieldTag || {} ).style
    }
  }

  return a['|appkit-report-field']( [
    this.field.header( r, options ),
    a['|appkit-report-field-body']( [
      r.help( options ),
      r.control( {
        ...options,
        label: '',
        labelTag: {},
      } ),
      r.hint( options ),
    ], options.bodyTag ),
  ], fieldTagOptions )

}

ax.extension.report.field.shim.
help = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let help = options.help

  return help ? a['|appkit-report-field-help-wrapper'](
    a['|appkit-report-field-help']( help, {
      $toggle: function () {
        x.lib.animate.fade.toggle( this )
      },
      ...options.helpTag,
      style: {
        display: 'none',
        ...( options.helpTag || {} ).style,
      }
    } ),
    {
      ...options.helpWrapper,
      style: {
        display: 'block',
        ...( options.helpWrapper || {} ).style,
      }
    }
  ) : null

}

ax.extension.report.field.shim.controls = {}

ax.extension.report.field.shim.
hint = function( options={} ) {

  let a = ax.a

  let hint = options.hint

  return hint ? a.small( a['|appkit-report-field-hint']( hint, options.hintTag ) ) : null

}

ax.extension.report.field.shim.
helpbutton = function( options={} ) {

  let a = ax.a
  let x = ax.x

  return a['|appkit-report-field-helpbutton']( null, {
    $state: false,
    $nodes: function() {
      return a['|appkit-report-field-helpbutton-text'](
        this.$state ? ' ❓ ✖ ' : ' ❓ '
      )
    },
    $on: { 'click: toggle help': function() {
      this.$state = !this.$state
      this.$('^|appkit-report-field', '|appkit-report-field-help').$toggle()
    } },
    ...options.helpbuttonTag,
    style: {
      cursor: 'help',
      ...( options.helpbuttonTag || {} ).style,
    }
  } )

}

ax.extension.form.field.shim.field.
header = function( f, options={} ) {

  if ( options.type == 'hidden' ) {

    return null

  } else {

    let component

    if ( options.header == true ) {
      options.header = null
    }

    if ( options.header ) {
      component = header
    } else {
      let caption = options.label === false ? null : f.label( options )
      if ( options.help ) {
        component = [ caption, f.helpbutton( options ) ]
      } else {
        component = caption
      }
    }

    return ax.a['|appkit-form-field-header'](
      component,
      {
        ...options.headerTag
      }
    )

  }



}

ax.extension.form.field.shim.field.
collection = function( f, control, options={} ) {

  let a = ax.a
  let x = ax.x

  let values = x.lib.form.collection.value( options.value )

  let itemFn = ( value ) => a['|appkit-form-collection-item']( [
    a['|appkit-form-collection-item-header'](
      a['|appkit-form-collection-item-buttons']( [
        options.stationary ? null : x.form.field.shim.field.collection.up( f, options.upButton || {} ),
        options.stationary ? null : x.form.field.shim.field.collection.down( f, options.downButton || {} ),
        options.confined ? null : x.form.field.shim.field.collection.remove( f, {
          item: options.item,
          ...options.removeButton
        } ),
      ], options.itemButtonsTag ),
      options.itemHeaderTag
    ),
    a['|appkit-form-collection-item-body'](
      control( {
        ...options,
        name: `${ options.name }[]`,
        value: value,
      } ),
      options.itemBodyTag,
    ),
  ], options.itemTag )

  let components = values.map( value => itemFn( value ) )

  let controlTagOptions = {

    $value: function() {
      return this.$$('input').value.$$
    },

    $focus: function () {
      this.$('input').focus()
    },

    $disable: function() {
      let inputs = this.$$('input').$$
      for ( let input of inputs ) {
        input.setAttribute( 'disabled', 'disabled' )
      }
    },

    $enable: function() {
      if ( !options.disabled ) {
        let inputs = this.$$('input').$$
        for ( let input of inputs ) {
          input.removeAttribute('disabled')
        }
      }
    },

    ...options.controlTag,

  }

  return a['|appkit-form-control'](
    a['|appkit-form-collection'](
      [
        a['bananas|appkit-form-collection-items'](
          components,
          {
            $add: function() {
              this.append( itemFn() )
            },
            ...options.itemsTag,
          }
        ),
        options.confined ? null : x.form.field.shim.field.collection.add( f, {
          item: options.item,
          ...options.addButton
        } )
      ],
      options.collectionTag
    ),
    controlTagOptions
  )

}

ax.extension.form.field.shim.controls.
checkboxes = function( f, options ) {

  let a = ax.a

  let checkboxesOptions = {
    ...options,
    ...options.checkboxes
  }

  let controlTagOptions = {

    name: options.name,

    $value: function() {
      return this.$$('input:checked').value.$$
    },

    $focus: function () {
      this.$('input').focus()
    },

    $controls: function() {
      return this.$$( '|appkit-form-control' ).$$
    },

    $inputs: function() {
      return this.$$( 'input' ).$$
    },

    $disable: function() {
      for ( let input of this.$inputs() ) {
        input.setAttribute( 'disabled', 'disabled' )
      }
    },

    $enable: function() {
      if ( !checkboxesOptions.disabled ) {
        for ( let input of this.$inputs() ) {
          if ( !input.$properties.disabled ) {
            input.removeAttribute( 'disabled' )
          }
        }
      }
    },

    ...options.controlTag,

    $on: {
      'click: do nothing when readonly': (e) => { if ( checkboxesOptions.readonly ) e.preventDefault() },
      'change: send control change event': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  return a['|appkit-form-control'](
    a['|appkit-form-control-checkboxes'](
      f.checkboxes( checkboxesOptions ),
      options.checkboxesTag
    ),
    controlTagOptions
  )

}

ax.extension.form.field.shim.controls.
textarea = ( f, options={} ) => {

  let a = ax.a
  let x = ax.x

  let textareaOptions = {
    ...options,
    ...options.textarea
  }

  let controlTagOptions = {

    $value: function() {
      return this.$('textarea').value
    },

    $focus: function () {
      this.$('textarea').focus()
    },

    $disable: function() {
      this.$('textarea').setAttribute( 'disabled', 'disabled' )
    },

    $enable: function() {
      if ( !textareaOptions.disabled ) {
        this.$('textarea').removeAttribute('disabled')
      }
    },

    ...options.controlTag,

    $on: {
      'input: send control change event': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  return a['|appkit-form-control'](
    f.textarea( textareaOptions ),
    controlTagOptions
  )

}

ax.extension.form.field.shim.controls.
input = function( f, options ) {

  let a = ax.a

  let inputOptions = {
    ...options,
    ...options.input
  }

  let controlTagOptions = {

    $init: function () { this.$valid() },

    $value: function() {
      return this.$('input').value
    },

    $focus: function () {
      this.$('input').focus()
    },

    $disable: function() {
      for ( let input of this.$$('input').$$ ) {
        input.setAttribute( 'disabled', 'disabled' )
      }
    },

    $enable: function() {
      if ( !inputOptions.disabled ) {
        for ( let input of this.$$('input').$$ ) {
          input.removeAttribute('disabled')
        }
      }
    },

    $validity: function() {
      return this.$('input').validity
    },

    $valid: function() {
      this.$('input').setCustomValidity('')
      if( this.$validity().valid ) {
        return true
      } else {
        if ( inputOptions.invalid ) {
          if ( ax.is.function( inputOptions.invalid ) ) {
            let invalidMessage = inputOptions.invalid( this.$value, this.$validity() )
            if ( invalidMessage ) {
              this.$('input').setCustomValidity( invalidMessage )
            }
          } else {
            this.$('input').setCustomValidity( inputOptions.invalid )
          }
        }
        return false
      }
    },

    ...options.controlTag,

    $on: {
      'input: check validity': (e,el) => {
        el.$valid()
      },
      'input: send control change event': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  return a['|appkit-form-control'](
    f.input( inputOptions ),
    controlTagOptions
  )

}

ax.extension.form.field.shim.controls.
checkbox = function( f, options ) {

  let a = ax.a

  let checkboxOptions = {
    ...options,
    ...options.checkbox
  }

  // let hiddenInputOptions = {
  //   type: 'hidden',
  //   name: options.name,
  //   value: options.unchecked,
  // }

  let controlTagOptions = {

    $init: function () { this.$valid() },

    $value: function() {
      if ( this.$('input').checked ) {
        return this.$('input').value
      // } else {
      //   return checkboxOptions.unchecked
    } else {
      return ''
    }
    },

    $focus: function () {
      this.$('input').focus()
    },

    $disable: function() {
      let inputs = this.$$('input').$$
      for ( let input of inputs ) {
        input.setAttribute( 'disabled', 'disabled' )
      }
    },

    $enable: function() {
      if ( !checkboxOptions.disabled ) {
        let inputs = this.$$('input').$$
        for ( let input of inputs ) {
          input.removeAttribute('disabled')
        }
        // this.$processUnchecked()
      }
    },

    // $processUnchecked: function() {
    //   if ( this.$('input[type=checkbox]').checked ) {
    //     this.$('input[type=hidden]').setAttribute( 'disabled', 'disabled' )
    //   } else {
    //     this.$('input[type=hidden]').removeAttribute('disabled')
    //   }
    // },

    $validity: function() {
      return this.$('input').validity
    },

    $valid: function() {
      this.$('input').setCustomValidity('')
      if( this.$validity().valid ) {
        // this.$processUnchecked()
        return true
      } else {
        if ( checkboxOptions.invalid ) {
          if ( ax.is.function( checkboxOptions.invalid ) ) {
            let invalidMessage = checkboxOptions.invalid( this.$value, this.$validity() )
            if ( invalidMessage ) {
              this.$('input').setCustomValidity( invalidMessage )
            }
          } else {
            this.$('input').setCustomValidity( checkboxOptions.invalid )
          }
        }
        return false
      }
    },

    ...options.controlTag,

    $on: {
      'input: check validity': (e,el) => {
        el.$valid()
      },
      'input: send control change event': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  return a['|appkit-form-control']( [
    // f.input( hiddenInputOptions ),
    f.checkbox( checkboxOptions ),
  ], controlTagOptions )

}

ax.extension.form.field.shim.controls.
radios = function( f, options ) {

  let a = ax.a

  let radiosOptions = {
    ...options,
    ...options.radios
  }

  let controlTagOptions = {

    $init: function () { this.$valid() },

    $value: function() {
      return this.$('input:checked').value
    },

    $focus: function () {
      this.$('input').focus()
    },

    $inputs: function() {
      return this.$$( 'input' ).$$
    },

    $disable: function() {
      for ( let input of this.$inputs() ) {
        input.setAttribute( 'disabled', 'disabled' )
      }
    },

    $enable: function() {
      if ( !radiosOptions.disabled ) {
        for ( let input of this.$inputs() ) {
          if ( !input.$properties.disabled ) {
            input.removeAttribute( 'disabled' )
          }
        }
      }
    },

    $validity: function() {
      return this.$('input').validity
    },

    $valid: function() {
      this.$('input').setCustomValidity('')
      if( this.$validity().valid ) {
        return true
      } else {
        if ( radiosOptions.invalid ) {
          if ( ax.is.function( radiosOptions.invalid ) ) {
            let invalidMessage = radiosOptions.invalid( this.$value, this.$validity() )
            if ( invalidMessage ) {
              this.$('input').setCustomValidity( invalidMessage )
            }
          } else {
            this.$('input').setCustomValidity( radiosOptions.invalid )
          }
        }
        return false
      }
    },


    ...options.controlTag,

    $on: {
      'click: do nothing when readonly': (e) => { if ( radiosOptions.readonly ) e.preventDefault() },
      'input: check validity': (e,el) => {
        el.$valid()
      },
      'change: send control change event': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  return a['|appkit-form-control'](
    f.radios( radiosOptions ),
    controlTagOptions
  )

}

ax.extension.form.field.shim.controls.
select = function( f, options ) {

  let a = ax.a

  let selectOptions = {
    ...options,
    ...options.select
  }

  let controlTagOptions = {

    $init: function () { this.$valid() },


    $value: function() {
      // if ( selectOptions.multiple ) {
      //   let checked = this.$$('option:checked').value.$$
      //   checked = checked.filter( (el) => el != '' )
      //   return checked
      // } else {
        return this.$('select').value
      // }
    },

    $focus: function () {
      this.$('select').focus()
    },

    $disable: function() {
      this.$('select').setAttribute( 'disabled', 'disabled' )
    },

    $enable: function() {
      if ( !selectOptions.disabled ) {
        this.$('select').removeAttribute('disabled')
      }
    },

    $validity: function() {
      return this.$('select').validity
    },

    $valid: function() {
      this.$('select').setCustomValidity('')
      if( this.$validity().valid ) {
        return true
      } else {
        if ( selectOptions.invalid ) {
          if ( ax.is.function( selectOptions.invalid ) ) {
            let invalidMessage = selectOptions.invalid( this.$value, this.$validity )
            if ( invalidMessage ) {
              this.$('select').setCustomValidity( invalidMessage )
            }
          } else {
            this.$('select').setCustomValidity( selectOptions.invalid )
          }
        }
        return false
      }
    },

    ...options.controlTag,

    $on: {
      'click: do nothing when readonly': (e) => { if ( selectOptions.readonly ) e.preventDefault() },
      'change: check validity': (e,el) => {
        el.$valid()
      },
      'change: send control change event': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  return a['|appkit-form-control'](
    f.select( selectOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.shim.field.
header = function( r, options={} ) {

  if ( options.type == 'hidden' ) {

    return null

  } else {

    let component

    if ( options.header == true ) {
      options.header = null
    }

    if ( options.header ) {
      component = header
    } else {
      let caption = r.label( options )
      if ( options.help ) {
        component = [ caption, r.helpbutton( options ) ]
      } else {
        component = caption
      }
    }

    return ax.a['|appkit-report-field-header'](
      component,
      {
        ...options.headerTag
      }
    )

  }



}

ax.extension.report.field.shim.controls.
checkboxes = function( r, options ) {

  let a = ax.a

  let checkboxesOptions = {
    ...options,
    ...options.checkboxes
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },


    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    r.checkboxes( checkboxesOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.shim.controls.
text = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let textOptions = {
    ...options,
    ...options.text
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,


  }

  return a['|appkit-report-control'](
    r.text( textOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.shim.controls.
checkbox = function( r, options ) {

  let a = ax.a

  let checkboxOptions = {
    // name: options.name,
    // value: options.value,
    //
    ...options,
    ...options.checkbox
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    r.checkbox( checkboxOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.shim.controls.
radios = function( r, options ) {

  let a = ax.a

  let radiosOptions = {
    ...options,
    ...options.radios
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    r.radios( radiosOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.shim.controls.
string = function( r, options ) {

  let a = ax.a

  let stringOptions = {
    // name: options.name,
    // value: options.value,
    // placeholder: options.placeholder,
    ...options,
    ...options.string
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    r.string( stringOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.shim.controls.
output = function( r, options={} ) {

  let a = ax.a
  let x = ax.x

  let outputOptions = {
    ...options,
    ...options.output
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,


  }

  return a['|appkit-report-control'](
    r.output( outputOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.shim.controls.
select = function( r, options ) {

  let a = ax.a

  let selectOptions = {
    // name: options.name,
    // value: options.value,
    // selections: options.selections,
    // placeholder: options.placeholder,
    ...options,
    ...options.select,
    // selectTag: {
    //   tabindex: 0,
    //   ...( options.select || {} ).selectTag,
    // }
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    r.select( selectOptions ),
    controlTagOptions
  )

}

ax.extension.form.field.shim.field.collection.
down = function( f, options ) {

  return f.button( {
    label: '⏷',
    onclick: function (e,el) {
      var target = options.itemTarget ? options.itemTarget(el) : el.$('^|appkit-form-collecion-item')
      var next = target.nextSibling
      var parent = target.parentElement
      if ( next ) {
        parent.insertBefore( target, next.nextSibling )
        this.$send( 'axf.appkit.form.collecion.item.move' )
      }
    },
    ...options
  } )

}

ax.extension.form.field.shim.field.collection.
add = function( f, options ) {

  let label = `✚ Add${ options.item ? ` ${ options.item }`: '' }`

  return f.button( {
    label: label,
    onclick: (e,el) => {
      let itemsTag = options.target ? options.target(el) : el.$('^|appkit-form-collection |appkit-form-collection-items')
      itemsTag.$add()
      itemsTag.$send( 'axf.appkit.form.collection.item.add' )
    },
    ...options
  } )

}

ax.extension.form.field.shim.field.collection.
remove = function( f, options ) {

  let item = options.item || 'item'
  let confirmation

  if ( ax.is.false( options.confirm ) ) {
    confirmation = false
  } else if ( ax.is.string( options.confirm ) || ax.is.function( options.confirm ) ) {
    confirmation = options.confirm
  } else {
    confirmation = `Are you sure that you want to remove this ${ item }?`
  }

  return f.button( {
    label: '✖',
    confirm: confirmation,
    onclick: function (e,el) {
      var target = el.$('^|appkit-form-collection-item')
      let parent = target.parentElement
      let index = Array.prototype.indexOf.call( parent.children, target )
      target.remove()
      let length = parent.children.length
      parent.$send( 'axf.appkit.form.collection.item.remove', { detail: {
        target: el,
        index: index,
        length: length,
      } } )
    },
    ...options
  } )

}

ax.extension.form.field.shim.field.collection.
up = function( f, options ) {

  return f.button( {
    label: '⏶',
    onclick: function (e,el) {
      var target = options.itemTarget ? options.itemTarget(el) : el.$('^|appkit-form-collection-item')
      var previous = target.previousSibling
      var parent = target.parentElement
      if ( previous ) {
        parent.insertBefore( target, previous )
        this.$send( 'axf.appkit.form.collection.item.move' )
      }
    },
    ...options
  } )

}

ax.extension.form.field.dependent = {}

ax.extension.report.field.dependent = {}

ax.extension.form.field.dependent.shim = function() {

  let x = ax.x

  return {

    field: ( f, target ) => ( options={} ) => {
      return this.shim.dependent( {
        body: target( options ),
        scope: f.scope,
        dependent: options.dependent,
      } )
    },

    fieldset: ( f, target ) => ( options={} ) => {
      return this.shim.dependent( {
        body: target( options ),
        scope: f.scope,
        dependent: options.dependent,
      } )
    },

    dependent: ( f, target ) => ( options={} ) => {

      return this.shim.dependent( {
        scope: f.scope,
        ...options
      } )
    },

    form: ( f, target ) => ( options={} ) => target( {
      ...options,
      formTag: {
        ...options.formTag,
        $init: function() {
          options.formTag && options.formTag.$init && options.formTag.$init.bind( this )( arguments )
          this.$checkDependents()
        },
        $checkDependents: function() {
          let dependents = x.lib.unnested( this, '|appkit-form-field-dependent' )
          for ( let i in dependents ) {
            dependents[i].$check()
          }
        },
      },
    } ),

    items: ( f, target ) => ( options={} ) => target( {
      ...options,
      itemsTag: {
        ...options.itemsTag,
        $on: {
          'axf.appkit.form.nest.item.add: check dependents on new item': (e,el) => {
            let newItem = el.$$('|appkit-form-nest-item').$$.reverse()[0]
            let dependents = x.lib.unnested( newItem, '|appkit-form-field-dependent' )
            for ( let i in dependents ) {
              dependents[i].$check()
            }
          },
          ...( options.itemsTag || {} ).$on
        },
      },
    } ),



  }

}

ax.extension.form.field.dependent.collect = options => {

  let x = ax.x

  let collection

  if ( ax.is.string( options.dependent ) ) {
    collection = [ { key: options.dependent } ]
  } else if ( ax.is.array( options.dependent ) ) {
    collection = options.dependent
  } else if ( ax.is.object( options.dependent ) ) {
    collection = [ options.dependent ]
  } else {
    collection = []
  }

  let nameFor = ( scope, key ) => {
    let dismantle = x.lib.name.dismantle
    let parts = [ ...dismantle( scope || '' ), ...dismantle( key ) ]
    while ( parts.indexOf( '..' ) >= 0 ) {
      let index = parts.indexOf( '..' )
      parts.splice( index, 1 )
      if ( index > 0 ) parts.splice( index - 1, 1 )
    }
    let name = parts.shift()
    if ( parts.length ) name = `${ name }[${ parts.join('][') }]`
    return name
  }

  for ( let item of collection ) {
    if ( item.key ) {
      item.name = nameFor( options.scope, item.key )
    }
  }

  return collection

}

ax.extension.report.field.dependent.shim = function() {

  let x = ax.x

  return {

    field: ( r, target ) => ( options={} ) => {
      return this.shim.dependent( {
        body: target( options ),
        scope: r.scope,
        dependent: options.dependent,
      } )
    },

    fieldset: ( r, target ) => ( options={} ) => {
      return this.shim.dependent( {
        body: target( options ),
        scope: r.scope,
        dependent: options.dependent,
      } )
    },

    dependent: ( r, target ) => ( options={} ) => {
      return this.shim.dependent( {
        scope: r.scope,
        ...options
      } )
    },


  }

}

ax.extension.form.field.dependent.shim.
dependent = function( options ) {

  let a = ax.a
  let x = ax.x

  let optionsCollection = x.form.field.dependent.collect( options )

  let dependentTag = {
    $init: function () {
      this.$dependencies = optionsCollection.map(
        options => ( {
          field: x.form.field.dependent.shim.dependent.dependency( this, options ),
          value: options.value,
          pattern: options.pattern,
        } )
      )
      for ( let dependency of this.$dependencies ) {
        dependency.field.$registerDependent( this )
      }
    },
    $registerDependent: function( dependent ) {
      this.$dependents.push( dependent )
    },
    $hide: function() {
      this.style.display = 'none'
      this.$('|appkit-form-control').$disable()
      let dependents = x.lib.unnested( this, '|appkit-form-field-dependent' )
      for ( let i in dependents ) {
        dependents[i].$hide()
      }
    },
    $show: function() {
      this.$('|appkit-form-control').$enable()
      if ( !options.animate ) {
        this.style.display = 'block'
      } else {
        x.lib.animate.fade.in( this )
      }
      let dependents = x.lib.unnested( this, '|appkit-form-field-dependent' )
      for ( let i in dependents ) {
        dependents[i].$check()
      }
    },
    $dependents: [],
    $value: function() {
      return this.$('|appkit-form-control').$value()
    },
    $match: function() {
      if ( ax.is.undefined( this.$matched ) ) {
        if ( this.$dependencies.length ) {
          for ( let dependency of this.$dependencies ) {
            if ( x.form.field.dependent.shim.dependent.match( dependency ) ) {
              this.$matched = true
              return true
            }
          }
          this.$matched = false
          return false
        } else {
          this.$matched = true
          return true
        }
      } else {
        return this.$matched
      }
    },
    $check: function() {
      if ( this.$match() ) {
        this.$show()
      } else {
        this.$hide()
      }
    },
    $reset: function() {
      this.$matched = undefined
      for ( let dependent of this.$dependents ) {
        dependent.$reset()
      }
    },
    $checkDependents: function() {
      for ( let dependent of this.$dependents ) {
        dependent.$reset()
        dependent.$check()
      }
    },
    ...options.dependentTag,
    style: {
      display: 'none',
      ...( options.dependentTag || {} ).style,
    },
    $on: {
      'axf.appkit.form.control.change': (e,el) => {
        el.$checkDependents()
      },
      ...( options.dependentTag || {} ).$on,
    },
  }

  return a['|appkit-form-field-dependent']( options.body, dependentTag )

}

ax.extension.report.field.dependent.shim.
dependent = function( options ) {

  let a = ax.a
  let x = ax.x

  let optionsCollection = x.form.field.dependent.collect( options )

  let dependentTag = {
    $init: function () {
      this.$dependencies = optionsCollection.map(
        options => ( {
          field: x.report.field.dependent.shim.dependent.dependency( this, options ),
          value: options.value,
          pattern: options.pattern,
        } )
      )
      this.$check()
    },
    $hide: function() {
      this.style.display = 'none'
    },
    $show: function() {
      this.style.display = 'block'
    },
    $value: function() {
      return this.$('|appkit-report-control').$value()
    },
    $match: function() {
      if ( ax.is.undefined( this.$matched ) ) {
        if ( this.$dependencies.length ) {
          for ( let dependency of this.$dependencies ) {
            if ( x.form.field.dependent.shim.dependent.match( dependency ) ) {
              this.$matched = true
              return true
            }
          }
          this.$matched = false
          return false
        } else {
          this.$matched = true
          return true
        }
      } else {
        return this.$matched
      }
    },
    $check: function() {
      if ( this.$match() ) {
        this.$show()
      } else {
        this.$hide()
      }
    },
    ...options.dependentTag,
    style: {
      display: 'none',
      ...( options.dependentTag || {} ).style,
    },
  }

  return a['|appkit-report-field-dependent']( options.body, dependentTag )

}

ax.extension.form.field.dependent.shim.
dependent.dependency = ( el, options ) => {

  let selector

  if ( options.selector ) {
    selector = options.selector
  } else {
    let name = options.name
    selector = `[name="${ name }"]`
  }

  let search = options.search || '^form'

  let target = el.$( search ).$( selector )
  let targetDependency

  if ( target ) {
    targetDependency = target.$('^|appkit-form-field-dependent')
  }

  if ( targetDependency ) {
    return targetDependency
  } else {
    console.error( el, `Form field failed to find a dependency target using options:`, options )
  }

}

ax.extension.form.field.dependent.shim.
dependent.match = function( options ) {

  let field = options.field

  if ( field.$match() ) {

    let fieldValue = field.$value()

    if ( options.value ) {
      return fieldValue === options.value
    } else if ( options.pattern ) {
      return new RegExp( options.pattern || '.*' ).test( fieldValue.toString() )
    } else if ( ax.is.array( fieldValue ) ) {
      return fieldValue.length > 0
    } else {
      return !!fieldValue
    }

  } else {
    return false
  }

}

ax.extension.report.field.dependent.shim.
dependent.dependency = ( el, options ) => {

  let selector

  if ( options.selector ) {
    selector = options.selector
  } else {
    let name = options.name
    selector = `[data-name='${ name }']`
  }

  let search = options.search || '^|appkit-report'

  let target = el.$( search ).$( selector )
  let targetDependency

  if ( target ) {
    targetDependency = target.$('^|appkit-report-field-dependent')
  }

  if ( targetDependency ) {
    return targetDependency
  } else {
    console.error( `Report field failed to find a dependency target using options:`, options )
  }

}

// ax.extension.report.field.dependent.shim.
// dependent.match = function( el, options ) {
//
//   let field = el.$field
//
//   if ( field.$match() ) {
//
//     let fieldValue = field.$value()
//
//     if ( options.value ) {
//       return fieldValue == options.value
//     } else if ( options.pattern ) {
//       return new RegExp( options.pattern || '' ).
//       test( fieldValue.toString() )
//     } else {
//       if ( ax.is.array( fieldValue ) ) {
//         return fieldValue.length > 0
//       } else {
//         return !!fieldValue
//       }
//     }
//
//   } else {
//     return false
//   }
//
// }

ax.extension.lib.locale = {}

ax.extension.form.field.extras = {}

ax.extension.report.field.extras = {}

ax.extension.lib.locale.timezones = {
  'Pacific/Pago_Pago': '(GMT-11:00) American Samoa',
  'Pacific/Midway': '(GMT-11:00) Midway Island',
  'Pacific/Honolulu': '(GMT-10:00) Hawaii',
  'America/Juneau': '(GMT-09:00) Alaska',
  'America/New_York': '(GMT-05:00) Eastern Time (US & Canada)',
  'America/Tijuana': '(GMT-08:00) Tijuana',
  'America/Phoenix': '(GMT-07:00) Arizona',
  'America/Chihuahua': '(GMT-07:00) Chihuahua',
  'America/Mazatlan': '(GMT-07:00) Mazatlan',
  'America/Guatemala': '(GMT-06:00) Central America',
  'America/Mexico_City': '(GMT-06:00) Mexico City',
  'America/Monterrey': '(GMT-06:00) Monterrey',
  'America/Regina': '(GMT-06:00) Saskatchewan',
  'America/Bogota': '(GMT-05:00) Bogota',
  'America/Indiana/Indianapolis': '(GMT-05:00) Indiana (East)',
  'America/Lima': '(GMT-05:00) Quito',
  'America/Halifax': '(GMT-04:00) Atlantic Time (Canada)',
  'America/Caracas': '(GMT-04:00) Caracas',
  'America/Guyana': '(GMT-04:00) Georgetown',
  'America/La_Paz': '(GMT-04:00) La Paz',
  'America/Santiago': '(GMT-04:00) Santiago',
  'America/St_Johns': '(GMT-03:30) Newfoundland',
  'America/Sao_Paulo': '(GMT-03:00) Brasilia',
  'America/Argentina/Buenos_Aires': '(GMT-03:00) Buenos Aires',
  'America/Godthab': '(GMT-03:00) Greenland',
  'America/Montevideo': '(GMT-03:00) Montevideo',
  'Atlantic/South_Georgia': '(GMT-02:00) Mid-Atlantic',
  'Atlantic/Azores': '(GMT-01:00) Azores',
  'Atlantic/Cape_Verde': '(GMT-01:00) Cape Verde Is.',
  'Africa/Casablanca': '(GMT+00:00) Casablanca',
  'Europe/Dublin': '(GMT+00:00) Dublin',
  'Europe/London': '(GMT+00:00) London',
  'Europe/Lisbon': '(GMT+00:00) Lisbon',
  'Africa/Monrovia': '(GMT+00:00) Monrovia',
  'Etc/UTC': '(GMT+00:00) UTC',
  'Europe/Amsterdam': '(GMT+01:00) Amsterdam',
  'Europe/Belgrade': '(GMT+01:00) Belgrade',
  'Europe/Berlin': '(GMT+01:00) Berlin',
  'Europe/Zurich': '(GMT+01:00) Zurich',
  'Europe/Bratislava': '(GMT+01:00) Bratislava',
  'Europe/Brussels': '(GMT+01:00) Brussels',
  'Europe/Budapest': '(GMT+01:00) Budapest',
  'Europe/Copenhagen': '(GMT+01:00) Copenhagen',
  'Europe/Ljubljana': '(GMT+01:00) Ljubljana',
  'Europe/Madrid': '(GMT+01:00) Madrid',
  'Europe/Paris': '(GMT+01:00) Paris',
  'Europe/Prague': '(GMT+01:00) Prague',
  'Europe/Rome': '(GMT+01:00) Rome',
  'Europe/Sarajevo': '(GMT+01:00) Sarajevo',
  'Europe/Skopje': '(GMT+01:00) Skopje',
  'Europe/Stockholm': '(GMT+01:00) Stockholm',
  'Europe/Vienna': '(GMT+01:00) Vienna',
  'Europe/Warsaw': '(GMT+01:00) Warsaw',
  'Africa/Algiers': '(GMT+01:00) West Central Africa',
  'Europe/Zagreb': '(GMT+01:00) Zagreb',
  'Europe/Athens': '(GMT+02:00) Athens',
  'Europe/Bucharest': '(GMT+02:00) Bucharest',
  'Africa/Cairo': '(GMT+02:00) Cairo',
  'Africa/Harare': '(GMT+02:00) Harare',
  'Europe/Helsinki': '(GMT+02:00) Helsinki',
  'Asia/Jerusalem': '(GMT+02:00) Jerusalem',
  'Europe/Kaliningrad': '(GMT+02:00) Kaliningrad',
  'Europe/Kiev': '(GMT+02:00) Kyiv',
  'Africa/Johannesburg': '(GMT+02:00) Pretoria',
  'Europe/Riga': '(GMT+02:00) Riga',
  'Europe/Sofia': '(GMT+02:00) Sofia',
  'Europe/Tallinn': '(GMT+02:00) Tallinn',
  'Europe/Vilnius': '(GMT+02:00) Vilnius',
  'Asia/Baghdad': '(GMT+03:00) Baghdad',
  'Europe/Istanbul': '(GMT+03:00) Istanbul',
  'Asia/Kuwait': '(GMT+03:00) Kuwait',
  'Europe/Minsk': '(GMT+03:00) Minsk',
  'Europe/Moscow': '(GMT+03:00) St. Petersburg',
  'Africa/Nairobi': '(GMT+03:00) Nairobi',
  'Asia/Riyadh': '(GMT+03:00) Riyadh',
  'Europe/Volgograd': '(GMT+03:00) Volgograd',
  'Asia/Tehran': '(GMT+03:30) Tehran',
  'Asia/Muscat': '(GMT+04:00) Muscat',
  'Asia/Baku': '(GMT+04:00) Baku',
  'Europe/Samara': '(GMT+04:00) Samara',
  'Asia/Tbilisi': '(GMT+04:00) Tbilisi',
  'Asia/Yerevan': '(GMT+04:00) Yerevan',
  'Asia/Kabul': '(GMT+04:30) Kabul',
  'Asia/Yekaterinburg': '(GMT+05:00) Ekaterinburg',
  'Asia/Karachi': '(GMT+05:00) Karachi',
  'Asia/Tashkent': '(GMT+05:00) Tashkent',
  'Asia/Kolkata': '(GMT+05:30) New Delhi',
  'Asia/Colombo': '(GMT+05:30) Sri Jayawardenepura',
  'Asia/Kathmandu': '(GMT+05:45) Kathmandu',
  'Asia/Almaty': '(GMT+06:00) Almaty',
  'Asia/Dhaka': '(GMT+06:00) Dhaka',
  'Asia/Urumqi': '(GMT+06:00) Urumqi',
  'Asia/Rangoon': '(GMT+06:30) Rangoon',
  'Asia/Bangkok': '(GMT+07:00) Hanoi',
  'Asia/Jakarta': '(GMT+07:00) Jakarta',
  'Asia/Krasnoyarsk': '(GMT+07:00) Krasnoyarsk',
  'Asia/Novosibirsk': '(GMT+07:00) Novosibirsk',
  'Asia/Shanghai': '(GMT+08:00) Beijing',
  'Asia/Chongqing': '(GMT+08:00) Chongqing',
  'Asia/Hong_Kong': '(GMT+08:00) Hong Kong',
  'Asia/Irkutsk': '(GMT+08:00) Irkutsk',
  'Asia/Kuala_Lumpur': '(GMT+08:00) Kuala Lumpur',
  'Australia/Perth': '(GMT+08:00) Perth',
  'Asia/Singapore': '(GMT+08:00) Singapore',
  'Asia/Taipei': '(GMT+08:00) Taipei',
  'Asia/Ulaanbaatar': '(GMT+08:00) Ulaanbaatar',
  'Asia/Tokyo': '(GMT+09:00) Tokyo',
  'Asia/Seoul': '(GMT+09:00) Seoul',
  'Asia/Yakutsk': '(GMT+09:00) Yakutsk',
  'Australia/Adelaide': '(GMT+09:30) Adelaide',
  'Australia/Darwin': '(GMT+09:30) Darwin',
  'Australia/Brisbane': '(GMT+10:00) Brisbane',
  'Australia/Melbourne': '(GMT+10:00) Melbourne',
  'Pacific/Guam': '(GMT+10:00) Guam',
  'Australia/Hobart': '(GMT+10:00) Hobart',
  'Pacific/Port_Moresby': '(GMT+10:00) Port Moresby',
  'Australia/Sydney': '(GMT+10:00) Sydney',
  'Asia/Vladivostok': '(GMT+10:00) Vladivostok',
  'Asia/Magadan': '(GMT+11:00) Magadan',
  'Pacific/Noumea': '(GMT+11:00) New Caledonia',
  'Pacific/Guadalcanal': '(GMT+11:00) Solomon Is.',
  'Asia/Srednekolymsk': '(GMT+11:00) Srednekolymsk',
  'Pacific/Auckland': '(GMT+12:00) Wellington',
  'Pacific/Fiji': '(GMT+12:00) Fiji',
  'Asia/Kamchatka': '(GMT+12:00) Kamchatka',
  'Pacific/Majuro': '(GMT+12:00) Marshall Is.',
  'Pacific/Chatham': '(GMT+12:45) Chatham Is.',
  'Pacific/Tongatapu': '(GMT+13:00) Nuku\'alofa',
  'Pacific/Apia': '(GMT+13:00) Samoa',
  'Pacific/Fakaofo': '(GMT+13:00) Tokelau Is.',
}

ax.extension.lib.locale.countries = {
  AF: 'Afghanistan',
  AL: 'Albania',
  DZ: 'Algeria',
  AS: 'American Samoa',
  AD: 'Andorra',
  AO: 'Angola',
  AQ: 'Antarctica',
  AG: 'Antigua and Barbuda',
  AR: 'Argentina',
  AM: 'Armenia',
  AW: 'Aruba',
  AU: 'Australia',
  AT: 'Austria',
  AZ: 'Azerbaijan',
  BS: 'Bahamas',
  BH: 'Bahrain',
  BD: 'Bangladesh',
  BB: 'Barbados',
  BY: 'Belarus',
  BE: 'Belgium',
  BZ: 'Belize',
  BJ: 'Benin',
  BM: 'Bermuda',
  BT: 'Bhutan',
  BO: 'Bolivia',
  BA: 'Bosnia and Herzegovina',
  BW: 'Botswana',
  BV: 'Bouvet Island',
  BR: 'Brazil',
  IO: 'British Indian Ocean Territory',
  BN: 'Brunei Darussalam',
  BG: 'Bulgaria',
  BF: 'Burkina Faso',
  BI: 'Burundi',
  KH: 'Cambodia',
  CM: 'Cameroon',
  CA: 'Canada',
  CV: 'Cape Verde',
  KY: 'Cayman Islands',
  CF: 'Central African Republic',
  TD: 'Chad',
  CL: 'Chile',
  CN: 'China',
  CX: 'Christmas Island',
  CC: 'Cocos (Keeling) Islands',
  CO: 'Colombia',
  KM: 'Comoros',
  CG: 'Congo',
  CD: 'Congo, The Democratic Republic of The',
  CK: 'Cook Islands',
  CR: 'Costa Rica',
  CI: 'CÔte D\'ivoire',
  HR: 'Croatia',
  CU: 'Cuba',
  CY: 'Cyprus',
  CZ: 'Czech Republic',
  DK: 'Denmark',
  DJ: 'Djibouti',
  DM: 'Dominica',
  DO: 'Dominican Republic',
  EC: 'Ecuador',
  EG: 'Egypt',
  SV: 'El Salvador',
  GQ: 'Equatorial Guinea',
  ER: 'Eritrea',
  EE: 'Estonia',
  ET: 'Ethiopia',
  FK: 'Falkland Islands (Malvinas)',
  FO: 'Faroe Islands',
  FJ: 'Fiji',
  FI: 'Finland',
  FR: 'France',
  GF: 'French Guiana',
  PF: 'French Polynesia',
  TF: 'French Southern Territories',
  GA: 'Gabon',
  GM: 'Gambia',
  GE: 'Georgia',
  DE: 'Germany',
  GH: 'Ghana',
  GI: 'Gibraltar',
  GR: 'Greece',
  GL: 'Greenland',
  GD: 'Grenada',
  GP: 'Guadeloupe',
  GU: 'Guam',
  GT: 'Guatemala',
  GN: 'Guinea',
  GW: 'Guinea Bissau',
  GY: 'Guyana',
  HT: 'Haiti',
  HM: 'Heard Island and Mcdonald Islands',
  HN: 'Honduras',
  HK: 'Hong Kong',
  HU: 'Hungary',
  IS: 'Iceland',
  IN: 'India',
  ID: 'Indonesia',
  IR: 'Iran, Islamic Republic of',
  IQ: 'Iraq',
  IE: 'Ireland',
  IL: 'Israel',
  IT: 'Italy',
  JM: 'Jamaica',
  JP: 'Japan',
  JO: 'Jordan',
  KZ: 'Kazakhstan',
  KE: 'Kenya',
  KI: 'Kiribati',
  KP: 'Korea, Democratic People\'s Republic of',
  KR: 'Korea, Republic of',
  KW: 'Kuwait',
  KG: 'Kyrgyzstan',
  LA: 'Lao People\'s Democratic Republic',
  LV: 'Latvia',
  LB: 'Lebanon',
  LS: 'Lesotho',
  LR: 'Liberia',
  LY: 'Libyan Arab Jamahiriya',
  LI: 'Liechtenstein',
  LT: 'Lithuania',
  LU: 'Luxembourg',
  MO: 'Macao',
  MK: 'Macedonia, The Former Yugoslav Republic of',
  MG: 'Madagascar',
  MW: 'Malawi',
  MY: 'Malaysia',
  MV: 'Maldives',
  ML: 'Mali',
  MT: 'Malta',
  MH: 'Marshall Islands',
  MQ: 'Martinique',
  MR: 'Mauritania',
  MU: 'Mauritius',
  YT: 'Mayotte',
  MX: 'Mexico',
  FM: 'Micronesia, Federated States of',
  MD: 'Monaco',
  MN: 'Mongolia',
  MS: 'Montserrat',
  MA: 'Morocco',
  MZ: 'Mozambique',
  MM: 'Myanmar',
  NA: 'Namibia',
  NR: 'Nauru',
  NP: 'Nepal',
  NL: 'Netherlands',
  AN: 'Netherlands Antilles',
  NC: 'New Caledonia',
  NZ: 'New Zealand',
  NI: 'Nicaragua',
  NE: 'Niger',
  NG: 'Nigeria',
  NU: 'Niue',
  NF: 'Norfolk Island',
  MP: 'Northern Mariana Islands',
  NO: 'Norway',
  OM: 'Oman',
  PK: 'Pakistan',
  PW: 'Palau',
  PS: 'Palestinian Territory, Occupied',
  PA: 'Panama',
  PG: 'Papua New Guinea',
  PY: 'Paraguay',
  PE: 'Peru',
  PH: 'Philippines',
  PN: 'Pitcairn',
  PL: 'Poland',
  PR: 'Puerto Rico',
  QA: 'Qatar',
  RE: 'RÉunion',
  RO: 'Romania',
  RU: 'Russian Federation',
  RW: 'Rwanda',
  SH: 'Saint Helena',
  KN: 'Saint Kitts and Nevis',
  LC: 'Saint Lucia',
  PM: 'Saint Pierre and Miquelon',
  VC: 'Saint Vincent and The Grenadines',
  WS: 'Samoa',
  SM: 'San Marino',
  ST: 'Sao Tome and Principe',
  SA: 'Saudi Arabia',
  SN: 'Senegal',
  CS: 'Serbia and Montenegro',
  SC: 'Seychelles',
  SL: 'Sierra Leone',
  SG: 'Singapore',
  SK: 'Slovakia',
  SI: 'Slovenia',
  SB: 'Solomon Islands',
  SO: 'Somalia',
  ZA: 'South Africa',
  GS: 'South Georgia and The South Sandwich Islands',
  ES: 'Spain',
  LK: 'Sri Lanka',
  SD: 'Sudan',
  SR: 'Suriname',
  SJ: 'Svalbard and Jan Mayen',
  SZ: 'Swaziland',
  SE: 'Sweden',
  CH: 'Switzerland',
  SY: 'Syrian Arab Republic',
  TW: 'Taiwan, Province of China',
  TJ: 'Tajikistan',
  TZ: 'Tanzania, United Republic of',
  TH: 'Thailand',
  TL: 'Timor Leste',
  TG: 'Togo',
  TK: 'Tokelau',
  TO: 'Tonga',
  TT: 'Trinidad and Tobago',
  TN: 'Tunisia',
  TR: 'Turkey',
  TM: 'Turkmenistan',
  TC: 'Turks and Caicos Islands',
  TV: 'Tuvalu',
  UG: 'Uganda',
  UA: 'Ukraine',
  AE: 'United Arab Emirates',
  GB: 'United Kingdom',
  US: 'United States',
  UM: 'United States Minor Outlying Islands',
  UY: 'Uruguay',
  UZ: 'Uzbekistan',
  VU: 'Vanuatu',
  VE: 'Venezuela',
  VN: 'Viet Nam',
  VG: 'Virgin Islands, British',
  VI: 'Virgin Islands, U.S.',
  WF: 'Wallis and Futuna',
  EH: 'Western Sahara',
  YE: 'Yemen',
  ZM: 'Zambia',
  ZW: 'Zimbabwe',
}

ax.extension.lib.locale.languages = {
  'ach': 'Acholi',
  'aa': 'Afar',
  'af': 'Afrikaans',
  'ak': 'Akan',
  'tw': 'Akan, Twi',
  'sq': 'Albanian',
  'am': 'Amharic',
  'ar': 'Arabic',
  'ar-BH': 'Arabic, Bahrain',
  'ar-EG': 'Arabic, Egypt',
  'ar-SA': 'Arabic, Saudi Arabia',
  'ar-YE': 'Arabic, Yemen',
  'an': 'Aragonese',
  'hy-AM': 'Armenian',
  'frp': 'Arpitan',
  'as': 'Assamese',
  'ast': 'Asturian',
  'tay': 'Atayal',
  'av': 'Avaric',
  'ae': 'Avestan',
  'ay': 'Aymara',
  'az': 'Azerbaijani',
  'ban': 'Balinese',
  'bal': 'Balochi',
  'bm': 'Bambara',
  'ba': 'Bashkir',
  'eu': 'Basque',
  'be': 'Belarusian',
  'bn': 'Bengali',
  'bn-IN': 'Bengali, India',
  'ber': 'Berber',
  'bh': 'Bihari',
  'bfo': 'Birifor',
  'bi': 'Bislama',
  'bs': 'Bosnian',
  'br-FR': 'Breton',
  'bg': 'Bulgarian',
  'my': 'Burmese',
  'ca': 'Catalan',
  'ceb': 'Cebuano',
  'ch': 'Chamorro',
  'ce': 'Chechen',
  'chr': 'Cherokee',
  'ny': 'Chewa',
  'zh-CN': 'Chinese Simplified',
  'zh-TW': 'Chinese Traditional',
  'zh-HK': 'Chinese Traditional, Hong Kong',
  'zh-MO': 'Chinese Traditional, Macau',
  'zh-SG': 'Chinese Traditional, Singapore',
  'cv': 'Chuvash',
  'kw': 'Cornish',
  'co': 'Corsican',
  'cr': 'Cree',
  'hr': 'Croatian',
  'cs': 'Czech',
  'da': 'Danish',
  'fa-AF': 'Dari',
  'dv': 'Dhivehi',
  'nl': 'Dutch',
  'nl-BE': 'Dutch, Belgium',
  'nl-SR': 'Dutch, Suriname',
  'dz': 'Dzongkha',
  'en': 'English',
  'en-AR': 'English, Arabia',
  'en-AU': 'English, Australia',
  'en-BZ': 'English, Belize',
  'en-CA': 'English, Canada',
  'en-CB': 'English, Caribbean',
  'en-CN': 'English, China',
  'en-DK': 'English, Denmark',
  'en-HK': 'English, Hong Kong',
  'en-IN': 'English, India',
  'en-ID': 'English, Indonesia',
  'en-IE': 'English, Ireland',
  'en-JM': 'English, Jamaica',
  'en-JA': 'English, Japan',
  'en-MY': 'English, Malaysia',
  'en-NZ': 'English, New Zealand',
  'en-NO': 'English, Norway',
  'en-PH': 'English, Philippines',
  'en-PR': 'English, Puerto Rico',
  'en-SG': 'English, Singapore',
  'en-ZA': 'English, South Africa',
  'en-SE': 'English, Sweden',
  'en-GB': 'English, United Kingdom',
  'en-US': 'English, United States',
  'en-ZW': 'English, Zimbabwe',
  'eo': 'Esperanto',
  'et': 'Estonian',
  'ee': 'Ewe',
  'fo': 'Faroese',
  'fj': 'Fijian',
  'fil': 'Filipino',
  'fi': 'Finnish',
  'vls-BE': 'Flemish',
  'fra-DE': 'Franconian',
  'fr': 'French',
  'fr-BE': 'French, Belgium',
  'fr-CA': 'French, Canada',
  'fr-LU': 'French, Luxembourg',
  'fr-QC': 'French, Quebec',
  'fr-CH': 'French, Switzerland',
  'fy-NL': 'Frisian',
  'fur-IT': 'Friulian',
  'ff': 'Fula',
  'gaa': 'Ga',
  'gl': 'Galician',
  'ka': 'Georgian',
  'de': 'German',
  'de-AT': 'German, Austria',
  'de-BE': 'German, Belgium',
  'de-LI': 'German, Liechtenstein',
  'de-LU': 'German, Luxembourg',
  'de-CH': 'German, Switzerland',
  'got': 'Gothic',
  'el': 'Greek',
  'el-CY': 'Greek, Cyprus',
  'kl': 'Greenlandic',
  'gn': 'Guarani',
  'gu-IN': 'Gujarati',
  'ht': 'Haitian Creole',
  'ha': 'Hausa',
  'haw': 'Hawaiian',
  'he': 'Hebrew',
  'hz': 'Herero',
  'hil': 'Hiligaynon',
  'hi': 'Hindi',
  'ho': 'Hiri Motu',
  'hmn': 'Hmong',
  'hu': 'Hungarian',
  'is': 'Icelandic',
  'ido': 'Ido',
  'ig': 'Igbo',
  'ilo': 'Ilokano',
  'id': 'Indonesian',
  'iu': 'Inuktitut',
  'ga-IE': 'Irish',
  'it': 'Italian',
  'it-CH': 'Italian, Switzerland',
  'ja': 'Japanese',
  'jv': 'Javanese',
  'quc': 'K\'iche\'',
  'kab': 'Kabyle',
  'kn': 'Kannada',
  'pam': 'Kapampangan',
  'ks': 'Kashmiri',
  'ks-PK': 'Kashmiri, Pakistan',
  'csb': 'Kashubian',
  'kk': 'Kazakh',
  'km': 'Khmer',
  'rw': 'Kinyarwanda',
  'tlh-AA': 'Klingon',
  'kv': 'Komi',
  'kg': 'Kongo',
  'kok': 'Konkani',
  'ko': 'Korean',
  'ku': 'Kurdish',
  'kmr': 'Kurmanji (Kurdish)',
  'kj': 'Kwanyama',
  'ky': 'Kyrgyz',
  'lol': 'LOLCAT',
  'lo': 'Lao',
  'la-LA': 'Latin',
  'lv': 'Latvian',
  'lij': 'Ligurian',
  'li': 'Limburgish',
  'ln': 'Lingala',
  'lt': 'Lithuanian',
  'jbo': 'Lojban',
  'nds': 'Low German',
  'dsb-DE': 'Lower Sorbian',
  'lg': 'Luganda',
  'luy': 'Luhya',
  'lb': 'Luxembourgish',
  'mk': 'Macedonian',
  'mai': 'Maithili',
  'mg': 'Malagasy',
  'ms': 'Malay',
  'ms-BN': 'Malay, Brunei',
  'ml-IN': 'Malayalam',
  'mt': 'Maltese',
  'gv': 'Manx',
  'mi': 'Maori',
  'arn': 'Mapudungun',
  'mr': 'Marathi',
  'mh': 'Marshallese',
  'moh': 'Mohawk',
  'mn': 'Mongolian',
  'sr-Cyrl-ME': 'Montenegrin (Cyrillic)',
  'me': 'Montenegrin (Latin)',
  'mos': 'Mossi',
  'na': 'Nauru',
  'ng': 'Ndonga',
  'ne-NP': 'Nepali',
  'ne-IN': 'Nepali, India',
  'pcm': 'Nigerian Pidgin',
  'se': 'Northern Sami',
  'nso': 'Northern Sotho',
  'no': 'Norwegian',
  'nb': 'Norwegian Bokmal',
  'nn-NO': 'Norwegian Nynorsk',
  'oc': 'Occitan',
  'oj': 'Ojibwe',
  'or': 'Oriya',
  'om': 'Oromo',
  'os': 'Ossetian',
  'pi': 'Pali',
  'pap': 'Papiamento',
  'ps': 'Pashto',
  'fa': 'Persian',
  'en-PT': 'Pirate English',
  'pl': 'Polish',
  'pt-PT': 'Portuguese',
  'pt-BR': 'Portuguese, Brazilian',
  'pa-IN': 'Punjabi',
  'pa-PK': 'Punjabi, Pakistan',
  'qu': 'Quechua',
  'qya-AA': 'Quenya',
  'ro': 'Romanian',
  'rm-CH': 'Romansh',
  'rn': 'Rundi',
  'ru': 'Russian',
  'ru-BY': 'Russian, Belarus',
  'ru-MD': 'Russian, Moldova',
  'ru-UA': 'Russian, Ukraine',
  'ry-UA': 'Rusyn',
  'sah': 'Sakha',
  'sg': 'Sango',
  'sa': 'Sanskrit',
  'sat': 'Santali',
  'sc': 'Sardinian',
  'sco': 'Scots',
  'gd': 'Scottish Gaelic',
  'sr': 'Serbian (Cyrillic)',
  'sr-CS': 'Serbian (Latin)',
  'sh': 'Serbo-Croatian',
  'crs': 'Seychellois Creole',
  'sn': 'Shona',
  'ii': 'Sichuan Yi',
  'sd': 'Sindhi',
  'si-LK': 'Sinhala',
  'sk': 'Slovak',
  'sl': 'Slovenian',
  'so': 'Somali',
  'son': 'Songhay',
  'ckb': 'Sorani (Kurdish)',
  'nr': 'Southern Ndebele',
  'sma': 'Southern Sami',
  'st': 'Southern Sotho',
  'es-ES': 'Spanish',
  'es-EM': 'Spanish (Modern)',
  'es-AR': 'Spanish, Argentina',
  'es-BO': 'Spanish, Bolivia',
  'es-CL': 'Spanish, Chile',
  'es-CO': 'Spanish, Colombia',
  'es-CR': 'Spanish, Costa Rica',
  'es-DO': 'Spanish, Dominican Republic',
  'es-EC': 'Spanish, Ecuador',
  'es-SV': 'Spanish, El Salvador',
  'es-GT': 'Spanish, Guatemala',
  'es-HN': 'Spanish, Honduras',
  'es-MX': 'Spanish, Mexico',
  'es-NI': 'Spanish, Nicaragua',
  'es-PA': 'Spanish, Panama',
  'es-PY': 'Spanish, Paraguay',
  'es-PE': 'Spanish, Peru',
  'es-PR': 'Spanish, Puerto Rico',
  'es-US': 'Spanish, United States',
  'es-UY': 'Spanish, Uruguay',
  'es-VE': 'Spanish, Venezuela',
  'su': 'Sundanese',
  'sw': 'Swahili',
  'sw-KE': 'Swahili, Kenya',
  'sw-TZ': 'Swahili, Tanzania',
  'ss': 'Swati',
  'sv-SE': 'Swedish',
  'sv-FI': 'Swedish, Finland',
  'syc': 'Syriac',
  'tl': 'Tagalog',
  'ty': 'Tahitian',
  'tg': 'Tajik',
  'tzl': 'Talossan',
  'ta': 'Tamil',
  'tt-RU': 'Tatar',
  'te': 'Telugu',
  'kdh': 'Tem (Kotokoli)',
  'th': 'Thai',
  'bo-BT': 'Tibetan',
  'ti': 'Tigrinya',
  'ts': 'Tsonga',
  'tn': 'Tswana',
  'tr': 'Turkish',
  'tr-CY': 'Turkish, Cyprus',
  'tk': 'Turkmen',
  'uk': 'Ukrainian',
  'hsb-DE': 'Upper Sorbian',
  'ur-IN': 'Urdu (India)',
  'ur-PK': 'Urdu (Pakistan)',
  'ug': 'Uyghur',
  'uz': 'Uzbek',
  'val-ES': 'Valencian',
  've': 'Venda',
  'vec': 'Venetian',
  'vi': 'Vietnamese',
  'wa': 'Walloon',
  'cy': 'Welsh',
  'wo': 'Wolof',
  'xh': 'Xhosa',
  'yi': 'Yiddish',
  'yo': 'Yoruba',
  'zea': 'Zeelandic',
  'zu': 'Zulu',
}

ax.extension.form.field.extras.shim = function() {

  return {
    controls: {
      language: ( f, target ) => ( options={} ) => this.controls.language( f, options ),
      timezone: ( f, target ) => ( options={} ) => this.controls.timezone( f, options ),
      country: ( f, target ) => ( options={} ) => this.controls.country( f, options ),
      multiselect: ( f, target ) => ( options={} ) => this.controls.multiselect( f, options ),
      selectinput: ( f, target ) => ( options={} ) => this.controls.selectinput( f, options ),
      password: ( f, target ) => ( options={} ) => this.controls.password( f, options ),
      // uri: ( f, target ) => ( options={} ) => this.controls.uri( f, options ),
    }

  }

}

ax.extension.form.field.extras.controls = {}

ax.extension.report.field.extras.shim = function() {

  return {
    controls: {
      boolean: ( r, target ) => ( options={} ) => this.controls.boolean( r, options ),
      language: ( r, target ) => ( options={} ) => this.controls.language( r, options ),
      timezone: ( r, target ) => ( options={} ) => this.controls.timezone( r, options ),
      country: ( r, target ) => ( options={} ) => this.controls.country( r, options ),
      color: ( r, target ) => ( options={} ) => this.controls.color( r, options ),
      datetime: ( r, target ) => ( options={} ) => this.controls.datetime( r, options ),
      email: ( r, target ) => ( options={} ) => this.controls.email( r, options ),
      tel: ( r, target ) => ( options={} ) => this.controls.tel( r, options ),
      url: ( r, target ) => ( options={} ) => this.controls.url( r, options ),
      number: ( r, target ) => ( options={} ) => this.controls.number( r, options ),
      password: ( r, target ) => ( options={} ) => this.controls.password( r, options ),
      preformatted: ( r, target ) => ( options={} ) => this.controls.preformatted( r, options ),
      json: ( r, target ) => ( options={} ) => this.controls.json( r, options ),
    }

  }

}

ax.extension.report.field.extras.controls = {}

// ax.extension.form.field.extras.controls.
// combobox = (f, options={} ) => {
//
//   let a = ax.a
//   let x = ax.x
//
//   let selections = x.lib.form.selections( options.selections )
//
//   let selectValue
//   let value
//
//   if ( options.value ) {
//     let valueInSelections = selections.some( option => option.value == options.value )
//     // selectValue = valueInSelections ? options.value : '__USE_INPUT__'
//     value = valueInSelections ? '' : options.value
//   // } else {
//     // If no value and no placeholder then show the input
//     // selectValue = options.placeholder ? '' : '__USE_INPUT__'
//   }
//
//   let controlTagOptions = {
//     $value: function() {
//       return this.$('input').value
//     },
//     $focus: function () {
//       this.$('input').focus()
//     },
//
//     $disable: function() {
//       // let select = this.$('|appkit-form-combobox-select select')
//       let input = this.$('|appkit-form-combobox-input input')
//       // select.disabled = 'disabled'
//       input.disabled = 'disabled'
//     },
//     $enable: function() {
//       if ( !options.disabled ) {
//         // let select = this.$('|appkit-form-combobox-select select')
//         let input = this.$('|appkit-form-combobox-input input')
//         // select.removeAttribute('disabled')
//         input.removeAttribute('disabled')
//       }
//     },
//     $on: { change: function () {
//       let select = this.$('select')
//       let input = this.$('|appkit-form-combobox-input input')
//       let hiddeninput = this.$('|appkit-form-combobox-hiddeninput input')
//       if ( select.value === '__USE_INPUT__' ) {
//         input.style.display = ''
//         hiddeninput.value = input.value
//         if ( options.required ) {
//           select.removeAttribute('required')
//           input.required = 'required'
//         }
//         if ( select == document.activeElement ) {
//           input.focus()
//         }
//       } else {
//         input.style.display = 'none'
//         hiddeninput.value = select.value
//         if ( options.required ) {
//           input.removeAttribute('required')
//           select.required = 'required'
//         }
//       }
//     } },
//
//     ...options.controlTag
//
//   }
//
//   return a['|appkit-form-control'](
//     [
//       a['|appkit-form-combobox-input']( f.input( {
//
//         value: value,
//         disabled: options.disabled,
//         ...options.input,
//         // inputTag: {
//         //   style: selectValue == '__USE_INPUT__' ? {} : { display: 'none' },
//         //   ...( options.input || {} ).inputTag,
//         // },
//       } ) ),
//       a['|appkit-form-combobox-select']( f.select(
//         {
//           // value: selectValue,
//           selections: selections,
//           placeholder: options.placeholder,
//           disabled: options.disabled,
//           ...options.select
//         }
//       ) ),
//     ],
//     controlTagOptions
//   )
//
// }

ax.extension.form.field.extras.controls.
password = function( f, options ) {

  let a = ax.a

  if ( options.confirmation == true ) {
    options.confirmation = {}
  }

  let secure = function ( element ) {
    if ( element.value ) {
      element.style.fontFamily = 'text-security-disc'
    } else {
      element.style.fontFamily = 'unset'
    }
  }

  let inputOptions = {
    name: options.name,
    value: options.value,
    placeholder: options.placeholder,
    disabled: options.disabled,
    readonly: options.readonly,
    required: options.required,
    pattern: options.pattern,
    autocomplete: 'off',
    ...options.input,
    inputTag: {

      $valid: function() {
        this.setCustomValidity('')
        if( this.validity.valid ) {
          return true
        } else {
          if ( options.invalid ) {
            if ( ax.is.function( options.invalid ) ) {
              let invalidMessage = options.invalid( this.value, this.validity )
              if ( invalidMessage ) {
                this.setCustomValidity( invalidMessage )
              }
            } else {
              this.setCustomValidity( options.invalid )
            }
          }
          return false
        }
      },

      ...( options.input || {} ).inputTag,

    },

  }

  let confirmation = function () {

    let confirmationInputOptions = {
      value: options.value,
      disabled: options.disabled,
      readonly: options.readonly,
      autocomplete: 'off',
      ...options.confirmation,
      inputTag: {

        $valid: function() {
          let input = this.$('^').$('input')
          if ( input.value == this.value ) {
            this.setCustomValidity('')
          } else {
            this.setCustomValidity('Passwords must match.')
          }
        },

        ...( options.confirmation || {} ).inputTag,

      },
    }

    return f.input( confirmationInputOptions )

  }

  let controlTagOptions = {

    $init: function () {
      for ( let input of this.$inputs() ) {
        secure( input )
        input.$valid()
      }
    },

    $inputs: function() {
      return this.$$('input').$$
    },

    $value: function() {
      return this.$inputs()[0].value
    },

    $focus: function () {
      this.$inputs()[0].focus()
    },

    $disable: function() {
      for ( let input of this.$inputs() ) {
        input.setAttribute( 'disabled', 'disabled' )
      }
    },

    $enable: function() {
      if ( !inputOptions.disabled ) {
        for ( let input of this.$inputs() ) {
          input.removeAttribute('disabled')
        }
      }
    },

    ...options.controlTag,

    $on: {
      'input: secure text': function () {
        for ( let input of this.$inputs() ) {
          secure( input )
        }
      },
      'input: check validity': function () {
        for ( let input of this.$inputs() ) {
          input.$valid()
        }
      },
      'input: send control change event': function () {
        this.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  return a['|appkit-form-control'](
    [
      f.input( inputOptions ),
      options.confirmation ? confirmation() : null
    ],
    controlTagOptions
  )

}

ax.extension.form.field.extras.controls.
multiselect = function( f,  options={} ) {

  let a = ax.a
  let x = ax.x

  options.value = x.lib.form.collection.value( options.value )

  options.selections = x.lib.form.selections( options.selections )

  let controlTagOptions = {
    $init: function() { this.$preselect(); },

    $value: function() {
      return this.$('|appkit-form-multiselect-selected').$state.
        map( function(item) { return item.value } )
    },

    $data: function() {
      return this.$value()
    },

    $focus: function () {
      this.$('select').focus()
    },

    $disable: function() {
      this.$$('|appkit-form-multiselect-selected-item-remove').$disable()
      this.$('select').disabled = 'disabled'
    },

    $enable: function() {
      if ( !options.disabled ) {
        this.$$('|appkit-form-multiselect-selected-item-remove').$enable()
        this.$('select').removeAttribute('disabled')
      }
    },

    $preselect: function () {
      let items = []
      let select = this.$('select')
      let selections = Array.apply( null, select.options )

      options.value.map( (itemValue) => {

        // if ( ax.is.undefined( selections[i].value ) )
        // debugger
        selections.forEach( ( selection, i ) => {


          if ( selection.value.toString() == itemValue.toString() ) {
            items.push( {
              index: i,
              value: itemValue,
              label: selection.text,
            } )
            selection.disabled = 'disabled'
          }
        } )

      } )
      this.$('|appkit-form-multiselect-selected').$state = items
    },

    $on: {
      'axf.appkit.form.multiselect.selected.change: send control change event': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

    ...options.controlTag

  }

  return a['|appkit-form-control'](
    a['|appkit-form-control-collection'](
      [
        this.multiselect.select( f, options ),
        this.multiselect.selected( f, options )
      ],
      { name: options.name } // Used to find control content using name without []
    ),
    controlTagOptions
  )

}

// ax.extension.form.field.extras.controls.
// uri = ( f, options={} ) => {
//
//   let a = ax.a
//   let x = ax.x
//
//   let controlTagOptions = {
//     $value: function() {
//       return this.$('input').value
//     },
//     $focus: function () {
//       this.$('input').focus()
//     },
//
//     $disable: function() {
//       this.$('input').setAttribute( 'disabled', 'disabled' )
//     },
//
//     $enable: function() {
//       if ( !inputOptions.disabled ) {
//         this.$('input').removeAttribute('disabled')
//       }
//     },
//
//     ...options.controlTag,
//
//     $on: {
//       'input:': (e,el) => {
//         el.$send( 'axf.appkit.form.control.change' )
//       },
//       ...( options.controlTag || {} ).$on
//     },
//
//   }
//
//   let inputOptions = {
//     ...options,
//     value: options.value,
//     pattern: `([A-Za-z][A-Za-z0-9+\\-.]*):(?:(//)(?:((?:[A-Za-z0-9\\-._~!$&'()*+,;=:]|%[0-9A-Fa-f]{2})*)@)?((?:\\[(?:(?:(?:(?:[0-9A-Fa-f]{1,4}:){6}|::(?:[0-9A-Fa-f]{1,4}:){5}|(?:[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){4}|(?:(?:[0-9A-Fa-f]{1,4}:){0,1}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){3}|(?:(?:[0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})?::(?:[0-9A-Fa-f]{1,4}:){2}|(?:(?:[0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})?::[0-9A-Fa-f]{1,4}:|(?:(?:[0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})?::)(?:[0-9A-Fa-f]{1,4}:[0-9A-Fa-f]{1,4}|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))|(?:(?:[0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})?::[0-9A-Fa-f]{1,4}|(?:(?:[0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})?::)|[Vv][0-9A-Fa-f]+\\.[A-Za-z0-9\\-._~!$&'()*+,;=:]+)\\]|(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:[A-Za-z0-9\\-._~!$&'()*+,;=]|%[0-9A-Fa-f]{2})*))(?::([0-9]*))?((?:/(?:[A-Za-z0-9\\-._~!$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)|/((?:(?:[A-Za-z0-9\\-._~!$&'()*+,;=:@]|%[0-9A-Fa-f]{2})+(?:/(?:[A-Za-z0-9\\-._~!$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)?)|((?:[A-Za-z0-9\\-._~!$&'()*+,;=:@]|%[0-9A-Fa-f]{2})+(?:/(?:[A-Za-z0-9\\-._~!$&'()*+,;=:@]|%[0-9A-Fa-f]{2})*)*)|)(?:\\?((?:[A-Za-z0-9\\-._~!$&'()*+,;=:@/?]|%[0-9A-Fa-f]{2})*))?(?:\\#((?:[A-Za-z0-9\\-._~!$&'()*+,;=:@/?]|%[0-9A-Fa-f]{2})*))?`,
//     ...options.input
//   }
//
//   return a['|appkit-form-control'](
//     f.input( inputOptions ),
//     controlTagOptions
//   )
//
// }

ax.extension.form.field.extras.controls.
language = ( f, options={} ) => {

  let a = ax.a
  let x = ax.x

  let controlTagOptions = {
    $value: function() {
      return this.$('select').value
    },
    $focus: function () {
      this.$('select').focus()
    },

    $disable: function() {
      this.$('select').setAttribute( 'disabled', 'disabled' )
    },

    $enable: function() {
      if ( !selectOptions.disabled ) {
        this.$('select').removeAttribute('disabled')
      }
    },

    ...options.controlTag,

    $on: {
      'click: do nothing when readonly': (e) => { if ( selectOptions.readonly ) e.preventDefault() },
      'change:': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  let selectOptions = {
    ...options,
    value: options.value,
    selections: x.lib.locale.languages,
    placeholder: options.placeholder || ' ',
    ...options.select
  }

  return a['|appkit-form-control'](
    f.select( selectOptions ),
    controlTagOptions
  )

}

ax.extension.form.field.extras.controls.
country = ( f, options={} ) => {

  let a = ax.a
  let x = ax.x

  let controlTagOptions = {
    $value: function() {
      return this.$('select').value
    },
    $focus: function () {
      this.$('select').focus()
    },

    $disable: function() {
      this.$('select').setAttribute( 'disabled', 'disabled' )
    },

    $enable: function() {
      if ( !selectOptions.disabled ) {
        this.$('select').removeAttribute('disabled')
      }
    },

    ...options.controlTag,

    $on: {
      'click: do nothing when readonly': (e) => { if ( selectOptions.readonly ) e.preventDefault() },
      'change:': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  let selectOptions = {
    ...options,
    value: options.value,
    selections: x.lib.locale.countries,
    placeholder: options.placeholder || ' ',
    ...options.select
  }

  return a['|appkit-form-control'](
    f.select( selectOptions ),
    controlTagOptions
  )

}

ax.extension.form.field.extras.controls.
selectinput = (f, options={} ) => {

  let a = ax.a
  let x = ax.x

  let selections = x.lib.form.selections( options.selections )
  selections.push( { disabled: 'hr' } )
  selections.push( { value: '__USE_INPUT__', label: options.customValueLabel || '⬇ Enter a value' } )

  let selectValue
  let inputValue

  if ( options.value ) {
    let valueInselections = selections.some( option => option.value == options.value )
    selectValue = valueInselections ? options.value : '__USE_INPUT__'
    inputValue = valueInselections ? '' : options.value
  } else {
    // If no value and no placeholder then show the input
    selectValue = options.placeholder ? '' : '__USE_INPUT__'
  }

  let controlTagOptions = {
    $value: function() {
      return this.$('|appkit-form-selectinput-hiddeninput input').value
    },
    // $data: function() {
    //   if ( options.datatype ) {
    //     return ax.x.lib.coerce[ options.datatype ]( this.$value() )
    //   } else {
    //     return this.$value()
    //   }
    // },
    $focus: function () {
      let select = this.$('select')
      if ( select.value === '__USE_INPUT__' ) {
        this.$('|appkit-form-selectinput-input input').focus()
      } else {
        select.focus()
      }
    },

    $disable: function() {
      let select = this.$('|appkit-form-selectinput-select select')
      let input = this.$('|appkit-form-selectinput-input input')
      let hiddeninput = this.$('|appkit-form-selectinput-hiddeninput input')
      select.disabled = 'disabled'
      input.disabled = 'disabled'
      hiddeninput.disabled = 'disabled'
    },
    $enable: function() {
      if ( !options.disabled ) {
        let select = this.$('|appkit-form-selectinput-select select')
        let input = this.$('|appkit-form-selectinput-input input')
        let hiddeninput = this.$('|appkit-form-selectinput-hiddeninput input')
        select.removeAttribute('disabled')
        input.removeAttribute('disabled')
        hiddeninput.removeAttribute('disabled')
      }
    },
    $on: { change: function () {
      let select = this.$('select')
      let input = this.$('|appkit-form-selectinput-input input')
      let hiddeninput = this.$('|appkit-form-selectinput-hiddeninput input')
      if ( select.value === '__USE_INPUT__' ) {
        input.style.display = ''
        hiddeninput.value = input.value
        if ( options.required ) {
          select.removeAttribute('required')
          input.required = 'required'
        }
        if ( select == document.activeElement ) {
          input.focus()
        }
      } else {
        input.style.display = 'none'
        hiddeninput.value = select.value
        if ( options.required ) {
          input.removeAttribute('required')
          select.required = 'required'
        }
      }
    } },

    ...options.controlTag

  }

  return a['|appkit-form-control'](
    [
      a['|appkit-form-selectinput-hiddeninput']( f.input(
        {
          name: options.name,
          value: options.value,
          type: 'hidden',
          ...options.hiddeninput
        }
      ) ),
      a['|appkit-form-selectinput-select']( f.select(
        {
          value: selectValue,
          selections: selections,
          placeholder: options.placeholder,
          disabled: options.disabled,
          ...options.select
        }
      ) ),
      a['|appkit-form-selectinput-input']( f.input( {

        value: inputValue,
        disabled: options.disabled,
        ...options.input,
        inputTag: {
          style: selectValue == '__USE_INPUT__' ? {} : { display: 'none' },
          ...( options.input || {} ).inputTag,
        },
      } ) )
    ],
    controlTagOptions
  )

}

ax.extension.form.field.extras.controls.
timezone = ( f, options={} ) => {

  let a = ax.a
  let x = ax.x

  let controlTagOptions = {
    $value: function() {
      return this.$('select').value
    },
    $focus: function () {
      this.$('select').focus()
    },

    $disable: function() {
      this.$('select').setAttribute( 'disabled', 'disabled' )
    },

    $enable: function() {
      if ( !selectOptions.disabled ) {
        this.$('select').removeAttribute('disabled')
      }
    },

    ...options.controlTag,

    $on: {
      'click: do nothing when readonly': (e) => { if ( selectOptions.readonly ) e.preventDefault() },
      'change:': (e,el) => {
        el.$send( 'axf.appkit.form.control.change' )
      },
      ...( options.controlTag || {} ).$on
    },

  }

  let selectOptions = {
    ...options,
    value: options.value || Intl.DateTimeFormat().resolvedOptions().timeZone,
    selections: x.lib.locale.timezones,
    placeholder: options.placeholder || ' ',
    ...options.select
  }

  return a['|appkit-form-control'](
    f.select( selectOptions ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
url = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    component = a.a( value, {
      href: value,
      target: value,
    } )
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-timezone'](
      component,
      options.urlTag,
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
password = function( r, options ) {

  let a = ax.a
  let x = ax.x

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  let passwordTagOptions = {
    $init: el => {
      el.style.fontFamily = 'text-security-disc'
    },
    ...options.passwordTag
  }

  return a['|appkit-report-control'](
    a['|appkit-report-password'](
      options.value ?
      [
        a['|appkit-report-password-text'](
          ( el, flag ) => {
            if ( flag > 0 ) {
              el.style.fontFamily = 'text-security-disc'
              el.classList.add( 'secure-text' )
            } else {
              el.style.fontFamily = 'monospace'
              el.classList.remove( 'secure-text' )
            }
            return a( { $text: options.value || '' } )
          },
          {
            $state: 1,
            ...options.textTag
          }
        ),
        x.button( {
          label: '👁',
          onclick: (e,el) => {
            let text = el.$('^|appkit-report-password |appkit-report-password-text')
            text.$state = text.$state * -1
          },
          ...options.button
        } ),
      ] :
      a.span( options.placeholder || 'None', { class: 'placeholder' } ),
      options.passwordTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
color = ( r, options={} ) => {

  let a = ax.a

  let value = options.value
  let component

  if ( value ) {
    component = a.div( null, {
      style: {
        backgroundColor: options.value,
        height: '100%',
      },
    } )
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-color'](
      component,
      options.colorTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
datetime = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    if ( options.only === 'time' ) {
      component = new Date( value ).toTimeString()
    } else if ( options.only === 'date' ) {
      component = new Date( value ).toDateString()
    } else {
      component = new Date( value ).toString()
    }
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-datetime'](
      component,
      options.datetimeTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
number = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    component = Number( value )
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-number'](
      component,
      options.numberTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
language = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    label = x.lib.locale.languages[value]
    if ( label ) {
      component = label
    } else {
      component = value
    }
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-language'](
      component,
      options.languageTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
country = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    label = x.lib.locale.countries[value]
    if ( label ) {
      component = label
    } else {
      component = value
    }
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  let selectOptions = {
    ...options,
    selections: x.lib.locale.countries,
    placeholder: options.placeholder || ' ',
    ...options.select
  }

  return a['|appkit-report-control'](
    a['|appkit-report-country'](
      component,
      options.countryTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
boolean = ( r, options={} ) => {

  let a = ax.a

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  let label = options.label || {}

  let trueLabel = label.true || '✔ True'
  let falseLabel = label.false || '❌ False'

  return a['|appkit-report-control'](
    a['|appkit-report-boolean'](
      options.value ? trueLabel : falseLabel,
      options.booleanTag,
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
email = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    component = a.a( value, { href: `mailto: ${ value }` } )
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-email'](
      component,
      options.emailTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
json = function( r, options ) {

  let a = ax.a

  let value = options.value
  let component

  if ( value ) {
    if ( options.parse ) {
      try {
        component = a.pre(
          JSON.stringify( JSON.parse( value ), null, 2  ),
          options.preTag
        )
      }
      catch (error) {
        component = a['.error']( `⚠ ${ error.message }` )
      }
    } else {
      component = a.pre(
        JSON.stringify( value, null, 2  ),
        options.preTag
      )
    }
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-json'](
      component,
      options.jsonTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
timezone = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    label = x.lib.locale.timezones[value]
    if ( label ) {
      component = label
    } else {
      component = value
    }
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-timezone'](
      component,
      options.timezoneTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
tel = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    component = a.a( value, { href: `tel: ${ value }` } )
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  return a['|appkit-report-control'](
    a['|appkit-report-tel'](
      component,
      options.telTag
    ),
    controlTagOptions
  )

}

ax.extension.report.field.extras.controls.
preformatted = ( r, options={} ) => {

  let a = ax.a
  let x = ax.x

  // let preformattedOptions = {
  //   // name: options.name,
  //   // value: options.value,
  //   // placeholder: options.placeholder,
  //   ...options,
  //   ...options.preformatted
  // }

  let controlTagOptions = {

    'data-name': options.name,
    tabindex: 0,
    $value: function() {
      return options.value
    },
    $focus: function () {
      this.focus()
    },

    ...options.controlTag,

  }

  let component

  if ( options.value ) {
    component = a.pre( options.value || '', options.preTag )
  } else {
    component = a.span( ( options.placeholder || 'None' ), { class: 'placeholder'} )
  }

  return a['|appkit-report-control'](
    a['|appkit-report-preformatted'](
      component,
      options.preformattedTag
    ),
    controlTagOptions
  )

}

ax.css( {
  '|appkit-form-multiselect-selected': {
    background: 'white',
    color: '#333',
  },
  '|appkit-form-multiselect-selected-item': {
    display: 'block',
    overflow: 'auto',
  },
  '|appkit-form-multiselect-selected-item-label': {
    verticalAlign: 'middle'
  },
  '|appkit-form-multiselect-selected-item-remove': {
    float: 'right',
    borderColor: 'transparent',
    backgroundColor: 'transparent',
    margin: '1px',
  },

} )

ax.extension.form.field.extras.controls.
multiselect.selected = function(
  f, options={}
) {

  let a = ax.a

  return a['div|appkit-form-multiselect-selected']( null, {

    $state: [],

    $remove: function ( item ) {
      let state = [ ...this.$state ]
      let index = state.indexOf( item )
      if (index !== -1) {
        state.splice(index, 1)
        this.$state = state
      }
      this.$send( 'axf.appkit.form.multiselect.selected.change' )
    },

    $add: function ( item, index ) {
      this.$state = [ item ].concat( this.$state )
      this.$send( 'axf.appkit.form.multiselect.selected.change' )
    },

    $update: function() {

      if ( this.$state.length === 0 ) {
        this.style.display = 'none'
        this.$( '^|appkit-form-multiselect-selected' ).previousSibling.required = options.required
        this.$nodes = [
          f.input( {
            name: options.name + '[]',
            disabled: true,
            inputTag: { type: 'hidden' },
          } )
        ]
      } else {
        this.style.display = ''
        this.$( '^|appkit-form-multiselect-selected' ).
          previousSibling.removeAttribute( 'required' )
        this.$nodes = this.$state.map( function( item ) {
          return a['|appkit-form-multiselect-selected-item']( [
            a['|appkit-form-multiselect-selected-item-label']( item.label ),
            a['button|appkit-form-multiselect-selected-item-remove'](
              '✖',
              {
                $on: {
                  'click: remove item from selection': function(e) {
                    if ( !this.disabled ) {
                      this.$( '^|appkit-form-control' ).
                      $('select').$enableDeselected( item.index )
                      this.$( '^|appkit-form-multiselect-selected' ).$remove( item )
                    }
                  },
                },
                $disable: function() {
                  this.disabled = 'disabled'
                },
                $enable: function() {
                  this.removeAttribute('disabled')
                },
              },
            ),
            f.input( {
              name: options.name + '[]',
              required: options.required,
              value: item.value,
              inputTag: { type: 'hidden' },
            } )
          ], options.itemTag )
        } )
      }
    },

  } )

}

ax.extension.form.field.extras.controls.
multiselect.select = function(
  f, options={}
) {

  let a = ax.a

  return f.select(
    // No name on select. Field name goes on hidden inputs.
    {
      placeholder: options.placeholder || '＋ Add',
      selections: options.selections,
      selectTag: {
        $on: {
          'change: add item to selection': function (e,el) {
            this.nextSibling.$add( {
              index: this.selectedIndex,
              value: this.value,
              label: this.options[this.selectedIndex].text,
            } )
            this.$disableSelected()
          }
        },

        $disableSelected: function () {
          this.options[this.selectedIndex].disabled = 'disabled'
          this.selectedIndex = 0
        },

        $enableDeselected: function ( index ) {
          this.options[index].removeAttribute('disabled')
        },

      },

      ...options.select

    }
  )



}

ax.css( {

  '|appkit-report-password': {

    button: {
      fontSize: '1em',
      border: 'none',
      backgroundColor: 'transparent',
      cursor: 'pointer',
      float: 'right',
    },

  }

} )

ax.extension.form.field.nest = {}

ax.extension.report.field.nest = {}

ax.extension.form.field.nest.shim = function() {

  let a = ax.a

  return {

    controls: {
      nest: ( f, target ) => ( options={} ) => this.shim.nest( f, options ),
    }
  }

}

ax.extension.report.field.nest.shim = function() {

  let a = ax.a

  return {

    controls: {
      nest: ( f, target ) => ( options={} ) => this.shim.nest( f, options ),
    }
  }

}

ax.extension.form.field.nest.shim.
nest = function( f, options={} ) {

  let a = ax.a
  let x = ax.x

  let nestForm = options.form || ( () => null )

  let nestFactory = this.nest.factory( {
    scope: options.name, // name is the scope for child items
    object: options.value || {},
    params: f.params,
    shims: f.shims,
    singular: options.singular,
  } )

  let rebasedName = function( name, scope, index ) {
    let pattern = `^${ scope.replace( /(\[|\])/g, '\\$1' ) }\\[\\d+\\](.*)$`
    let regex = new RegExp( pattern )
    let match = name.match( regex )
    return `${ scope }[${ index }]${ match[1] }`
  }

  let nestTagOptions = {

    name: nestFactory.scope,

    $rescopeElement: function( el, scope, index ) {
      el.setAttribute( 'name', rebasedName( el.getAttribute( 'name' ), scope, index ) )
    },

    $rescope: function( scope, index ) {

      let name = rebasedName( this.getAttribute( 'name' ), scope, index )
      this.setAttribute( 'name', name )
      nestFactory.scope = name

      let namedElements = x.lib.unnested( this, `[name^="${ scope }"]` )
      namedElements.forEach( function( el ) {
        if ( el.dataset.axfComponent == 'appkit-form-nest') {
          el.$rescope( scope, index )
        } else {
          this.$rescopeElement( el, scope, index )
        }
      }.bind( this ) )

    },

    ...options.nestTag,

  }

  let controlTagOptions = {
    $value: function() {
      let items = this.$('|appkit-form-nest-items')
      if ( items ) {
        return this.$('|appkit-form-nest-items').$count()
      } else {
        return null
      }
    },
    $controls: function() {
      return x.lib.unnested( this, '|appkit-form-control' )
    },
    $buttons: function() {
      return this.$$('button').$$
    },
    $disable: function() {
      let controls = [ ...this.$controls(), ...this.$buttons() ]
      for ( let i in controls ) {
        controls[i].$disable && controls[i].$disable()
      }
    },
    $enable: function() {
      let controls = [ ...this.$controls(), ...this.$buttons() ]
      for ( let i in controls ) {
        controls[i].$enable && controls[i].$enable()
      }
    },
    $focus: function() {
      let first = this.$('|appkit-form-control')
      if ( first ) first.$focus()
    },
    $on: {
      'axf.appkit.form.nest.item.move': (e,el) =>
        el.$send( 'axf.appkit.form.control.change' ),
      'axf.appkit.form.nest.item.add': (e,el) =>
        el.$send( 'axf.appkit.form.control.change' ),
      'axf.appkit.form.nest.item.remove': (e,el) =>
        el.$send( 'axf.appkit.form.control.change' ),
    },
    ...options.controlTag,

  }

  return a['|appkit-form-control'](
    a['|appkit-form-nest'](
      nestForm( nestFactory ),
      nestTagOptions
    ),
    controlTagOptions
  )

}

ax.extension.report.field.nest.shim.
nest = function( f, options={} ) {

  let a = ax.a
  let x = ax.x

  let nestReport = options.report || ( () => null )

  let nestFactory = this.nest.factory( {
    scope: options.name, // name is the scope for child items
    object: options.value || {},
    params: f.params,
    shims: f.shims,
    item: options.item,
  } )

  let nestTagOptions = {
    name: nestFactory.scope,
    ...options.nestTag,
  }

  let controlTagOptions = {
    $value: function() {
      let items = this.$('|appkit-report-nest-items')
      if ( items ) {
        return this.$('|appkit-report-nest-items').$count()
      } else {
        return null
      }
    },
    $focus: function() {
      this.$('|appkit-report-control').$focus()
    },
    ...options.controlTag,
  }

  return a['|appkit-report-control'](
    a['|appkit-report-nest'](
      nestReport( nestFactory ),
      nestTagOptions
    ),
    controlTagOptions
  )

}

ax.extension.form.field.nest.shim.nest.
items = function( f, options ) {

  let a = ax.a
  let x = ax.x

  let formFn = options.form || ( () => null )
  let item = function( itemData, index ) {

    let ff = this.items.factory( {
      scope: f.scope ? `${ f.scope }[${ index }]`: `${ index }`,
      params: f.params,
      shims: f.shims,
      object: itemData,
      // item: options.item,
      index: index,
    } )

    return a['|appkit-form-nest-item'](
      formFn( ff ),
      {
        $rescope: function( scope, index ) {

          ff.index = index
          ff.scope = `${ scope }[${ index }]`


          let namedElements = x.lib.unnested( this, `[name^="${ scope }"]` )

          namedElements.forEach( function( el ) {
            if ( el.dataset.axfComponent == 'appkit-form-nest') {
              el.$rescope( scope, index )
            } else {
              el.$('^|appkit-form-nest').$rescopeElement( el, scope, index )
            }
          } )

        },
        ...options.itemTag,
      }
    )

  }.bind( this )


  let itemsData
  let object = f.object

  if ( ax.is.array( object ) ) {
    itemsData = object
  } else if ( ax.is.object( object ) ) {
    itemsData = Object.values( object )
  }

  return a['|appkit-form-nest-items']( itemsData.map(
    item
  ), {
    $add: function() {
      this.append( item( {}, this.children.length ) )
    },
    $count: function() {
      return this.$$(':scope > |appkit-form-nest-item').$$.length
    },
    $rescopeItems: function() {
      this.$$(':scope > |appkit-form-nest-item').$$.forEach( function( itemTag, index ) {
        itemTag.$rescope( f.scope, index )
      } )
    },
    ...options.itemsTag,
    $on: {
      'axf.appkit.form.nest.item.move': (e,el) => {
        e.stopPropagation()
        el.$rescopeItems()
      },
      'axf.appkit.form.nest.item.remove': (e,el) => {
        e.stopPropagation()
        el.$rescopeItems()
      },
      ...( options.itemsTag || {} ).$on
    },
  } )

}

ax.extension.form.field.nest.shim.nest.
add = function( f, options ) {

  let singular = options.singular

  let label = `✚ Add${ singular ? ` ${ singular }`: '' }`

  return f.button( {
    label: label,
    onclick: (e,el) => {
      let itemsTag = options.target ? options.target(el) : el.$('^|appkit-form-nest |appkit-form-nest-items')
      itemsTag.$add()
      itemsTag.$send( 'axf.appkit.form.nest.item.add' )
    },
    ...options
  } )

}

ax.extension.form.field.nest.shim.nest.
factory = function( options ) {

  let x = ax.x

  let ff = x.form.factory( {
    shims: options.shims,
    scope: options.scope,
    object: options.object,
    params: options.params,
  } )

  // ff.item = options.item || ''
  // ff.items = ( options={} ) => this.items( ff, options )
  // ff.add = ( options={} ) => this.add( ff, options )

  let singular = options.singular

  ff.items = ( options={} ) => this.items( ff, {
    singular: singular,
    ...options
  } )
  ff.add = ( options={} ) => this.add( ff, {
    singular: singular,
    ...options
  } )

  return ff

}

ax.extension.report.field.nest.shim.nest.
items = function( f, options ) {

  let a = ax.a
  let x = ax.x

  let reportFn = options.report || ( () => null )
  let item = function( itemData, index ) {

    let ff = this.items.factory( {
      scope: f.scope ? `${ f.scope }[${ index }]`: `${ index }`,
      params: f.params,
      shims: f.shims,
      object: itemData,
      item: options.item,
      index: index,
    } )

    return a['|appkit-report-nest-item'](
      reportFn( ff ),
      options.itemTag
    )

  }.bind( this )

  let itemsData
  let object = f.object

  if ( ax.is.array( object ) ) {
    itemsData = object
  } else if ( ax.is.object( object ) ) {
    itemsData = Object.values( object )
  }

  return a['|appkit-report-nest-items'](
    itemsData.length ?
    itemsData.map( item ) :
    ( options.empty || a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    ) ),
    {
      $count: function() {
        return this.$$(':scope > |appkit-report-nest-item').$$.length
      },
      ...options.itemsTag,
  } )

}

// ax.extension.report.field.nest.shim.nest.
// add = function( f, options ) {
//
//   let label = `✚ Add${ f.item ? ` ${ f.item }`: '' }`
//
//   return f.button( {
//     label: label,
//     onclick: (e,el) => {
//       let itemsTag = options.target ? options.target(el) : el.$('^|appkit-report-nest |appkit-report-nest-items')
//       itemsTag.$add()
//       itemsTag.$send( 'axf.appkit.report.nest.item.add' )
//     },
//     ...options
//   } )
//
// }

ax.extension.report.field.nest.shim.nest.
factory = function( options ) {

  let x = ax.x

  let ff = x.report.factory( {
    shims: options.shims,
    scope: options.scope,
    object: options.object,
    params: options.params,
  } )

  // ff.item = options.item || ''
  ff.items = ( options={} ) => this.items( ff, options )
  // ff.add = ( options={} ) => this.add( ff, options )

  return ff

}

ax.extension.form.field.nest.shim.nest.items.
down = function( f, options={} ) {

  return f.button( {
    label: '⏷',
    onclick: function (e,el) {
      var target = options.itemTarget ? options.itemTarget(el) : el.$('^|appkit-form-nest-item')
      var next = target.nextSibling
      var parent = target.parentElement
      if ( next ) {
        parent.insertBefore( target, next.nextSibling )
        this.$send( 'axf.appkit.form.nest.item.move' )
      }
    },
    ...options
  } )

}

ax.extension.form.field.nest.shim.nest.items.
remove = function( f, options={} ) {

  let singular = options.singular || 'item'
  let confirmation

  if ( ax.is.false( options.confirm ) ) {
    confirmation = false
  } else if ( ax.is.string( options.confirm ) || ax.is.function( options.confirm ) ) {
    confirmation = options.confirm
  } else {
    confirmation = `Are you sure that you want to remove this ${ singular }?`
  }

  return f.button( {
    label: '✖',
    confirm: confirmation,
    onclick: function (e,el) {
      var target = el.$('^|appkit-form-nest-item')
      let parent = target.parentElement
      let index = Array.prototype.indexOf.call( parent.children, target )
      target.remove()
      let length = parent.children.length
      parent.$send( 'axf.appkit.form.nest.item.remove', { detail: {
        target: el,
        index: index,
        length: length,
      } } )
      // let confirmed = confirmation( el )
      // if ( confirmed ) {
      // }
    },
    ...options
  } )

}

ax.extension.form.field.nest.shim.nest.items.
factory = function( options={} ) {

  let x = ax.x

  let index = options.index

  let f = x.form.factory( {
    shims: options.shims,
    scope: options.scope,
    object: options.object,
    params: options.params,
  } )

  let singular = options.singular

  f.index = index
  f.remove = options => this.remove( f, { singular: singular, ...options } )
  f.up = options => this.up( f, options )
  f.down = options => this.down( f, options )

  return f

}

ax.extension.form.field.nest.shim.nest.items.
up = function( f, options={} ) {

  return f.button( {
    label: '⏶',
    onclick: function (e,el) {
      var target = options.itemTarget ? options.itemTarget(el) : el.$('^|appkit-form-nest-item')
      var previous = target.previousSibling
      var parent = target.parentElement
      if ( previous ) {
        parent.insertBefore( target, previous )
        this.$send( 'axf.appkit.form.nest.item.move' )
      }
    },
    ...options
  } )

}

// ax.extension.report.field.nest.shim.nest.items.
// down = function( f, options ) {
//
//   return f.button( {
//     label: '⏷',
//     onclick: function (e,el) {
//       var target = options.itemTarget ? options.itemTarget(el) : el.$('^|appkit-report-nest-item')
//       var next = target.nextSibling
//       var parent = target.parentElement
//       if ( next ) {
//         parent.insertBefore( target, next.nextSibling )
//         this.$send( 'axf.appkit.report.nest.item.move' )
//       }
//     },
//     ...options
//   } )
//
// }

// ax.extension.report.field.nest.shim.nest.items.
// remove = function( f, options ) {
//
//   let item = f.item || 'item'
//   let confirmation
//
//   if ( ax.is.false( options.confirmation ) ) {
//     confirmation = () => true
//   } else if ( ax.is.string( options.confirmation ) ) {
//     confirmation = ( target ) => confirm( options.confirmation )
//   } else if ( ax.is.function( options.confirmation ) ) {
//     confirmation = ( target ) => confirm( options.confirmation( target ) )
//   } else {
//     confirmation = () => confirm( `Are you sure that you want to remove this ${ item }?` )
//   }
//
//   return f.button( {
//     label: '✖',
//     onclick: function (e,el) {
//       var target = options.itemTarget ? options.itemTarget(el) : el.$('^|appkit-report-nest-item')
//       let confirmed = confirmation( target )
//       if ( confirmed ) {
//         let parent = target.parentElement
//         let index = Array.prototype.indexOf.call( parent.children, target )
//         target.remove()
//         let length = parent.children.length
//         parent.$send( 'axf.appkit.report.nest.item.remove', { detail: {
//           target: el,
//           index: index,
//           length: length,
//         } } )
//       }
//     },
//     ...options
//   } )
//
// }

ax.extension.report.field.nest.shim.nest.items.
factory = function( options ) {

  let x = ax.x

  let index = options.index

  let f = x.report.factory( {
    shims: options.shims,
    scope: options.scope,
    object: options.object,
    params: options.params,
  } )

  f.index = index
  f.item = options.item
  f.remove = ( options={} ) => this.remove( f, options )
  f.up = ( options={} ) => this.up( f, options )
  f.down = ( options={} ) => this.down( f, options )

  return f

}

// ax.extension.report.field.nest.shim.nest.items.
// up = function( f, options ) {
//
//   return f.button( {
//     label: '⏶',
//     onclick: function (e,el) {
//       var target = options.itemTarget ? options.itemTarget(el) : el.$('^|appkit-report-nest-item')
//       var previous = target.previousSibling
//       var parent = target.parentElement
//       if ( previous ) {
//         parent.insertBefore( target, previous )
//         this.$send( 'axf.appkit.report.nest.item.move' )
//       }
//     },
//     ...options
//   } )
//
// }

ax.extension.form.field.nest.prefab = {}

ax.extension.report.field.nest.prefab = {}

ax.extension.form.field.nest.prefab.shim = function() {

  return {

    controls: {
      table: f => options => this.shim.table( f, options ),
      many: f => options => this.shim.many( f, options ),
      one: f => options => f.controls.nest( options )
    },

  }

}

ax.extension.report.field.nest.prefab.shim = function() {

  return {

    controls: {
      table: r => options => this.shim.table( r, options ),
      many: r => options => this.shim.many( r, options ),
      one: r => options => r.controls.nest( options )
    },

  }

}

ax.extension.form.field.nest.prefab.shim.
many = function ( f, options ) {

  let a = ax.a

  return f.controls.nest( {
    ...options,
    form: (ff) => (a,x) => {

      return a['|appkit-form-nest-many-wrapper']( [
      ff.items( {
        ...options,
        form: (fff) => [
          a['|appkit-form-nest-many-item-header']( [
            a['|appkit-form-nest-many-item-buttons']( [
              !options.stationary ? fff.up( options.upButton ) : null,
              !options.stationary ? fff.down( options.downButton ) : null,
              !options.confined ? fff.remove( options.removeButton ) : null,
            ], options.itemButtonsTag )
          ], options.itemHeaderTag ),
          a['|appkit-form-nest-many-item-body'](
            options.form( fff ),
            options.itemBodyTag
          ),
        ],
        itemsTag: {
          ...options.itemsTag,
          $on: {
            'sortupdate: rescope items': (e,el) => {
              el.$rescopeItems()
            },
            ...( options.itemsTag || {} ).$on,
          },
          $sortable: function() {
            this.$$('|appkit-form-nest-sort-off button').click() // turn off sort on children
            sortable( this, {
              forcePlaceholderSize: true
            } )
            this.$('^|appkit-form-nest').$$('|appkit-form-nest-add-button button').$disable()
            let buttons = this.$('^|appkit-form-nest |appkit-form-nest-items').$$('button').$$
            for ( let button of buttons ) {
              button.$disable && button.$disable()
            }
            this.$$('[draggable] *').style.pointerEvents = 'none' // do not let contents interfere with draggable
          },
          $unsortable: function() {
            this.$$('[draggable] *').style.pointerEvents = 'auto'
            sortable( this, 'destroy' )
            this.$('^|appkit-form-nest').$$('|appkit-form-nest-add-button button').$enable()
            let buttons = this.$('^|appkit-form-nest |appkit-form-nest-items').$$('button').$$
            for ( let button of buttons ) {
              button.$enable && button.$enable()
            }
          },
        },
        itemTag: {
          ...options.itemTag,
          style: {
            display: 'block',
            ...( options.itemTag || {} ).style,
          }
        },

      } ),

      a['|appkit-form-nest-many-footer']( [

        !options.confined ? a['|appkit-form-nest-add-button'](
          ff.add( options.addButton ),
          options.addButtonWrapperTag
        ) : null,

        !options.stationary ? a['|appkit-form-nest-sort-buttons']( [
          a['|appkit-form-nest-sort-on']( ff.button( {
            label: '⬍',
            onclick: (e,el) => {
              el.$('^|appkit-form-nest |appkit-form-nest-items').$sortable()
              let sortOn = el.$('^|appkit-form-nest-sort-on')
              sortOn.style.display = 'none'
              sortOn.nextSibling.style.display = ''
              sortOn.nextSibling.$('button').$enable()
            },
            ...options.sortOnButton,
          } ), options.sortOnTag ),
          a['|appkit-form-nest-sort-off']( ff.button( {
            label: '⬍ Drag',
            onclick: (e,el) => {
              el.$('^|appkit-form-nest |appkit-form-nest-items').$unsortable()
              let sortOff = el.$('^|appkit-form-nest-sort-off')
              sortOff.style.display = 'none'
              sortOff.previousSibling.style.display = ''
            },
            ...options.sortOffButton,
          } ), {
            ...options.sortOffTag,
            style: {
              ...( options.sortOffTag || {} ).style,
              display: 'none'
            },

          } ),
        ], options.sortButtonsTag ) : null,

      ], options.footerTag )


    ], {
        ...options.wrapperTag,
        style: {
          display: 'block',
          ...( options.wrapperTag || {} ).style
        },
      } )

    }
  } )

}

ax.extension.form.field.nest.prefab.shim.
table = function ( f, options ) {

  let a = ax.a

  return f.controls.nest( {
    ...options,
    form: (ff) => (a,x) => {

      let form = options.form || ( () => {} )

      let tableHeader = function() {

        let ffP = new Proxy( ff, {
          get: ( target, property ) => {
            if ( property == 'field' ) {
              return ( itemOptions ) => {
                let label = itemOptions.label || x.lib.text.labelize( itemOptions.key )
                return a.th( a['|appkit-form-field']( [
                  label,
                  itemOptions.help ? ff.helpbutton( {
                    helpbuttonTag: {
                      $on: {
                        'click: toggle help': function() {
                          this.$state = !this.$state
                          this.$('^table', `|appkit-form-field-help[data-field-key="${ itemOptions.key }"]`).$toggle()
                        },
                      },
                    },
                  } ) : null,
                ] ), {
                  ...options.thTag,
                  ...itemOptions.thTag
                } )
              }
            } else {
              return a.td
            }
          }
        } )

        let headerCells = function() {
          let cells = form(ffP) || []
          if ( !options.stationary || !options.confined ) cells.push(
            a.th( null, {
              width: '10%',
              ...options.thTag
            } )
          )
          return cells
        }

        return a.thead( a.tr( headerCells() ) )

      }

      let tableHelp = function() {

        let ffP = new Proxy( ff, {
          get: ( target, property ) => {
            if ( property == 'field' ) {
              return ( options ) => {
                let help = options.help
                return a.td(
                  ff.help( {
                    ...options,
                    helpTag: {
                      'data-field-key': options.key,
                      ...options.helpTag,
                    }
                  } ),
                  options.tdTag
                )
              }
            } else {
              return a.td
            }
          }
        } )

        let helpCells = function() {
          let cells = form(ffP) || []
          if ( !options.stationary || !options.confined ) cells.push( a.td )
          return cells
        }

        return a.tr( helpCells() )

      }

      let tableHint = function() {

        let ffP = new Proxy( ff, {
          get: ( target, property ) => {
            if ( property == 'field' ) {
              return ( options ) => {
                let hint = options.hint
                return a.td(
                  ff.hint( options ),
                  options.tdTag
                )
              }
            } else {
              return a.td
            }
          }
        } )

        let hintCells = function() {
          let cells = form(ffP) || []
          if ( !options.stationary || !options.confined ) cells.push( a.td )
          return cells
        }

        return a.tr( hintCells() )

      }


      let tableBody = () => ff.items( {
        ...options.items,
        form: (fff) => {

          let fffP = new Proxy( fff, {
            get: ( target, property ) => {
              if ( property == 'field' ) {
                return ( options ) => {
                  return a.td( fff.control( options ), {
                    style: {
                      verticalAlign: 'top',
                      ...( options.tdTag || {} ).style
                    },
                    ...options.tdTag
                  } )
                }
              } else {
                return target[property]
              }
            }
          } )

          let cells = form( fffP )

          if ( !options.stationary || !options.confirmed ) cells.push( a.td(
            a['|appkit-form-nest-table-item-buttons']( [
              !options.stationary ? fffP.up( {
                itemTarget: (el) => el.$('^tr'),
                ...options.upButton
              } ) : null,
              !options.stationary ? fffP.down( {
                itemTarget: (el) => el.$('^tr'),
                ...options.downButton
              } ) : null,
              !options.confined ? fffP.remove( {
                itemTarget: (el) => el.$('^tr'),
                ...options.removeButton
              } ) : null,
            ], options.itemButtonsTag )
          ) )

          return cells

        },
        itemsTag: {
          $tag: 'tbody',
          ...options.itemsTag,
          $on: {
            'sortupdate': (e,el) => {
              el.$rescopeItems()
            },
            ...( options.itemsTag || {} ).$on,
          },
          $sortable: function() {
            this.$$('|appkit-form-nest-sort-off button').click() // turn off sort on children
            sortable( this, {
              forcePlaceholderSize: true
            } )
            this.$('^|appkit-form-nest').$$('|appkit-form-nest-add-button button').$disable()
            let buttons = this.$('^|appkit-form-nest |appkit-form-nest-items').$$('button').$$
            for ( let button of buttons ) {
              button.$disable && button.$disable()
            }
            this.$$('[draggable] > td *').style.pointerEvents = 'none' // do not let contents interfere with draggable
          },
          $unsortable: function() {
            this.$$('[draggable] > td *').style.pointerEvents = 'auto'
            sortable( this, 'destroy' )
            this.$('^|appkit-form-nest').$$('|appkit-form-nest-add-button button').$enable()
            let buttons = this.$('^|appkit-form-nest |appkit-form-nest-items').$$('button').$$
            for ( let button of buttons ) {
              button.$enable && button.$enable()
            }
          },
        },
        itemTag: {
          $tag: 'tr',
          ...options.itemTag,
        }
      } )

      let tableButtons = function() {

        return a['|appkit-form-nest-table-footer']( [

          !options.confined ? a['|appkit-form-nest-add-button'](
            ff.add( {
              target: (el) => el.$('^|appkit-form-nest tbody'),
              ...options.addButton,
            } ),
            options.addButtonTag
          ) : null,

          options.sortable ? a['|appkit-form-nest-sort-buttons']( [
            a['|appkit-form-nest-sort-on']( ff.button( {
              label: '⬍',
              onclick: (e,el) => {
                el.$('^|appkit-form-nest tbody').$sortable()
                let sortOn = el.$('^|appkit-form-nest-sort-on')
                sortOn.style.display = 'none'
                sortOn.nextSibling.style.display = ''
                sortOn.nextSibling.$('button').$enable()
              },
              ...options.sortOnButton,
            } ), options.sortOnTag ),
            a['|appkit-form-nest-sort-off']( ff.button( {
              label: '⬍ Drag',
              onclick: (e,el) => {
                el.$('^|appkit-form-nest tbody').$unsortable()
                let sortOff = el.$('^|appkit-form-nest-sort-off')
                sortOff.style.display = 'none'
                sortOff.previousSibling.style.display = ''
              },
              ...options.sortOffButton,
            } ), {
              ...options.sortOffTag,
              style: {
                ...( options.sortOffTag || {} ).style,
                display: 'none'
              },

            } ),
          ], options.sortButtonsTag ) : null,

        ], options.footerTag )

      }

      return a['|appkit-form-nest-table-wrapper']( [
        a.table( [
          tableHeader(),
          tableHelp(),
          tableBody(),
          tableHint(),
        ], options.tableTag ),
        tableButtons()
      ], {
        ...options.wrapperTag,
        style: {
          display: 'block',
          ...( options.wrapperTag || {} ).style
        },
      } )

    },
  } )

}

ax.extension.report.field.nest.prefab.shim.
many = function ( f, options ) {

  let a = ax.a

  return f.controls.nest( {
    ...options,
    report: (ff) => (a,x) => a['|appkit-report-nest-many-wrapper']( [
      ff.items( {
        ...options,
        report: (fff) => [
          a['|appkit-report-nest-many-item-header']( null, options.itemHeaderTag ),
          a['|appkit-report-nest-many-item-body']( options.report( fff ), options.itemBodyTag ),
        ],
      } ),
    ],
    {
      ...options.wrapperTag,
      style: {
        display: 'block',
        ...( options.wrapperTag || {} ).style
      },
    } )
  } )

}

ax.extension.report.field.nest.prefab.shim.
table = function ( r, options ) {

  let a = ax.a

  return r.controls.nest( {
    ...options,
    report: (rr) => (a,x) => {

      let report = options.report || ( () => {} )

      let tableHeader = function() {

        let rrP = new Proxy( rr, {
          get: ( target, property ) => {
            if ( property == 'field' ) {
              return ( options ) => {
                let label = options.label || x.lib.text.labelize( options.key )
                return a.th( a['|appkit-report-field']( [
                  label,
                  options.help ? r.helpbutton( {
                    helpbuttonTag: {
                      $on: {
                        'click: toggle help': function() {
                          this.$state = !this.$state
                          this.$('^table', `|appkit-report-field-help[data-field-key="${ options.key }"]`).$toggle()
                        },
                      },
                    },
                  } ) : null,
                ] ), options.thTag )
              }
            } else {
              return a.td // empty cell
            }
          }
        } )

        let headerCells = function() {
          let cells = report(rrP) || []
          return cells
        }

        return a.thead( a.tr( headerCells() ) )

      }

      let tableHelp = function() {

        let rrP = new Proxy( rr, {
          get: ( target, property ) => {
            if ( property === 'field' ) {
              return ( options ) => {
                let help = options.help
                return a.td(
                  rr.help( {
                    ...options,
                    helpTag: {
                      'data-field-key': options.key,
                      ...options.helpTag,
                    }
                  } ),
                  options.tdTag
                )
              }
            } else {
              return a.td // empty cell
            }
          }
        } )

        let helpCells = function() {
          let cells = report(rrP) || []
          return cells
        }

        return a.tr( helpCells() )

      }

      let tableHint = function() {

        let rrP = new Proxy( rr, {
          get: ( target, property ) => {
            if ( property == 'field' ) {
              return ( options ) => {
                let hint = options.hint
                // debugger
                return a.td(
                  rr.hint( options ),
                  options.tdTag
                )
              }
            } else {
              return a.td // empty cell
            }
          }
        } )

        let hintCells = function() {
          let cells = report(rrP) || []
          return cells
        }

        return a.tr( hintCells() )

      }

      let tableBody = () => rr.items( {
        ...options.items,
        report: (rrr) => {

          let rrrP = new Proxy( rrr, {
            get: ( target, property ) => {
              if ( property == 'field' ) {
                return ( options ) => {
                  return a.td( rrr.control( options ), {
                    style: {
                      verticalAlign: 'top',
                      ...( options.tdTag || {} ).style
                    },
                    ...options.tdTag
                  } )
                }
              } else {
                return target[property]
              }
            }
          } )

          let cells = report( rrrP )

          return cells

        },
        itemsTag: {
          $tag: 'tbody',
          ...options.itemsTag,
        },
        itemTag: {
          $tag: 'tr',
          ...options.itemTag,
        }
      } )

      return a['|appkit-report-nest-table-wrapper']( [
        a.table( [
          tableHeader(),
          tableHelp(),
          tableBody(),
          tableHint(),
        ], options.tableTag ),
      ], {
        ...options.wrapperTag,
        style: {
          display: 'block',
          ...( options.wrapperTag || {} ).style
        },
      } )

    },
  } )

}

ax.extension.form.async = {}

ax.extension.form.async.shim = function() {

  let a = ax.a
  let x = ax.x

  return {

    form:  ( f, target ) => ( options={} ) => a['|appkit-asyncform']( [
      a['div|appkit-asyncform-output'],
      a['|appkit-asyncform-body']( target( {
        ...options,
        formTag: {
          $controls: function() {
            return x.lib.unnested( this, '|appkit-form-control' )
          },
          $buttons: function() {
            return this.$$('button').$$
          },
          $disable: function() {
            let controls = [ ...this.$controls(), ...this.$buttons() ]
            for ( let i in controls ) {
              x.lib.element.visible( controls[i] ) &&
              controls[i].$disable &&
              controls[i].$disable()
            }
          },
          $enable: function() {
            let controls = [ ...this.$controls(), ...this.$buttons() ]
            for ( let i in controls ) {
              x.lib.element.visible( controls[i] ) &&
              controls[i].$enable &&
              controls[i].$enable()
            }
          },
          ...options.formTag,
          $on: {
            'submit: async submit': (e,el) => {

              e.preventDefault()

              let form = el.$('^form')
              let formData = el.$formData()

              let submitter = el.$('[type="submit"]:focus')
              if ( submitter && submitter.name ) {
                formData.append( submitter.name, submitter.value )
              }

              el.$disable && el.$disable()

              let outputEl = el.$('^|appkit-asyncform |appkit-asyncform-output')
              let completeFn = () => {
                el.$enable && el.$enable()
                var windowTop = $(window).scrollTop();
                var windowBottom = windowTop + $(window).height();
                var outputTop = $(outputEl).offset().top;
                var outputBottom = outputTop + $(outputEl).height();
                if ( ( outputBottom > windowBottom ) || ( outputTop < windowTop ) ) {
                  outputEl.scrollIntoView()
                }
                el.$send( 'axf.appkit.form.async.complete' )
              }

              if( ax.is.function( options.action ) ) {

                let submition = {
                  formData: formData,
                  data: ax.x.lib.form.data.objectify( formData ),
                  form: el,
                  output: outputEl,
                  complete: completeFn,
                  submitter: submitter,
                }

                options.action( submition ) && completeFn()

              } else {

                let body
                // Do not send empty form data. Some web servers don't lik it.
                if ( Array.from( formData.entries() ).length > 0 ) {
                  body = formData
                }

                outputEl.$nodes = (a,x) => x.http( {
                  url: el.getAttribute( 'action' ),
                  body: body,
                  method: el.getAttribute( 'method' ),
                  when: options.when,
                  success: options.success,
                  error: options.error,
                  catch: options.catch,
                  complete: completeFn,
                } )

              }

              // return false

            },
            ...( options.formTag || {} ).$on
          }

        },
      } ) ),
    ], options.asyncformTag ),

  }

}

ax.extension.jsoneditor = {}

ax.css( {
  '|appkit-form-codemirror': {
    '.jsoneditor-tree': {
      background: 'white',
    }
  }
} )

ax.extension.jsoneditor.form = {}

// ax.extension.jsoneditor.json = function( content, options={} ) {
//   return ax.a.textarea(
//     content,
//     {
//       $init: function() {
//
//         var options = {
//
//           // mode: 'view',
//
//         };
//
//         var editor = new JSONEditor(this, options);
//
//       }
//     }
//   )
// }

ax.extension.jsoneditor.form.
control = function( f, options={} ) {

  let a = ax.a
  let x = ax.x

  let controlTagOptions = {
    $init: function() {

      let editor = this

      let jsoneditorOptions = {
        onEditable: function (node) {
          return !editor.$disabled // Do not allow editing when disabled.
        },
        onChange: function() {
          editor.$stash()
          editor.$send( 'axf.appkit.form.control.change' )
        },
        ...options.jsoneditor
      }

      this.$editor = new JSONEditor( this.$('div'), jsoneditorOptions )

      let value = options.value || 'null'

      if ( options.parse ) {
        try {
          value = JSON.parse( value )
          this.$editor.set( value )
          this.$stash()
        }
        catch (error) {
          this.$nodes = a['p.error']( `⚠ ${ error.message }` )
        }
      } else {
        this.$editor.set( value )
        this.$stash()
      }

    },
    $stash: function() {
      this.$('input').value = this.$value()
    },
    $value: function() {
      return JSON.stringify( this.$editor.get() )
    },
    $data: function() {
      return this.$value()
    },
    $focus: function () {
      this.$('.jsoneditor-tree button').focus()
    },
    $disable: function() {
      this.$disabled = true
    },
    $enable: function() {
      if ( !options.disabled ) {
        this.$disabled = false
      }
    },
    $on: {

      'keydown: check for editor exit': (e,el) => {
        if ( e.keyCode == 27 && e.shiftKey ) {
          // shift+ESC pressed - move focus backward
          ax.x.lib.tabable.previous( el ).focus()
        } else if ( e.keyCode == 27 && e.ctrlKey ) {
          // ctrl+ESC pressed - move focus forward
          ax.x.lib.tabable.next( el ).focus()
        }
      },

    },

    ...options.controlTag

  }

  return a['|appkit-form-control']( [
    a['|appkit-form-jsoneditor']( [
      a.input( null, { name: options.name, type: 'hidden' } ),
      a.div,
    ], options.jsoneditorTag )
  ], controlTagOptions )

}

ax.extension.simplemde = {}

ax.extension.simplemde.form = {}

ax.extension.simplemde.form.control = function( f, options ) {

  let a = ax.a

  let toolbarIcons = [
    {
      name: 'bold',
      action: SimpleMDE.toggleBold,
      className: 'fa fa-bold',
      title: 'Bold',
    },
    {
      name: 'italic',
      action: SimpleMDE.toggleItalic,
      className: 'fa fa-italic',
      title: 'Italic',
    },
    {
      name: 'heading',
      action: SimpleMDE.toggleHeadingSmaller,
      className: 'fa fa-heading',
      title: 'Heading',
    },
    '|',
    {
      name: 'quote',
      action: SimpleMDE.toggleBlockquote,
      className: 'fa fa-quote-left',
      title: 'Quote',
    },
    {
      name: 'unordered-list',
      action: SimpleMDE.toggleUnorderedList,
      className: 'fa fa-list-ul',
      title: 'Generic List',
    },
    {
      name: 'ordered-list',
      action: SimpleMDE.toggleOrderedList,
      className: 'fa fa-list-ol',
      title: 'Numbered List',
    },
    '|',
    {
      name: 'link',
      action: SimpleMDE.drawLink,
      className: 'fa fa-link',
      title: 'Create Link',
    },
    {
      name: 'image',
      action: SimpleMDE.drawImage,
      className: 'fa fa-image',
      title: 'Insert Image',
    },
    {
      name: 'table',
      action: SimpleMDE.drawTable,
      className: 'fa fa-table',
      title: 'Insert Table'
    },
    '|',
    {
      name: 'preview',
      action: SimpleMDE.togglePreview,
      className: 'fa fa-eye no-disable',
      title: 'Toggle Preview',
    },
    {
      name: 'side-by-side',
      action: SimpleMDE.toggleSideBySide,
      className: 'fa fa-columns no-disable',
      title: 'Toggle Side by Side',
    },
    {
      name: 'fullscreen',
      action: SimpleMDE.toggleFullScreen,
      className: 'fa fa-arrows-alt no-disable',
      title: 'Toggle Fullscreen',
    }
  ]

  let simplemdeTagOptions = {

    $init: function() {
      this.$setup()
    },

    $setup: function() {

      this.$simplemde = new SimpleMDE( {
        element: this.$('textarea'),
        toolbar: toolbarIcons,
        placeholder: options.placeholder,
        autoDownloadFontAwesome: false,
        spellChecker: false,
        previewRender: options.preview,
        ...options.simplemde
      } )

      // Set required attribute on the CodeMirror textarea
      let checkRequired = ( value ) => {
        let textarea = this.$( '.CodeMirror textarea' )
        if ( options.required && !value ) {
          textarea.required = options.required
        } else {
          textarea.removeAttribute( 'required' )
        }
      }

      checkRequired( options.value )

      this.$refresh()

      this.$simplemde.codemirror.on( 'change', (e) => {
        checkRequired( this.$simplemde.value() )
      })

    },
    $refresh: function () {
      setTimeout( function() {
        this.$simplemde.codemirror.refresh()
      }.bind( this ), 1 )
    },

    $on: {
      'keyup: update textarea': (e,el) => {
        el.$('textarea').value = el.$simplemde.value()
        el.$send( 'axf.appkit.form.control.change' )
      },
      'keydown: check for editor exit': (e,el) => {

        if ( el.$( 'div.CodeMirror' ).classList.contains( 'CodeMirror-fullscreen' ) ) {
          // SimpleMDE closes fullscreen when ESC pressed.
          el.$simplemde.codemirror.focus()
        } else {

          if ( e.target.nodeName === 'TEXTAREA' ) {

            if ( e.keyCode == 27 && e.shiftKey ) {
              // shift+ESC pressed - move focus backward
              ax.x.lib.tabable.previous( e.target ).focus()
            } else if ( e.keyCode == 27 ) {
              // ESC pressed - move focus forward
              ax.x.lib.tabable.next( e.target ).focus()
            }

          }

        }

      },

    },

    ...options.simplemdeTag

  }


  let controlTagOptions = {

    $value: function() {
      return this.$$('textarea').value()
    },
    $disable: function() {
      this.$$('textarea').setAttribute('disabled', 'disabled')
    },
    $enable: function() {
      this.$('|appkit-form-simplemde').$refresh()
      this.$$('textarea').removeAttribute('disabled')
    },
    $focus: function () {
      this.$('|appkit-form-simplemde').$simplemde.codemirror.focus()
    },

    ...options.markdownTag
  }

  return a['|appkit-form-control'](
    a['|appkit-form-simplemde'](
      f.textarea(
        {
          value: options.value,
          name: options.name,
          ...options.textareaTag,
        }
      ),
      simplemdeTagOptions
    ),
    controlTagOptions
  )

}

ax.css( {
  '|appkit-form-simplemde': {
    '.editor-toolbar': {
      a: {
        color: '#333 !important',
      },
      backgroundColor: 'white',
      opacity: 1,
      borderBottom: '1px solid #e6e6e6',
      borderBottom: 'none',
      '&:before': {
        margin: 0,
      },
      '&:after': {
        margin: 0,
      },
    },
  }
} )

ax.extension.chartjs = function( options={} ) {

  var a = ax.a

  var wrapperTag = {
    $init: function() {
      this.$chart = new Chart(
        this.$('canvas').getContext('2d'), options.chartjs || {}
      )
    },
    ...options.wrapperTag,
  }

  return a['div|axf-chartjs-chart-wrapper']( [
    a.canvas( null, options.canvasTag ),
  ], wrapperTag )

}

// .chart alias
ax.extension.chart = ax.extension.chartjs

ax.extension.codemirror = {}

// ax.extension.codemirror.code = function( content, options={} ) {
//   return ax.a.textarea(
//     content,
//     {
//       $init: function() {
//         this.$codemirror = CodeMirror.fromTextArea( this, {
//           lineNumbers: true,
//           readOnly: true,
//           mode: options.mode || '',
//         } )
//         this.$codemirror.setSize('100%', '100%')
//         setTimeout( function() {
//           this.$codemirror.refresh()
//         }.bind( this ), 1 )
//       }
//     }
//   )
// }

ax.extension.codemirror.report = {}

// // These styles will apply to all codemirrors, on report and form.
// ax.extension.document.css[*](
//   {
//
//     'div.CodeMirror': {
//       minHeight: 2em,
//       borderRadius: unset,
//       padding: unset,
//       fontFamily: monospace,
//       zIndex: 1,
//       'div.CodeMirror-scroll': {
//         minHeight: unset,
//       }
//     }
//
//   }
// )

ax.extension.codemirror.form = {}

ax.extension.codemirror.form.control = function(
  f, options={}
) {

  let a = ax.a

  return a['|appkit-form-control'](
    a['|appkit-form-codemirror']( [
      this.control.toolbar( f, options ),
      this.control.editor( f, options ),
    ], {
      $setMode: function() {
        this.$('textarea').$codemirror.setOption(
          'mode',
          this.$( '|appkit-form-codemirror-mode' ).$value()
        )
      },
      $setKeymap: function () {
        this.$('textarea').$codemirror.setOption(
          'keyMap',
          this.$( '|appkit-form-codemirror-keymap' ).$value() || null,
        )
      },
    } ),
    {
      $value: function() {
        return this.$('textarea').$codemirror.getValue()
      },
      $focus: function () {
        this.$('textarea').$codemirror.focus()
      },
      $disable: function() {
        this.$$('textarea').setAttribute('disabled', 'disabled')
      },
      $enable: function() {
        this.$('textarea').$refresh()
        if ( !options.disabled ) {
          this.$$('textarea').removeAttribute('disabled')
        }
      },

      ...options.controlTag

    }
  )

}

ax.extension.codemirror.report.control = function(
  r, options={}
) {

  let a = ax.a
  let x = ax.x
  let report = x.codemirror.report

  return a['|appkit-report-control'](

    a['|appkit-report-codemirror'](
      [
        report.control.toolbar( options ),
        report.control.editor( options ),
      ],
      {

        // name: options.name,
        //
        // $value: function() {
        //   return options.value
        // },

        ...options.codeTag

      }
    ),

    {

      'data-name': options.name,
      $value: function() {
        return options.value
      },

      tabindex: 0,
      $focus: function() {
        this.focus()
      },

      ...options.controlTag

    }

  )



}

ax.extension.codemirror.form.control.editor = function(
  f, options={}
) {

  let a = ax.a

  return a['|appkit-form-codemirror-editor'](
    f.textarea(
      {
        name: options.name,
        value: options.value,
        textareaTag: {
          $init: function() {
            this.$setup()
          },
          $refresh: function () {
            setTimeout( function() {
              this.$codemirror.refresh()
            }.bind( this ), 1 )
          },
          $setup: function() {

            this.$codemirror = CodeMirror.fromTextArea( this, {
              lineNumbers: true,
              placeholder: options.placeholder,
            } )

            this.$('^|appkit-form-codemirror').$setMode()

            this.$codemirror.setSize('100%', '100%')

            this.$required()
            this.$refresh()

            this.$codemirror.on('keyup', function( codemirror, e ) {
              codemirror.getTextArea().$required()

            })

          },
          $required: function () {
            let value = this.$codemirror.getValue()
            let textarea = this.$('^|appkit-form-codemirror').$$('textarea')[1]
            if ( !value && options.required ) {
              // debugger
              textarea.setAttribute( 'required', true )

            } else {
              // debugger
              textarea.removeAttribute('required')
            }
          },
          ...options.textareaTag
        },
      }
    ),
    {
      $on: {
        'keyup: send control change event': (e,el) =>
          el.$send( 'axf.appkit.form.control.change' ),
        'keyup: update textarea value': function(e) {
          this.$('textarea').$codemirror.save()
        },
        'keydown: check for editor exit': function(e) {

          let container = this.$('^|appkit-form-codemirror')
          let allowEsc = this.$('textarea').$codemirror.options.keyMap != 'vim'

          if ( container.classList.contains( 'fullscreen' ) ) {

            if ( e.keyCode == 27 && ( allowEsc || e.ctrlKey ) ) {
              // ESC pressed - close full screen
              container.$('|appkit-form-codemirror-fullscreen button').click()
            }

          } else {

            if ( e.keyCode == 27 && e.shiftKey ) {
              // shift+ESC pressed - move focus backward
              ax.x.lib.tabable.previous( e.target ).focus()
            } else if ( e.keyCode == 27 && ( allowEsc || e.ctrlKey ) ) {
              // ESC pressed - move focus forward
              ax.x.lib.tabable.next( e.target ).focus()
            }

          }

        }
      }
    }
  )

}

ax.extension.codemirror.form.control.keymap = function(
  f, options
) {

  let a = ax.a
  let x = ax.x

  let keymap
  let component
  let value

  let keymapLabel = function( keymap ) {
    let labels = {
      vim: 'Vim',
      emacs: 'Emacs',
      sublime: 'Sublime',
    }
    return labels[ keymap ] || keymap
  }

  if ( ax.is.string( options ) ) {

    component = a.label( keymapLabel( options ) )
    value = () => options

  } else if ( options ) {

    if ( ax.is.not.object( options ) ) {
      options = {}
    }

    let show
    let selections = options.selections

    if ( ax.is.undefined( selections ) ) {

      selections = [
        [ 'default', '𝍣 Keys' ],
      ]

      if ( CodeMirror.keyMap.vim ) {
        show = true
        selections.push( [ 'vim', 'Vim' ] )
      }
      if ( CodeMirror.keyMap.emacs ) {
        show = true
        selections.push( [ 'emacs', 'Emacs' ] )
      }
      if ( CodeMirror.keyMap.pcSublime ) {
        show = true
        selections.push( [ 'sublime', 'Sublime' ] )
      }

    } else {
      show = true
    }

    if ( ax.is.true( show ) ) {
      component = f.select( {
        selections: selections,
        value: options.value,
        selectTag: {
          $on: { 'change: set CodeMirror keymap': function () {
            this.$('^|appkit-form-codemirror').$setKeymap()
          } },
          ...options.selectTag
        },
      } )
      value = function() {
        return this.$('select').$value()
      }
    } else {
      component = null
      value = () => 'default'
    }


  } else {

    component = null
    value = () => 'default'

  }

  return a['|appkit-form-codemirror-keymap']( component, {
    $value: value
  }, options.keymapTag )


}

ax.css( {
  '|appkit-form-codemirror': {
    display: 'block',
    border: '1px solid #b3b3b3',
    '|appkit-form-codemirror-toolbar': {
      display: 'block',
      overflow: 'auto',
      color: '#333',
      backgroundColor: 'white',
      borderBottom: '1px solid #e6e6e6',
      button: {
        fontSize: '1.2em',
        border: 'none',
        backgroundColor: 'transparent',
        cursor: 'pointer'
      },
      select: {
        padding: '2px',
        border: 'none',
        backgroundColor: 'transparent',
      }
    },
    '|appkit-form-codemirror-mode, |appkit-form-codemirror-keymap': {
      'select': {
        padding: '4px',
      },
      'label': {
        margin: '2px 10px',
      }
    },
    '|appkit-form-codemirror-toolbar-right': {
      float: 'right',
    },
    '&.fullscreen': {
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      border: 'none',
      borderRadius: '0px',
      zIndex: 999,
    },
    '|appkit-form-codemirror-editor': {
      'div.CodeMirror': {
        minHeight: '2em',
        border: 'unset',
        borderRadius: 'unset',
        padding: 'unset',
        fontFamily: 'monospace',
        zIndex: 1,
        'div.CodeMirror-scroll': {
          minHeight: 'unset',
        }
      }
    },
  }
} )

ax.extension.codemirror.form.control.mode = function(
  f, name, options={}
) {

  let a = ax.a

  let mode
  let component
  let value

  let selectName

  if ( name.endsWith(']') ) {
    selectName = name.replace(/(.*)(\])$/, "$1_mode$2" )
  } else {
    selectName = name + '_mode'
  }

  if ( ax.is.string( options ) ) {

    component = a.label( options )
    value = () => options

  } else if ( options ) {

    let selections = options.selections

    if ( ax.is.undefined( selections ) ) {
      selections = Object.keys( CodeMirror.modes ) // List of installed language modes
      selections.shift(); // remove null
    }

    if ( ax.is.object( selections ) && Object.entries( selections ).length > 0 ) {
      // selections = selections.map( ( mode ) => [ mode, modeLabel( mode ) ] )
      component = f.select( {
        name: selectName,
        placeholder: '𝍣 Mode',
        selections: selections,
        value: options.value,
        selectTag: {
          $on: { 'change: set CodeMirror mode': function () {
            this.$('^|appkit-form-codemirror').$setMode()
          } },
          ...options.selectTag
        },
      } )
      value = function() {
        return this.$('select').value
      }

    } else {

      component = null
      value = () => ''

    }


  } else {

    component = null
    value = () => ''

  }

  return a['|appkit-form-codemirror-mode']( component, {
    $value: value
  }, options.modeTag )


}

ax.extension.codemirror.form.control.toolbar = function(
  f, options={}
) {

  let a = ax.a

  return a['|appkit-form-codemirror-toolbar'](
    [
      this.mode( f, options.name, options.mode || false ),
      a['|appkit-form-codemirror-toolbar-right']( [
        this.keymap( f, options.keymap || false ),
        a['|appkit-form-codemirror-fullscreen'](
          a.button( '🗖', {
            type: 'button',
            $on: {
              'click: toggle full screen': function() {
                let container = this.$('^|appkit-form-codemirror')
                let editor = container.$('|appkit-form-codemirror-editor')
                let codemirror = editor.$('textarea').$codemirror
                if ( container.classList.contains('fullscreen') ) {
                  this.$text = '🗖'
                  container.classList.remove('fullscreen')
                  editor.style.height = ''
                  codemirror.focus()
                } else {
                  this.$text = '🗗'
                  container.classList.add('fullscreen')
                  codemirror.focus()
                }
              }
            }
          } )
        ) ]
      ),
    ],
    options.toolbarTag
  )

}

ax.extension.codemirror.report.control.editor = function(
  options={}
) {

  let a = ax.a

  return a['|appkit-report-codemirror-editor'](
    a.textarea(
      options.value,
      {
        $init: function() {
          this.$codemirror = CodeMirror.fromTextArea( this, {
            lineNumbers: true,
            readOnly: true,
            placeholder: options.placeholder,
            mode: options.mode || '',
          } )
          this.$codemirror.setSize('100%', '100%')
          setTimeout( function() {
            this.$codemirror.refresh()
          }.bind( this ), 1 )
        }
      }
    ),
    {
      $on: {
        'keydown: check for editor exit': function(e) {

          let container = this.$('^|appkit-report-codemirror')

          if ( container.classList.contains( 'fullscreen' ) ) {

            if ( e.keyCode == 27 ) {
              // ESC pressed - close full screen
              container.$('|appkit-report-codemirror-fullscreen button').click()
            }

          } else {

            if ( e.keyCode == 9 && e.shiftKey ) {
              // shift+TAB pressed - move focus backward
              ax.x.lib.tabable.previous( e.target ).focus()
            } else if ( e.keyCode == 9 ) {
              // TAB pressed - move focus forward
              ax.x.lib.tabable.next( e.target ).focus()
            }

          }

        }
      }
    }

  )

}

ax.css( {
  '|appkit-report-codemirror': {
    display: 'block',
    border: '1px solid #b3b3b3',
    '|appkit-report-codemirror-toolbar': {
      display: 'block',
      overflow: 'auto',
      color: '#333',
      backgroundColor: 'white',
      borderBottom: '1px solid #e6e6e6',
      button: {
        fontSize: '1.2em',
        border: 'none',
        backgroundColor: 'transparent',
        cursor: 'pointer'
      },
      select: {
        padding: '2px',
        border: 'none',
        backgroundColor: 'transparent',
      }
    },
    '|appkit-report-codemirror-mode': {
      'select': {
        padding: '4px',
      },
      'label': {
        margin: '2px 5px',
      }
    },
    '|appkit-report-codemirror-toolbar-right': {
      float: 'right',
    },
    '&.fullscreen': {
      position: 'fixed',
      top: '0',
      left: '0',
      right: '0',
      bottom: '0',
      border: 'none',
      borderRadius: '0px',
      zIndex: '999',
    },
    '|appkit-report-codemirror-editor': {
      'div.CodeMirror': {
        minHeight: '2em',
        border: 'unset',
        borderRadius: 'unset',
        padding: 'unset',
        fontFamily: 'monospace',
        zIndex: 1,
        'div.CodeMirror-scroll': {
          minHeight: 'unset',
        }
      }
    },
  },

} )

ax.extension.codemirror.report.control.toolbar = function(
  options={}
) {

  let a = ax.a

  return a['|appkit-report-codemirror-toolbar'](
    [
      a['|appkit-report-codemirror-mode'](
        a.label( options.mode ),
      ),
      a['|appkit-report-codemirror-toolbar-right'](
        a['|appkit-report-codemirror-fullscreen'](
          a.button( '🗖', {
            type: 'button',
            $on: {
              'click: toggle full screen': function() {
                let container = this.$( '^|appkit-report-codemirror' )
                let editor = container.$('|appkit-report-codemirror-editor')
                let codemirror = editor.$('textarea').$codemirror
                if ( container.classList.contains( 'fullscreen' ) ) {
                  this.$text = '🗖'
                  container.classList.remove('fullscreen')
                  editor.style.height = ''
                  codemirror.focus()
                } else {
                  this.$text = '🗗'
                  container.classList.add('fullscreen')
                  codemirror.focus()
                }
              }
            }
          } )
        )
      ),
    ],
  )

}

ax.extension.menu = ( options={} ) => (a,x) => {

  let items = options.menu || []

  return a['|appkit-menu'](
    a.menu( items.map(
      ( item ) => ax.is.object( item ) ? a.menuitem( x.menu.item( item, options.item ) ) : item )
    ),
    {
      $init: (el) => {
        let z = Number( window.getComputedStyle( el ).zIndex )
        el.$$('|appkit-menu-submenu').$setZ( z + 1 )
      },
      $closeSubmenus: function () {
        this.$$('|appkit-menu-submenu').style.display = 'none'
      },
      ...options.menuTag,
    }
  )

}

ax.extension.popup = function( component, options={} ) {

  let a = ax.a
  let x = ax.x

  let popupTagOptions = {
    ...options.popupTag,
    style: {
      // display: 'none',
      position: 'fixed',
      zIndex: 1,
      ...( options.popupTag || {} ).style
    }
  }

  let contextTagOptions = {
    $on: {
      // 'axf.appkit.context.popup.close': (e,el) => {
      // },
      'click: close submenus': (e,el) => {
        if ( options.menu ) {
          let menu = el.$('|appkit-menu')
          menu && menu.$closeSubmenus()
        }
        el.$('|appkit-context-popup').style.display = 'none'
      },
    },
    $menu: function() {

      let parent = this.$('^ ^|appkit-context')
      let menu = options.menu || []
// debugger
      if ( parent ) {
        menu.push( ...parent.$menu() )
      }

      return menu

    },
    ...options.contextTag
  }

  let nudgePopup = function( target ) {

    let rect = target.getBoundingClientRect();
    let ww = window.innerWidth
    let wh = window.innerHeight
    let bGap = wh - rect.top - rect.height
    let rGap = ww - rect.left - rect.width
    // debugger
    if ( bGap < 0 ) target.style.top = `${ rect.y + bGap }px`
    if ( rGap < 0 ) target.style.left = `${ rect.x + rGap }px`

  }

  let contentTagOptions = {
    $init: (el) => {

      let popupContents
      let context = el.$('^|appkit-context')

      if ( options.menu ) {
        if ( ax.is.function( x.menu ) ) {
          // debugger
          popupContents = x.menu( { menu: context.$menu() } )
        } else {
          popupContents = options.menu
        }
      } else {
        popupContents = options.popup || null
      }

      let popup = context.$('|appkit-context-popup')

      let clickHandler = function(e) {
        if ( !popup.contains( e.target ) ) {
          if ( options.menu ) {
            let menu = popup.$('|appkit-menu')
            menu && menu.$closeSubmenus()
          }
          popup.style.display = 'none'
          removeClickHandler()
          el.$send( 'axf.appkit.context.popup.close' )
        }
      }

      let removeClickHandler = function() {
        document.removeEventListener( 'mousedown', clickHandler )
      }

      let addClickHandler = function() {
        document.addEventListener( 'mousedown', clickHandler )
      }

      el.$on( {
        'click: show popup': (e) => {
          e.preventDefault()
          e.stopPropagation()
          popup.$nodes = popupContents
          popup.style.left = `${ e.pageX + 1 }px`
          popup.style.top = `${ e.pageY + 1 }px`
          popup.style.display = 'inline-block'
          nudgePopup( popup )
          addClickHandler()
          el.$send( 'axf.appkit.context.popup.show' )
        }
      } )

    },
    ...options.contentTag
  }

  return (a,x) => a['|appkit-context']( [
    a['|appkit-context-content']( component, contentTagOptions ),
    a['|appkit-context-popup']( null, popupTagOptions )
  ], contextTagOptions )


}

// ax.extension.popup( )

ax.extension.context = function( options={} ) {

  let a = ax.a
  let x = ax.x

  let component = options.content || null

  let popupTagOptions = {
    ...options.popupTag,
    style: {
      // display: 'none',
      position: 'fixed',
      zIndex: 1,
      ...( options.popupTag || {} ).style
    }
  }

  let contextTagOptions = {
    $on: {
      // 'axf.appkit.context.popup.close': (e,el) => {
      // },
      'click': (e,el) => {
        if ( options.menu ) {
          let menu = el.$('|appkit-menu')
          menu && menu.$closeSubmenus()
        }
        el.$('axf-context-popup').style.display = 'none'
      },
    },
    $menu: function() {

      let parent = this.$('^ ^axf-context')
      let menu = options.menu || []
// debugger
      if ( parent ) {
        menu.push( ...parent.$menu() )
      }

      return menu

    },
    ...options.contextTag,
    style: {
      cursor: 'context-menu',
      ...( options.contextTag || {} ).style,
    }
  }

  let nudgePopup = function( target ) {

    let rect = target.getBoundingClientRect();
    let ww = window.innerWidth
    let wh = window.innerHeight
    let bGap = wh - rect.top - rect.height
    let rGap = ww - rect.left - rect.width
    // debugger
    if ( bGap < 0 ) target.style.top = `${ rect.y + bGap }px`
    if ( rGap < 0 ) target.style.left = `${ rect.x + rGap }px`

  }

  let contentTagOptions = {
    $init: (el) => {

      let popupContents
      let context = el.$('^axf-context')

      if ( options.menu ) {
        if ( ax.is.function( x.menu ) ) {
          // debugger
          popupContents = x.menu( { menu: context.$menu() } )
        } else {
          popupContents = options.menu
        }
      } else {
        popupContents = options.popup || null
      }

      let popup = context.$('axf-context-popup')

      let clickHandler = function(e) {
        if ( !popup.contains( e.target ) ) {
          if ( options.menu ) {
            let menu = popup.$('|appkit-menu')
            menu && menu.$closeSubmenus()
          }
          popup.style.display = 'none'
          removeClickHandler()
          el.$send( 'axf.appkit.context.popup.close' )
        }
      }

      let removeClickHandler = function() {
        document.removeEventListener( 'mousedown', clickHandler )
      }

      let addClickHandler = function() {
        document.addEventListener( 'mousedown', clickHandler )
      }

      el.$on( {
        'contextmenu': (e) => {
          e.preventDefault()
          e.stopPropagation()
          popup.$nodes = popupContents
          popup.style.left = `${ e.pageX + 1 }px`
          popup.style.top = `${ e.pageY + 1 }px`
          popup.style.display = 'inline-block'
          nudgePopup( popup )
          addClickHandler()
          el.$send( 'axf.appkit.context.popup.show' )
        }
      } )

    },
    ...options.contentTag
  }

  return (a,x) => a['axf-context']( [
    a['axf-context-content']( component, contentTagOptions ),
    a['axf-context-popup']( null, popupTagOptions )
  ], contextTagOptions )


}

// ax.extension.popup( )

ax.extension.menu.item = ( item, options={} ) => (a,x) => {

  let component

  if ( item.menu ) {
    component = [
      a['|appkit-menu-submenu-open-caret']( '⯈' ),
      a['|appkit-menu-submenu-open']( item.label ),
      a['|appkit-menu-submenu'](
        x.menu( { menu: item.menu } ),
        {
          $setZ: function(z) { this.style.zIndex = z },
        }
      )
    ]
  } else {
    component = x.button( { label: item.label, onclick: item.onclick } )
  }

  let openSubmenu = (e,el) => {
    e.preventDefault()
    let target = el.$('|appkit-menu-submenu')
    let submenus = el.$('^|appkit-menu').$$('|appkit-menu-submenu').$$

    for ( let i in submenus ) {
      let submenu = submenus[i]
      if ( submenu.contains( target ) ) {
        target.style.display = 'unset'
        nudgeSubmenu( target )
      } else {
        submenu.style.display = 'none'
      }
    }
  }

  let nudgeSubmenu = function( target ) {

    let rect
    rect = target.getBoundingClientRect()
    target.style.top = '0px'
    target.style.left = `${ rect.width }px`
    rect = target.getBoundingClientRect();
    let ww = window.innerWidth
    let wh = window.innerHeight
    let bGap = wh - rect.top - rect.height
    let rGap = ww - rect.left - rect.width
    if ( bGap < 0 ) target.style.top = `${ bGap }px`
    if ( rGap < 0 ) target.style.left = `${ rect.width + rGap }px`

  }

  let itemTagOptions = {
    ...options.itemTag,
    $on: {
      'click': (e,el) => {
        if ( e.target.tagName == 'APPKIT-MENU-SUBMENU-OPEN' ) {
          openSubmenu(e,el)
          e.stopPropagation()
        // } else {
        //   let outside = el.$('^|appkit-menu ^')
        //   outside.click()
        //   debugger
        }
      },
      'mouseenter': (e,el) => {
        openSubmenu(e,el)
      },
      ...( options.itemTag || {} ).$on
    }
  }

  return a['|appkit-menu-item']( component, itemTagOptions )
}

ax.css( {
  '|appkit-menu': {
    display: 'block',
    width: '150px',
    zIndex: 1,
    '|appkit-menu-item': {
      display: 'block',
      width: '100%',
      userSelect: 'none',
      // padding: '2px 5px',
      // padding: '2px',
      // margin: '',
      position: 'relative',
      '|appkitMenuSubmenuOpen': {
        whiteSpace: 'nowrap',
        display: 'block',
        width: '125px',
        lineHeight: '1.5',
        padding: '0.375rem',
        overflowX: 'hidden',
      },
      appkitMenuSubmenuOpenCaret: {
        float: 'right',
        lineHeight: '1.5',
        padding: '0.375rem',
      },
      appkitMenuSubmenu: {
        position: 'absolute',
        left: '150px',
        top: '0px',
        display: 'none'
      },
      '&:hover': {
        backgroundColor: 'lightgray',
      },
      button: {
        lineHeight: '1.5',
        padding: '0.375rem',
        width: '100%',
        border: 'none',
        background: 'none',
        textAlign: 'left',
      },
    },
    hr: {
      marginTop: '0.375rem',
      marginBottom: '0.375rem',
    },
    menu: {
      margin: 0,
      padding: 0,
      backgroundColor: 'white',
      boxShadow: '0px 0px 5px gray',
    },
  }
} )

ax.extension.filepond = ( options={} ) => {

  return ax.a['axf-filepond']( null, {

    $init: (el) => {

      el.$nodes = FilePond.create( {
        server: options.server,
        ...options.filepond
      } ).element

    },

    ...options.filepondTag

  } )

}

ax.css( {
  'axf-filepond': {
    display: 'block',
  }
} )

ax.extension.markedjs = {}

ax.extension.markedjs.report = {}

ax.extension.markedjs.markdown = function ( options={} ) {

  let a = ax.a

  let content = options.markdown || ''
  let html

  let processMarkdown = function( string ) {
    string = ( string || '').toString()
    if ( options.inline ) {
      return marked.inlineLexer( string, [] )
    } else {
      return marked( string )
    }
  }

  if ( content instanceof Array ) {
    let result = []
    content.forEach( function( item ) {
      result.push( processMarkdown( item ) )
    } )
    html = result.join('')
  } else {
    html = processMarkdown( content )
  }

  if ( options.sanitize ) {
    html = options.sanitize( html )
  }

  return a['div|axf-markedjs']( a( html ), options.markedjsTag )

}

ax.extension.markedjs.report.control = function(
  r, options={}
) {

  let a = ax.a
  let x = ax.x

  let value = options.value
  let component

  if ( value ) {
    component = x.markedjs.markdown( {
      markdown: value,
      markedjsTag: options.markedjsTag,
    } )
  } else {
    component = a.span(
      options.placeholder || 'None',
      { class: 'placeholder' }
    )
  }

  return a['|appkit-report-control'](
    a['|appkit-report-markdown'](
      component,
      options.markdownTag
    ),
    {

      'data-name': options.name,
      $value: function() {
        return options.value
      },

      tabindex: 0,
      $focus: function() {
        this.focus()
      },

      ...options.controlTag

    }
  )

}

ax.extension.panes = function ( options={} ) {

  let a = ax.a

  let proximate = options.proximate || null
  let adjacent = options.adjacent || null
  let orientation = options.vertical ? 'vertical' : 'horizontal'

  function move(e) {

    let el = e.target.$('^|axf-panes')

    let percent,
        vertical = options.vertical

    if ( vertical ) {
      let position = el.clientHeight - ( e.clientY - el.offsetTop )
      percent = 100 * position / el.clientHeight
    } else {
      let position = el.clientWidth - ( e.clientX - el.offsetLeft )
      percent = 100 * ( 1 - position / el.clientWidth )
    }

    resize( el, percent, vertical )

  }

  function resize( el, percent, vertical ) {

    let proximateEl = el.$('|axf-panes-proximate'),
          adjacentEl = el.$('|axf-panes-adjacent'),
          drag = el.$('|axf-panes-drag')

    percent = Number( percent || 50 )
    if ( Number.isNaN( percent ) ) percent = 50
    if ( percent > 90 ) percent = 90
    if ( percent < 10 ) percent = 10

    if ( vertical ) {
      proximateEl.style.bottom = `calc( ${ 100 - percent }% + 2px )`
      adjacentEl.style.top = `calc( ${ percent }% + 2px )`
      drag.style.top = `calc( ${ percent }% - 2px )`
    } else {
      proximateEl.style.right = `calc( ${ 100 - percent }% + 2px )`
      adjacentEl.style.left = `calc( ${ percent }% + 2px )`
      drag.style.left = `calc( ${ percent }% - 2px )`
    }

    // el.$send( 'resize' )
    el.$send( 'axf.panes.resize', { detail: { percent: percent } } )
  }

  function clear(e) {
    e.target.$('^|axf-panes').classList.remove( 'dragable' )
    document.removeEventListener( 'mousemove', move )
    document.removeEventListener( 'mouseup', clear )
  }

  return a['|axf-panes']( [
    a['|axf-panes-proximate']( proximate ),
    a['|axf-panes-drag']( null, { $on: {
      'mousedown': (e,el) => {
        el.$('^|axf-panes').classList.add( 'dragable' )
        document.addEventListener( 'mousemove', move )
        document.addEventListener( 'mouseup', clear )
      },
    } } ),
    a['|axf-panes-adjacent']( adjacent ),
  ], {
    class: orientation,
    $init: function() {
      resize( this, options.percent, options.vertical )
    },
    ...options.panesTag
  } )

}

ax.css( {

  '|axf-panes': {

    position: 'fixed',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,

    '|axf-panes-proximate': {
      display: 'block',
      position: 'absolute',
      left: 0,
      top: 0,
      bottom: 0,
      right: 'calc( 50% + 2px )',
      overflowY: 'auto',
      overflowX: 'hidden',
    },

    '|axf-panes-adjacent': {
      display: 'block',
      position: 'absolute',
      right: 0,
      top: 0,
      bottom: 0,
      left: 'calc( 50% + 2px )',
      // paddingLeft: '2px',
      overflowY: 'auto',
      overflowX: 'hidden',
      // color: '#fff',
    },

    '|axf-panes-drag': {
      display: 'block',
      position: 'absolute',
      left: 'calc( 50% - 2px )',
      top: 0,
      bottom: 0,
      width: '4px',
      background: '#0001',
      '&:hover': {
        background: '#ddd',
      }
    },

    '&.dragable': {
      cursor: 'grabbing',
      '|axf-panes-drag': {
        background: '#aaa',
      },
    },

    '&:not(.dragable)': {
      '|axf-panes-drag': {
        cursor: 'ew-resize',
      },
    },

    '&.vertical': {

      '|axf-panes-proximate': {
        bottom: 'calc( 50% + 2px )',
        right: 0,
        // overflowY: 'hidden',
        // overflowX: 'auto',
      },

      '|axf-panes-adjacent': {
        // width: '100%',
        left: 0,
        top: 'calc( 50% + 2px )',
        // paddingTop: '2px',
        // overflowY: 'hidden',
        // overflowX: 'auto',
      },

      '|axf-panes-drag': {
        display: 'block',
        position: 'absolute',
        top: 'calc( 50% - 2px )',
        left: 0,
        right: 0,
        height: '4px',
        width: '100%',
        background: '#eee',
      },

      '&:not(.dragable)': {
        '|axf-panes-drag': {
          cursor: 'ns-resize',
        },
      },

    }

  }

} )

ax.extension.xtermjs = ( options={} ) => (a,x) =>

a['axf-xtermjs']( [
  a['axf-xtermjs-toolbar'](
    [
      a['axf-xtermjs-toolbar-left']( options.label ),
      a['axf-xtermjs-toolbar-right'](
        a['axf-xtermjs-fullscreen'](
          a.button( '🗖', {
            type: 'button',
            $on: {
              'click: toggle full screen': function() {
                let terminal = this.$('^axf-xtermjs')
                terminal.$fullscreen = !terminal.$fullscreen
                if ( terminal.$fullscreen ) {
                  this.$text = '🗗'
                  this.$('^body').style.overflowY = 'hidden'
                  this.$('^body').querySelectorAll('axf-xtermjs').forEach( (el) => {
                    if ( el != this.$('^axf-xtermjs') ) el.$('axf-xtermjs-container').style.display = 'none'
                  } )
                  terminal.$('^axf-xtermjs').classList.add('fullscreen')
                } else {
                  this.$text = '🗖'
                  this.$('^body').style.overflowY = 'auto';
                  this.$('^body').querySelectorAll('axf-xtermjs').forEach( (el) => {
                    el.$('axf-xtermjs-container').style.display = ''
                  } )
                  terminal.$('^axf-xtermjs').classList.remove('fullscreen')
                }
                terminal.$xterm.toggleFullScreen( terminal.$fullscreen )
                terminal.$xterm.fit()
                // Fit called twice as hack for bug where resizing is
                // terminal.$xterm.fit() // wrong after exiting fullscreen.
              },
            },
          } )
        )
      ),
    ],
    options.toolbarTag
  ),
  a['axf-xtermjs-container']
  ], {
    $init: function() {

      const resizeFn = function() {
        this.$xterm.fit()
        // Fit called twice as hack for bug where resizing is
        // this.$xterm.fit() // wrong after some page zoom changes.
      }.bind( this )

      window.addEventListener( 'resize', resizeFn )

      Terminal.applyAddon( fullscreen )
      Terminal.applyAddon( fit )
      this.$xterm = new Terminal( options.terminal )
      this.$xterm.open( this.$('axf-xtermjs-container') )
      this.$xterm.write( options.text || '' )
      resizeFn()

    },
    $on: {
      // 'keyup: check for escape fullscreen': function(e) {
      //   if ( e.keyCode == 27 ) {
      //     this.$('^axf-xtermjs').$xterm.toggleFullScreen(false)
      //   }
      // },
      // 'onblur: close fullscreen': function(e) {
      //   this.$('^axf-xtermjs').$xterm.toggleFullScreen(false)
      // },
    },
    $write: function( text ) {
      this.$xterm.write( text )
      // this.$xterm.fit()
    },
    ...options.terminalTag
  }
)

ax.extension.xtermjs.report = {}

ax.css( {

  'axf-xtermjs': {

    display: 'block',
    height: 'calc( 300px + 1.8rem )',
    // width: '100%',

    '&.fullscreen': {
      // height: 'unset',
      height: 'calc( 100vh - 1.8rem - 3px )',
      marginTop: 'calc( 1.8rem + 4px )',
      position: 'fixed',
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      zIndex: 1,
      // height: '100vh',
      // width: '100%',
      'axf-xtermjs-toolbar': {
        zIndex: '257',
        position: 'fixed',
        top: 0,
        left: 0,
        right: 0,
      },
      'axf-xtermjs-container': {
        height: '100%',
        '.xterm-screen': {
          marginTop: '1.8rem',
        }
      },
    },

    'axf-xtermjs-container': {
      display: 'block',
      height: '300px',
      // width: '100%',
      // padding: '30px',
    },

    'axf-xtermjs-toolbar': {
      display: 'block',
      overflow: 'auto',
      backgroundColor: 'white',
      border: '1px solid #e6e6e6',
      borderBottom: 'none',
      button: {
        fontSize: '1.2rem',
        border: 'none',
        backgroundColor: 'transparent',
        cursor: 'pointer'
      },
    },

    'axf-xtermjs-toolbar-right': {
      float: 'right',
    },

    'axf-xtermjs-toolbar-left': {
      lineHeight: '1.8',
      paddingLeft: '5px',
    },

  }

} )

ax.extension.xtermjs.report.control = function(
  r, options={}
) {

  let a = ax.a
  let x = ax.x

  return a['|appkit-report-control'](
    a['|appkit-report-terminal'](
      x.xtermjs( {
        text: options.value || '',
        ...options.xtermjs,
      } ),
      options.terminalTag
    ),
    {

      'data-name': options.name,
      $value: function() {
        return options.value
      },

      tabindex: 0,
      $focus: function() {
        this.focus()
      },

      ...options.controlTag

    }
  )

}
