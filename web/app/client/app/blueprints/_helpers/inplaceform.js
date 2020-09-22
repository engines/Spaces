app.blueprints.inplaceform = (options = {}) => (a, x) => a['app-blueprint-inplaceform']([
  a['app-blueprint-inplaceform-background.d-block.position-fixed.fixed-top.fixed-bottom'](null, {
    $on: {
      'click: close form': (e,el) => {
        if (e.target == el) el.$('^app-blueprint-inplaceform').$close()
      }
    }
  }),
  app.form({
    url: `/api/blueprinting/${options.router.params.blueprint_id}/${options.keys.join('/')}`,
    method: 'PUT',
    object: options.object,
    form: f => [
      options.form(f),
      f.buttons({
        cancel: {
          onclick: (e,el) => el.$('^app-blueprint-inplaceform').$close()
        }
      }),
    ],
    success: (result,el) => {
      blueprint = el.$('^app-blueprint')
      x.lib.object.assign(blueprint.$state, options.keys, result)
      el.$('^app-blueprint-inplaceform').$close()
    },
    formTag: {
      $on: {
        "keydown: cancel on ESC, submit on ENTER": (e, el) => {
          if (e.keyCode == 27) {
            el.$('^app-blueprint-inplaceform').$close()
          }
        },
      },
    },
  })
],{
  $close: function() {
    options.router.open(options.close || '..');
  },
})
