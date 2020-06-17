app.navbar = (router) => (a, x) =>
  a["nav#navbar.navbar.navbar-expand-md.navbar-light.bg-transparent.mx-n3.mt-n1.mb-1"](
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
        data: {
          toggle: "collapse",
          target: "#navbarCollapse",
        },
      }),
      a.div(
        a.ul(
          [
            a.li(
              a.a(app.icon("fa fa-cog"), {
                class: 'nav-link',
                href: '#',
                $on: {click: (e) => {
                  e.preventDefault();
                  router.open("/settings")
                  $('#navbarCollapse').collapse('hide')
                }},
              }),
              {
                class: 'nav-item',
                data: {
                  path: '/settings'
                },
              }
            ),
            a.li(
              a.a(app.icon("fa fa-sign-out-alt"), {
                class: 'nav-link',
                href: '#',
                $on: {click: (e) => {
                  e.preventDefault();
                  router.open("/logout")
                  $('#navbarCollapse').collapse('hide')
                }},
              }),
              {
                class: 'nav-item',
                data: {
                  path: '/logout'
                },
              }
            ),
          ],
          {
            class: 'navbar-nav ml-auto mt-0',
          }
        ),
        {
          id: 'navbarCollapse',
          class: 'collapse navbar-collapse',
        }
      ),
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
