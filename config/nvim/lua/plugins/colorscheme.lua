return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.termguicolors = true
		vim.o.background = "dark"
		vim.cmd("colorscheme catppuccin-mocha")
		vim.cmd("hi clear SignColumn")
	end,
}
