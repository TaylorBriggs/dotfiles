local get_provider_path = function(provider)
	local ret = vim.system({ "mise", "which", provider }, { text = true })
		:wait()
	return vim.trim(ret.stdout)
end

vim.g.node_host_prog = get_provider_path("neovim-node-host")
vim.g.python3_host_prog = get_provider_path("python")
vim.g.ruby_host_prog = get_provider_path("neovim-ruby-host")

-- https://github.com/junegunn/fzf/blob/master/README-VIM.md#installation
vim.opt.rtp:append("/opt/homebrew/opt/fzf")
