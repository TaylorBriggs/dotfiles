-- https://github.com/junegunn/fzf/blob/master/README-VIM.md#installation
vim.opt.rtp:append("/opt/homebrew/opt/fzf")

return {
	"nvim-telescope/telescope.nvim",
	keys = {
		{ "<C-p>", "<CMD>Telescope find_files<CR>" },
		{ "<leader>fg", "<CMD>Telescope live_grep<CR>" },
	},
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"junegunn/fzf.vim",
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		require("telescope").load_extension("ui-select")

		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, {
				buffer = true,
				remap = false,
				desc = "LSP: " .. desc,
			})
		end
		local builtins = require("telescope.builtin")

		map("gd", builtins.lsp_definitions, "Goto Definition")
		map("gr", builtins.lsp_references, "Goto References")
		map("gI", builtins.lsp_implementations, "Goto Implementation")
		map("<leader>D", builtins.lsp_type_definitions, "Type Definition")
		map("<leader>ds", builtins.lsp_document_symbols, "Document Symbols")
		map("<leader>ws", builtins.lsp_workspace_symbols, "Workspace Symbols")
		map("<leader>d", builtins.diagnostics, "Diagnostics")
	end,
}
