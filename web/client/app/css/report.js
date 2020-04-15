ax.css( {

  '|appkit-report-control': {

    display: 'block',
    '&:focus, &:focus-within': {
      boxShadow: '0 0 0 .2rem #FFD70077',
    },


    '.form-control': {
      minHeight: 'calc(1.5em + .75rem + 2px)',
      maxHeight: '300px',
      overflowY: 'auto',
      borderColor: 'transparent',
    },

    '.form-control:focus, .form-control:focus-within': {
      borderColor: '#CED4DA',
      boxShadow: 'unset',
    },
    
    '|appkit-report-checkbox-wrapper, |appkit-report-checkboxs, |appkit-report-radios': {
      pointerEvents: 'none',
    },

    'pre': {
      marginTop: '0.25rem',
      marginBottom: '0.25rem',
    },

    '|appkit-report-password': {
      paddingRight: '1px',
    },

    '|appkit-report-string': { minHeight: '40px' },

    '|appkit-report-nest': {
      '.table-sm': {
        td: { padding: '0.125rem', },
        th: { padding: '0.125rem', fontWeight: 'normal' },
      },
    },

    '.custom-control-input:disabled ~ .custom-control-label': {
      color: 'unset',
    }

  },



} )
