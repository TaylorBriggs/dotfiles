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
		"m4xshen/autoclose.nvim",
		event = "InsertEnter",
		config = function()
			require("autoclose").setup()
		end,
	},
}
