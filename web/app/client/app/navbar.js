app.navbar = (router) => (a, x) =>
  a["nav#navbar.navbar.navbar-expand-md.navbar-light.bg-white.mx-n3.mt-n1"](
    [
      a.a([
        a({
          $nodes: [app.logo(24)],
          class: 'app-navbar-brand-icon',
        }),
        a({$text: "Engines"}),
      ], {
        href: "/",
        class: "navbar-brand",
      }),
      a.button(a({class: "navbar-toggler-icon"}), {
        class: "navbar-toggler",
        // dataToggle: 'collapse',
        data: {
          toggle: "collapse",
          target: "#navbarCollapse",
        },
      }),
      a.div(
        a.ul(
          [
            a.li(
              a.a( 'Blueprints',{
                class: 'nav-link',
                href: '#',
                $on: {click: (e) => {
                  e.preventDefault();
                  router.open("/blueprints")
                  $('#navbarCollapse').collapse('hide')
                }},
              }),
              {
                class: 'nav-item',
                data: {
                  path: '/blueprints'
                },
              }
            ),
            a.li(
              a.a( 'Resolutions',{
                class: 'nav-link',
                href: '#',
                $on: {click: (e) => {
                  e.preventDefault();
                  router.open("/resolutions")
                  $('#navbarCollapse').collapse('hide')
                }},
              }),
              {
                class: 'nav-item',
                data: {
                  path: '/resolutions'
                },
              }
            ),
          ],
          {
            class: 'navbar-nav mr-auto mt-0',
          }
        ),
        {
          id: 'navbarCollapse',
          class: 'collapse navbar-collapse',
        }
      ),
      // a["div.float-right"]([
      //   app.button({
      //     label: app.icon("fa fa-cog"),
      //     title: "Settings",
      //     onclick: () => router.open("/settings"),
      //     class: "nav-link app-nav-btn app-nav-btn-settings",
      //   }),
      //   app.button({
      //     label: app.icon("fa fa-sign-out-alt"),
      //     title: "Log out",
      //     onclick: () => router.load("/logout"),
      //     class: "nav-link app-nav-btn",
      //   }),
      // ]),
    ],
    {
      $activate: function() {
        this.$$('.nav-item.active').classList.remove('active')
        let section = location.pathname.split('/')[1]
        let active = this.$(`[data-path="/${section}"]`)
        if (active) active.classList.add('active')
      },
    }
  );
