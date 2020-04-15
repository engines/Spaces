app.polling.wait = () => (a,x) => a['app-polling-wait'](
  app.spinner( a( {
    $text: el => `Try again in ${ el.$state } second${ el.$state === 1 ? '': 's' }`,
    $state: 8,
    $init: el => setInterval(
      () => el.$state--,
      1000
    ),
  } ) ),
  {
    $init: el => setTimeout(
      () => el.$('^app-polling').$check(),
      8000
    ),
  }
)
