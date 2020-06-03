app.blueprints.edit.os_packages = (router, blueprint) => (a, x) =>
app.blueprints.edit.editable({
  router: router,
  division: "os_packages",
  blueprint: blueprint,
  form: (f) => [
    f.field({
      key: "os_packages",
      label: "OS Packages",
      as: 'table',
      singular: 'package',
      collection: true,
      draggable: true,
      addable: true,
      deletable: true,
      form: ff => [
        ff.field({
          key: 'name',
          label: false,
          required: true,
        }),
      ],
    }),
  ],
  report: (r) => [
    r.field({
      label: "OS Packages",
      as: 'listgroup',
      value: (r.object.os_packages || []).map( package => package.name),
    }),
  ],
});
