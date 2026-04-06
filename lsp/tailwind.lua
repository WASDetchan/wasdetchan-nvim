return {
  name = "tailwind",
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html", "css", "javascript", "typescript",
    "templ",
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'tailwind.config.js' }, { upward = true })[1]),
  settings = {
    tailwindCSS = {
      includeLanguages = {
        templ = "html",
      },
      experimental = {
        configFile = "css/app.css",
      },
    },
  },
}
