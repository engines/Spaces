app.resolutions.show = (router) => (a, x) => [
  app.button({
    label: app.icon("fa fa-trash", "Delete"),
    onclick: () => router.open("delete"),
    class: "btn app-btn-danger",
  }),
  a.hr,
  app.http({
    url: `/api/resolutions/${router.params.resolution_id}`,
    placeholder: app.spinner(
      `Loading resolution ${router.params.resolution_id}`
    ),
  }),
];
