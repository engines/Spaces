app.blueprints.inplace = (router, component, path) => (a, x) => a['app-blueprint-inplace'](
  component,
  {
    $on: {click: ()=> router.open(path)}
  }
)
