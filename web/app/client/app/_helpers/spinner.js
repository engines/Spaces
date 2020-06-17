app.spinner = (text) => (a, x) => {

  text = app.i18n(text)

  return x.cycle({
    collection: [
      app.icon("far fa-hourglass", text),
      app.icon("fas fa-hourglass-start", text),
      app.icon("fas fa-hourglass-half", text),
      app.icon("fas fa-hourglass-end", text),
      app.icon("far fa-hourglass", text),
    ],
  });

};
