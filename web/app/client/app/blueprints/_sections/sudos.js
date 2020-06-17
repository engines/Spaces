app.blueprints.sudos = (router, blueprint, i) => (a, x) => {

  let routes = {}

  routes[`/stages/${i}/sudos`] = router => app.blueprints.sudos.edit(router, blueprint, i)
  routes['*'] = router => app.blueprints.sudos.show(router, blueprint, i)

  return router.nest({
    routes: routes
  })

}
