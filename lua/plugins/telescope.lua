return {
  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-frecency.nvim",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
      }
    },
    config = function()
      -- You dont need to set any of these options. These are the default ones. Only
      -- the loading is important
      require('telescope').setup {
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          frecency = {
            matcher = "fuzzy",
          },
        }
      }
      -- To get fzf loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('frecency')

      local telescope_extensions = require('telescope').extensions
      local telescope_builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>f",
        function()
          telescope_extensions.frecency.frecency {
            workspace = "CWD",
            path_display = { "shorten" },
          }
        end
      )

      vim.keymap.set("n", "<leader>r",
        function() telescope_builtin.lsp_references { jump_type = "never" } end)
      -- vim.keymap.set("n", "<leader>d", telescope_builtin.diagnostics)
      vim.keymap.set("n", "<leader>gd",
        function() telescope_builtin.lsp_definitions { jump_type = "never" } end)

      vim.keymap.set("n", "gd",
        function() telescope_builtin.lsp_definitions {} end)
      vim.keymap.set("n", "<leader>gi", telescope_builtin.lsp_implementations)
      vim.keymap.set("n", "<leader>c", telescope_builtin.command_history)
      vim.keymap.set("n", "<leader>y",
        function() telescope_builtin.lsp_type_definitions { jump_type = "never" } end)
      vim.keymap.set("n", "<leader>s", telescope_builtin.live_grep)

      local function git_check()
        local result = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
        if vim.v.shell_error == 0 and result:match("true") then
          return true
        else
          vim.notify("Not in a git repository", vim.log.levels.WARN)
          return false
        end
      end

      vim.keymap.set("n", "<leader>gs", function()
        if git_check() then
          require("telescope.builtin").git_status()
        end
      end)


      vim.keymap.set("n", "<leader>bf", telescope_builtin.buffers)

      vim.keymap.set("n", "<leader>tt", telescope_builtin.builtin)
      vim.keymap.set("n", "<leader>th", telescope_builtin.help_tags)
      vim.keymap.set("n", "<leader>tr", telescope_builtin.registers)
      vim.keymap.set("n", "<leader>tc", telescope_builtin.colorscheme)
      vim.keymap.set("n", "<leader>tf", telescope_builtin.find_files)
    end
  }
}
