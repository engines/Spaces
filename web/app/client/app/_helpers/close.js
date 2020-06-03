app.close = (router, options = {}) => (a, x) =>
  a["div.float-right"](
    app.button({
      label: app.icon("fa fa-times", "Close"),
      onclick: () =>
        router.open(options.path || "..", router.query, router.anchor),
    })
  );
