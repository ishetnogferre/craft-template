/*
** TailwindCSS Configuration File
**
** Docs: https://tailwindcss.com/docs/configuration
** Default: https://github.com/tailwindcss/tailwindcss/blob/master/stubs/defaultConfig.stub.js
**
*/
module.exports = {
  purge: {
    enabled: true,
    mode: 'all',
    content: [
      './templates/**/**/*.twig',
      './templates/**/**/*.html',
      './src/styles/**/*.css',
      './src/scripts/**/*.js',
      './src/scripts/**/*.vue'
    ],
    options: {
      whitelistPatterns: [/ls-blur-up-img/],
      whitelist: [],
      whitelistPatternsChildren: [/body/, /ls-blur-up-img/, /lb-/]
    }
  },
  theme: {
    aspectRatio: {
      square: [1, 1],
      "5/4": [5, 4],
      "4/3": [4, 3],
      "3/2": [3, 2],
      "16/10": [16, 10],
      "16/9": [16, 9],
      "21/9": [21, 9],
    },
    borderWith: {
      default: '1px',
      '0': '0',
      '2': '2px',
      '3': '3px',
      '4': '4px',
      '5': '5px',
      '6': '6px',
      '7': '7px',
      '8': '8px',
      '9': '9px',
      '10': '10px',
      '16': '16px',
    },
    customForms: theme => ({
      default: {
        input: {
          borderRadius: theme('borderRadius.lg'),
          backgroundColor: theme('colors.gray'),
          '&:focus': {
              backgroundColor: theme('colors.blue'),
          }
        },
        select: {
          borderRadius: theme('borderRadius.lg'),
          boxShadow: theme('boxShadow.default'),
        },
        checkbox: {
          width: theme('spacing.6'),
          height: theme('spacing.6'),
        },
        radio: {
          backgroundColor: theme('colors.blue'),
        },
        // textarea: {}
        // multiselect: {}
      },
    }),
    debugScreens: {
      position: ['bottom', 'left'],
      style: {
        backgroundColor: '#C0FFEE',
        color: 'black',
        boxShadow: '0 0 0 1px #fff',
      },
    },
    fontSizes: {
      tiny: '0.625rem',     // 10px
      xs: '0.75rem',        // 12px
      sm: '0.875rem',       // 14px
      base: '1rem',         // 16px
      lg: '1.125rem',       // 18px
      xl: '1.25rem',        // 20px
      '2xl': '1.5rem',      // 24px
      '3xl': '1.875rem',    // 30px
      '4xl': '2.25rem',     // 36px
      '5xl': '2.5rem',      // 40px
      '6xl': '3rem',        // 48px
      '7xl': '3.125rem',    // 50px
      '8xl': '4rem',        // 64px
      '9xl': '4.5rem',      // 72px
      '10xl': '5.25rem',    // 84px
      '11xl': '5.625rem',   // 90px
      '12xl' : '6.5rem',    // 104px
    },
    height: theme => ({
      auto: 'auto',
      ...theme('spacing'),
      '1/2': '50%',
      '1/4': '25%',
      '2/4': '50%',
      '3/4': '75%',
      '1/5': '20%',
      '2/5': '40%',
      '3/5': '60%',
      '4/5': '80%',
      '9/10': '90%',
      full: '100%',
      '75vh': '75vh',
      '80vh': '80vh',
      '90vh': '90vh',
      screen: '100vh',
    }),
    maxHeight: theme => ({
      ...theme('height')
    }),
    opacity: {
      '0': '0',
      '10': '0.1',
      '20': '0.2',
      '25': '0.25',
      '30': '0.3',
      '40': '0.4',
      '50': '0.5',
      '60': '0.6',
      '70': '0.7',
      '75': '0.75',
      '80': '0.8',
      '90': '0.9',
      '100': '1',
    },
    spacing: {
      px: '1px',
      '0': '0',
      '1': '0.25rem',
      '2': '0.5rem',
      '3': '0.75rem',
      '4': '1rem',
      '5': '1.25rem',
      '6': '1.5rem',
      '7': '1.75rem',
      '8': '2rem',
      '9': '2.25rem',
      '10': '2.5rem',
      '11': '2.75rem',
      '12': '3rem',
      '13': '3.25rem',
      '14': '3.5rem',
      '15': '3.75rem',
      '16': '4rem',
      '17': '4.25rem',
      '18': '4.5rem',
      '19': '4.75rem',
      '20': '5rem',
      '21': '5.25rem',
      '22': '5.5rem',
      '23': '5.75rem',
      '24': '6rem',
      '25': '6.25rem',
      '26': '6.5rem',
      '27': '6.75rem',
      '28': '7rem',
      '29': '7.25rem',
      '30': '7.5rem',
      '32': '8rem',
      '36': '9rem',
      '40': '10rem',
      '44': '11rem',
      '48': '12rem',
      '52': '13rem',
      '56': '14rem',
      '64': '16rem',
      '80' : '20rem',
      '100': '25rem',
      '120': '30rem',
      '128': '32rem',
    },
    screens: {
      sm: '640px',
      md: '768px',
      lg: '992px',
      xl: '1024px',
      xxl: '1280px',
      big: '1440px',
    },
    zIndex: {
      auto: 'auto',
      '0': '0',
      '10': '10',
      '20': '20',
      '30': '30',
      '40': '40',
      '50': '50',
      '60': '60',
      '70': '70',
      '80': '80',
      '90': '90',
      'top': '9999',
    },
    extend: {
      colors: {
        // COLOR naming: prefix of 3 first letters of project/client e.g. 'tai-<colorname>'
      },
      borderRadius: {
        xl: '1rem',
        xxl: '1.25rem',
      },
      boxShadow: {
        drop: '0 4px 6px 3px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
        'drop-xl': '0 0 50px 10px rgba(0, 0, 0, 0.5)',
      }
    }
  },
  variants: {
    backgroundColor: ['responsive', 'hover', 'focus', 'active', 'group-hover'],
    borderColor: ['responsive', 'hover', 'focus', 'group-hover'],
    boxShadow: ['responsive', 'hover', 'focus', 'group-hover'],
    fontWeight: ['responsive', 'hover', 'focus'],
    margin: ['responsive', 'hover', 'group-hover'],
    opacity: ['responsive', 'hover', 'focus'],
    padding: ['responsive', 'hover', 'group-hover'],
    textColor: ['responsive', 'hover', 'focus', 'active', 'group-hover'],
  },
  plugins: [
    /* Doc: https://github.com/webdna/tailwindcss-aspect-ratio */
    require('tailwindcss-aspect-ratio'),
    /* Doc: https://github.com/brettgullan/tailwindcss-scrims */
    require('tailwindcss-scrims')({
      directions: {
        't': 'to bottom',
        'b': 'to top',
        'r': 'to left',
        'l': 'to right',
      },
      distances: {
        '1/4': '25%',
        '1/3': '33.33333%',
        '1/2': '50%',
        '2/3': '66.66666%',
        '3/4': '75%',
        'full': '100%'
      },
      colors: {
        default: ['rgba(0,0,0,0.4)', 'rgba(0,0,0,0)'],
        white: ['rgba(255,255,255,0.4)', 'rgba(255,255,255,0)'],
      },
      variants: ['responsive', 'hover'],
    }),
  ]
}
