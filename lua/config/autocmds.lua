-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

-- vim.api.nvim_create_augroup("AutoBuild", { clear = true })
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = "AutoBuild",
--   pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.css", "*.html" },
--   callback = function()
--     vim.fn.system("npm run build")
--     print("Rebuilt frontend!")
--   end,
-- })

local function bcell_set_file_type(buf)
  -- only for .bcell files
  local name = vim.api.nvim_buf_get_name(buf)
  if not name:match("%.bcell$") then
    return nil
  end

  local lines = vim.api.nvim_buf_get_lines(buf, 0, 1, false)
  if #lines == 0 then
    vim.bo[buf].filetype = "bcell"
    return "bcell"
  end

  local first = lines[1]
  if first:sub(1, 1) == "=" then
    -- THIS is the critical line
    vim.bo[buf].filetype = "bcell-lua"
    return "lua"
  else
    vim.bo[buf].filetype = "bcell"
    return "bcell"
  end
end

-- when opening / creating the file
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function(args)
    bcell_set_file_type(args.buf)
  end,
})

-- when typing
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function(args)
    bcell_set_file_type(args.buf)
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "bcell-lua",
  callback = function(args)
    vim.notify("set filetype bcell-lua")
    local lspconfig = require("lspconfig")

    lspconfig.bight_lsp.setup({
      cmd = { "/home/yaroslav/Projects/rust/bight/target/debug/bight_lsp", "--stdio" }, -- your executable path
      filetypes = { "bcell-lua" }, -- e.g., "python", "cpp"
      root_dir = lspconfig.util.root_pattern(".git", "."),
      settings = {}, -- optional, depends on your LSP
    })
  end,
})
-- local lsp = vim.lsp
--
-- -- Wrap the original 'didChange' handler
-- local function transform_did_change(bufnr, changes)
--   -- Example: append a comment to the buffer content
--   local new_changes = {}
--   for _, change in ipairs(changes) do
--     local new_text = change.text .. "\n-- modified"
--     table.insert(new_changes, { range = change.range, text = new_text })
--   end
--   return new_changes
-- end
--
-- -- Override LSP handler for didChange
-- vim.lsp.handlers["textDocument/didChange"] = function(err, result, ctx, config)
--   local bufnr = ctx.bufnr
--
--   local client = lsp.get_client_by_id(ctx.client_id)
--   local changes = vim.lsp.util.make_text_document_params(bufnr).contentChanges
--
--   -- Transform changes before sending to server
--   local transformed_changes = transform_did_change(bufnr, changes)
--
--   client.notify("textDocument/didChange", {
--     textDocument = { uri = vim.uri_from_bufnr(bufnr), version = vim.api.nvim_buf_get_changedtick(bufnr) },
--     contentChanges = transformed_changes,
--   })
-- end

-- local shadow_buffers = {}
--
-- local function ensure_shadow_buffer(buf)
--   if shadow_buffers[buf] then
--     return shadow_buffers[buf]
--   end
--
--   local shadow = vim.api.nvim_create_buf(false, true) -- unlisted, scratch
--   vim.bo[shadow].filetype = "lua"
--
--   shadow_buffers[buf] = shadow
--   return shadow
-- end
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local buf = args.buf
--
--     local ft = bcell_set_file_type(buf)
--
--     if ft ~= "lua" then
--       return
--     end
--
--     local shadow_buf = ensure_shadow_buffer(buf)
--     vim.bo[shadow_buf].filetype = "lua" -- so LuaLS can attach
--
--     -- Send initial content
--     local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--     vim.api.nvim_buf_set_lines(shadow_buf, 0, -1, false, bcell_to_lua_lines(lines))
--
--     -- Sync edits
--     vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
--       buffer = buf,
--       callback = function()
--         local updated = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--         vim.api.nvim_buf_set_lines(shadow_buf, 0, -1, false, bcell_to_lua_lines(updated))
--       end,
--     })
--   end,
-- })
