app.spaces.show.main = (router,spaces) => (a, x) => a['div.m-2']( router.routes({
  "/?": 'Home',
  "/blueprints*": app.blueprints,
  "/installations*": app.installations,
}) );
