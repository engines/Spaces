app.logo = function( size=100 ) {

  let scale = size / 100 / 3

 return (a,x) => a(
`<svg width='${ size }' height='${ size }' style='vertical-align: middle;'>
  <g transform='scale(${ scale })'>
    <path d='
      M 150,300 L 280,225 L 280,75 L 150,0 L 20,75 L 20,225 L 150,300
      M 40,150 A 110,110 0 1,0 260,150 A 110,110 0 1,0 40,150 Z'
      style='fill:#48D;stroke-width:0' fill-rule='evenodd'>
    </path>
  </g>
</svg>`
  )

}
