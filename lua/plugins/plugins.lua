return {
  { "RomanAverin/charleston.nvim" },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "charleston",
  --   },
  -- },
  {
    "jeffkreeftmeijer/vim-dim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "charleston",
    },
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },

  -- {
  --   "mason-org/mason.nvim",
  --   version = "^1.0.0",
  --   opts = {
  --     ensure_installed = {
  --       "phpcs",
  --       "php-cs-fixer",
  --     },
  --   },
  -- },
  -- { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = { ensure_installed = { "php" } },
  -- },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
  --     table.insert(opts.sources, nls.builtins.diagnostics.phpcs)
  --   end,
  -- },
  -- {
  --   "mfussenegger/nvim-lint",
  --   optional = true,
  --   opts = {
  --     linters_by_ft = {
  --       php = { "phpcs" },
  --     },
  --   },
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   optional = true,
  --   opts = {
  --     formatters_by_ft = {
  --       php = { "php_cs_fixer" },
  --     },
  --   },
  -- }
}
