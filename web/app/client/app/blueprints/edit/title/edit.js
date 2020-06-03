app.blueprints.edit.title.edit = (router, blueprint) => (a,x) => {

  return app.blueprints.edit.inplaceform({
    key: 'title',
    router: router,
    blueprint: blueprint,
    form: f => [
      f.field({
        key: 'title',
      }),
    ],
  })

}
