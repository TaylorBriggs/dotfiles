return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostic.eslint_d,
        null_ls.builtins.diagnostic.fish,
        null_ls.builtins.diagnostic.markdownlint,
        null_ls.builtins.diagnostic.rubocop,
        null_ls.builtins.formatting.fish_indent,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.formatting.stylua,
      },
    })

    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end,
}
