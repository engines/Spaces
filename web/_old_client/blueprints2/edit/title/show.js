app.blueprints2.edit.title.show = (router, blueprint) => app.inplacereport({
  router: router,
  object: blueprint,
  report: r => [
    // blueprint,
    r.field({
      key: 'title',
    })
  ]
})

app.inplacereport = options => (a,x) => a['app-inplacereport']([
  app.report({
    ...options,
    reportTag: {
      ...options.reportTag,
      $on: {
        click: () => options.router.open('title'),
        ...(options.reportTag || {}).$on,
      },
    },
  })
])
