app.blueprints.edit.ports = (router, blueprint) => (a, x) =>
app.blueprints.edit.editable({
  router: router,
  action: "~ports-edit",
  blueprint: blueprint,
  form: (f) => [
    f.field({
      key: "ports",
      as: 'table',
      singular: 'port',
      collection: true,
      form: ff => [
        ff.field({
          key: 'name',
          label: false,
        }),
      ],
    }),
  ],
  report: (r) => [
    r.field({
      key: "ports",
      as: 'table',
      report: rr => [
        rr.field({
          key: 'name',
          label: false,
        }),
      ],
    }),
  ],
});
