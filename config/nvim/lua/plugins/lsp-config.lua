return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
          ["ruby_lsp"] = function()
            require("lspconfig")["ruby_lsp"].setup({
              autostart = true,
              cmd = { "mise", "x", "--", "ruby-lsp" },
              cmd_env = {
                RUBOCOP_IGNORE_TODO = "true",
                RUBOCOP_IGNORE_FOCUSED_SPECS = "true",
              },
              single_file_support = false,
              on_attach = function(client, _bufnr)
                client.server_capabilities.semanticTokensProvider =
                    false
              end,
            })
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig_defaults = require("lspconfig").util.default_config

      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set(
            "n",
            "<leader>gd",
            vim.lsp.buf.definition,
            opts
          )
          vim.keymap.set(
            "n",
            "<leader>gD",
            vim.lsp.buf.declaration,
            opts
          )
          vim.keymap.set(
            "n",
            "<leader>gi",
            vim.lsp.buf.implementation,
            opts
          )
          vim.keymap.set(
            "n",
            "<leader>go",
            vim.lsp.buf.type_definition,
            opts
          )
          vim.keymap.set(
            "n",
            "<leader>gr",
            vim.lsp.buf.references,
            opts
          )
          vim.keymap.set(
            "n",
            "<leader>gs",
            vim.lsp.buf.signature_help,
            opts
          )
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set(
            "n",
            "<leader>F",
            "<cmd>lua vim.lsp.buf.format({async = true})<CR>",
            opts
          )
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts
          )
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ruby",
        callback = function()
          vim.lsp.start({
            name = "rubocop",
            cmd = { "bundle", "exec", "rubocop", "--lsp" },
          })
        end,
      })
    end,
  },
}
