app.blueprints.edit.inplaceform = (options = {}) => (a, x) => a['app-inplaceform']( [
  // a['app-inplaceform-background.d-block.position-fixed.fixed-top.fixed-bottom'](null, {
  //   $on: {
  //     'click: focus on form': (e,el) => {
  //       el.$('^app-inplaceform').$focus()
  //     }
  //   }
  // }),
  app.form({
    // ...options,
    url: `/api/blueprints/${options.router.params.blueprint_id}/${options.key}`,
    method: 'PUT',
    object: options.blueprint,
    // let path = `/blueprints/${router.params.blueprint_id}/title`;
    // asyncformTag: {
    //   ...options.asyncformTag,
    //   style: {
    //     zIndex: 2000,
    //     display: 'block',
    //     position: 'relative',
    //     ...(options.asyncformTag || {}).style,
    //   },
    // },
    form: f => [
      options.form(f),
      f.buttons(options.router),
    ],
    success: (result,el) => {
      // el.$('^app').classList.remove('inplaceform-in')
      blueprint = el.$('^app-blueprint')
      blueprint.$state[options.key] = result
      options.router.open('..')
    },
    formTag: {
      ...options.formTag,
      $submit: function() {
        if ( this.checkValidity() ) {
          this.$send('submit')
        } else {
           this.reportValidity()
        }
      },
      $cancel: function() {
        // this.$('^app').classList.remove('inplaceform-in')
        options.router.open(`/blueprints/${options.router.params.blueprint_id}/edit`);
      },
      $on: {
        // "ax.appkit.form.table.drag.start: ensure focus stays on form":
        //   (e,el) => el.$('|appkit-form-nest-drag-off button').focus(),
        // "ax.appkit.form.table.drag.stop: ensure focus stays on form":
        //   (e,el) => el.$('|appkit-form-nest-drag-off button').focus(),
        // "ax.appkit.form.table.drag.update: ensure focus stays on form":
        //   (e,el) => el.$('|appkit-form-nest-drag-off button').focus(),
        "keydown: cancel on ESC, submit on ENTER": (e, el) => {
          if (e.keyCode == 27) {
            el.$cancel()
          // } else if (e.keyCode == 13 && !e.shiftKey) {
          //   el.$submit()
          }
        },
        ...(options.formTag || {}).$on,
      },
    },
  })
], {
  // $init: (el) => {
  //   // el.$('^app').classList.add('inplaceform-in')
  //   el.$focus()
  // },
  // $focus: function () {
  //   if (!this.contains(document.activeElement)) {
  //     let first = this.$('input:not([type="hidden"]),select,textarea,button');
  //     if (first) setTimeout( () => first.focus(), 1);
  //   }
  // },
  // $on:{
  //   "focusout: submit when loses form focus": (e, el) => {
  //     setTimeout( () => {
  //       let form = el.$('form')
  //       if ( !form.contains(document.activeElement) ) {
  //         form.$$('|appkit-form-nest-drag-off button').click()
  //         setTimeout( () => {
  //           form.$submit()
  //         }, 1)
  //       }
  //     }, 1)
  //   },
  // },
})
