return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end,
      sources = {
        null_ls.builtins.completion.luasnip,
        null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.rubocop.with({
          args = {
            "bundle",
            "exec",
            "rubocop",
            "-f",
            "json",
            "--force-exclusion",
            "--stdin",
            "$FILENAME",
          },
        }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rubocop.with({
          args = {
            "bundle",
            "exec",
            "rubocop",
            "-a",
            "--server",
            "-f",
            "quiet",
            "--stderr",
            "--stdin",
            "$FILENAME",
          },
        }),
        null_ls.builtins.formatting.stylua,
      },
    })
  end,
}
