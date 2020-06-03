app.installations.show = (router) => (a, x) => [
  app.button({
    label: app.icon("fa fa-trash", "Delete"),
    onclick: () => router.open("delete"),
    class: "btn app-btn-danger",
  }),
  a.hr,
  app.http({
    url: `/api/installations/${router.params.installation_id}`,
    placeholder: app.spinner(
      `Loading installation ${router.params.installation_id}`
    ),
  }),
];
