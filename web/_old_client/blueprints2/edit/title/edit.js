app.blueprints2.edit.title.edit = (router, blueprint) => (a,x) => {

  return app.blueprints2.edit.inplaceform({
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
