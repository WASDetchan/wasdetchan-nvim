return {
  -- { "RomanAverin/charleston.nvim" },
  -- { "joshdick/onedark.vim" },
  -- { "Soares/base16.nvim" },
  -- {
  --   "neanias/everforest-nvim",
  --   version = false,
  --   lazy = false,
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   -- Optional; default configuration will be used if setup isn't called.
  --   config = function()
  --     require("everforest").setup({
  --       -- Your config here
  --     })
  --   end,
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "charleston",
  --   },
  -- },
  -- {
  --   "jeffkreeftmeijer/vim-dim",
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "everforest",
  --     everforest_background = "hard",
  --   },
  -- },
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background = "hard"
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
  {

    "williamboman/mason.nvim",

    opts = {

      ensure_installed = {

        "tinymist",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {

      settings = {

        formatterMode = "typstyle",

        exportPdf = "onType",

        semanticTokens = "disable",
      },
      setup = {
        bight_lsp = function(_, _)
          local lspconfig = require("lspconfig")
          -- register a new server only if not already registered
          if not lspconfig.bight_lsp then
            lspconfig.bight_lsp = {
              default_config = {
                cmd = { "/home/yaroslav/Projects/rust/bight/target/debug/bight_lsp", "--stdio" }, -- your executable
                filetypes = { "bight" }, -- your filetype
                root_dir = lspconfig.util.root_pattern(".git", "."),
                settings = {}, -- optional
              },
            }
          end
          lspconfig.bight_lsp.setup({})
          return true -- tells LazyVim we've handled setup
        end,
      },
    },
  },
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
