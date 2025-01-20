/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {
      fontSize: {
        xs: '11px',
        sm: '13px',
        base: '15px',
      },
    },
    container: {
      center: true,
      padding: {
        DEFAULT: '1rem',
        sm: '2rem',
        md: '3rem',
        lg: '4rem',
        xl: '5rem',
        '2xl': '6rem',
      },
    },
    fontFamily: {
      body: ['DM Sans', 'sans-serif'],
    },
  },
  darkMode: 'class',
  daisyui: {
    themes: ['light', 'dark'],
  },
  plugins: [require('daisyui')],
};
