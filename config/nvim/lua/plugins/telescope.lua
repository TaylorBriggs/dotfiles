return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
		"junegunn/fzf",
		"junegunn/fzf.vim",
		"folke/trouble.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{ "<C-p>", "<CMD>Telescope find_files<CR>" },
			{ "<leader>fg", "<CMD>Telescope live_grep<CR>" },
		},
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				pickers = {
					find_files = { hidden = true },
				},
			})

			require("telescope").load_extension("ui-select")

			local builtins = require("telescope.builtin")
			local trouble = require("trouble.sources.telescope")

			vim.keymap.set("i", "<C-t>", trouble.open)

			local nmap = function(keys, func)
				vim.keymap.set("n", keys, func)
			end

			nmap("<C-t>", function()
				trouble.open()
			end)
			nmap("<leader>gd", builtins.lsp_definitions)
			nmap("<leader>gr", builtins.lsp_references)
			nmap("<leader>gI", builtins.lsp_implementations)
			nmap("<leader>D", builtins.lsp_type_definitions)
			nmap("<leader>ds", builtins.lsp_document_symbols)
			nmap("<leader>ws", builtins.lsp_workspace_symbols)
			nmap("<leader>d", builtins.diagnostics)
		end,
	},
}
