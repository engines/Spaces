app.float = (options) => (a, x) =>
  a["div.clearfix"]([
    a["div.float-left"](options.left || null),
    a["div.float-right"](options.right || null),
  ]);
