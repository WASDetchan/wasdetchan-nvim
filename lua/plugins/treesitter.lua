return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch  = "main",
    version = false,
    build   = ":TSUpdate",
    config  = function()
      require('nvim-treesitter').install {
        "bash",
        "c",
        "diff",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "haskell",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "kotlin",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = 'nvim-treesitter/nvim-treesitter',
    branch = "main",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      -- configuration
      require("nvim-treesitter-textobjects").setup {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
      }

      -- keymaps
      -- You can use the capture groups defined in `textobjects.scm`
      vim.keymap.set({ "x", "o" }, "af", function()
          require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
        end,
        { desc = "function" }
      )
      vim.keymap.set({ "x", "o" }, "if", function()
          require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
        end,
        { desc = "function" }
      )
      vim.keymap.set({ "x", "o" }, "ac", function()
          require "nvim-treesitter-textobjects.select".select_textobject("@comment.outer", "textobjects")
        end,
        { desc = "comment" }
      )
      vim.keymap.set({ "x", "o" }, "ic", function()
          require "nvim-treesitter-textobjects.select".select_textobject("@comment.inner", "textobjects")
        end,
        { desc = "comment" }
      )
      vim.keymap.set({ "x", "o" }, "as", function()
          require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
        end,
        { desc = "scope" }
      )
    end
  }
}
