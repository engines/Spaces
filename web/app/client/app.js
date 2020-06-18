let app = (a, x) =>
  a["app"](
    [
      app.modal(),
      a["div.container-fluid"](
        x.router({
          routes: (router) => [
            app.navbar(router),
            router.nest({
              routes: {
                '/settings/?*': app.settings,
                "/blueprints/?*": app.blueprints,
              },
            }),
          ],
          home: '/blueprints',
          lazy: true,
          transition: 'fade',
          default: (router) =>
            a["p.error"]([
              a.pre(
                `Not found in client routes: ${router.path} in ${
                  router.scope || "root"
                }`
              ),
              router,
            ]),
        })
      ),
    ],
    {
      $on: {
        "appkit.router.load": (e, el) => {
          navbar.$activate();
        },
      },
    }
  );
