ax.css( {

  'body.app-theme-dark': {

    color: 'lightgray',
    backgroundColor: 'black',

    '.app-btn': {
      color: 'lightgray',
    },

    '.app-btn:hover': {
      color: 'black',
    },

    'app-nav': {
      '.app-nav-btn.active': {
        color: 'black',
      },
    },

    hr: {
      borderTop: '1px solid rgba(255, 255, 255, 0.1)'
    },

    '|appkit-menu menu': {
      backgroundColor: 'black',
    },

    pre: {
      color: 'lightgray',
    },

    '.form-control:focus, .custom-select:focus': {
      boxShadow: '0 0 0 .2rem #90F9',
    },
    '.custom-control-input:focus ~ .custom-control-label::before': {
      boxShadow: '0 0 0 .2rem #90F9',
    },

    '.table': {
      color: 'lightgray',
    },

    '.success': { color: 'lightblue' },
    '.success pre': { color: 'lightblue' },

    '.well': {
      borderColor: '#333',
    },

    '|axf-panes': {

      '|axf-panes-drag': {
        background: '#FFF1',
        '&:hover': {
          background: '#333',
        }
      },

      '&.dragable': {
        '|axf-panes-drag': {
          background: '#666',
        },
      },

      '> *': {
        borderTop: '1px solid #FFF1',
      },

    },




  },

} )
