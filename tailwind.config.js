module.exports = {
  purge: [
    "./app/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.vue",
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    screens: {
      'sm': '767px',

      'md': '768px',

      'lg': '1024px',

      'xl': '1280px',
      
      '2xl': '1536px',
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],

};
