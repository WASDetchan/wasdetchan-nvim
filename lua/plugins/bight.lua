return {
  -- release
  -- {
  --   'WASDetchan/bight.nvim',
  --   opts = {}
  -- },
  -- dev
  {
    dir = "/home/yaroslav/Projects/rust/bight_nvim",
    config = function()
      require('bight').setup {}
    end
  }
}
