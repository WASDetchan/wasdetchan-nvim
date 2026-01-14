return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local opts = {
        options = {
          move_wraps_at_ends = true,
          diagnostics = "nvim_lsp",
        }
      }
      local bufferline = require 'bufferline'
      bufferline.setup(opts)

      vim.keymap.set('n', '<C-H>', '<cmd>BufferLineMovePrev<CR>')
      vim.keymap.set('n', '<C-L>', '<cmd>BufferLineMoveNext<CR>')
      vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<CR>')
      vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<CR>')
      -- buffer operations (+ fuzzy search in telescope config)
      vim.keymap.set("n", "<leader>bd", function() vim.api.nvim_buf_delete(0, {}) end, { silent = true })
      vim.keymap.set("n", "<leader>bo", '<cmd>BufferLineCloseOthers<CR>',
        { silent = true })
    end
  }
}
