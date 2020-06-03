app.spaces.show = (router,spaces) => (a, x) => a['app-spaces'](
  x.panes(
    {
      proximate: app.spaces.show.menu( router, spaces ),
      adjacent: app.spaces.show.main( router, spaces ),
      percent: window.localStorage.spacesHorizontalPanesPercent || '33',
      panesTag: {
        $on: {
          'ax.panes.resize': (e,el) => {
            const panesPercent = e.detail.percent
            window.localStorage.spacesHorizontalPanesPercent = panesPercent
          }
        }
      }
    }
  ),

)
