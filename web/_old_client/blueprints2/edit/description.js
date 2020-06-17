app.blueprints2.edit.description = (router, blueprint) => (a, x) =>
app.blueprints2.edit.editable({
  router: router,
  division: "description",
  blueprint: blueprint,
  form: f => [
    f.field({key: "description", as: "textarea"}),
  ],
  report: r => [
    r.field({key: "description"}),
  ]
});
