app.report = (options = {}) => (a, x) =>
  x.report({
    shims: [
      x.report.field.shim,
      x.report.field.extras.shim,
      x.report.field.dependent.shim,
      x.report.field.nest.shim,
      x.report.field.nest.prefab.shim,
      x.bootstrap.report.shim,
      app.report.shim,
    ],
    ...options,
  });
