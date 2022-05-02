module.exports = {
  content: [
    './templates/**/**/*.twig',
    './templates/**/**/*.html',
    './src/scripts/**/*.js',
  ],
  /*safelist: [
    {
      pattern: '',
      variants: '' 
    }
  ],
  */
  theme: {
    aspectRatio: {
      'none': 0,
      'square': [1, 1],
      "5/4": [5, 4],
      "4/3": [4, 3],
      "3/2": [3, 2],
      "16/10": [16, 10],
      "16/9": [16, 9],
      "21/9": [21, 9],
    },
    fontFamily: {
      sans: ['sans-serif'],
      serif: ['serif'],
    },
    extend: {
      borderWidth: {
        3: '3px',
        5: '5px'
      },
      colors: {},
      gridColumn: {
        'span-13': 'span 13 / span 13',
        'span-14': 'span 14 / span 14'
      },
      gridColumnEnd: {
        14: '14'
      },
      gridTemplateColumns: {
        13: 'repeat(13, minmax(0, 1fr))',
        14: 'repeat(14, minmax(0, 1fr))',
      },
      spacing: {
        96: '24rem',
        100: '25rem',
        120: '30rem',
        128: '32rem',
        136: '34rem'
      },
      zIndex: {
        'd1': '-1',
        60: '60',
        70: '70',
        80: '80',
        90: '90'
      }
    }
  },
  variantOrder: [
    'first',
    'last',
    'odd',
    'even',
    'visited',
    'checked',
    'group-hover',
    'group-focus',
    'hover',
    'focus',
    'focus-visible',
    'active',
    'disabled',
  ],
  plugins: [
    require('tailwindcss-aspect-ratio'), /* Doc: https://github.com/webdna/tailwindcss-aspect-ratio */
  ]
}