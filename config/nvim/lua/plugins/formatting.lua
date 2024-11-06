return {
	{ "tpope/vim-commentary" },
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"andrewferrier/wrapping.nvim",
		config = function()
			require("wrapping").setup()
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				debug = true,
				sources = {
					require("none-ls.diagnostics.eslint_d"),
					null_ls.builtins.diagnostics.editorconfig_checker,
					null_ls.builtins.diagnostics.fish,
					null_ls.builtins.diagnostics.markdownlint,
					null_ls.builtins.diagnostics.rubocop,
					null_ls.builtins.diagnostics.spectral,
					null_ls.builtins.diagnostics.terraform_validate,
					null_ls.builtins.diagnostics.tfsec,
					null_ls.builtins.formatting.fish_indent,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.terraform_fmt,
				},
			})

			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
			vim.cmd.autocmd(
				"BufWritePre",
				"*.{[m,c]?js,json,jsx,rb,tf,tsx?,ya?ml}",
				"lua vim.lsp.buf.format()"
			)
		end,
	},
}
