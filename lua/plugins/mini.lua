return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      require('mini.icons').setup {}
      require('mini.git').setup {}
      require('mini.diff').setup {}
      require('mini.statusline').setup { use_icons = true }
    end,
  }
}
