app.settings = (router) => (a, x) => [
  a.h1("Settings"),

  app.form({
    object: {
      theme: window.localStorage.cssTheme,
      editor_keymap: window.localStorage.editorKeymap,
    },
    form: (f) => [
      f.field({
        key: "theme",
        as: "select",
        placeholder: "Default",
        selections: {
          dark: "Dark",
        },
      }),
      f.field({
        key: "editor_keymap",
        as: "select",
        placeholder: "None",
        selections: {
          vim: "Vim",
          emacs: "Emacs",
          sublime: "Sublime",
        },
      }),
      f.buttons(router),
    ],
    action: (submition) => {
      window.localStorage.cssTheme = submition.data.theme;
      window.localStorage.editorKeymap = submition.data.editor_keymap;
      window.localStorage.editorDefaultMode =
        submition.data.editor_default_mode;
      location.assign("/");
      return false;
    },
  }),
];
