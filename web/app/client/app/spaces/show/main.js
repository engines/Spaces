app.spaces.show.main = (router,spaces) => (a, x) => a['div.m-2']( router.nest({
  routes: {
    "/?": 'Home',
    "/blueprints*": app.blueprints,
    "/resolutions*": app.resolutions,
  },
}) );
