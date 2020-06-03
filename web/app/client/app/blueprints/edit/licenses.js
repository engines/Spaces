app.blueprints.edit.licenses = (router, blueprint) => (a, x) =>
app.blueprints.edit.editable({
  router: router,
  division: "licenses",
  blueprint: blueprint,
  form: (f) => [
    f.field({
      key: "licenses",
      as: 'many',
      singular: 'license',
      collection: true,
      draggable: true,
      addable: true,
      deletable: true,
      form: ff => [
        ff.field({
          key: 'label',
          required: true,
        }),
        ff.field({
          key: 'url',
          label: 'URL',
          required: true,
        }),
      ],
    }),
  ],
  report: (r) => [
    // r.object.licenses,
    r.field({
      label: "Licenses",
      as: 'listgroup',
      value: (r.object.licenses || []).map( license => license.label),
    }),
  ],
});
