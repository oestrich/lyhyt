let mode = undefined;

if (process.env.WATCH == "true") {
  mode = "jit";
}

module.exports = {
  mode,
  content: [
    '../lib/lyhyt/web/templates/**/*.html.eex'
  ],
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
