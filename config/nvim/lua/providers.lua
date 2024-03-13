local get_host_prog = function(prog)
  return vim.fn.trim(vim.fn.system("which " .. prog))
end

vim.g.node_host_prog = get_host_prog("neovim-node-host")
vim.g.python3_host_prog = get_host_prog("python")
vim.g.ruby_host_prog = get_host_prog("neovim-ruby-host")
