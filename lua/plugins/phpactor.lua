local nvim_lsp = require("lspconfig")

vim.lsp.config["phpactor"] = {
  {
    cmd = { "phpactor", "language-server" },
    filetypes = { "php", "blade" },
    root_dir = nvim_lsp.util.root_pattern("composer.json", ".git"),
    init_options = {
      ["language_server_worse_reflection.inlay_hints.enable"] = true,
      ["language_server_worse_reflection.inlay_hints.params"] = true,
      -- ["language_server_worse_reflection.inlay_hints.types"] = true,
      ["language_server_configuration.auto_config"] = false,
      ["code_transform.import_globals"] = true,
      ["language_server_phpstan.enabled"] = true,
      ["language_server_phpstan.level"] = 7,
      ["language_server_phpstan.bin"] = "phpstan",
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {
          init_options = {
            ["language_server_worse_reflection.inlay_hints.enable"] = true,
            ["language_server_worse_reflection.inlay_hints.params"] = true,
            -- ["language_server_worse_reflection.inlay_hints.types"] = true,
            ["language_server_configuration.auto_config"] = false,
            ["code_transform.import_globals"] = true,
            ["language_server_phpstan.enabled"] = true,
            ["language_server_phpstan.level"] = "7",
            ["language_server_phpstan.bin"] = "phpstan",
            ["language_server_php_cs_fixer.enabled"] = true,
            ["php_code_sniffer.enabled"] = true,
          },
        },
      },
    },
  },
}
