return {
  name = "templ",
  cmd = { "go", "tool", "templ", "lps" },
  filetypes = { "templ" },
  root_dir = vim.fs.dirname(vim.fs.find({ 'go.mod' }, { upward = true })[1]),
}
