app.button = (options = {}) => (a, x) =>
  x.button({
    ...options,
    buttonTag: {
      id: options.id,
      class: options.class || "btn app-btn",
      disabled: options.disabled,
      title: options.title,
      ...options.buttonTag,
    },
  });
