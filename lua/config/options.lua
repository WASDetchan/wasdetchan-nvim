-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Set to "intelephense" to use intelephense instead of phpactor.
vim.opt.wrap = true
vim.opt.linebreak = false

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
})

vim.g.lazyvim_rust_diagnostics = "rust-analyzer"

vim.g.dbs = {
  myfirstdb = "postgres://yaroslav@localhost/myfirstdb",
}
