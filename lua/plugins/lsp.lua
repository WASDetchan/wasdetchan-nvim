return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        enable = false,
        ft = "lua",
        cmd = "LazyDev",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      }

    },
    config = function()
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('gopls')
      -- vim.lsp.enable('rust-analyzer')
      vim.lsp.enable('clangd')
      vim.lsp.enable('kotlin-lsp')
      vim.lsp.enable('tinymist')
      vim.lsp.enable('templ')
      vim.lsp.enable('tailwind')
      -- vim.lsp.enable('sqls')

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          --- @diagnostic disable-next-line: missing-parameter
          if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format { bufnr = args.buf, id = client.id }
              end
            })
          end
        end
      })
    end
  }, {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false,   -- This plugin is already lazy
  default_settings = {
    -- rust-analyzer language server configuration
    ["rust-analyzer"] = {
      cargo = {
        targetDir = true, -- use workspace target
        allFeatures = true,
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
      },
      -- Add clippy lints for Rust if using rust-analyzer
      checkOnSave = true,
      enable_clippy = false,
      -- Enable diagnostics if using rust-analyzer
      diagnostics = {
        enable = true,
      },
      procMacro = {
        enable = true,
      },
      files = {
        exclude = {
          ".direnv",
          ".git",
          ".jj",
          ".github",
          ".gitlab",
          "bin",
          "node_modules",
          "target",
          "venv",
          ".venv",
        },
        -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
        watcher = "client",
      },
    },
  },
  config = function()
    if vim.fn.executable("rust-analyzer") == 0 then
      vim.notify(
        "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
        vim.log.levels.ERROR
      )
    end
  end
},

}
