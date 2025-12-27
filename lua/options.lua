vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.diagnostic.config({
  virtual_text = true,
})

-- local function bcell_set_file_type(buf)
--   -- only for .bcell files
--   local name = vim.api.nvim_buf_get_name(buf)
--   if not name:match("%.bcell$") then
--     return nil
--   end
--
--   local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
--   if #lines == 0 then
--     vim.bo[buf].filetype = "bcell"
--     return "bcell"
--   end
--
--   local first = lines[1]
--   if first:sub(1, 1) == "=" then
--     -- THIS is the critical line
--     vim.bo[buf].filetype = "bcell-lua"
--     return "lua"
--   else
--     vim.bo[buf].filetype = "bcell"
--     return "bcell"
--   end
-- end
--
-- -- when opening / creating the file
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   callback = function(args)
--     bcell_set_file_type(args.buf)
--   end,
-- })
--
-- -- when typing
-- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
--   callback = function(args)
--     bcell_set_file_type(args.buf)
--   end,
-- })

-- vim.lsp.set_log_level("DEBUG")

vim.filetype.add {
  extension = {
    bcell = 'bcell',
  }
}

vim.lsp.config['bcell'] = {
  cmd = { "/home/yaroslav/Projects/rust/bight/target/debug/bight_lsp" },
  filetypes = { "bcell" },
  root_markers = { ".git" },
}


vim.lsp.enable("bcell")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set('n', '<Up>', '<Nop>')
vim.keymap.set('n', '<Down>', '<Nop>')
vim.keymap.set('n', '<Left>', '<Nop>')
vim.keymap.set('n', '<Right>', '<Nop>')

vim.keymap.set('v', '<Up>', '<Nop>')
vim.keymap.set('v', '<Down>', '<Nop>')
vim.keymap.set('v', '<Left>', '<Nop>')
vim.keymap.set('v', '<Right>', '<Nop>')

vim.keymap.set('n', '<leader>qq', ':conf q<CR>')
vim.keymap.set('n', '<leader>qx', ':x<CR>')

vim.keymap.set('o', 'ag', function()
  local buf = vim.api.nvim_get_current_buf()
  local last_line = vim.api.nvim_buf_line_count(buf)
  local last_line_length = #vim.api.nvim_buf_get_lines(buf, last_line - 1, last_line, false)[1]

  vim.fn.setpos("'<", { buf, 1, 1, 0 })
  vim.fn.setpos("'>", { buf, last_line, math.max(1, last_line_length), 0 })

  vim.cmd('normal! gv')
end, { noremap = true, silent = true })

vim.keymap.set('v', 'ag', function()
  local buf = vim.api.nvim_get_current_buf()
  local last_line = vim.api.nvim_buf_line_count(buf)
  local last_line_length = #vim.api.nvim_buf_get_lines(buf, last_line - 1, last_line, false)[1]

  vim.fn.setpos("'<", { buf, 1, 1, 0 })
  vim.fn.setpos("'>", { buf, last_line, math.max(1, last_line_length), 0 })

  vim.cmd('normal! gv')
end, { noremap = true, silent = true })
