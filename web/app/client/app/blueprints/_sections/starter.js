app.blueprints.starter = (router, blueprint, i) => (a, x) => {

  let routes = {}

  routes[`/stages/${i}/starter`] = router => app.blueprints.starter.edit(router, blueprint, i)
  routes['*'] = router => app.blueprints.starter.show(router, blueprint, i)

  return router.nest({
    routes: routes
  })

}
