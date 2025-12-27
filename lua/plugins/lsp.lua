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
      vim.lsp.enable('rust-analyzer')
      vim.lsp.enable('clangd')

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
  },
  -- Nvim config LS support
}
