return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				require("none-ls.diagnostics.eslint_d"),
				null_ls.builtins.diagnostics.editorconfig_checker,
				null_ls.builtins.diagnostics.fish,
				null_ls.builtins.diagnostics.markdownlint,
				null_ls.builtins.diagnostics.rubocop.with({
					command = "bundle",
					args = vim.list_extend(
						{ "exec", "rubocop" },
						null_ls.builtins.diagnostics.rubocop._opts.args
					),
				}),
				null_ls.builtins.diagnostics.spectral,
				null_ls.builtins.diagnostics.terraform_validate,
				null_ls.builtins.diagnostics.tfsec,
				null_ls.builtins.formatting.fish_indent,
				null_ls.builtins.formatting.markdownlint,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.rubocop.with({
					command = "bundle",
					args = vim.list_extend(
						{ "exec", "rubocop" },
						null_ls.builtins.formatting.rubocop._opts.args
					),
				}),
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.terraform_fmt,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
		vim.cmd.autocmd("BufWritePre", "*", "lua vim.lsp.buf.format()")
	end,
}
