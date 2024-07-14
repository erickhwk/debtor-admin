const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        'gray-blue-lighter': 'rgb(243, 244, 247)',
        'gray-blue-light': 'rgb(58, 66, 82)',
        'gray-blue-medium': 'rgb(38, 46, 62)',
        'gray-blue-dark': 'rgb(28, 36, 52)'
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}