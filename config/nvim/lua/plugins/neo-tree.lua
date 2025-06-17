return {
	"nvim-neo-tree/neo-tree.nvim",
	keys = {
		{ "<leader>\\", "<CMD>Neotree filesystem toggle<CR>" },
	},
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
    local command = require("neo-tree.command")
		require("neo-tree").setup({
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			default_component_configs = {
				git_status = {
					symbols = {
						conflict = "",
						ignored = "☒",
						modified = "•",
						renamed = "→",
						staged = "✓",
						unstaged = "✗",
						untracked = "*",
					},
				},
				name = {
					trailing_slash = true,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(_)
						command.execute({ action = "close" })
					end,
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
					never_show = {
						".DS_Store",
						".git",
						"tags",
					},
				},
				follow_current_file = {
					enabled = true,
				},
			},
		})
	end,
}
